package com.kedu.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.commons.TagSplitUtil;
import com.kedu.dto.ReviewDTO;

@Repository
public class ReviewDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public int insert(ReviewDTO dto) {
		String sql = "insert into review values(review_seq.nextval, ?, ?, ?, ?, systimestamp, ?, ?, ?, 0)";
		
		return jdbc.update(sql, dto.getMember_id(), dto.getTarget_type(), dto.getTarget_id(), dto.getRating(), dto.getTag(), dto.getContents(), dto.getImage1());
	}
	
	public List<ReviewDTO> selectSort(int start, int end, String sort, String tag_list){
		String[] tagList = TagSplitUtil.tagSplit(tag_list);
		String where = "";
		Object[] tag = new Object[tagList.length + 2];
		
		tag[tagList.length] = start;
		tag[tagList.length + 1] = end;
		
		for(int i = 0; i<tagList.length; i++) {
			where += " and r.tag like ?";
			tag[i] = "%" + tagList[i] + "%";
		}
		if("reply".equals(sort)) {
			String sql = "select * from ( select r.*, ROW_NUMBER() OVER ( "
					+ " order by (select count(*) from review_reply rp where rp.review_seq = r.seq) desc, r.seq desc) rn "
					+ " from review r where 1 = 1 " + where + ") where rn between ? and ?";
			return jdbc.query(sql, new BeanPropertyRowMapper<>(ReviewDTO.class), tag);
		}else if("recommend".equals(sort)) {
			String sql = "select * from ( select r.*, ROW_NUMBER() OVER ( "
					+ " order by (select count(*) from review_recommend rr where rr.review_seq = r.seq) desc, r.seq desc) rn "
					+ " from review r where 1 = 1 " + where + ") where rn between ? and ?";
			return jdbc.query(sql, new BeanPropertyRowMapper<>(ReviewDTO.class), tag);
		}else if("view".equals(sort)){
			String sql = "select * from (select r.*, ROW_NUMBER() OVER(order by r.view_count desc)rn from review r where 1 = 1 " + where + ") where rn between ? and ?";
			return jdbc.query(sql, new BeanPropertyRowMapper<>(ReviewDTO.class), tag);
		}else {
			String sql = "select * from (select r.*, ROW_NUMBER() OVER(order by r.seq desc)rn from review r where 1 = 1 " + where + ") where rn between ? and ?";
			return jdbc.query(sql, new BeanPropertyRowMapper<>(ReviewDTO.class), tag);
		}
	}
	
	public int selectCount(String tag_list) {
		String[] tagList = TagSplitUtil.tagSplit(tag_list);
		String where = "";
		Object[] tag = new Object[tagList.length];
		
		for(int i = 0; i<tagList.length; i++) {
			where += " and tag like ?";
			tag[i] = "%" + tagList[i] + "%";
		}
		
		String sql = "select count(*) from review where 1 = 1 " + where;
		return jdbc.queryForObject(sql, Integer.class, tag);
	}
	
	public ReviewDTO selectOne(int seq) {
		String sql = "select * from review where seq = ?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(ReviewDTO.class), seq);
	}
	
	public String nicknameSearch(int seq) {
		String sql = "select (select m.nickname from members m where m.id = r.member_id) from review r where r.seq = ?"; 
		return jdbc.queryForObject(sql, String.class, seq);
	}
	
	public String targetSearch(int target_id) {
		String sql = "select name from place where place_id = ?";
		return jdbc.queryForObject(sql, String.class, target_id);
	}
	
	public int delete(int seq) {
		String sql = "delete from review where seq = ?";
		return jdbc.update(sql, seq);
	}
	
	public int update(ReviewDTO rdto) {
		String sql = "update review set target_type = ?, target_id = ?, rating = ?, tag = ?, contents = ?, image1 = ? where seq = ?";
		return jdbc.update(sql, rdto.getTarget_type(), rdto.getTarget_id(), rdto.getRating(), rdto.getTag(), rdto.getContents(), rdto.getImage1(), rdto.getSeq());
	}
	
	public void viewCountUp(int seq) {
		String sql = "update review set view_count = view_count + 1 where seq = ?";
		jdbc.update(sql, seq);
	}
	
	
	
	public ArrayList<ReviewDTO> selectMyReview(String memberId, int cpage, int pagesize) {
	    int start = (cpage - 1) * pagesize + 1;
	    int end = cpage * pagesize;
		String sql = "SELECT * FROM (" + "SELECT r.*, ROW_NUMBER() OVER (ORDER BY r.reg_date DESC) AS rn "
				+ "FROM review r WHERE r.member_id = ?" + ") WHERE rn BETWEEN ? AND ?";
	    return (ArrayList<ReviewDTO>) jdbc.query(sql, new BeanPropertyRowMapper<>(ReviewDTO.class), memberId, start, end);
	}
	
	
	public int countMyReview(String memberId) {
	    String sql = "SELECT COUNT(*) FROM review WHERE member_id = ?";
	    return jdbc.queryForObject(sql, Integer.class, memberId);
	}
	
	public int reviewCount(String memberId) {
	    String sql = "SELECT COUNT(*) FROM review "
	            + "WHERE member_id = ?";
	    return jdbc.queryForObject(sql, Integer.class, memberId);
	}
	
	public List<ReviewDTO> selectRecentReviews() {
	    String sql = "select seq, member_id, target_type, image1, rating, contents, tag, reg_date, target_id from review order by reg_date desc";
	    return jdbc.query(sql, new BeanPropertyRowMapper<>(ReviewDTO.class));
	}
	
	
}
