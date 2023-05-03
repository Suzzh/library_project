package work;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import work.dao.WorkDAO;

@WebServlet("/work_servlet/*")
public class WorkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		WorkDAO dao = new WorkDAO();
		String path = request.getContextPath();
		
		if(uri.indexOf("make_holiday.do")!=-1) {
			
			System.out.println("시작");
			String[] dates = request.getParameterValues("date");
			String[] names = request.getParameterValues("name");
			
			dao.makeHoliday(dates, names);
			
			String page = path + "/work/make_holiday.jsp";
			response.sendRedirect(page);
			
			
		}

		

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
