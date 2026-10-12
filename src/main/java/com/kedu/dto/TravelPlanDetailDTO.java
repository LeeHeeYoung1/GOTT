package com.kedu.dto;

public class TravelPlanDetailDTO {
	private int detail_id; // 여행 일정 상세 고유 번호 (기본키)
	private int plan_id; // 상세 일정이 속한 여행 일정 번호
	private int day_no; // 여행 몇 일 차인지 (1일 차, 2일 차 등)
	private int place_id; // 방문할 장소의 고유 번호 (PLACE 테이블의 PLACE_ID)
	private int visit_order; // 해당 날짜의 방문 순서
	private String visit_time; // 장소 방문 예정 시간

    public TravelPlanDetailDTO() {}


    public TravelPlanDetailDTO(int detail_id, int plan_id, int day_no, int place_id, int visit_order, String visit_time) {
        this.detail_id = detail_id;
        this.plan_id = plan_id;
        this.day_no = day_no;
        this.place_id = place_id;
        this.visit_order = visit_order;
        this.visit_time = visit_time;
    }

    public int getDetail_id() {
        return detail_id;
    }
    public void setDetail_id(int detail_id) {
        this.detail_id = detail_id;
    }
    public int getPlan_id() {
        return plan_id;
    }
    public void setPlan_id(int plan_id) {
        this.plan_id = plan_id;
    }
    public int getDay_no() {
        return day_no;
    }
    public void setDay_no(int day_no) {
        this.day_no = day_no;
    }
    public int getPlace_id() {
        return place_id;
    }
    public void setPlace_id(int place_id) {
        this.place_id = place_id;
    }
    public int getVisit_order() {
        return visit_order;
    }
    public void setVisit_order(int visit_order) {
        this.visit_order = visit_order;
    }
    public String getVisit_time() {
        return visit_time;
    }
    public void setVisit_time(String visit_time) {
        this.visit_time = visit_time;
    }
}