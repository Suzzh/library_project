package book.dao;

import java.util.List;

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

	public void makeCopy(CopyDTO cdto) {
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			session.insert("copy.add", cdto);
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public List<CopyDTO> list(long isbn) {
		
		List<CopyDTO> copies = null;
		
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			copies = session.selectList("copy.list", isbn);
			} catch (Exception e) {
	        e.printStackTrace();
	    	}
	    
	    return copies;
		}
		


}
