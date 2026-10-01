package com.kedu.dto;

import java.sql.Timestamp;

public class Travel_TypeDTO {
	private int result_id;
	private String member_id;
	private String type_code;
	private Timestamp reg_date;
	private int plan_score;
	private int explore_score;
	private int healing_score;
	private int emotion_score;
	private int food_score;
	private int activity_score;
	
	public Travel_TypeDTO () {}

	public Travel_TypeDTO(int result_id, String member_id, String type_code, Timestamp reg_date, int plan_score,
			int explore_score, int healing_score, int emotion_score, int food_score, int activity_score) {
		super();
		this.result_id = result_id;
		this.member_id = member_id;
		this.type_code = type_code;
		this.reg_date = reg_date;
		this.plan_score = plan_score;
		this.explore_score = explore_score;
		this.healing_score = healing_score;
		this.emotion_score = emotion_score;
		this.food_score = food_score;
		this.activity_score = activity_score;
	}

	public int getResult_id() {
		return result_id;
	}

	public void setResult_id(int result_id) {
		this.result_id = result_id;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getType_code() {
		return type_code;
	}

	public void setType_code(String type_code) {
		this.type_code = type_code;
	}

	public Timestamp getReg_date() {
		return reg_date;
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

	public int getPlan_score() {
		return plan_score;
	}

	public void setPlan_score(int plan_score) {
		this.plan_score = plan_score;
	}

	public int getExplore_score() {
		return explore_score;
	}

	public void setExplore_score(int explore_score) {
		this.explore_score = explore_score;
	}

	public int getHealing_score() {
		return healing_score;
	}

	public void setHealing_score(int healing_score) {
		this.healing_score = healing_score;
	}

	public int getEmotion_score() {
		return emotion_score;
	}

	public void setEmotion_score(int emotion_score) {
		this.emotion_score = emotion_score;
	}

	public int getFood_score() {
		return food_score;
	}

	public void setFood_score(int food_score) {
		this.food_score = food_score;
	}

	public int getActivity_score() {
		return activity_score;
	}

	public void setActivity_score(int activity_score) {
		this.activity_score = activity_score;
	};
	
	
	
}
