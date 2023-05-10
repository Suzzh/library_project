package circulate;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import circulate.dao.CirculateDAO;
import circulate.dto.CheckoutDTO;
import member.dao.MemberDAO;
import member.dto.MemberDTO;
import work.Library;

@WebServlet("/circulate_servlet/*")
public class CirculateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath(); 
		CirculateDAO dao = new CirculateDAO();
		
		if(uri.indexOf("checkout.do")!=-1) {
			
			 BufferedReader reader = request.getReader();
			 StringBuilder sb = new StringBuilder();
			 String line;
			 
			while((line = reader.readLine())!= null) {
			 sb.append(line);
			 }
			
			reader.close();
			
		 
			String jsonString = sb.toString();
			System.out.println("jsonString : " + jsonString);
			
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();

			Type listType = new TypeToken<List<CheckoutDTO>>() {}.getType();
			/*JSON에 저장된 데이터가 배열 형식일때 원래의 Data Type으로 만들기위해서 사용되는 코드가 아래코드입니다.
			 * new TypeToken<List<Account>>() {}.getType(); 
			 * TypeToken이라는 클래스를 이용해서 List<Account>형식의 객체를 내부적으로 만들고 만들어진 List<Account> 데이터 타입을
			 * getType()이라는 메서드로 얻어오는 동작입니다. 
			*/
			
			List<CheckoutDTO> dtoList = gson.fromJson(jsonString, listType);
			
			
			List<CheckoutDTO> successList = null;
			MemberDTO member = null;

			if(dtoList!=null && dtoList.size()>0) {
				successList = dao.checkout(dtoList);
				
				member = new MemberDTO();
				MemberDAO mdao = new MemberDAO();

				long user_id = dtoList.get(0).getUser_id();
				System.out.println("user_id : " + user_id);
				int numCheckedOut = mdao.countCheckouts(user_id);
				int numLateReturns = mdao.countLateReturns(user_id);
				member.setNumCheckedOut(numCheckedOut);
				member.setNumLateReturns(numLateReturns);
					
					if(numCheckedOut > Library.getMaxBorrow(dtoList.get(0).getUser_type()) || numLateReturns >= 1) {
						member.setCheckout_status("대출불가");
					}
					
					else member.setCheckout_status("정상");
					
				int numReservations = mdao.countReservations(user_id);
				member.setNumReservations(numReservations);

			}
									
			
			Map<String, Object> map = new HashMap<>();
			map.put("successList", successList);
			map.put("member", member);
			
			Gson returnGson = new Gson();
			String json = returnGson.toJson(map);
			System.out.print(json.toString());
			
			//한글깨짐 방지
		    response.setCharacterEncoding("utf-8");
		    
			PrintWriter writer = response.getWriter();
			writer.write(json.toString());
			writer.flush();
			writer.close();
			
			
		}
		
		else if(uri.indexOf("getDuedate")!=-1) {
			
			String user_type = request.getParameter("user_type");
			System.out.println("user_type : " + user_type);
			
			String due_date = dao.getDuedate(user_type);
			
			Map<String, Object> map = new HashMap<>();
			map.put("due_date", due_date);
			
			Gson returnGson = new Gson();
			String json = returnGson.toJson(map);
			
			PrintWriter writer = response.getWriter();
			writer.write(json.toString());
			writer.flush();
			writer.close();
			
			}
	
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
