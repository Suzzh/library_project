package notice;

import java.io.IOException;
import java.io.PrintWriter;
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

			if(request.getParameter("curPage")!=null && request.getParameter("curPage")!="") {
				try {
					curPage = Integer.parseInt(request.getParameter("curPage"));	
				} catch (Exception e) {
					e.printStackTrace();
					curPage = 1;
				}
			}
			
			Pager pager = new Pager(count, curPage, 20);
			int start = pager.getPageBegin();
			int end = pager.getPageEnd();
			
			List<NoticeDTO> notices = dao.boardList(category, start, end);
			request.setAttribute("count", count);
			request.setAttribute("notices", notices);
			request.setAttribute("category", category);
			request.setAttribute("page", pager);
			System.out.println(pager.getCurPage());
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
			String page = request.getContextPath()+"/notice_servlet/board.do";
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
		
		
		else if(uri.indexOf("recentNotices.do")!=-1){
			List<HashMap<String, Object>> noticeList = dao.recentBoardList(5);
			Map<String, Object> map = new HashMap<>();
			map.put("noticeList", noticeList);
			Gson returnGson = new Gson();
			String json = returnGson.toJson(map);
			
			//한글깨짐 방지
		    response.setCharacterEncoding("utf-8");
		    
			PrintWriter writer = response.getWriter();
			writer.write(json.toString());
			writer.flush();
			writer.close();
		}
		

		
	}
		
		

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
