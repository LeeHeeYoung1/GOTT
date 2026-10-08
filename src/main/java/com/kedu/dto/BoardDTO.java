package com.kedu.dto;

import java.sql.Timestamp;

public class BoardDTO {
	private int seq;
	private String title;
	private String contents;
	private String writer;
	private int view_count;
	private Timestamp write_date;
	private int recommendCount;

	public BoardDTO () {}
	
	public BoardDTO(int seq, String title, String contents, String writer, int view_count, Timestamp write_date) {

		this.seq = seq;
		this.title = title;
		this.contents = contents;
		this.writer = writer;
		this.view_count = view_count;
		this.write_date = write_date;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
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
	public int getRecommendCount() {
	    return recommendCount;
	}

	public void setRecommendCount(int recommendCount) {
	    this.recommendCount = recommendCount;
	}
	
}
