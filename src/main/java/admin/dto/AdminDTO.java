package admin.dto;

public class AdminDTO {
	
	private long admin_id;
	private String passwd;
	private String name;
	private String department;
	private String job;
	public long getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(long admin_id) {
		this.admin_id = admin_id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	
	@Override
	public String toString() {
		return "AdminDTO [admin_id=" + admin_id + ", passwd=" + passwd + ", name=" + name + ", department=" + department
				+ ", job=" + job + "]";
	}
	
	
	

}
