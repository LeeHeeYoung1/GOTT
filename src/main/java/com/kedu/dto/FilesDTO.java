package com.kedu.dto;

import java.sql.Timestamp;

public class FilesDTO {
	private int seq;
	private String oriname;
	private String sysname;
	private Timestamp regdate;
	private int parent_seq;
	
	public FilesDTO () {}
	
	public FilesDTO(int seq, String oriname, String sysname, Timestamp regdate, int parent_seq) {
		this.seq = seq;
		this.oriname = oriname;
		this.sysname = sysname;
		this.regdate = regdate;
		this.parent_seq = parent_seq;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getOriname() {
		return oriname;
	}
	public void setOriname(String oriname) {
		this.oriname = oriname;
	}
	public String getSysname() {
		return sysname;
	}
	public void setSysname(String sysname) {
		this.sysname = sysname;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	public int getParent_seq() {
		return parent_seq;
	}
	public void setParent_seq(int parent_seq) {
		this.parent_seq = parent_seq;
	}
}
