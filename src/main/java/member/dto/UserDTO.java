package member.dto;

public class UserDTO {
	
	private long user_id;
	private String passwd;
	private String user_type;
	
	public UserDTO() {
		
	}
	
	public UserDTO(long user_id, String passwd, String user_type) {
		super();
		this.user_id = user_id;
		this.passwd = passwd;
		this.user_type = user_type;
	}
	public long getUser_id() {
		return user_id;
	}
	public void setUser_id(long user_id) {
		this.user_id = user_id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getUser_type() {
		return user_type;
	}
	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	@Override
	public String toString() {
		return "UserDTO [user_id=" + user_id + ", passwd=" + passwd + ", user_type=" + user_type + "]";
	}
	
	

}
