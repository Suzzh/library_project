package book.dto;

import java.util.Date;

public class AuthorDTO {
	
	private int author_id;
	private int book_author_id;
	private String author_name, biography, works, author_type;
	private Date birthdate;
	private int preference;

	
	public AuthorDTO() {
		
	}
	
	public AuthorDTO(int author_id, String author_name, String biography, String works, String author_type,
			Date birthdate, int preference) {
		super();
		this.author_id = author_id;
		this.author_name = author_name;
		this.biography = biography;
		this.works = works;
		this.author_type = author_type;
		this.birthdate = birthdate;
		this.preference = preference;
	}

	public int getAuthor_id() {
		return author_id;
	}

	public void setAuthor_id(int author_id) {
		this.author_id = author_id;
	}

	public String getAuthor_name() {
		return author_name;
	}

	public void setAuthor_name(String author_name) {
		this.author_name = author_name;
	}

	public String getBiography() {
		return biography;
	}

	public void setBiography(String biography) {
		this.biography = biography;
	}

	public String getWorks() {
		return works;
	}

	public void setWorks(String works) {
		this.works = works;
	}

	public String getAuthor_type() {
		return author_type;
	}

	public void setAuthor_type(String author_type) {
		this.author_type = author_type;
	}

	public Date getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}

	public int getPreference() {
		return preference;
	}

	public void setPreference(int preference) {
		this.preference = preference;
	}
	
	
	public int getBook_author_id() {
		return book_author_id;
	}

	public void setBook_author_id(int book_author_id) {
		this.book_author_id = book_author_id;
	}

	@Override
	public String toString() {
		return "AuthorDTO [author_id=" + author_id + ", book_author_id=" + book_author_id + ", author_name="
				+ author_name + ", biography=" + biography + ", works=" + works + ", author_type=" + author_type
				+ ", birthdate=" + birthdate + ", preference=" + preference + "]";
	}

	


	
	

}
