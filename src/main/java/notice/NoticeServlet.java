package notice;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import admin.dao.AdminDAO;
import notice.dao.NoticeDAO;
import notice.dto.NoticeDTO;
import work.Pager;



@WebServlet("/notice_servlet/*")
public class NoticeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		NoticeDAO dao = new NoticeDAO();

		if(uri.indexOf("board.do")!=-1) {
			String category = "";
			
			if(request.getParameter("category")!=null) {
				category = request.getParameter("category");
			}
			
			int count = dao.noticeCount(category);
			
			int curPage = 1;

			if(request.getParameter("curPage")!=null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
			}
			
			Pager pager = new Pager(count, curPage, 20);
			int start = pager.getPageBegin();
			int end = pager.getPageEnd();
			
			List<NoticeDTO> notices = dao.boardList(category, start, end);
			request.setAttribute("count", count);
			request.setAttribute("notices", notices);
			request.setAttribute("category", category);
			request.setAttribute("page", pager);
			RequestDispatcher rd = request.getRequestDispatcher("/notice/board.jsp");
			rd.forward(request, response);
			
		}
		
		else if(uri.indexOf("write.do")!=-1) {
			
			String filename = "";
			int filesize = 0;
			
			HttpSession session = request.getSession();
			
			long admin_id = 0;
			try {
				admin_id = (Long)session.getAttribute("admin_id");
			} catch (Exception e) {
				e.printStackTrace();
			}
			//필터 등 이용해서 id없으면 뒤로 보내기
			
			NoticeDTO dto = new NoticeDTO();
			
			dto.setWriter_id(admin_id);
			
			AdminDAO adminDAO = new AdminDAO();
			String dept_in_charge = adminDAO.getDept(admin_id);
			dto.setDept_in_charge(dept_in_charge);
			dto.setTitle(request.getParameter("title"));
			dto.setNotice_content(request.getParameter("notice_content"));
			dto.setPost_category(request.getParameter("post_category"));
			dto.setFilename(filename);
			dto.setFilesize(filesize);
			int fixyn;
			String fix = request.getParameter("fix");
			if(fix==null) fixyn=0;
			else fixyn=1;
			
			dto.setFix(fixyn);
			
			dao.writeBoard(dto);
			String page = request.getContextPath()+"/notice/board.do";
			response.sendRedirect(page);
				
		}
		
		else if(uri.indexOf("view.do")!=-1) {

			NoticeDTO dto = new NoticeDTO();
			int notice_id = Integer.parseInt(request.getParameter("notice_id"));
			
			System.out.println("notice_id" + notice_id);
			
			dto = dao.viewNotice(notice_id);
			request.setAttribute("dto", dto);
			if(request.getParameter("curPage")!=null) request.setAttribute("curPage", request.getParameter("curPage"));
			if(request.getParameter("category")!=null) request.setAttribute("category", request.getParameter("category"));
			String page = "/notice/view.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
		

		
	}
		
		

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
