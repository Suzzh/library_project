package collection;

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

import com.google.gson.Gson;

import book.dto.BookDTO;
import collection.dao.CollectionDAO;
import work.Pager;

@WebServlet("/collection_servlet/*")
public class CollectionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath(); 
		CollectionDAO dao = new CollectionDAO();
		
		if(uri.indexOf("top_list.do")!=-1) {
			
			String category = "";
			int days = 30;
			
			if(request.getParameter("category")!=null && !request.getParameter("category").equals("")) {
				category = request.getParameter("category");
			}
			
			if(request.getParameter("days")!=null && !request.getParameter("days").equals("")) {
				try {
					days = Integer.parseInt(request.getParameter("days"));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			//최대 상위 120개까지 출력할 예정 -> 총 출력 개수 구하기
			int count = dao.getTopNums(category, 120, days);
			
			int curPage = 1;

			if(request.getParameter("curPage")!=null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
			}
			
			Pager pager = new Pager(count, curPage, 30);
			int start = pager.getPageBegin();
			int end = pager.getPageEnd();
			
			List<BookDTO> topList = dao.getTopList(start, end, category, days);
			request.setAttribute("list", topList);
			request.setAttribute("count", count);
			request.setAttribute("page", pager);
			request.setAttribute("category", category);
			request.setAttribute("days", days);
			String page = "";
			page = "/collection/tops.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		}
		
		
		else if(uri.indexOf("popularBooks.do")!=-1) {
			int curPage = 1;
			int count = 6;
			if(request.getParameter("curPage")!=null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
			}
			
			int start = 1;
			int end = count;
			
			if(curPage == 2) {
				start = count+1;
				end = count*2;
			}
			
			List<HashMap<String, Object>> popularList 
				= dao.getSimpleTopList(start, end);
			
			Map<String, Object> map = new HashMap<>();
			map.put("popularList", popularList);
			map.put("p_curPage", curPage);
			Gson returnGson = new Gson();
			String json = returnGson.toJson(map);
			
			//한글깨짐 방지
		    response.setCharacterEncoding("utf-8");
		    
			PrintWriter writer = response.getWriter();
			writer.write(json.toString());
			writer.flush();
			writer.close();
		}
		
		
		else if(uri.indexOf("recentBooks.do")!=-1) {
			int curPage = 1;
			int count = 6;
			if(request.getParameter("curPage")!=null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
			}
			
			int start = 1;
			int end = count;
			
			if(curPage == 2) {
				start = count+1;
				end = count*2;
			}
			
			List<HashMap<String, Object>> recentList 
				= dao.getSimpleRecentList(start, end);
			
			Map<String, Object> map = new HashMap<>();
			map.put("recentList", recentList);
			map.put("r_curPage", curPage);
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
