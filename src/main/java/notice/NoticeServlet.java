package notice;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import admin.dao.AdminDAO;
import common.Constants;
import common.Util;
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
			
			HttpSession session = request.getSession();
			
			long admin_id = 0;
			try {
				admin_id = (Long)session.getAttribute("admin_id");
			} catch (Exception e) {
				e.printStackTrace();
			}
			//(1) 일차로 필터 이용해서 admin만 접근케 했는데
			//(2) 2차로 여기서도 admin_id없으면 뒤로 보내게 해야 하나?
			
			File uploadDir = new File(Constants.UPLOAD_PATH);
			//업로드 디렉토리를 표상하는 객체
			if(!uploadDir.exists()) { //해당 위치에 디렉토리가 없다면
				uploadDir.mkdir(); //만들어라
			}
			
			//request를 확장시킨 MultipartRequest 생성
			MultipartRequest multi = new MultipartRequest(request, Constants.UPLOAD_PATH,
					Constants.MAX_UPLOAD, "utf-8", new DefaultFileRenamePolicy());
			

			NoticeDTO dto = new NoticeDTO();
			
			dto.setWriter_id(admin_id);
			
			
			//request -> multipartRequest로 변경
			dto.setTitle(multi.getParameter("title"));
			dto.setNotice_content(multi.getParameter("notice_content"));
			dto.setPost_category(multi.getParameter("post_category"));
			int fixyn;
			String fix = multi.getParameter("fix");
			if(fix==null) fixyn=0;
			else fixyn=1;
			dto.setFix(fixyn);
			
			//첨부파일 관련 처리
			String filename = "";
			int filesize = 0;
			try {
				//첨부파일명 집합 files
				Enumeration files = multi.getFileNames();

				//다음 요소가 있다면(첨부된 파일이 있다면)
				while(files.hasMoreElements()) {
					String file1 = (String)files.nextElement();
					//file1에 사용자가 업로드하고자 파일을 선택할 당시의 파일명을 담음
					filename = multi.getFilesystemName(file1);
					//filename은 실제로 해당 경로에 업로드된 파일명을 의미
					File f1 = multi.getFile(file1);
					//multipartrequest에 담긴 file1의 파일객체를 생성한 것이 f1
					//f1의 사이즈를 구함
					if(f1!=null) {
						filesize=(int)f1.length(); //파일 사이즈 저장
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			//파일을 첨부하지 않는 경우도 생각해야 함
			if(filename == null || filename.trim().equals("")) {
				filename="-";
			}
			dto.setFilename(filename); //실제 경로에 업로드된 파일명 사용
			dto.setFilesize(filesize);
			
			dao.writeBoard(dto);
			String page = request.getContextPath()+"/notice_servlet/board.do";
			response.sendRedirect(page);
				
		}
		
		else if(uri.indexOf("view.do")!=-1) {

			int notice_id = Integer.parseInt(request.getParameter("notice_id"));
			Cookie[] cookies = request.getCookies();
			boolean updateViewCount = true;
			
			if(cookies!=null) {
				String noticeViewCookie = Util.getCookie(cookies, "noticeView");
				
				if(noticeViewCookie!=null) {
					if(noticeViewCookie.indexOf("["+notice_id+"]")!=-1) {
						updateViewCount = false;
					}
					
					else{
						response.addCookie(new Cookie("noticeView", noticeViewCookie + "_["+notice_id+"]"));
					}
				}
				
				else {
					response.addCookie(new Cookie("noticeView", "["+notice_id+"]"));
				}
			}
			
			NoticeDTO dto = new NoticeDTO();
			dto = dao.viewNotice(notice_id, updateViewCount);
			request.setAttribute("dto", dto);
			if(request.getParameter("curPage")!=null) request.setAttribute("curPage", request.getParameter("curPage"));
			if(request.getParameter("category")!=null) request.setAttribute("category", request.getParameter("category"));
			String page = "/notice/view.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
		
		
		else if(uri.indexOf("download.do")!=-1) {
			int notice_id = Integer.parseInt(request.getParameter("notice_id"));
			String filename = dao.getFileName(notice_id);
			
			//여기부터 본격적인 다운로드 처리
			//파일의 전체 경로를 찍어보자
			String path = Constants.UPLOAD_PATH+filename;
			byte b[] = new byte[4096];
			//해당 경로로부터 데이터를 읽어들일 fis 생성. 
			//한번에 위 배열 크기만큼 읽어들일것임
			FileInputStream fis = new FileInputStream(path);
			
			
			//~~~~~~~~~~~~~암기~~~~~~~~~~~~~~
			//~~~~~~~~~~~~~암기~~~~~~~~~~~~~~
			//파일의 종류 알아내기(여기부터 밑에 setHeader()까지는 그냥 외우는수밖에 없을듯)
			String mimeType = getServletContext().getMimeType(path);
			if(mimeType==null) {
				mimeType="application/octet-stream;charset=utf-8";
				//octet-stream이란 8비트로 된 일련의 데이터를 의미. 
				//모든 종류의 이진데이터를 처리하겠다는 뜻
			}
			
			//파일명의 한글처리를 위한 코드
			//utf-8로 되어 있던 이름을 바이트로 바꾼 뒤 다시 8859_1타입의 스트링으로 바꾸는 것인듯?
			filename = new String(filename.getBytes("utf-8"), "8859_1");
			response.setHeader("Content-Disposition", "attachment;filename=" + filename);
			//~~~~~~~~~~~~~암기~~~~~~~~~~~~~~
			//~~~~~~~~~~~~~암기~~~~~~~~~~~~~~
			
			//이제 서버에서 클라이언트에 쓰기 위한 OutputStream 생성
			ServletOutputStream out = response.getOutputStream();
			int numRead;
			while(true) {
				numRead = fis.read(b, 0, b.length); //데이터를 읽음
				if(numRead==-1) break;
				out.write(b, 0, numRead);
			}
			
			out.flush();
			out.close();
			fis.close();
				
		}
		
		
		else if(uri.indexOf("editForm.do")!=-1) {
			//근데 이때도 아이디 한번 확인해주는게 맞는지
			//editForm을 제출할 때만 확인해주는게 맞는지 모르겠다
			//일단 확인해주는 쪽으로 가자
			
			HttpSession session = request.getSession();
			long admin_id = 0;
			int notice_id = 0;
			
			try {
				admin_id = Long.parseLong(session.getAttribute("admin_id").toString());
				notice_id = Integer.parseInt(request.getParameter("notice_id"));
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			if(admin_id == 0 || notice_id == 0) {
				String page = request.getContextPath()+"/notice_servlet/board.do";
				response.sendRedirect(page);
			}
			
			NoticeDTO dto = dao.viewNotice(notice_id, false);
			
			if(admin_id == dto.getWriter_id()) {
				request.setAttribute("dto", dto);
				String page = "/notice/edit.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(page);
				rd.forward(request, response);
			}
			
			else {
				String page = request.getContextPath()+"/notice_servlet/board.do";
				response.sendRedirect(page);
			}
			
		}
		
		
		else if(uri.indexOf("update.do")!=-1) {
			//request를 확장시킨 MultipartRequest 생성
			MultipartRequest multi = new MultipartRequest(request, Constants.UPLOAD_PATH,
					Constants.MAX_UPLOAD, "utf-8", new DefaultFileRenamePolicy());
			
			//이쪽에서도 아이디 한번 확인해야 하나? 일단 확인 안했다
			
			File uploadDir = new File(Constants.UPLOAD_PATH);
			//업로드 디렉토리를 표상하는 객체
			if(!uploadDir.exists()) { //해당 위치에 디렉토리가 없다면
				uploadDir.mkdir(); //만들어라
			}
			
					NoticeDTO dto = new NoticeDTO();
			
			//request -> multipartRequest로 변경
			dto.setTitle(multi.getParameter("title"));
			dto.setNotice_content(multi.getParameter("notice_content"));
			dto.setPost_category(multi.getParameter("post_category"));
			int fixyn;
			String fix = multi.getParameter("fix");
			if(fix==null) fixyn=0;
			else fixyn=1;
			dto.setFix(fixyn);
			
			int notice_id = Integer.parseInt(multi.getParameter("notice_id"));
			dto.setNotice_id(notice_id);
			
			//첨부파일 관련 처리
			String filename = "";
			int filesize = 0;
			try {
				//첨부파일명 집합 files
				Enumeration files = multi.getFileNames();

				//다음 요소가 있다면(첨부된 파일이 있다면)
				while(files.hasMoreElements()) {
					String file1 = (String)files.nextElement();
					//file1에 사용자가 업로드하고자 파일을 선택할 당시의 파일명을 담음
					filename = multi.getFilesystemName(file1);
					//filename은 실제로 해당 경로에 업로드된 파일명을 의미
					File f1 = multi.getFile(file1);
					//multipartrequest에 담긴 file1의 파일객체를 생성한 것이 f1
					//f1의 사이즈를 구함
					if(f1!=null) {
						filesize=(int)f1.length(); //파일 사이즈 저장
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			//파일을 첨부하지 않는 경우
			if(filename == null || filename.trim().equals("")) {
				System.out.println("파일첨부안함");
				//기존 첨부파일을 삭제하는 경우
				if(multi.getParameter("fileDel").equals("y")) {
					dto.setFilename("-");
					dto.setFilesize(0);
				}
				
				//기존 내용 유지하는 경우
				else {
					NoticeDTO noticeOriginal = dao.viewNotice(notice_id, false);
					dto.setFilename(noticeOriginal.getFilename());
					dto.setFilesize(noticeOriginal.getFilesize());
				}
				
			}
			
			//파일을 첨부하는 경우
			else {
				dto.setFilename(filename); //실제 경로에 업로드된 파일명 사용
				dto.setFilesize(filesize);
			}
			
			dao.updateBoard(dto);
			String page = request.getContextPath()+"/notice_servlet/board.do";
			response.sendRedirect(page);
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

