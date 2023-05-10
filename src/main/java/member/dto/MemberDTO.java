package member.dto;

import java.sql.Date;
import java.util.List;

import circulate.dto.CheckoutDTO;

public class MemberDTO {
	
	private long user_id;
	private String user_type;
	private String name;
	private int gender;
	private String zipcode;
	private String address1;
	private String address2;
	private String email;
	private String tel1;
	private String tel2;
	private Date birthdate;
	
	
	private StudentDTO sdto;
	private ProfessorDTO pdto;

	private String checkout_status;
	private int numCheckedOut;
	private int numLateReturns;
	private int numReservations;

	public long getUser_id() {
		return user_id;
	}

	public void setUser_id(long user_id) {
		this.user_id = user_id;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTel1() {
		return tel1;
	}

	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}

	public String getTel2() {
		return tel2;
	}

	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}

	public Date getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}

	public StudentDTO getSdto() {
		return sdto;
	}

	public void setSdto(StudentDTO sdto) {
		this.sdto = sdto;
	}

	public ProfessorDTO getPdto() {
		return pdto;
	}

	public void setPdto(ProfessorDTO pdto) {
		this.pdto = pdto;
	}

	public String getCheckout_status() {
		return checkout_status;
	}

	public void setCheckout_status(String checkout_status) {
		this.checkout_status = checkout_status;
	}

	public int getNumCheckedOut() {
		return numCheckedOut;
	}

	public void setNumCheckedOut(int numCheckedOut) {
		this.numCheckedOut = numCheckedOut;
	}

	public int getNumLateReturns() {
		return numLateReturns;
	}

	public void setNumLateReturns(int numLateReturns) {
		this.numLateReturns = numLateReturns;
	}

	public int getNumReservations() {
		return numReservations;
	}

	public void setNumReservations(int numReservations) {
		this.numReservations = numReservations;
	}

	@Override
	public String toString() {
		return "MemberDTO [user_id=" + user_id + ", user_type=" + user_type + ", name=" + name + ", gender=" + gender
				+ ", zipcode=" + zipcode + ", address1=" + address1 + ", address2=" + address2 + ", email=" + email
				+ ", tel1=" + tel1 + ", tel2=" + tel2 + ", birthdate=" + birthdate + ", sdto=" + sdto + ", pdto=" + pdto
				+ ", checkout_status=" + checkout_status + ", numCheckedOut=" + numCheckedOut + ", numLateReturns="
				+ numLateReturns + ", numReservations=" + numReservations + "]";
	}

		
		
}
