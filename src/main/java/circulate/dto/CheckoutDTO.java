package circulate.dto;

import java.util.Date;

public class CheckoutDTO {
	
	private long checkout_id;
	private long copy_id;
	private long isbn;
	private long user_id;
	private Date checkout_date;
	private Date renewal_date;
	private Date due_date;
	private Date return_date;
	private String title;
	private String main_author;
	private int renewal_count;
	private String user_type;
	private int late_count;
	private int late_days;
	
	public long getCheckout_id() {
		return checkout_id;
	}

	public void setCheckout_id(long checkout_id) {
		this.checkout_id = checkout_id;
	}


	public long getCopy_id() {
		return copy_id;
	}


	public void setCopy_id(long copy_id) {
		this.copy_id = copy_id;
	}


	public long getIsbn() {
		return isbn;
	}


	public void setIsbn(long isbn) {
		this.isbn = isbn;
	}


	public long getUser_id() {
		return user_id;
	}


	public void setUser_id(long user_id) {
		this.user_id = user_id;
	}


	public Date getCheckout_date() {
		return checkout_date;
	}


	public void setCheckout_date(Date checkout_date) {
		this.checkout_date = checkout_date;
	}


	public Date getRenewal_date() {
		return renewal_date;
	}


	public void setRenewal_date(Date renewal_date) {
		this.renewal_date = renewal_date;
	}


	public Date getDue_date() {
		return due_date;
	}


	public void setDue_date(Date due_date) {
		this.due_date = due_date;
	}


	public Date getReturn_date() {
		return return_date;
	}


	public void setReturn_date(Date return_date) {
		this.return_date = return_date;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public int getRenewal_count() {
		return renewal_count;
	}


	public void setRenewal_count(int renewal_count) {
		this.renewal_count = renewal_count;
	}


	public String getUser_type() {
		return user_type;
	}


	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public int getLate_count() {
		return late_count;
	}

	public void setLate_count(int late_count) {
		this.late_count = late_count;
	}

	public int getLate_days() {
		return late_days;
	}

	public void setLate_days(int late_days) {
		this.late_days = late_days;
	}

	public String getMain_author() {
		return main_author;
	}

	public void setMain_author(String main_author) {
		this.main_author = main_author;
	}

	@Override
	public String toString() {
		return "CheckoutDTO [checkout_id=" + checkout_id + ", copy_id=" + copy_id + ", isbn=" + isbn + ", user_id="
				+ user_id + ", checkout_date=" + checkout_date + ", renewal_date=" + renewal_date + ", due_date="
				+ due_date + ", return_date=" + return_date + ", title=" + title + ", main_author=" + main_author
				+ ", renewal_count=" + renewal_count + ", user_type=" + user_type + ", late_count=" + late_count
				+ ", late_days=" + late_days + "]";
	}

	
	
}
