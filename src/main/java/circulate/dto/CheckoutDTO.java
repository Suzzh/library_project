package circulate.dto;

import java.util.Date;

public class CheckoutDTO {
	
	private long checkout_id;
	private long copy_id;
	private long user_id;
	private Date checkout_date;
	private Date renewal_date;
	private Date due_date;
	private Date return_date;
	private String title;
	
	private String user_type;

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

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	@Override
	public String toString() {
		return "CheckoutDTO [checkout_id=" + checkout_id + ", copy_id=" + copy_id + ", user_id=" + user_id
				+ ", checkout_date=" + checkout_date + ", renewal_date=" + renewal_date + ", due_date=" + due_date
				+ ", return_date=" + return_date + ", title=" + title + ", user_type=" + user_type + "]";
	}
	
	
	
	
}
