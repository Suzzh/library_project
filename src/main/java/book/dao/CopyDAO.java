package book.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import book.dto.BookDTO;
import book.dto.CopyDTO;
import config.DB;
import sqlmap.MybatisManager;

public class CopyDAO {
	
	SqlSession session = null;

	public CopyDTO viewCopy(int copy_id) {
		
		CopyDTO cdto = null;

		try {
			session = MybatisManager.getInstance().openSession();
			
			cdto = session.selectOne("copy.view", copy_id);			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return cdto;
	}

	public Long checkUniqueness(String call_number) {
    	
    	Long copy_id = null;
    
        try(SqlSession session = MybatisManager.getInstance().openSession()) {
			copy_id = session.selectOne("copy.checkUniqueness", call_number);
        	} catch (Exception e) {
            e.printStackTrace();
        	}
        
        return copy_id;

    	}

	
	public boolean checkReservationForCopy(long user_id, long copy_id) {
		
		boolean check = false;
		
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			
			Map<String, Long> map = new HashMap<>();
			map.put("user_id", user_id);
			map.put("copy_id", copy_id);
			
			int reservation = session.selectOne("copy.checkReservationForCopy", map);
			if(reservation > 0) check = true;

		} catch (Exception e) {
	        e.printStackTrace();
	    	}
		
		return check;
		
	}


}
