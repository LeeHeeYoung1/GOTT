package com.kedu.dto;

import java.sql.Timestamp;

public class NoticeDTO {
	private int notice_id;
	private String title;
	private String contents;
	private String writer;
	private int view_count;
	private Timestamp write_date;
	private String important;
	private String nickname;
	
	public NoticeDTO () {}
	
	public NoticeDTO(int notice_id, String title, String contents, String writer, int view_count, Timestamp write_date,
			String important) {

		this.notice_id = notice_id;
		this.title = title;
		this.contents = contents;
		this.writer = writer;
		this.view_count = view_count;
		this.write_date = write_date;
		this.important = important;
	}
	public int getNotice_id() {
		return notice_id;
	}
	public void setNotice_id(int notice_id) {
		this.notice_id = notice_id;
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
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	public Timestamp getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}
	public String getImportant() {
		return important;
	}
	public void setImportant(String important) {
		this.important = important;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
}
