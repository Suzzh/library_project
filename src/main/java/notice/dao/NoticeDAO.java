package notice.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.cursor.Cursor;
import org.apache.ibatis.executor.BatchResult;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import config.DB;
import notice.dto.NoticeDTO;
import sqlmap.MybatisManager;

public class NoticeDAO {
	
	List<NoticeDTO> notices = null;

	public void writeBoard(NoticeDTO dto) {
		try (SqlSession session = MybatisManager.getInstance().openSession()) {
			session.insert("notice.write", dto);
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	public List<NoticeDTO> boardList(String category, int start, int end) {
		
		//관리자 로그인 시 부서명이 아닌 사람이름이 보일 수 있게 수정
		try (SqlSession session = MybatisManager.getInstance().openSession()) {
			switch(category) {
			case "general": category="일반"; break;
			case "facility": category="시설"; break;
			case "academic": category="학술정보"; break;
			}
			
			Map<String, Object> map = new HashMap<>();
			map.put("start", start);
			map.put("end", end);
			map.put("category", category);
			
			
			notices = session.selectList("notice.list", map);
						
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return notices;
		
	}


	public NoticeDTO viewNotice(int notice_id, boolean updateViewCount) {
		
		NoticeDTO dto = null;
		
		try(SqlSession session = MybatisManager.getInstance().openSession()) {

			if(updateViewCount == true) {
				session.update("notice.updateViewCount", notice_id);
				session.commit();
			}

			dto = session.selectOne("notice.view", notice_id);

			session.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;

	}


	public int noticeCount(String category) {
		
		int count = 0;
		
		try (SqlSession session = MybatisManager.getInstance().openSession()) {
			switch(category) {
			case "general": category="일반"; break;
			case "facility": category="시설"; break;
			case "academic": category="학술정보"; break;
			}
			
			count = session.selectOne("notice.count", category);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return count;
		
	}


	public List<HashMap<String, Object>> recentBoardList(int end) {

		List<HashMap<String, Object>> noticeList = null;
		try (SqlSession session = MybatisManager.getInstance().openSession()) {
			
			noticeList = session.selectList("notice.recentList", end);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return noticeList;
	}

	
	//게시글의 첨부파일 이름 찾기
	public String getFileName(int notice_id) {
		String filename = "";
		
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			filename = session.selectOne("notice.getFileName", notice_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return filename;
	}


	public void updateBoard(NoticeDTO dto) {
		try(SqlSession session = MybatisManager.getInstance().openSession()) {
			session.update("notice.update", dto);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}



}
	
	

