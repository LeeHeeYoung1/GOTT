package com.kedu.dto;

import java.sql.Timestamp;

public class QnaDTO {
	private int qid;
	private String member_id;
	private String pw;
	private String title;
	private String contents;
	private Timestamp write_date;
	private String status;
	
	public QnaDTO () {}
	
	public QnaDTO(int qid, String member_id, String pw, String title, String contents, Timestamp write_date,
			String status) {

		this.qid = qid;
		this.member_id = member_id;
		this.pw = pw;
		this.title = title;
		this.contents = contents;
		this.write_date = write_date;
		this.status = status;
	}
	public int getQid() {
		return qid;
	}
	public void setQid(int qid) {
		this.qid = qid;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Timestamp getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
}

