package book.dto;

public class FilterDTO {
	
	private String f_author;
	private String f_publisher;
	private String f_category;
	private int f_count;
	private int f_row_num;
	private int recentest;
	private int oldest;
	
	public FilterDTO() {
		
	}
	
	public FilterDTO(String f_author, String f_publisher, String f_category, int f_count, int f_row_num, int recentest,
			int oldest) {
		super();
		this.f_author = f_author;
		this.f_publisher = f_publisher;
		this.f_category = f_category;
		this.f_count = f_count;
		this.f_row_num = f_row_num;
		this.recentest = recentest;
		this.oldest = oldest;
	}
	public String getF_author() {
		return f_author;
	}
	public void setF_author(String f_author) {
		this.f_author = f_author;
	}
	public String getF_publisher() {
		return f_publisher;
	}
	public void setF_publisher(String f_publisher) {
		this.f_publisher = f_publisher;
	}
	public String getF_category() {
		return f_category;
	}
	public void setF_category(String f_category) {
		this.f_category = f_category;
	}
	public int getF_count() {
		return f_count;
	}
	public void setF_count(int f_count) {
		this.f_count = f_count;
	}
	public int getF_row_num() {
		return f_row_num;
	}
	public void setF_row_num(int f_row_num) {
		this.f_row_num = f_row_num;
	}
	public int getRecentest() {
		return recentest;
	}
	public void setRecentest(int recentest) {
		this.recentest = recentest;
	}
	public int getOldest() {
		return oldest;
	}
	public void setOldest(int oldest) {
		this.oldest = oldest;
	}
	@Override
	public String toString() {
		return "FilterDTO [f_author=" + f_author + ", f_publisher=" + f_publisher + ", f_category=" + f_category
				+ ", f_count=" + f_count + ", f_row_num=" + f_row_num + ", recentest=" + recentest + ", oldest="
				+ oldest + "]";
	}
	
	
	
	
}
