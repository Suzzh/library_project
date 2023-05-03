package member.dto;

import java.util.Date;

public class StudentDTO {
	
	private long student_id;
	private Date enrolled_date;
	private String dept_name;
	private String status;
	private int grade;
	public long getStudent_id() {
		return student_id;
	}
	public void setStudent_id(long student_id) {
		this.student_id = student_id;
	}
	public Date getEnrolled_date() {
		return enrolled_date;
	}
	public void setEnrolled_date(Date enrolled_date) {
		this.enrolled_date = enrolled_date;
	}

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	@Override
	public String toString() {
		return "StudentDTO [student_id=" + student_id + ", enrolled_date=" + enrolled_date + ", dept_name=" + dept_name
				+ ", status=" + status + ", grade=" + grade + "]";
	}
	
	

	
	
	

}
