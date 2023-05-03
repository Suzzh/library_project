package work.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.sql.Date;

import org.apache.ibatis.session.SqlSession;

import config.DB;
import sqlmap.MybatisManager;

public class WorkDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;


	public void makeHoliday(String[] dates, String[] names) {
		
				
		try {
			String sql = "insert into holiday (holiday_date, holiday_name) values(?, ?)";
		  	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		  	
			conn = DB.getConn();
			pstmt = conn.prepareStatement(sql);
		  	  
	    	for(int i=0; i<dates.length; i++) {
	    		java.util.Date date = formatter.parse(dates[i]);
	    		java.sql.Date sqlDate = new java.sql.Date(date.getTime());
	    		System.out.println(sqlDate);
	    		
	    		pstmt.setDate(1, sqlDate);
	    		pstmt.setString(2, names[i]);
	    		pstmt.executeUpdate();  
	    		  
	    	  }

		}catch(Exception e) {
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

