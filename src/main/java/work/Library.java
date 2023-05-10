package work;

public class Library {

	public static final int MAX_BORROW_STD = 10;
	public static final int MAX_BORROW_PROF = 40;
	public static final int CHECKOUT_PERIOD_STD = 14;
	public static final int CHECKOUT_PERIOD_PROF = 60;
	public static final int MAX_RESERVATION = 3;
	public static final int MAX_RENEWAL = 1;
	
	public static int getMaxBorrow(String user_type) {
		switch(user_type) {
		case "학생": return MAX_BORROW_STD;
		case "교수": return MAX_BORROW_PROF;
		default: return 0;
		}
	}


	public static int getCheckoutPeriod(String user_type) {
		switch(user_type) {
		case "학생": return CHECKOUT_PERIOD_STD;
		case "교수": return CHECKOUT_PERIOD_PROF;
		default: return 0;
		}
	}
	
		
}
