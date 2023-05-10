package admin;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.dao.AdminDAO;
import member.dao.MemberDAO;

@WebServlet("/admin_servlet/*")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath(); 
		AdminDAO dao = new AdminDAO();
		

		if(uri.indexOf("login.do")!=-1) {
			
			long admin_id = 0;
			try {
				admin_id = Long.parseLong(request.getParameter("id"));
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			String passwd = request.getParameter("passwd");
			
			String name = dao.loginCheck(admin_id, passwd);
			
			String message="";
			String page="";
			
			if(name==null || name.equals("")) { //로그인 실패
				message="※ ID 또는 비밀번호가 일치하지 않습니다. 다시 시도해 주세요.";
				message = URLEncoder.encode(message, "utf-8");
				page = "/login.jsp?login_type=admin&message=" + message;				
			} else { //로그인 성공 시
				//로그인 시 세션 유지 필요. 서블릿에서는 세션 객체를 직접 생성해야 함.
				HttpSession session = request.getSession();

				session.setAttribute("admin_id", admin_id);
				session.setAttribute("admin_name", name);

				session.setAttribute("user_id", admin_id);
				session.setAttribute("user_name", name);

				page = "/main_servlet/index.do";
				
			}
			
			response.sendRedirect(request.getContextPath()+page);
		}
		
		
		
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
