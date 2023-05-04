package member;

import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Stream;

import javax.net.ssl.CertPathTrustManagerParameters;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.eclipse.jdt.internal.compiler.classfmt.NonNullDefaultAwareTypeAnnotationWalker;

import book.dto.BookDTO;
import circulate.dao.CirculateDAO;
import circulate.dto.CheckoutDTO;
import member.dao.MemberDAO;
import member.dto.MemberDTO;
import member.dto.UserDTO;
import notice.dao.NoticeDAO;
import notice.dto.NoticeDTO;
import work.Library;

@WebServlet("/member_servlet/*")
public class MemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

   	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
   		
		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath(); 
		MemberDAO dao = new MemberDAO();
		
		
		
		if(uri.indexOf("login.do")!=-1) {
			
			long user_id = 0;
			try {
				user_id = Long.parseLong(request.getParameter("id"));
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			String passwd = request.getParameter("passwd");
			
			String name = dao.loginCheck(user_id, passwd);
			
			String message="";
			String page="";
			
			if(name==null || name.equals("")) { //로그인 실패
				message="※ ID 또는 비밀번호가 일치하지 않습니다. 다시 시도해 주세요.";
				message = URLEncoder.encode(message, "utf-8");
				page = "/login.jsp?message=" + message;				
			} else { //로그인 성공 시
				//로그인 시 세션 유지 필요. 서블릿에서는 세션 객체를 직접 생성해야 함.
				HttpSession session = request.getSession();
				session.setAttribute("user_id", user_id);
				session.setAttribute("user_name", name);
				page = "/notice/board.jsp";
				
			}
			
			response.sendRedirect(request.getContextPath()+page);
		}
		
		
		else if(uri.indexOf("logout.do")!=-1) {
			
			HttpSession session = request.getSession();
			session.invalidate();
			response.sendRedirect(request.getContextPath() + "/notice/board.jsp");
			
		}


		else if(uri.indexOf("view.do")!=-1) {
			
			Long user_id = null;
			String page = "";

			user_id = Long.parseLong(request.getParameter("user_id"));
			
			MemberDTO dto = null;
			dto = dao.view(user_id);
			

			if(dto!=null) {
				dto = dao.view(user_id);
				
				Map<String, Object> checkoutsMap = CirculateDAO.getCheckout(user_id);
				
				int numCheckedOut = Integer.parseInt(String.valueOf(checkoutsMap.get("CHECKOUTS")));
				int numLateReturns = Integer.parseInt(String.valueOf(checkoutsMap.get("LATE_RETURNS")));

				dto.setNumCheckedOut(numCheckedOut);
				dto.setNumLateReturns(numLateReturns);
				
				if(numCheckedOut > Library.getMaxBorrow(dto.getUser_type()) || numLateReturns >= 1) {
					dto.setCheckout_status("대출불가");
				}
				
				else dto.setCheckout_status("정상");
				
				request.setAttribute("dto", dto);
				page = "/checkout/checkout2.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(page);
				rd.forward(request, response);

				} 
			
			else {
				page = contextPath + "/checkout/checkout.jsp?message=error&user_id="+user_id;
				response.sendRedirect(page);
			}
			
		}
		
		
		else if(uri.indexOf("myBorrowedBooks.do")!=-1) {
			
			Long user_id = null;
			String page = "";
			
			HttpSession session = request.getSession();
			if(session.getAttribute("user_id")==null || session.getAttribute("user_id").equals("")) {
				//로그인창으로 보내기 (추후 필터 등으로 보완)
			}
			
			user_id = (Long)(session.getAttribute("user_id"));
			
	
			MemberDTO dto = new MemberDTO();
			CirculateDAO circulateDAO = new CirculateDAO();

			dto.setUser_id(user_id);
			
			String user_type = dao.getUserType(user_id);
			dto.setUser_type(user_type);

			List<CheckoutDTO> borrowedBooks = dao.getBorrowedBooks(user_id);
			
			int numCheckedOut = 0;
			int numLateReturns = 0;
			
			if(borrowedBooks!=null) {
				numCheckedOut = borrowedBooks.size();
				for(CheckoutDTO b : borrowedBooks) {
					Date tmp = b.getDue_date();
					Date due_date = new Date(tmp.getYear(), tmp.getMonth(), tmp.getDay()+1,0,0);
					Date now = new Date();
					if(due_date.compareTo(now)<=0) {
						//연체일 구해서 setting
						numLateReturns++;
					}
				}
				}
			
			
			dto.setNumCheckedOut(numCheckedOut);
			dto.setNumLateReturns(numLateReturns);
			
			if(numCheckedOut > Library.getMaxBorrow(dto.getUser_type()) || numLateReturns >= 1) {
				dto.setCheckout_status("대출불가");
			}
			
			else dto.setCheckout_status("정상");
				
			request.setAttribute("dto", dto);
			request.setAttribute("list", borrowedBooks);
			page = "/mylibrary/borrowed.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);

			} 
			
						
	}
   		
		


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
