package member;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
				dto = dao.setCheckoutStatus(dto);
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
		
		
		else if(uri.indexOf("myCheckouts.do")!=-1) {
			
			Long user_id = null;
			String page = "";
			
			HttpSession session = request.getSession();
			if(session.getAttribute("user_id")==null || session.getAttribute("user_id").equals("")) {
				//로그인창으로 보내기 (추후 필터 등으로 보완)
			}
			
			user_id = (Long)(session.getAttribute("user_id"));
	
			MemberDTO dto = new MemberDTO();
			dto.setUser_id(user_id);

			dto = dao.setCheckoutStatus(dto);
			request.setAttribute("dto", dto);
			page = "/mylibrary/issue.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);

			} 
			
						
	}
   		
		


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
