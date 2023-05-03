package circulate.dao;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import book.dto.CopyDTO;
import circulate.dto.CheckoutDTO;
import sqlmap.MybatisManager;
import work.Library;

public class CirculateDAO {


	public List<CheckoutDTO> checkout(List<CheckoutDTO> dtoList) {
		
		System.out.println("dao.checkout 진입");
		List <CheckoutDTO> successfulCheckouts = new ArrayList<>();
		
		try (SqlSession session = MybatisManager.getInstance().openSession())
		{
			
			try {
				
				for(int i=0; i<dtoList.size(); i++) {
					Map<String, Object> checkoutsMap = null;

					checkoutsMap = session.selectOne("circulate.countCheckouts", dtoList.get(i).getUser_id());
					
					if(Integer.parseInt(String.valueOf(checkoutsMap.get("CHECKOUTS")))>=Library.getMaxBorrow(dtoList.get(i).getUser_type()) 
							|| Integer.parseInt(String.valueOf(checkoutsMap.get("LATE_RETURNS")))>0) break;
					
					//copy 상태 확인 후 대출하게끔 수정요망
					int checkoutResult = session.insert("circulate.checkout", dtoList.get(i));
					
					System.out.println("result는" + checkoutResult);
					
					if(checkoutResult == 1) {
						
						CopyDTO copy = new CopyDTO();
						copy.setCopy_id(dtoList.get(i).getCopy_id());
						copy.setStatus("대출중");
						int updateResult = session.update("copy.updateStatus", copy);
						
						if(updateResult == 1) {
							successfulCheckouts.add(dtoList.get(i));
							System.out.println("대출성공");
						}
					}
				}
				
				System.out.println("커밋");
				session.commit();
						
				} catch (Exception e) {
					System.out.println("에러발생1");
					session.rollback();
					e.printStackTrace();
				} 
			} catch (Exception e) {
				System.out.println("에러발생2");
			e.printStackTrace();
		}
		
		System.out.println("체크아웃 나가기");
		return successfulCheckouts;
		
		
	}

	public static Map<String, Object> getCheckout(Long user_id) {
		Map<String, Object> checkoutsMap = null;
		try(SqlSession session = MybatisManager.getInstance().openSession()){
			checkoutsMap = session.selectOne("circulate.countCheckouts", user_id);
		}
		return checkoutsMap;
	}

	
	public String getDuedate(String user_type) {
		
		LocalDate date = LocalDate.now();
		
		if(user_type.equals("학생")) {
			date = date.plusDays(Library.CHECKOUT_PERIOD_STD);
		}

		else if(user_type.equals("교수")) {
			date = date.plusDays(Library.CHECKOUT_PERIOD_PROF);
		}

		try (SqlSession session = MybatisManager.getInstance().openSession()){

			
		while(true) {
			int result = session.selectOne("work.isHoliday", date.toString());
			System.out.println("result : " + result);
			if(result > 0) {
				date = date.plusDays(1);
				continue;
			}
			
			if(date.getDayOfWeek()==DayOfWeek.SUNDAY) date = date.plusDays(1);
			else break;
		}
					
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String due_date = date.format(formatter);
		return due_date;
		
	}
	


}
