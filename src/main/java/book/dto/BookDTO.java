package book.dto;

import java.util.Date;
import java.util.List;

public class BookDTO {

	
	private int publication_year;
	private int page_count;
	private int volume_number;
	private float book_size;
	private String title;
	private String series_title;
	private String publisher_location;
	private String publisher_name;
	private String edition;
	private String img_url;
	private String book_description;
	private String classification_code;
	private Date register_date;
	private Date last_update_date;
	private long isbn;
	private int checkout_times;
	private int rank;

	private List<CopyDTO> copies;
	private List<AuthorDTO> authors;

	private String main_author;
	

	public List<CopyDTO> getCopies() {
		return copies;
	}

	public void setCopies(List<CopyDTO> copies) {
		this.copies = copies;
	}

	public int getPublication_year() {
		return publication_year;
	}


	public void setPublication_year(int publication_year) {
		this.publication_year = publication_year;
	}


	public int getPage_count() {
		return page_count;
	}


	public void setPage_count(int page_count) {
		this.page_count = page_count;
	}


	public int getVolume_number() {
		return volume_number;
	}


	public void setVolume_number(int volume_number) {
		this.volume_number = volume_number;
	}


	public float getBook_size() {
		return book_size;
	}


	public void setBook_size(float book_size) {
		this.book_size = book_size;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getSeries_title() {
		return series_title;
	}


	public void setSeries_title(String series_title) {
		this.series_title = series_title;
	}


	public String getPublisher_location() {
		return publisher_location;
	}


	public void setPublisher_location(String publisher_location) {
		this.publisher_location = publisher_location;
	}


	public String getPublisher_name() {
		return publisher_name;
	}


	public void setPublisher_name(String publisher_name) {
		this.publisher_name = publisher_name;
	}


	public String getEdition() {
		return edition;
	}


	public void setEdition(String edition) {
		this.edition = edition;
	}


	public String getImg_url() {
		return img_url;
	}


	public void setImg_url(String img_url) {
		this.img_url = img_url;
	}


	public String getBook_description() {
		return book_description;
	}


	public void setBook_description(String book_description) {
		this.book_description = book_description;
	}


	public String getClassification_code() {
		return classification_code;
	}


	public void setClassification_code(String classification_code) {
		this.classification_code = classification_code;
	}


	public Date getRegister_date() {
		return register_date;
	}


	public void setRegister_date(Date register_date) {
		this.register_date = register_date;
	}


	public Date getLast_update_date() {
		return last_update_date;
	}


	public void setLast_update_date(Date last_update_date) {
		this.last_update_date = last_update_date;
	}


	public long getIsbn() {
		return isbn;
	}


	public void setIsbn(long isbn) {
		this.isbn = isbn;
	}

	public int getCheckout_times() {
		return checkout_times;
	}

	public void setCheckout_times(int checkout_times) {
		this.checkout_times = checkout_times;
	}

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public String getMain_author() {
		return main_author;
	}

	public void setMain_author(String main_author) {
		this.main_author = main_author;
	}

	public List<AuthorDTO> getAuthors() {
		return authors;
	}

	public void setAuthors(List<AuthorDTO> authors) {
		this.authors = authors;
	}

	@Override
	public String toString() {
		return "BookDTO [publication_year=" + publication_year + ", page_count=" + page_count + ", volume_number="
				+ volume_number + ", book_size=" + book_size + ", title=" + title + ", series_title=" + series_title
				+ ", publisher_location=" + publisher_location + ", publisher_name=" + publisher_name + ", edition="
				+ edition + ", img_url=" + img_url + ", book_description=" + book_description + ", classification_code="
				+ classification_code + ", register_date=" + register_date + ", last_update_date=" + last_update_date
				+ ", isbn=" + isbn + ", checkout_times=" + checkout_times + ", rank=" + rank + ", copies=" + copies
				+ ", authors=" + authors + ", main_author=" + main_author + "]";
	}
	

	
}
