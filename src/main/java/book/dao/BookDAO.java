package book.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import book.dto.AuthorDTO;
import book.dto.BookDTO;
import book.dto.CopyDTO;
import book.dto.FilterDTO;
import sqlmap.MybatisManager;

public class BookDAO {
	
	public String checkUniqueness(long isbn) {
    	
    	String title = null;
    
        try(SqlSession session = MybatisManager.getInstance().openSession()) {
			title = session.selectOne("book.checkUniqueness", isbn);
        	} catch (Exception e) {
            e.printStackTrace();
        	}
        
        return title;

    	}

	public boolean makeBookInfo(BookDTO dto, CopyDTO cdto, HashMap<String, String[]> authorMap) {
		
		boolean pass = false;
		
		SqlSession session = MybatisManager.getInstance().openSession();
        try {
        	//코드 정리 요망
        	
        	String[] authorList = authorMap.get("author");
        	String[] painterList = authorMap.get("painter");
        	String[] translatorList = authorMap.get("translators");
        	dto.setMain_author(authorList[0]);
        	

        	int checkA = 0;
        	int checkT = 0;
        	int checkP = 0;
        	
        	long isbn = dto.getIsbn();
        	if(session.insert("book.add", dto)==1) {
        		
            	for(int i=0; i<authorList.length; i++) {
            		String author_name = authorList[i].trim();
            		System.out.println("작가명은" + authorList[i].trim());
            		if(session.insert("author.add", author_name)==1){
                		Map<String, Object> map = new HashMap<>();
                    	map.put("isbn", isbn);
                    	map.put("author_type", "지음");
                    	if(session.insert("author.book_author_add", map)==1) {
                    		checkA ++;
                    	}
            		}
            	}
            
            	if(checkA == authorList.length) {
            		
            		if(translatorList!=null) {
                		for(int i=0; i<translatorList.length; i++) {
                			String author_name = translatorList[i].trim();
                    		if(session.insert("author.add", author_name)==1) {
                    		Map<String, Object> map = new HashMap<>();
                    		map.put("isbn", isbn);
                    		map.put("author_type", "옮김");
                    		if(session.insert("author.book_author_add", map)==1) {
                    			checkT ++;
                    		}
                    	}
                	}
            		}
            		
            		if(translatorList==null || checkT == translatorList.length) {
            			if(painterList!=null) {
                        	for(int i=0; i<painterList.length; i++) {
                        		String author_name = painterList[i].trim();
                        		if(session.insert("author.add", author_name)==1) {
                            		Map<String, Object> map = new HashMap<>();
                            		map.put("isbn", isbn);
                            		map.put("author_type", "그림");
                            		if(session.insert("author.book_author_add", map)==1) {
                            			checkP ++;
                            		}
                        		}

                        	}
            			}
            			
            			if(painterList==null || checkP == translatorList.length) {
            				if(session.insert("copy.add", cdto)==1) pass = true;
            			}
            		}
            	}
        	}
        	
        	if(pass==true) {
        		session.commit();
        	}
        	
        	else session.rollback();
        	} catch (Exception e) {
            e.printStackTrace();
            session.rollback();
        	} finally {
        	session.close();
        	}
        
        return pass;
	}

	public List<BookDTO> search(String[] options, String[] keywords, int publishStart, int publishEnd, String sort, String order, int start, int end) {
        
		List<BookDTO> list = null;
		Map<String, Object> map = new HashMap();
		map.put("options", options);
		map.put("keywords", keywords);
		map.put("publishStart", publishStart);
		System.out.println("publishStart : " + publishStart);
		map.put("publishEnd", publishEnd);
		map.put("sort", sort);
		map.put("order", order);
		map.put("start", start);
		map.put("end", end);
		
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			list = session.selectList("book.searchList", map);
			} catch (Exception e) {
            e.printStackTrace();
        	}
        
