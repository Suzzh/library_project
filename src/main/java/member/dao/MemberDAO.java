package member.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;

import org.apache.ibatis.session.SqlSession;

import book.dto.BookDTO;
import circulate.dao.CirculateDAO;
import circulate.dto.CheckoutDTO;
import member.dto.MemberDTO;
import member.dto.ProfessorDTO;
import member.dto.StudentDTO;
import member.dto.UserDTO;
import sqlmap.MybatisManager;
import work.Library;

public class MemberDAO {
			
		public MemberDTO view(Long user_id) {
			MemberDTO dto = null;
				
			try (SqlSession session = MybatisManager.getInstance().openSession()) {
				
				dto = session.selectOne("member.member_view", user_id);
				
				if(dto!=null) {
					if(dto.getUser_type().equals("학생")) {
						StudentDTO sdto = session.selectOne("member.student_view", user_id);
						dto.setSdto(sdto);
					}
					
					else if(dto.getUser_type().equals("교수")) {
						ProfessorDTO pdto = session.selectOne("member.professor_view", user_id);
						dto.setPdto(pdto);
					}
				}
								
			} catch (Exception e) {
				e.printStackTrace();
			} 
			
			return dto;
		}

		public String loginCheck(long user_id, String passwd) {
			
			String name = "";
			
			try(SqlSession session = MybatisManager.getInstance().openSession()) {
				
				Map<String, Object> map = new HashMap<>();
				map.put("user_id", user_id);
				map.put("passwd", passwd);
				
				name = session.selectOne("member.loginCheck", map);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return name;
		}

		public List<CheckoutDTO> getBorrowedBooks(Long user_id) {
			List<CheckoutDTO> borrowedBooks = null;
			 
				try(SqlSession session = MybatisManager.getInstance().openSession()) {
					
					borrowedBooks = session.selectList("member.getBorrowedBooks", user_id);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			return borrowedBooks;
		}

		public String getUserType(Long user_id) {
			String user_type = "";
			
			try(SqlSession session = MybatisManager.getInstance().openSession()) {
				
				user_type = session.selectOne("member.getUserType", user_id);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return user_type;
		}

		
}
