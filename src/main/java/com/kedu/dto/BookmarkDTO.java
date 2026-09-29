package com.kedu.dto;

import java.sql.Timestamp;

public class BookmarkDTO {
	private int bookmark_id;
	private int board_seq;
	private Timestamp bookmark_date;
	
	public BookmarkDTO () {}
	
	public int getBookmark_id() {
		return bookmark_id;
	}
	public void setBookmark_id(int bookmark_id) {
		this.bookmark_id = bookmark_id;
	}
	public int getBoard_seq() {
		return board_seq;
	}
	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}
	public Timestamp getBookmark_date() {
		return bookmark_date;
	}
	public void setBookmark_date(Timestamp bookmark_date) {
		this.bookmark_date = bookmark_date;
	}

	public BookmarkDTO(int bookmark_id, int board_seq, Timestamp bookmark_date) {
		this.bookmark_id = bookmark_id;
		this.board_seq = board_seq;
		this.bookmark_date = bookmark_date;
	}
	
	
}
