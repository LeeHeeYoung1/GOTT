package com.kedu.dto;

import java.sql.Timestamp;

public class MembersDTO {
	
		private String id;
		private String pw;
		private String name;
		private String nickname;
		private String phone;
		private String email;
		private String gender;
		private String dob;
		private String zipcode;
		private String address1;
		private String address2;
		private Timestamp regdate;
		private int mileage;
		private String role;
		
		public MembersDTO() {}
		
		public MembersDTO(String id, String pw, String name, String nickname, String phone, String email, String gender,
				String dob, String zipcode, String address1, String address2, Timestamp regdate, int mileage, String role) {
			this.id = id;
			this.pw = pw;
			this.name = name;
			this.nickname = nickname;
			this.phone = phone;
			this.email = email;
			this.gender = gender;
			this.dob = dob;
			this.zipcode = zipcode;
			this.address1 = address1;
			this.address2 = address2;
			this.regdate = regdate;
			this.mileage = mileage;
			this.role = role;
		}
		
		public String getRole() {
			return role;
		}

		public void setRole(String role) {
			this.role = role;
		}

		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getPw() {
			return pw;
		}
		public void setPw(String pw) {
			this.pw = pw;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getNickname() {
			return nickname;
		}
		public void setNickname(String nickname) {
			this.nickname = nickname;
		}
		public String getPhone() {
			return phone;
		}
		public void setPhone(String phone) {
			this.phone = phone;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getGender() {
			return gender;
		}
		public void setGender(String gender) {
			this.gender = gender;
		}
		public String getDob() {
			return dob;
		}
		public void setDob(String dob) {
			this.dob = dob;
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
		public Timestamp getRegdate() {
			return regdate;
		}
		public void setRegdate(Timestamp regdate) {
			this.regdate = regdate;
		}
		public int getMileage() {
			return mileage;
		}
		public void setMileage(int mileage) {
			this.mileage = mileage;
		}
		
}

