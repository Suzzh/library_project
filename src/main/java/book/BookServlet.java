package book;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
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
			BookDTO dto = new BookDTO();
			CopyDTO cdto = new CopyDTO();
			AuthorDTO adto = new AuthorDTO();
			
			long isbn = Long.parseLong(request.getParameter("isbn"));			
			
			
			Integer page_count = null;
			if(request.getParameter("page_count")!=null && request.getParameter("page_count")!="") {
				page_count = Integer.parseInt(request.getParameter("page_count"));
						dto.setPage_count(page_count);
			}
			
			
			Float book_size = null;
			if(request.getParameter("book_size")!=null && request.getParameter("book_size")!="") {
				book_size = Float.parseFloat(request.getParameter("book_size"));
						dto.setBook_size(book_size);
			}
			
			Integer volume_number = null;
			if(request.getParameter("volume_number")!=null && request.getParameter("volume_number")!="") {
				volume_number = Integer.parseInt(request.getParameter("volume_number"));
						dto.setVolume_number(volume_number);
			}

			String classification_code = request.getParameter("classification_code");
			String title = request.getParameter("title");
			String series_title = request.getParameter("series_title");
			String publisher_location = request.getParameter("publisher_location");
			String publisher_name = request.getParameter("publisher_name");
			String edition = request.getParameter("edition");
			String img_url = request.getParameter("img_url");
			String book_description = request.getParameter("book_description");
			int publication_year = Integer.parseInt(request.getParameter("publication_year"));
			
			//copy
			String call_number = request.getParameter("call_number");
			String location = request.getParameter("location");
			String status = request.getParameter("status");
						
			
			//author
			String authors = request.getParameter("author");
			String[] author = null;
			
			if(authors!=null && !authors.isEmpty()) {
				author = authors.split(";");	
			}


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
						
			
			String existTitle = bdao.checkUniqueness(isbn);

			if(existTitle!=null) {
				String err = "데이터베이스에 동일한 ISBN의 도서가 존재합니다. '도서정보 조회'버튼을 눌러 확인해주세요.";
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
				request.setAttribute("img_url", img_url);
				request.setAttribute("book_description", book_description);
				request.setAttribute("call_number", call_number);
				request.setAttribute("location", location);
				request.setAttribute("status", status);
				request.setAttribute("author", authors);
				request.setAttribute("translator", translators);
				request.setAttribute("painter", painters);
				RequestDispatcher rd = request.getRequestDispatcher("/book/add.jsp");
				System.out.println(err);
				rd.forward(request, response);
				
			}
			
			
			else {
				
				Long existCopy_id = cdao.checkUniqueness(call_number);
				
				if(existCopy_id!=null) {
					String err = "데이터베이스에 동일한 청구기호가 존재합니다. '청구기호 브라우징'버튼을 눌러 확인해주세요.";
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
					request.setAttribute("img_url", img_url);
					request.setAttribute("book_description", book_description);
					request.setAttribute("call_number", call_number);
					request.setAttribute("location", location);
					request.setAttribute("status", status);
					request.setAttribute("author", authors);
					request.setAttribute("translator", translators);
					request.setAttribute("painter", painters);
					RequestDispatcher rd = request.getRequestDispatcher("/book/add.jsp");
					System.out.println(err);
					rd.forward(request, response);
			}

				
				 else {
						
						dto.setTitle(title);
						dto.setIsbn(isbn);
						dto.setPublication_year(publication_year);
						dto.setClassification_code(classification_code);
						dto.setSeries_title(series_title);
						dto.setPublisher_location(publisher_location);
						dto.setPublisher_name(publisher_name);
						dto.setEdition(edition);
						dto.setImg_url(img_url);
						dto.setBook_description(book_description);
						
						bdao.makeBookInfo(dto);
						
						cdto.setIsbn(isbn);
						cdto.setCall_number(call_number);
						cdto.setLocation(location);
						cdto.setStatus(status);
						
						cdao.makeCopy(cdto);
						
						
						Map<String, ArrayList> authorMap = adao.makeAuthor(author, translator, painter);
						adao.addBookAuthor(isbn, authorMap);

						response.sendRedirect(contextPath + "/notice/board.jsp");
					}
			
			
		
		}
			
		} else if(uri.indexOf("search.do")!=-1) {
			
			
			System.out.println("bookSearvlet 진입" + System.currentTimeMillis());
			
			String type = "key";
			
			if(request.getParameter("type")!=null) type = request.getParameter("type");
			

			List<FilterDTO> filter = null;
			List<BookDTO> books = null;
			Pager pager = null;

			
			String[] keywords = request.getParameterValues("keyword");			
			
			if(keywords!=null) {
				Stream<String> keyStream = Arrays.stream(keywords);
				if(keyStream.anyMatch(s -> s!=null & !s.trim().isEmpty())) {
					
					System.out.println("키워드검사 통과" + System.currentTimeMillis());
					
					
					String[] options =request.getParameterValues("option");
					String[] exact_keywords = null;
					String[] exact_options = null;
					int curPage=1;
					if(request.getParameter("curPage")!=null){
							curPage = Integer.parseInt(request.getParameter("curPage"));
					}
					int size = 0;

					String sort = "title";
					String order = "asc";
					int publishStart = 0;
					int publishEnd = 0;
					
					if(request.getParameter("publishStart")!=null && request.getParameter("publishStart")!="") {
						publishStart = Integer.parseInt(request.getParameter("publishStart"));
					}
					
					if(request.getParameter("publishEnd")!=null && request.getParameter("publishEnd")!="") {
						publishEnd = Integer.parseInt(request.getParameter("publishEnd"));
					}

					if(request.getParameter("sort")!=null && request.getParameter("sort")!="") {
						sort = request.getParameter("sort");
						order = "asc";
					}
					
					if(request.getParameter("order")!=null && request.getParameter("order")!="") {
						order = request.getParameter("order");
					}
					
					/*
					
					if(type.equals("exact")) {
						exact_keywords = request.getParameterValues("exact_keyword");
						exact_options = request.getParameterValues("exact_option");

						filter = bdao.makeFilterExact(options, keywords, publishStart, publishEnd);

						if(filter != null && filter.size()>=1) {
							size = filter.get(filter.size()-1).getF_count();
						}
						books = bdao.searchExact(options, keywords, publishStart, publishEnd, sort, order);
					}
					
					*/
					
					
					if(type.equals("keyAndExact")) {
						System.out.println("keyAndExact 진입");
						exact_keywords = request.getParameterValues("exact_keyword");
						exact_options = request.getParameterValues("exact_option");

						filter = bdao.makeFilterKeyAndExact(options, keywords, publishStart, publishEnd, exact_keywords, exact_options);
						
						if(filter != null && filter.size()>=1) {
							size = filter.get(filter.size()-1).getF_count();
						}
						
						pager = new Pager(size, curPage, 10);
						int start = pager.getPageBegin();
						int end = pager.getPageEnd();

						books = bdao.searchKeyAndExact(options, keywords, publishStart, publishEnd, sort, order, exact_keywords, exact_options, start, end);

					}
					
					else {
						
						System.out.println("타입 확인" + System.currentTimeMillis());


						filter = bdao.makeFilter(options, keywords, publishStart, publishEnd);
						System.out.println("필터 생성" + System.currentTimeMillis());
						if(filter != null && filter.size()>=1) {
							size = filter.get(filter.size()-1).getF_count();
						}
						
						pager = new Pager(size, curPage, 10);
						int start = pager.getPageBegin();
						int end = pager.getPageEnd();
												
						books = bdao.search(options, keywords, publishStart, publishEnd, sort, order, start, end);
						System.out.println("도서 획득" + System.currentTimeMillis());

					}
								
					
					request.setAttribute("filter", filter);
					request.setAttribute("books", books);
					request.setAttribute("size", size);
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
					
					System.out.println("리턴 진입" + System.currentTimeMillis());
					
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
			BookDTO bdto = bdao.view(isbn);
			List<CopyDTO> copies = cdao.list(isbn);
			request.setAttribute("bdto", bdto);
			request.setAttribute("copies", copies);
			/*RequestDispatcher dispatcher = request.getRequestDispatcher("/book/search.jsp");
			dispatcher.forward(request, response); */

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
