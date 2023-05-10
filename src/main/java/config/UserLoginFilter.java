package config;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(value = "/my_library/*")
public class UserLoginFilter implements Filter {
	
	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, 
			FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		
		HttpSession session = httpRequest.getSession();
		
		if(session==null || session.getAttribute("user_id")==null) {

			//이미 그 안에 들어가 있다가 로그아웃한 경우 메인으로
			System.out.println(httpRequest.getRequestURL().toString());
			System.out.println(httpRequest.getHeader("Referer"));
			if(httpRequest.getHeader("Referer")!=null && httpRequest.getRequestURL().toString().equals(httpRequest.getHeader("Referer"))) {
				httpResponse.sendRedirect(httpRequest.getContextPath()+ "/index.jsp");
				return;
			}
			
			else {
			
			String requestURI = httpRequest.getRequestURI();
			String queryString = httpRequest.getQueryString();
			if(queryString != null && queryString.equals(""))
				session.setAttribute("originalRequestURI", requestURI+"?"+queryString);
			else session.setAttribute("originalRequestURI", requestURI);
						
			//팝업
			if(requestURI.indexOf("reservation.do")!=-1) {
				httpResponse.sendRedirect(httpRequest.getContextPath()+"/loginPop.jsp");
				return;
			}
			
			//일반
			else {
				httpResponse.sendRedirect(httpRequest.getContextPath()+"/login.jsp");
				return;
			}
		
			}

		}

		chain.doFilter(request, response); //필터 처리
	}

}
