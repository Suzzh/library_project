package collection.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import book.dto.BookDTO;
import sqlmap.MybatisManager;

public class CollectionDAO {

	public List<BookDTO> getTopList(int start, int end, String category, int days) {
		
		String classification_code = "";
		
		if(category.equals("1")) classification_code = "0, 1, 2";
		else if(category.equals("2")) classification_code = "3, 4";
		else if(category.equals("3")) classification_code = "5, 6";
		else if(category.equals("4")) classification_code = "7, 8, 9";
		
		Map<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		map.put("classification_code", classification_code);
		map.put("days", days);

		List<BookDTO> topList = null;
		
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			topList = session.selectList("book.topList", map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return topList;
	}

	public int getTopNums(String category, int max, int days) {
		int num = 0;
		
		Map<String, Object> map = new HashMap<>();
		
		String classification_code = "";
		
		if(category.equals("1")) classification_code = "0, 1, 2";
		else if(category.equals("2")) classification_code = "3, 4";
		else if(category.equals("3")) classification_code = "5, 6";
		else if(category.equals("4")) classification_code = "7, 8, 9";
					
		map.put("classification_code", classification_code);
		map.put("max", max);
		map.put("days", days);
				
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			num = session.selectOne("book.getTopNums", map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return num;
	}

	
	public List<HashMap<String, Object>> getSimpleTopList(int start, int end) {
		Map<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);

		List<HashMap<String, Object>> topList = null;
		
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			topList = session.selectList("book.simpleTopList", map);			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return topList;
	}

	public List<HashMap<String, Object>> getSimpleRecentList(int start, int end) {
		Map<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);

		List<HashMap<String, Object>> recentList = null;
		
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			recentList = session.selectList("book.simpleRecentList", map);			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return recentList;
	}

}
