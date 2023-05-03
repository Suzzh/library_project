package work;

import java.util.Calendar;
import java.util.Date;

public class Library {

	public static final int MAX_BORROW_STD = 10;
	public static final int MAX_BORROW_PROF = 40;
	public static final int CHECKOUT_PERIOD_STD = 14;
	public static final int CHECKOUT_PERIOD_PROF = 60;
	
	
	public static int getMaxBorrow(String member_type) {
		
		switch(member_type) {
		case "학생": return MAX_BORROW_STD;
		case "교수": return MAX_BORROW_PROF;
		default: return 0;
		}
	}
	
		
}
