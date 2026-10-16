package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.TravelPlanDTO;

@Repository
public class TravelPlanScrapDAO {

	@Autowired
	private JdbcTemplate jdbc;

	public int scrapUp(int seq, String loginId) {
		String sql = "insert into travel_plan_scrap values (travel_plan_scrap_seq.nextval, ?, ?, systimestamp)";
		return jdbc.update(sql, seq, loginId);
	}

	public int scrapDown(int seq, String loginId) {
		String sql = "delete from travel_plan_scrap where plan_id = ? and member_id = ?";
		return jdbc.update(sql, seq, loginId);
	}

	public boolean isScrap(int seq, String loginId) {
		String sql = "select count(*) from travel_plan_scrap where plan_id = ? and member_id = ?";
		return jdbc.queryForObject(sql, Integer.class, seq, loginId) > 0;
	}
	
	public List<TravelPlanDTO> scrapPlan(String loginId){
		String sql = "select p.* "
				+ "  from travel_plan_scrap s "
				+ "  join travel_plan p on p.plan_id = s.plan_id "
				+ " where s.member_id = ? "
				+ " order by s.reg_date desc, p.plan_id desc";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(TravelPlanDTO.class), loginId);
	}
	
	public List<Integer> topFivePlanId(){
		String sql = "select plan_id from (select plan_id, count(*) cn from travel_plan_scrap group by plan_id order by cn desc) where ROWNUM <= 5";
		return jdbc.queryForList(sql, Integer.class);
	}
	
	public int tpsDeleteByPlanId(int planId) {
		String sql = "delete from travel_plan_scrap where plan_id = ?";
		return jdbc.update(sql, planId);
	}
}
