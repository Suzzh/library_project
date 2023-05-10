package book;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import book.dao.AuthorDAO;
import book.dao.BookDAO;
import book.dao.CopyDAO;
import book.dto.AuthorDTO;
import book.dto.BookDTO;
import book.dto.CopyDTO;
import book.dto.FilterDTO;
import work.Pager;


@WebServlet("/book_servlet/*")
public class BookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath(); 
		BookDAO bdao = new BookDAO();
		CopyDAO cdao = new CopyDAO();
		AuthorDAO adao = new AuthorDAO();
		String page = "";
		
		if(uri.indexOf("add.do")!=-1) {
			String err= "";
			AuthorDTO adto = new AuthorDTO();
			BookDTO dto = new BookDTO();
			CopyDTO cdto = new CopyDTO();
			String[] author = null;

			long isbn = 0;
			int publication_year = 0;
			try {
				isbn = Long.parseLong(request.getParameter("isbn"));
				publication_year = Integer.parseInt(request.getParameter("publication_year"));
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			String authors = request.getParameter("author");
			
			author = authors.split(";");

			String classification_code = request.getParameter("classification_code");
			String title = request.getParameter("title").trim();
			String publisher_name = request.getParameter("publisher_name").trim();
			String call_number = request.getParameter("call_number").trim();
				
			Integer page_count = null;
			if(request.getParameter("page_count")!=null && request.getParameter("page_count")!="") {
				try {
					page_count = Integer.parseInt(request.getParameter("page_count"));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
				
			Float book_size = null;
			if(request.getParameter("book_size")!=null && request.getParameter("book_size")!="") {
				try {
					book_size = Float.parseFloat(request.getParameter("book_size"));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
				
			Integer volume_number = null;
			if(request.getParameter("volume_number")!=null && request.getParameter("volume_number")!="") {
				try {
					volume_number = Integer.parseInt(request.getParameter("volume_number"));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			String series_title = request.getParameter("series_title").trim();
			String publisher_location = request.getParameter("publisher_location").trim();
			String edition = request.getParameter("edition").trim();
			//String img_url = request.getParameter("img_url");
			//이미지 구현 예정
			//String book_description = request.getParameter("book_description");
			//도서정보 구현 예정
				
				
			//기타 copy 정보
			String location = request.getParameter("location");
			String status = request.getParameter("status");
							
			//기타 작가 정보
			String translators = request.getParameter("translator");
			String[] translator = null;
			if(translators!=null && !translators.isEmpty()) {
				translator = translators.split(";");	
			}
				
			String painters = request.getParameter("painter");
			String[] painter = null;
			if(painters!=null && !painters.isEmpty()) {
				painter = painters.split(";");	
			}
			
			if(isbn == 0 || publication_year == 0 || authors==null || authors.isEmpty()) {
				err = "도서 등록에 실패했습니다. 다시 시도해주세요.";
				request.setAttribute("err", err);
				request.setAttribute("isbn", isbn);
				request.setAttribute("page_count", page_count);
				request.setAttribute("book_size", book_size);
				request.setAttribute("volume_number", volume_number);
				request.setAttribute("classification_code", classification_code);
				request.setAttribute("title", title);
				request.setAttribute("series_title", series_title);
				request.setAttribute("publisher_location", publisher_location);
				request.setAttribute("publisher_name", publisher_name);
				request.setAttribute("publication_year", publication_year);
				request.setAttribute("edition", edition);
				//request.setAttribute("img_url", img_url);
				//request.setAttribute("book_description", book_description);
				request.setAttribute("call_number", call_number);
				request.setAttribute("location", location);
				request.setAttribute("status", status);
				request.setAttribute("author", authors);
				request.setAttribute("translator", translators);
				request.setAttribute("painter", painters);
				RequestDispatcher rd = request.getRequestDispatcher("/book/add.jsp");
				rd.forward(request, response);
				
			}
			
			else {
				
				//동일 도서 존재 여부 체크
				boolean pass = false;
				
				String existTitle = bdao.checkUniqueness(isbn);
				if(existTitle==null) {
					Long existCopy_id = cdao.checkUniqueness(call_number);
					if(existCopy_id == null){
						pass = true;
					}
					else {
						err = "데이터베이스에 동일한 청구기호가 존재합니다. '청구기호 브라우징'버튼을 눌러 확인해주세요";
					}
				} else {
					err = "데이터베이스에 동일한 ISBN의 도서가 존재합니다. '도서정보 조회'버튼을 눌러 확인해주세요.";
				}
				

				if(pass == true) {
					
					dto.setTitle(title);
					dto.setIsbn(isbn);
					dto.setPublication_year(publication_year);
					dto.setClassification_code(classification_code);
					dto.setSeries_title(series_title);
					dto.setPublisher_location(publisher_location);
					dto.setPublisher_name(publisher_name);
					dto.setEdition(edition);
					dto.setBook_size(book_size);
					dto.setPage_count(page_count);
					//dto.setImg_url(img_url);
					//dto.setBook_description(book_description);
					
					cdto.setIsbn(isbn);
					cdto.setCall_number(call_number);
					cdto.setLocation(location);
					cdto.setStatus(status);
					
					HashMap<String, String[]> authorMap = new HashMap<>();
					authorMap.put("author", author);
					authorMap.put("translator", translator);
					authorMap.put("painter", painter);
					
					boolean addOk = bdao.makeBookInfo(dto, cdto, authorMap);
					if(addOk) {
						response.sendRedirect(contextPath + "/main_servlet/index.do");
					}
						
					else {
						err = "도서 등록에 실패했습니다. 다시 시도해주세요.";
						request.setAttribute("err", err);
						request.setAttribute("isbn", isbn);
						request.setAttribute("page_count", page_count);
						request.setAttribute("book_size", book_size);
						request.setAttribute("volume_number", volume_number);
						request.setAttribute("classification_code", classification_code);
						request.setAttribute("title", title);
						request.setAttribute("series_title", series_title);
						request.setAttribute("publisher_location", publisher_location);
						request.setAttribute("publisher_name", publisher_name);
						request.setAttribute("publication_year", publication_year);
						request.setAttribute("edition", edition);
						//request.setAttribute("img_url", img_url);
						//request.setAttribute("book_description", book_description);
						request.setAttribute("call_number", call_number);
						request.setAttribute("location", location);
						request.setAttribute("status", status);
						request.setAttribute("author", authors);
						request.setAttribute("translator", translators);
						request.setAttribute("painter", painters);
						RequestDispatcher rd = request.getRequestDispatcher("/book/add.jsp");
						rd.forward(request, response);
					}
				} 
				
				else {
					
					request.setAttribute("err", err);
					request.setAttribute("isbn", isbn);
					request.setAttribute("page_count", page_count);
					request.setAttribute("book_size", book_size);
					request.setAttribute("volume_number", volume_number);
					request.setAttribute("classification_code", classification_code);
					request.setAttribute("title", title);
					request.setAttribute("series_title", series_title);
					request.setAttribute("publisher_location", publisher_location);
					request.setAttribute("publisher_name", publisher_name);
					request.setAttribute("publication_year", publication_year);
					request.setAttribute("edition", edition);
					//request.setAttribute("img_url", img_url);
					//request.setAttribute("book_description", book_description);
					request.setAttribute("call_number", call_number);
					request.setAttribute("location", location);
					request.setAttribute("status", status);
					request.setAttribute("author", authors);
					request.setAttribute("translator", translators);
					request.setAttribute("painter", painters);
					RequestDispatcher rd = request.getRequestDispatcher("/book/add.jsp");
					rd.forward(request, response);
					
				}
							
			}
			}
		

		else if(uri.indexOf("searchForm.do")!=-1){
			page = "/book/search.jsp";
			response.sendRedirect(contextPath + page);
		}
		
		else if(uri.indexOf("search.do")!=-1) {
			
			String type = "key";
			if(request.getParameter("type")!=null) type = request.getParameter("type");
			

			List<FilterDTO> filter = null;
			List<BookDTO> books = null;
			Pager pager = null;

			
			String[] keywords = request.getParameterValues("keyword");			
			
			if(keywords!=null) {
				Stream<String> keyStream = Arrays.stream(keywords);
				if(keyStream.anyMatch(s -> s!=null & !s.trim().isEmpty())) {
					
					String[] options =request.getParameterValues("option");
					String[] exact_keywords = null;
					String[] exact_options = null;
					int curPage=1;
					if(request.getParameter("curPage")!=null){
							curPage = Integer.parseInt(request.getParameter("curPage"));
					}
					int size = 0;

					String sort = "";
					String order = "asc";
					int publishStart = 0;
					int publishEnd = 0;
					int page_size = 10;
					
					if(request.getParameter("publishStart")!=null && request.getParameter("publishStart")!="") {
						try {
							publishStart = Integer.parseInt(request.getParameter("publishStart"));
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
						
					if(request.getParameter("publishEnd")!=null && request.getParameter("publishEnd")!="") {
						try {
							publishEnd = Integer.parseInt(request.getParameter("publishEnd"));
						} catch (Exception e) {
							e.printStackTrace();
						}
					}

					if(request.getParameter("sort")!=null && request.getParameter("sort")!="") 
						sort = request.getParameter("sort");
					
					
					if(request.getParameter("order")!=null && request.getParameter("order")!="") 
						order = request.getParameter("order");
					
					
					if(request.getParameter("page_size")!=null && request.getParameter("page_size")!="") {
						try {
							page_size = Integer.parseInt(request.getParameter("page_size"));
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					
					
					if(type.equals("keyAndExact")) {
						exact_keywords = request.getParameterValues("exact_keyword");
						exact_options = request.getParameterValues("exact_option");

						filter = bdao.makeFilterKeyAndExact(options, keywords, publishStart, publishEnd, exact_keywords, exact_options);
						
						if(filter != null && filter.size()>=1) {
							size = filter.get(filter.size()-1).getF_count();
						}
						
						pager = new Pager(size, curPage, page_size);
						int start = pager.getPageBegin();
						int end = pager.getPageEnd();

						books = bdao.searchKeyAndExact(options, keywords, publishStart, publishEnd, sort, order, exact_keywords, exact_options, start, end);

					}
					
					else {
						
						filter = bdao.makeFilter(options, keywords, publishStart, publishEnd);
						if(filter != null && filter.size()>=1) {
							size = filter.get(filter.size()-1).getF_count();
						}
						
						pager = new Pager(size, curPage, page_size);
						int start = pager.getPageBegin();
						int end = pager.getPageEnd();
												
						books = bdao.search(options, keywords, publishStart, publishEnd, sort, order, start, end);
						
					}
								
					
					request.setAttribute("filter", filter);
					request.setAttribute("books", books);
					request.setAttribute("size", size);
					request.setAttribute("page_size", page_size);
					request.setAttribute("page", pager);
					request.setAttribute("keywords", keywords);
					request.setAttribute("options", options);
					request.setAttribute("exact_keywords", exact_keywords);
					request.setAttribute("exact_options", exact_options);
					request.setAttribute("publishStart", publishStart);
					request.setAttribute("publishEnd", publishEnd);
					request.setAttribute("sort", sort);
					request.setAttribute("order", order);
					request.setAttribute("type", type);
					
					RequestDispatcher dispatcher = request.getRequestDispatcher("/book/result.jsp");
					dispatcher.forward(request, response);
					
		 		}

				else {
					String err = "검색어를 입력해주세요.";
					request.setAttribute("err", err);
					RequestDispatcher dispatcher = request.getRequestDispatcher("/book/search.jsp");
					dispatcher.forward(request, response);
				}
				
			} else {
				String err = "검색어를 입력해주세요.";
				request.setAttribute("err", err);
				RequestDispatcher dispatcher = request.getRequestDispatcher("/book/search.jsp");
				dispatcher.forward(request, response);
			}
			
					
		}
		
		
		else if(uri.indexOf("view.do")!=-1) {
			
			long isbn = Long.parseLong(request.getParameter("isbn"));
			//Boolean bool = bdao.chkCopyAvailable(isbn);
			BookDTO bdto = bdao.view(isbn);
			List<CopyDTO> copies = bdao.copyList(isbn);
			int reservation_count = bdao.getBookReserveCount(isbn);
			
			//예약가능여부
			//대출가능, 대출중, 예약서가,  분실, 파손, 대출불가, 정리중 가운데
			//1) 대출가능한 책이 한 권도 없으면서
			//2) 모든 책이 분실, 파손, 대출불가가 아니고 (정리중/예약서가/대출중이 한권이라도 있고)
			//3) 예약자가 copy*10을 초과하지 않는 경우 
			
			String reservation_status = "";
			
			if(copies!=null) {
				Stream<CopyDTO> copyStream = copies.stream();
				Stream<CopyDTO> copyStream2 = copies.stream();
				
				if(copyStream.noneMatch(c -> c.getStatus().equals("대출가능"))){
					if(copyStream2.anyMatch(c -> c.getStatus().equals("정리중") || c.getStatus().equals("예약서가") || c.getStatus().equals("대출중"))){
						if(copies.size()*10 > reservation_count) {
							reservation_status = "예약가능";
						}
						else reservation_status = "예약한도초과";
					}
					else reservation_status = "예약불가";
				}
			}
			request.setAttribute("bdto", bdto);
			request.setAttribute("copies", copies);
			request.setAttribute("reservation_status", reservation_status);
			request.setAttribute("reservation_count", reservation_count);

			RequestDispatcher dispatcher = request.getRequestDispatcher("/book/detail.jsp");
			dispatcher.forward(request, response);
			
				
		}
		
		
		else if(uri.indexOf("view_copy.do")!=-1) {
			
			int copy_id = Integer.parseInt(request.getParameter("copy_id"));
			CopyDTO cdto = cdao.viewCopy(copy_id);
			
			if(cdto != null) {
				request.setAttribute("cdto", cdto);
				page = "/checkout/copy_list.jsp";			
				RequestDispatcher rd = request.getRequestDispatcher(page);
				rd.forward(request, response);
			}
		}
		

		
	}
		

		
	
	


		
				
		
//		else if(uri.indexOf("search.do")!=-1) {
//				
//				BookDTO dto = new BookDTO();
//				
//				String search1_option = request.getParameter("search1_option");
//				String search2_option = request.getParameter("search2_option");
//				String search3_option = request.getParameter("search3_option");
//				
//				String search1_keyword = request.getParameter("search1_keyword");
//				String search2_keyword = request.getParameter("search2_keyword");
//				String search3_keyword = request.getParameter("search3_keyword");
//				
//				
//				String[] options = {search1_option, search2_option, search3_option};
//				String[] keywords = {search1_keyword, search2_keyword, search3_keyword};
//				
//				ArrayList<HashMap> books = bdao.search(options, keywords);
//				
//				request.setAttribute("books", books);
//				response.sendRedirect(context + "/library/login.jsp");
//				
//				RequestDispatcher dispatcher = request.getRequestDispatcher("/library/bookSearchResult_tmp.jsp");
//				dispatcher.forward(request, response);
//				
//			}
		
		
		
		
			
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
