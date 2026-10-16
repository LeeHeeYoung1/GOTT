package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.TravelPlanReplyDTO;

@Repository
public class TravelPlanReplyDAO {

	@Autowired
    private JdbcTemplate jdbc;
	
	public List<TravelPlanReplyDTO> selectByPlanId(int plan_id){
		String sql = "select r.*, m.nickname from travel_plan_reply r "
				+ "join members m on m.id = r.member_id "
				+ "where r.plan_id = ? order by r.seq asc";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(TravelPlanReplyDTO.class), plan_id);
	}
	
	public int tprInsert(TravelPlanReplyDTO dto){
		String sql = "insert into travel_plan_reply (seq, plan_id, member_id, contents) "
				+ "values(travel_plan_reply_seq.nextval, ?, ?, ?)";
		return jdbc.update(sql, dto.getPlan_id(), dto.getMember_id(), dto.getContents());
	}
	
	public int tprDelete(int seq){
		String sql = "delete from travel_plan_reply where seq = ?";
		return jdbc.update(sql, seq);
	}
	
	public int tprUpdate(int seq, String contents) {
		String sql = "update travel_plan_reply set contents = ? where seq = ?";
		return jdbc.update(sql, contents, seq);
	}
	
	public int tprDeleteByPlanId(int planId) {
		String sql = "delete from travel_plan_reply where plan_id = ?";
		return jdbc.update(sql, planId);
	}
}
