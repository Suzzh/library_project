package book.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import book.dto.AuthorDTO;
import config.DB;

public class AuthorDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	

	public Map<String, ArrayList> makeAuthor(String[] author, String[] translator,
			String[] painter) {
		
		
		Map<String, ArrayList>authorMap = new HashMap<>();
		ArrayList<Integer> author_id_list = new ArrayList<>();
		ArrayList<Integer> translator_id_list = new ArrayList<>();
		ArrayList<Integer> painter_id_list = new ArrayList<>();
		
		
		
		try {
			conn = DB.getConn();
			
			if(author!=null) {
			for(String author1 : author) {
				if(!author1.trim().isEmpty()) {
				pstmt = conn.prepareStatement("insert into author (author_id, author_name) "
							+ "values (author_id_seq.nextval, ?)");
				pstmt.setString(1, author1.trim());
				pstmt.executeUpdate();
				pstmt = conn.prepareStatement("select author_id_seq.currval from dual ");
				rs = pstmt.executeQuery();
				if(rs.next()) {
					int currentId = rs.getInt(1);
					author_id_list.add(currentId);
				}

				}
				
			}
			
			}
			
			
			if(translator!=null) {
			for(String translator1 : translator) {
				if(!translator1.trim().isEmpty()) {
				pstmt = conn.prepareStatement("insert into author (author_id, author_name) "
							+ "values (author_id_seq.nextval, ?)");
				pstmt.setString(1, translator1.trim());
				pstmt.executeUpdate();		
				pstmt = conn.prepareStatement("select author_id_seq.currval from dual ");
				rs = pstmt.executeQuery();
				if(rs.next()) {
					int currentId = rs.getInt(1);
					translator_id_list.add(currentId);
				}
				}

				}			
			} 
			
			if(painter!=null) {
			for(String painter1 : painter) {
				if(!painter1.trim().isEmpty()) {
				pstmt = conn.prepareStatement("insert into author (author_id, author_name) "
							+ "values (author_id_seq.nextval, ?)");
				pstmt.setString(1, painter1.trim());
				pstmt.executeUpdate();		
				pstmt = conn.prepareStatement("select author_id_seq.currval from dual ");
				rs = pstmt.executeQuery();
				if(rs.next()) {
					int currentId = rs.getInt(1);
					painter_id_list.add(currentId);
				}
				}
				}			
			} 
			
						
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			try {
				if(pstmt!=null) pstmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			try {
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			
		}
		
		
		authorMap.put("author_id_list", author_id_list);
		authorMap.put("painter_id_list", painter_id_list);
		authorMap.put("translator_id_list", translator_id_list);
		return authorMap;
		
		
		
	}


	public void addBookAuthor(long isbn, Map<String, ArrayList> authorMap) {
		ArrayList<Integer> author_id_list = authorMap.get("author_id_list"); 
		ArrayList<Integer> translator_id_list = authorMap.get("translator_id_list"); 
		ArrayList<Integer> painter_id_list = authorMap.get("painter_id_list"); 
		
	
	try {

		
		conn = DB.getConn();
		
		System.out.println(author_id_list.size());
		System.out.println(translator_id_list.size());
		System.out.println(painter_id_list.size());
		
		if(author_id_list.size()>=1) {
			StringBuilder sql = new StringBuilder();
			sql.append("insert into book_author (book_author_id, isbn, author_id, author_type) ");
			sql.append("values (book_author_id_seq.nextval, ? , ? , '지음')");
					
			for(int author_id : author_id_list) {
				pstmt = conn.prepareStatement(sql.toString());
				pstmt.setLong(1, isbn);
				pstmt.setInt(2, author_id);	
				pstmt.executeUpdate();
			}
		}
		
		if(translator_id_list.size()>=1) {
			StringBuilder sql = new StringBuilder();
			sql.append("insert into book_author (book_author_id, isbn, author_id, author_type) ");
			sql.append("values (book_author_id_seq.nextval, ? , ? , '옮김')");
					
			for(int translator_id : translator_id_list) {
				pstmt = conn.prepareStatement(sql.toString());
				pstmt.setLong(1, isbn);
				pstmt.setInt(2, translator_id);	
				pstmt.executeUpdate();
			}
		}
		
		if(painter_id_list.size()>=1) {
			StringBuilder sql = new StringBuilder();
			sql.append("insert into book_author (book_author_id, isbn, author_id, author_type) ");
			sql.append("values (book_author_id_seq.nextval, ? , ? , '그림')");
					
			for(int painter_id : painter_id_list) {
				pstmt = conn.prepareStatement(sql.toString());
				pstmt.setLong(1, isbn);
				pstmt.setInt(2, painter_id);	
				pstmt.executeUpdate();
			}
		}
		
		
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if(pstmt!=null) pstmt.close();
		} catch (Exception e2) {
			e2.printStackTrace();
		}
		try {
			if(conn!=null) conn.close();
		} catch (Exception e2) {
			e2.printStackTrace();
		}
		
	}


}
}
