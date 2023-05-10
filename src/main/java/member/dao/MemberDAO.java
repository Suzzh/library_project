package member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import circulate.dto.CheckoutDTO;
import member.dto.MemberDTO;
import member.dto.ProfessorDTO;
import member.dto.StudentDTO;
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
		
		
		public String getUserType(Long user_id) {
			String user_type = "";
			
			try(SqlSession session = MybatisManager.getInstance().openSession()) {
				
				user_type = session.selectOne("member.getUserType", user_id);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return user_type;
		}
		

		public List<CheckoutDTO> getBorrowedBooks(long user_id, int start, int end) {
			List<CheckoutDTO> borrowedBooks = null;
				try(SqlSession session = MybatisManager.getInstance().openSession()) {
					
					Map<String, Object> map = new HashMap<>();
					map.put("user_id", user_id);
					map.put("start", start);
					map.put("end", end);
					
					borrowedBooks = session.selectList("member.getBorrowedBooks", map);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			return borrowedBooks;
		}
		
		public int countCheckouts(Long user_id) {
			int numCheckedOut = 0;

			try(SqlSession session = MybatisManager.getInstance().openSession()){
				numCheckedOut = session.selectOne("member.countCheckouts", user_id);
			}
			return numCheckedOut;
		}

		public int countLateReturns(Long user_id) {
			int numLateReturns = 0;

			try(SqlSession session = MybatisManager.getInstance().openSession()){
				numLateReturns = session.selectOne("member.countLateReturns", user_id);
			}
			return numLateReturns;
		}

		public int countReservations(Long user_id) {
			int numReservations = 0;

			try(SqlSession session = MybatisManager.getInstance().openSession()){
				numReservations = session.selectOne("member.countReservations", user_id);
			}
			return numReservations;
		}
		
		
		
		public MemberDTO getUserDTO(HttpSession session) {
			
			long user_id = (Long)(session.getAttribute("user_id"));
			MemberDTO dto = new MemberDTO();

			dto.setUser_id(user_id);
			
			String user_type = getUserType(user_id);
			dto.setUser_type(user_type);
			
			int numCheckedOut = countCheckouts(user_id);
			int numLateReturns = countLateReturns(user_id);
			int numReservations = countReservations(user_id);
			dto.setNumCheckedOut(numCheckedOut);
			dto.setNumLateReturns(numLateReturns);
			dto.setNumReservations(numReservations);

			if(numCheckedOut > Library.getMaxBorrow(dto.getUser_type()) || numLateReturns >= 1) {
				dto.setCheckout_status("대출불가");
			}
			
			else dto.setCheckout_status("정상");
			

			return dto;
		}


		public String getUserCheckoutStatus(long user_id, String user_type) {
			int numCheckedOut = countCheckouts(user_id);
			int numLateReturns = countLateReturns(user_id);
			if(numCheckedOut > Library.getMaxBorrow(user_type) || numLateReturns >= 1) {
				return "대출불가";
			}
			
			else return"정상";
		}

		
}
