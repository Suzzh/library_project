package admin.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import sqlmap.MybatisManager;

public class AdminDAO {

	public String loginCheck(long admin_id, String passwd) {
		
		String admin_name = "";
		
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			
			Map<String, Object> map = new HashMap<>();
			
			map.put("admin_id", admin_id);
			map.put("passwd", passwd);
			
			admin_name = session.selectOne("admin.loginCheck", map);

			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return admin_name;
	}

	public String getDept(long admin_id) {
		String lib_dept = "";
		
		
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			
			Map<String, Object> map = new HashMap<>();
			
			lib_dept= session.selectOne("admin.getDept", admin_id);

			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return lib_dept;
	}

}
