package model;

import java.io.UnsupportedEncodingException;

public class MemberBean {
	
	private String id;
	private String pass1;
	private String pass2;
	private String email;
	private String tel;
	private String age;
	private String info;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass1() {
		return pass1;
	}
	public void setPass1(String pass1) {
		this.pass1 = pass1;
	}
	public String getPass2() {
		return pass2;
	}
	public void setPass2(String pass2) {
		this.pass2 = pass2;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	
	@Override
	public String toString() {
		return "MemberBean [id=" + id + ", pass1=" + pass1 + ", pass2=" + pass2 + ", email=" + email + ", tel=" + tel
				+ ", age=" + age + ", info=" + info + "]";
	}
	
	
}
