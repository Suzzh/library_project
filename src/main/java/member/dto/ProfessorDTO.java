package member.dto;

public class ProfessorDTO {
	
	private long professor_id;
	private String dept_name;
	private String rank;
	private String office;
	
	
	public long getProfessor_id() {
		return professor_id;
	}
	public void setProfessor_id(long professor_id) {
		this.professor_id = professor_id;
	}

	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
	public String getOffice() {
		return office;
	}
	public void setOffice(String office) {
		this.office = office;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	@Override
	public String toString() {
		return "ProfessorDTO [professor_id=" + professor_id + ", dept_name=" + dept_name + ", rank=" + rank
				+ ", office=" + office + "]";
	}

	
	
	
	
	
}
