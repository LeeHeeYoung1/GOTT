package com.kedu.dto;

import java.sql.Timestamp;

public class FaqDTO {
	
	private int faq_id;
	private String title;
	private String writer;
	private String content;
	private Timestamp regdate;
	
	public FaqDTO() {};
	
	public int getFaq_id() {
		return faq_id;
	}
	public void setFaq_id(int faq_id) {
		this.faq_id = faq_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	
	public FaqDTO(int faq_id, String title, String writer, String content, Timestamp regdate) {
		super();
		this.faq_id = faq_id;
		this.title = title;
		this.writer = writer;
		this.content = content;
		this.regdate = regdate;
	}
	
}
