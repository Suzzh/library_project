package notice.dto;

import java.util.Date;

public class NoticeDTO {
	
	private int notice_id;
	private int view_count;
	private int fix;
	private Date post_date;
	private long writer_id;
	private String title;
	private String notice_content;
	private String post_category;
	private String dept_in_charge;
	private String dept_name;

	private String filename;
	private int filesize;
	private String ext;
	public int getNotice_id() {
		return notice_id;
	}
	public void setNotice_id(int notice_id) {
		this.notice_id = notice_id;
	}
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	public int getFix() {
		return fix;
	}
	public void setFix(int fix) {
		this.fix = fix;
	}
	public Date getPost_date() {
		return post_date;
	}
	public void setPost_date(Date post_date) {
		this.post_date = post_date;
	}
	public long getWriter_id() {
		return writer_id;
	}
	public void setWriter_id(long writer_id) {
		this.writer_id = writer_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public String getPost_category() {
		return post_category;
	}
	public void setPost_category(String post_category) {
		this.post_category = post_category;
	}
	public String getDept_in_charge() {
		return dept_in_charge;
	}
	public void setDept_in_charge(String dept_in_charge) {
		this.dept_in_charge = dept_in_charge;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public int getFilesize() {
		return filesize;
	}
	public void setFilesize(int filesize) {
		this.filesize = filesize;
	}
	public String getExt() {
		return ext;
	}
	public void setExt(String ext) {
		this.ext = ext;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	@Override
	public String toString() {
		return "NoticeDTO [notice_id=" + notice_id + ", view_count=" + view_count + ", fix=" + fix + ", post_date="
				+ post_date + ", writer_id=" + writer_id + ", title=" + title + ", notice_content=" + notice_content
				+ ", post_category=" + post_category + ", dept_in_charge=" + dept_in_charge + ", dept_name=" + dept_name
				+ ", filename=" + filename + ", filesize=" + filesize + ", ext=" + ext + "]";
	}
	
	


	
	
}
