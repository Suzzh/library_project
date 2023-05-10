package circulate.dao;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

import org.apache.ibatis.session.SqlSession;

import book.dao.BookDAO;
import book.dao.CopyDAO;
import book.dto.CopyDTO;
import circulate.dto.CheckoutDTO;
import sqlmap.MybatisManager;
import work.Library;

public class CirculateDAO {


	public List<CheckoutDTO> checkout(List<CheckoutDTO> dtoList) {
		
		List <CheckoutDTO> successfulCheckouts = new ArrayList<>();
		long user_id = dtoList.get(0).getUser_id();
		String user_type = dtoList.get(0).getUser_type();
		
		try (SqlSession session = MybatisManager.getInstance().openSession())
		{
			
			try {
				
				for(int i=0; i<dtoList.size(); i++) {
					CheckoutDTO dto = dtoList.get(i);
					
					int numCheckedOut = session.selectOne("member.countCheckouts", user_id);
					int numLateReturns = session.selectOne("member.countLateReturns", user_id);
					if(numCheckedOut > Library.getMaxBorrow(user_type) || numLateReturns >= 1) break;
					
					
					//대출가능, 대출중, 예약서가,  분실, 파손, 대출불가, 정리중 가운데
					//대출가능, 예약서가, 정리중인 경우에만 대출 가능
					String copyStatus = session.selectOne("copy.checkStatus", dto.getCopy_id());
					if(!copyStatus.equals("대출가능") && !copyStatus.equals("예약서가") && !copyStatus.equals("정리중")) continue;
					
					BookDAO bdao = new BookDAO();
					int reserveCount = bdao.getBookReserveCount(dtoList.get(i).getIsbn());
					if(reserveCount > 0) { //도서를 예약한 사람이 있다면 
						//이 회원이 이 책을 예약했는지 확인
						//나중에 에러메시지도 출력되게끔 바꾸기
						CopyDAO cdao = new CopyDAO();
						Boolean check = cdao.checkReservationForCopy(dto.getUser_id(), dto.getCopy_id());
						if(check == false) continue;
					}
					
					int checkoutResult = session.insert("circulate.checkout", dto);
					
					if(checkoutResult == 1) {
						CopyDTO copy = new CopyDTO();
						copy.setCopy_id(dtoList.get(i).getCopy_id());
						copy.setStatus("대출중");
						int updateResult = session.update("copy.updateStatus", copy);
						
						if(updateResult == 1) {
							successfulCheckouts.add(dto);
							session.commit();
						}
						
						else {
							session.rollback();
							continue;
						}
					}
					
					else {
						session.rollback();
						continue;
					}
				}
						
				} catch (Exception e) {
					session.rollback();
					e.printStackTrace();
				} 
			} catch (Exception e) {
			e.printStackTrace();
		}
		
		return successfulCheckouts;
		
		
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


	public String renewal(long user_id, String user_type, ArrayList<CheckoutDTO> checkoutList) {
		
		int countSuccess = 0;
		StringBuilder message = new StringBuilder();
		ArrayList<String> errors = new ArrayList<>();
		ArrayList<Long> newList = new ArrayList<>();
		
		try (SqlSession session = MybatisManager.getInstance().openSession()){
			
			for(CheckoutDTO dto : checkoutList) {
				long checkout_id = dto.getCheckout_id();
				
				/*
				int countRenewal = session.selectOne("circulate.countRenewal", checkout_id);
				if(countRenewal > Library.MAX_RENEWAL) {
					errors.add(dto.getTitle() + "(사유: 연장횟수초과)");
					continue;
				}
				*/

				int reservationChk = session.selectOne("circulate.chkReservationByChkoutID", checkout_id);
				if(reservationChk > 0) {
					errors.add(dto.getTitle());
					continue;
				}
				
				else newList.add(checkout_id);
				}

			
			//연장
			Map<String, Object> data = new HashMap<>();
			data.put("newList", newList);
			data.put("new_due_date", getDuedate(user_type));
			data.put("max_renewal", Library.MAX_RENEWAL);

			countSuccess = session.update("circulate.renewal", data);
			session.commit();
			
			message.append("총 " + countSuccess + "권의 책이 대출 연장되었습니다.");
			if(errors.size()>0) {
				message.append("\n\n====다음 도서들은 예약자가 존재하여 연장이 불가능합니다.====\n");
				message.append(String.join("\n", errors));
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return message.toString();
		
	}


	public String make_reservation(long user_id, long isbn) {
		
		String message = "";
		Map<String, Object> map = new HashMap<>();

		try (SqlSession session = MybatisManager.getInstance().openSession()) {
		
			//예약 가능여부 확인
			Boolean reservation_ok = false;
			
			BookDAO bdao = new BookDAO();
			List<CopyDTO> copies = bdao.copyList(isbn);
			int reservation_count = bdao.getBookReserveCount(isbn);
			
			
			if(copies!=null) {
				
				//도서의 예약가능여부 확인
				Stream<CopyDTO> copyStream = copies.stream();
				Stream<CopyDTO> copyStream2 = copies.stream();
				if(copyStream.noneMatch(c -> c.getStatus().equals("대출가능")) &&
						copyStream2.anyMatch(c -> c.getStatus().equals("정리중") || c.getStatus().equals("예약서가") || c.getStatus().equals("대출중")) &&
						copies.size()*10 > reservation_count) {
					
					//이 회원이 이 도서를 이미 예약했는지 확인
					map.put("user_id", user_id);
					map.put("isbn", isbn);
					int count = session.selectOne("member.checkReservation", map);

					if(count == 0) {
						//이 회원의 도서 예약 횟수 확인
						int count2 = session.selectOne("member.countReservations", user_id);
						if(count2 < Library.MAX_RESERVATION) {
							reservation_ok = true;
					}
						else {
							message = "예약 가능 권수를 초과하였습니다./n(1인당 최대 " + Library.MAX_RESERVATION + "권까지 예약 가능";
						}
					}
					else {
						message = "이미 동일한 도서의 예약 내역이 존재합니다.";
					}
				}else {
					message = "이 도서는 예약할 수 없습니다.";
				}
			}
			
			if(reservation_ok == true) {
				int num = session.insert("reservation", map);
				session.commit();
				
				if(num == 1) message = "도서를 예약하였습니다.";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(message.equals("")) message = "도서 예약에 실패하였습니다.\n이 문제가 반복되면 관리자에게 문의해주세요.";
		return message;
	}
	
	

}
