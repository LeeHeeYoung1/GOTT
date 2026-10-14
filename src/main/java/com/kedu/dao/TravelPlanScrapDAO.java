package com.kedu.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

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

}
