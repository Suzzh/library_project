package book.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Map;

import config.DB;

public class Book_AuthorDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public void addBook_Author(long isbn, Map<String, ArrayList> authorMap) {
		
		try {
			ArrayList<Integer> author_id_list = authorMap.get("author_id_list"); 
			ArrayList<Integer> translator_id_list = authorMap.get("translator_id_list"); 
			ArrayList<Integer> painter_id_list = authorMap.get("painter_id_list"); 
			System.out.println(author_id_list);
			System.out.println(translator_id_list);
			System.out.println(painter_id_list);
			
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
