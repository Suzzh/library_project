package book.dto;

public class Book_AuthorDTO {
	
	private int book_author_id, author_id, preference;
	private long isbn;
	private String author_type;
	private AuthorDTO author;
	
	public Book_AuthorDTO() {
		
	}
	

	public Book_AuthorDTO(int book_author_id, int author_id, int preference, long isbn, String author_type,
			AuthorDTO author) {
		super();
		this.book_author_id = book_author_id;
		this.author_id = author_id;
		this.preference = preference;
		this.isbn = isbn;
		this.author_type = author_type;
		this.author = author;
	}

	public int getBook_author_id() {
		return book_author_id;
	}

	public void setBook_author_id(int book_author_id) {
		this.book_author_id = book_author_id;
	}

	public int getAuthor_id() {
		return author_id;
	}

	public void setAuthor_id(int author_id) {
		this.author_id = author_id;
	}

	public int getPreference() {
		return preference;
	}

	public void setPreference(int preference) {
		this.preference = preference;
	}

	public long getIsbn() {
		return isbn;
	}

	public void setIsbn(long isbn) {
		this.isbn = isbn;
	}

	public String getAuthor_type() {
		return author_type;
	}

	public void setAuthor_type(String author_type) {
		this.author_type = author_type;
	}

	public AuthorDTO getAuthor() {
		return author;
	}

	public void setAuthor(AuthorDTO author) {
		this.author = author;
	}

	@Override
	public String toString() {
		return "Book_AuthorDTO [book_author_id=" + book_author_id + ", author_id=" + author_id + ", preference="
				+ preference + ", isbn=" + isbn + ", author_type=" + author_type + ", author=" + author + "]";
	}
	
	
	


}
