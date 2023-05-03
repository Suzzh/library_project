package book.dto;

import java.util.Date;

public class CopyDTO {
	

	private long copy_id, isbn;
	private String call_number, location, status;
	private String acquisition_date;
	private BookDTO bookDTO;
	private Date due_date;

	
	public CopyDTO() {
		
	}
	

	public CopyDTO(long copy_id, long isbn, String call_number, String location, String status, String acquisition_date,
			BookDTO bookDTO) {
		super();
		this.copy_id = copy_id;
		this.isbn = isbn;
		this.call_number = call_number;
		this.location = location;
		this.status = status;
		this.acquisition_date = acquisition_date;
		this.bookDTO = bookDTO;
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


	public String getCall_number() {
		return call_number;
	}


	public void setCall_number(String call_number) {
		this.call_number = call_number;
	}


	public String getLocation() {
		return location;
	}


	public void setLocation(String location) {
		this.location = location;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getAcquisition_date() {
		return acquisition_date;
	}


	public void setAcquisition_date(String acquisition_date) {
		this.acquisition_date = acquisition_date;
	}


	public BookDTO getBookDTO() {
		return bookDTO;
	}


	public void setBookDTO(BookDTO bookDTO) {
		this.bookDTO = bookDTO;
	}
	
	
	public Date getDue_date() {
		return due_date;
	}


	public void setDue_date(Date due_date) {
		this.due_date = due_date;
	}


	@Override
	public String toString() {
		return "CopyDTO [copy_id=" + copy_id + ", isbn=" + isbn + ", call_number=" + call_number + ", location="
				+ location + ", status=" + status + ", acquisition_date=" + acquisition_date + ", bookDTO=" + bookDTO
				+ "]";
	}
	
	



}
