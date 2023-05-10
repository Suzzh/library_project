package member;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.dao.MemberDAO;
import member.dto.MemberDTO;
import work.Library;

@WebServlet("/member_servlet/*")
public class MemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

   	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
   		
		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath(); 
		MemberDAO dao = new MemberDAO();
		
		
		if(uri.indexOf("loginForm.do")!=-1){
			String referer = request.getHeader("Referer");
			HttpSession session = request.getSession();
			session.setAttribute("referer", referer);
			String page = "/login.jsp";
			response.sendRedirect(contextPath + page);
		}
			
		
		else if(uri.indexOf("login.do")!=-1) {
			
			System.out.println("왜안됨");
			HttpSession session = request.getSession();
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
				System.out.println("왜안됨2");
				message="※ ID 또는 비밀번호가 일치하지 않습니다. 다시 시도해 주세요.";
				message = URLEncoder.encode(message, "utf-8");
				
				//팝업창 로그인
				if(request.getParameter("pop")!=null && request.getParameter("pop").equals("yes")) 
					page = "/loginPop.jsp?message=" + message;
				
				//일반 로그인
				else page = "/login.jsp?message=" + message;
				
				
				if(request.getParameter("originalRequestURI")!=null) {
					session.setAttribute("originalRequestURI", request.getParameter("originalRequestURI"));
				}
				
				else if(request.getParameter("referer")!=null) {
					session.setAttribute("referer", request.getParameter("referer"));
				}
				
			} else { //로그인 성공 시
				System.out.println("왜안됨3");
				session = request.getSession();
				session.setAttribute("user_id", user_id);
				session.setAttribute("user_name", name);
				
				if(request.getParameter("originalRequestURI")!=null) {
					page = request.getParameter("originalRequestURI");
					response.sendRedirect(page);
					return;
				}
				
				else if(request.getParameter("referer")!=null) {
					page = request.getParameter("referer");
					response.sendRedirect(page);
					return;
				}
						
				else page = "/index.jsp";
				System.out.println("오잉3");
				
			}
			
			response.sendRedirect(request.getContextPath()+page);
		}
		
		
		else if(uri.indexOf("logout.do")!=-1) {
			
			String referer = request.getHeader("Referer");
			HttpSession session = request.getSession();
			session.invalidate();
			response.sendRedirect(referer);			
		}


		else if(uri.indexOf("view.do")!=-1) {
			
			Long user_id = null;
			String page = "";

			user_id = Long.parseLong(request.getParameter("user_id"));
			
			MemberDTO dto = null;
			dto = dao.view(user_id);
			

			if(dto!=null) {
				dto = dao.view(user_id);
				
				int numCheckedOut = dao.countCheckouts(user_id);
				int numLateReturns = dao.countLateReturns(user_id);
				dto.setNumCheckedOut(numCheckedOut);
				dto.setNumLateReturns(numLateReturns);
				
				if(numCheckedOut > Library.getMaxBorrow(dto.getUser_type()) || numLateReturns >= 1) {
					dto.setCheckout_status("대출불가");
				}
				
				else dto.setCheckout_status("정상");
				
				int numReservations = dao.countReservations(user_id);
				dto.setNumReservations(numReservations);
				
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
		
						
	}
   		
		


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
