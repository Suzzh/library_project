package mylibrary;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import circulate.dao.CirculateDAO;
import circulate.dto.CheckoutDTO;
import member.dao.MemberDAO;
import member.dto.MemberDTO;
import work.Library;
import work.Pager;

@WebServlet("/my_library/*")
public class MyLibraryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath(); 
		MemberDAO dao = new MemberDAO();
		
		
		if(uri.indexOf("borrowedBooks.do")!=-1) {
			
			System.out.println("borrowedBooks");
			
			String page = "";
			
			MemberDTO dto = dao.getUserDTO(request.getSession());
			
			int curPage = 1;
			int count = dto.getNumCheckedOut();

			if(request.getParameter("curPage")!=null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
			}
			
			Pager pager = new Pager(count, curPage, 10);
			int start = pager.getPageBegin();
			int end = pager.getPageEnd();
			
			List<CheckoutDTO> borrowedBooks = dao.getBorrowedBooks(dto.getUser_id(), start, end);
			
			//연체일 계산
			
			if(borrowedBooks != null) {
				for(CheckoutDTO checkout : borrowedBooks) {
					LocalDate today = LocalDate.now();
					LocalDate due_date = checkout.getDue_date().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
					if(today.isAfter(due_date)) {
						Period diff = Period.between(due_date, today);
						checkout.setLate_days(diff.getDays());
					} 
				}
			}

			
			String message = request.getParameter("message");
			
			request.setAttribute("count", count);
			request.setAttribute("page", pager);
			request.setAttribute("dto", dto);
			request.setAttribute("list", borrowedBooks);
			request.setAttribute("maxRenewal", Library.MAX_RENEWAL);
			request.setAttribute("message", message);
			page = "/mylibrary/borrowed.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);

			} 
		
		
		else if(uri.indexOf("renewal.do")!=-1) {
			
			String page = "";
			long user_id = 0;
			String user_type = "학생";
			ArrayList<CheckoutDTO> checkoutList = new ArrayList<>();
			int curPage = 1;
			String message = "";
			
			try {
				user_id = (long)request.getSession().getAttribute("user_id");
				
				if(request.getParameter("curPage")!=null) {
					curPage = Integer.parseInt(request.getParameter("curPage"));	
				}
				
				user_type = dao.getUserType(user_id);
				int numLateReturns = dao.countLateReturns(user_id);
				if(numLateReturns > 0) { //연장 불가. 다시 돌려보내주기
					message = "회원님은 현재 대출 연장이 불가능한 상태입니다.";
					page = "/my_library/borrowedBooks.do?curPage=" + curPage + "&message=" + URLEncoder.encode(message, "utf-8");
					response.setCharacterEncoding("utf-8");
					response.sendRedirect(contextPath + page);
				}

				String[] checkouts = request.getParameterValues("renewCheck");
				String[] titles = request.getParameterValues("title");
				
				
				if(checkouts!=null && titles!=null && checkouts.length>0 && checkouts.length == titles.length) {
					for(int i = 0; i < checkouts.length ; i++) {
						CheckoutDTO dto = new CheckoutDTO();
						dto.setCheckout_id(Long.parseLong(checkouts[i]));
						dto.setTitle(titles[i]);
						checkoutList.add(dto);
				}
				}
				
				else {
					message = "오류가 발생했습니다. 다시 시도해주세요.";
					page = "/my_library/borrowedBooks.do?curPage=" + curPage + "&message=" + URLEncoder.encode(message, "utf-8");
					response.setCharacterEncoding("utf-8");
					response.sendRedirect(contextPath + page);
				}
				
				}


			catch (Exception e) {
				e.printStackTrace();
				message = "오류가 발생했습니다. 다시 시도해주세요.";
				page = "/my_library/borrowedBooks.do?curPage=" + curPage + "&message=" + URLEncoder.encode(message, "utf-8");
				response.setCharacterEncoding("utf-8");
				response.sendRedirect(contextPath + page);
			}
			
			
			CirculateDAO cdao = new CirculateDAO();
			message = cdao.renewal(user_id, user_type, checkoutList);
			
			page = "/my_library/borrowedBooks.do";
			request.setAttribute("curPage", curPage);
			request.setAttribute("message", message);
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
			}
		
		
		else if(uri.indexOf("make_reservation.do")!=-1) {
			
			long isbn = 0;
			long user_id = 0;
			HttpSession session = request.getSession();
			String page = "/mylibrary/result_reservation.jsp";
			request.setAttribute("title", request.getParameter("title"));

			try {
				isbn = Long.parseLong(request.getParameter("isbn"));
				user_id = (long)(session.getAttribute("user_id"));
			} catch (Exception e) {
				e.printStackTrace();
				RequestDispatcher rd = request.getRequestDispatcher(page);
				rd.forward(request, response);
			}
			
			CirculateDAO cdao = new CirculateDAO();
			String message = cdao.make_reservation(user_id, isbn);
			request.setAttribute("message", message);
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		}
		
		else if(uri.indexOf("reservation.do")!=-1) {
			
			long isbn = 0;
			try {
				isbn = Long.parseLong(request.getParameter("isbn"));
			} catch (Exception e) {
				e.printStackTrace();
				//에러처리해야함 - 비정상적인 접근
			}

			String title = request.getParameter("title");
			
			request.setAttribute("isbn", isbn);
			request.setAttribute("title", title);
			
			System.out.println(isbn);
			System.out.println(title);
			String page = "/mylibrary/apply_reservation.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
		

		
	}
			
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
