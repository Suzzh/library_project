package book.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import book.dto.BookDTO;
import book.dto.CopyDTO;
import book.dto.FilterDTO;
import config.DB;
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

	public void makeBookInfo(BookDTO dto) {
		
        try(SqlSession session = MybatisManager.getInstance().openSession()) {
			session.insert("book.add", dto);
			session.commit();
        	} catch (Exception e) {
            e.printStackTrace();
        	}
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
			list = session.selectList("book.searchList2", map);
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
			//copy등록번호 순으로 출력되게끔 변경
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

	
	

}
