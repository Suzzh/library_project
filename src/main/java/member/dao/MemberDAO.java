package member.dao;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;

import org.apache.ibatis.session.SqlSession;

import circulate.dao.CirculateDAO;
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
		
		

		public MemberDTO setCheckoutStatus(MemberDTO dto) {
			
			//아예 checkoutDTO들을 받아오는걸로 바꾸기 ~ 범용성있게
			Map<String, Object> checkoutsMap = CirculateDAO.getCheckout(dto.getUser_id());
			
			int numCheckedOut = Integer.parseInt(String.valueOf(checkoutsMap.get("CHECKOUTS")));
			int numLateReturns = Integer.parseInt(String.valueOf(checkoutsMap.get("LATE_RETURNS")));

			dto.setNumCheckedOut(numCheckedOut);
			dto.setNumLateReturns(numLateReturns);
			
			if(numCheckedOut > Library.getMaxBorrow(dto.getUser_type()) || numLateReturns >= 1) {
				dto.setCheckout_status("대출불가");
			}
			
			else dto.setCheckout_status("정상");
			
			return dto;
		}
}