        return list;

	}

	public List<FilterDTO> makeFilter(String[] options, String[] keywords, int publishStart, int publishEnd) {
		
		List<FilterDTO> filter = null;
		Map<String, Object> map = new HashMap();
		map.put("options", options);
		map.put("keywords", keywords);
		map.put("publishStart", publishStart);
		map.put("publishEnd", publishEnd);
		
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			filter = session.selectList("book.makeFilter", map);
			} catch (Exception e) {
            e.printStackTrace();
        	}
		
		return filter;
	}

	public List<FilterDTO> makeFilterExact(String[] options, String[] keywords, int publishStart, int publishEnd) {
		List<FilterDTO> filter = null;
		Map<String, Object> map = new HashMap();
		map.put("options", options);
		map.put("keywords", keywords);
		map.put("publishStart", publishStart);
		map.put("publishEnd", publishEnd);
		
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			filter = session.selectList("book.makeFilterExact", map);
			} catch (Exception e) {
            e.printStackTrace();
        	}
		
		return filter;
	}

	public List<BookDTO> searchExact(String[] options, String[] keywords, int publishStart, int publishEnd, String sort,
			String order) {
		List<BookDTO> list = null;
		Map<String, Object> map = new HashMap();
		map.put("options", options);
		map.put("keywords", keywords);
		map.put("publishStart", publishStart);
		map.put("publishEnd", publishEnd);
		map.put("sort", sort);
		map.put("order", order);
		
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			list = session.selectList("book.searchListExact", map);
			} catch (Exception e) {
            e.printStackTrace();
        	}
        
        return list;
	}
	


	public List<FilterDTO> makeFilterKeyAndExact(String[] options, String[] keywords, int publishStart, int publishEnd,
			String[] exact_keywords, String[] exact_options) {
		List<FilterDTO> filter = null;
		Map<String, Object> map = new HashMap<>();
		map.put("options", options);
		map.put("keywords", keywords);
		map.put("publishStart", publishStart);
		map.put("publishEnd", publishEnd);
		map.put("exact_keywords", exact_keywords);
		map.put("exact_options", exact_options);
		
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			filter = session.selectList("book.makeFilterKeyAndExact", map);
			} catch (Exception e) {
	        e.printStackTrace();
	    	}
		
		return filter;
	}

	public List<BookDTO> searchKeyAndExact(String[] options, String[] keywords, int publishStart, int publishEnd,
			String sort, String order, String[] exact_keywords, String[] exact_options, int start, int end) {
		List<BookDTO> list = null;
		Map<String, Object> map = new HashMap<>();
		map.put("options", options);
		map.put("keywords", keywords);
		map.put("publishStart", publishStart);
		map.put("publishEnd", publishEnd);
		map.put("sort", sort);
		map.put("order", order);
		map.put("exact_keywords", exact_keywords);
		map.put("exact_options", exact_options);
		map.put("start", start);
		map.put("end", end);
	
	try(SqlSession session = MybatisManager.getInstance().openSession()) {
		list = session.selectList("book.searchListKeyAndExact", map);
		} catch (Exception e) {
        e.printStackTrace();
        System.out.println("에러발생");
    	}
    
    return list;
	}


	public BookDTO view(long isbn) {
		
		BookDTO bdto = null;
		
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			bdto = session.selectOne("book.view", isbn);
			} catch (Exception e) {
	        e.printStackTrace();
	    	}
	    
	    return bdto;
		}

	public Boolean chkCopyAvailable(long isbn) {
		
		//해당 도서에 대출 가능한 사본이 있는지 확인
		Boolean chk = false;
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			int count = session.selectOne("book.chkCopyAvailable", isbn);
			if(count > 0) chk = true;		
			} catch (Exception e) {
	        e.printStackTrace();
	    	}
		
		return chk;
	}
	
	
	public int getBookReserveCount(long isbn) {
		int reserveNum = 0;
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			reserveNum = session.selectOne("book.getBookReserveCount", isbn);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reserveNum;
	}

	public List<CopyDTO> copyList(long isbn) {
		List<CopyDTO> copies = null;
		
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			copies = session.selectList("copy.list", isbn);
			} catch (Exception e) {
	        e.printStackTrace();
	    	}
	    
	    return copies;
	}
	

}
