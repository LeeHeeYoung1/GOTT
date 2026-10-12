package com.kedu.dto;
import java.sql.Date;
import java.sql.Timestamp;

public class TravelPlanDTO {
	private int plan_id; // 여행 일정 고유 번호 (기본키)
	private String member_id; // 일정을 작성한 회원 아이디
	private String plan_title; // 여행 일정 제목
	private Date start_date; // 여행 시작 날짜
	private Date end_date; // 여행 종료 날짜
	private int person_count; // 여행 인원수
	private String is_public; // 일정 공개 여부 (Y: 공개, N: 비공개)
	private Timestamp created_at; // 일정 최초 생성 날짜 및 시간
	private Timestamp updated_at; // 일정 마지막 수정 날짜 및 시간


    public TravelPlanDTO() {
    }

 
    public TravelPlanDTO(int plan_id, String member_id, String plan_title, Date start_date, Date end_date, int person_count, String is_public, Timestamp created_at, Timestamp updated_at) {
        this.plan_id = plan_id;
        this.member_id = member_id;
        this.plan_title = plan_title;
        this.start_date = start_date;
        this.end_date = end_date;
        this.person_count = person_count;
        this.is_public = is_public;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public int getPlan_id() {
        return plan_id;
    }
    public void setPlan_id(int plan_id) {
        this.plan_id = plan_id;
    }
    public String getMember_id() {
        return member_id;
    }
    public void setMember_id(String member_id) {
        this.member_id = member_id;
    }
    public String getPlan_title() {
        return plan_title;
    }
    public void setPlan_title(String plan_title) {
        this.plan_title = plan_title;
    }
    public Date getStart_date() {
        return start_date;
    }
    public void setStart_date(Date start_date) {
        this.start_date = start_date;
    }
    public Date getEnd_date() {
        return end_date;
    }
    public void setEnd_date(Date end_date) {
        this.end_date = end_date;
    }
    public int getPerson_count() {
        return person_count;
    }
    public void setPerson_count(int person_count) {
        this.person_count = person_count;
    }
    public String getIs_public() {
        return is_public;
    }
    public void setIs_public(String is_public) {
        this.is_public = is_public;
    }
    public Timestamp getCreated_at() {
        return created_at;
    }
    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }
    public Timestamp getUpdated_at() {
        return updated_at;
    }
    public void setUpdated_at(Timestamp updated_at) {
        this.updated_at = updated_at;
    }
}