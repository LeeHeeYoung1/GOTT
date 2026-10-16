package com.kedu.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kedu.commons.TagSplitUtil;
import com.kedu.dto.ReviewDTO;

@Repository
public class ReviewDAO {

	@Autowired
	private JdbcTemplate jdbc;


	@Transactional
	public int insert(ReviewDTO dto) {
		String sql = "INSERT INTO review VALUES(" + "review_seq.nextval, ?, ?, ?, ?, " + "SYSTIMESTAMP, ?, ?, ?, 0)";
		int result = jdbc.update(sql, dto.getMember_id(), dto.getTarget_type(), dto.getTarget_id(), dto.getRating(),
				dto.getTag(), dto.getContents(), dto.getImage1());
		if (result <= 0) {
			return result;
		}

		String memberId = dto.getMember_id();
		int mileage = 3000;

		// 2. 회원 마일리지 잔액 증가
		String updateSql = "UPDATE MEMBERS " + "SET MILEAGE = NVL(MILEAGE, 0) + ? " + "WHERE ID = ?";
		int updateResult = jdbc.update(updateSql, mileage, memberId);
		if (updateResult != 1) {
			throw new IllegalStateException("마일리지 적립 실패");
		}

		// 3. 적립 후 잔액 조회
		String balanceSql = "SELECT MILEAGE FROM MEMBERS WHERE ID = ?";
		int balance = jdbc.queryForObject(balanceSql, Integer.class, memberId);

		// 4. 마일리지 내역 저장
		String historySql = "INSERT INTO MILEAGE_HISTORY " + "(SEQ, MEMBER_ID, RESERVATION_ID, PAYMENT_ID, "
				+ "TYPE, AMOUNT, BALANCE, REASON, REG_DATE) " + "VALUES (MILEAGE_HISTORY_SEQ.NEXTVAL, ?, "
				+ "NULL, NULL, ?, ?, ?, ?, SYSDATE)";

		jdbc.update(historySql, memberId, "적립", mileage, balance, "리뷰 작성 마일리지");

		return result;
	}



	public List<ReviewDTO> selectSort(int start, int end, String sort, String tag_list) {
		String[] tagList = TagSplitUtil.tagSplit(tag_list);
		String where = "";
		Object[] tag = new Object[tagList.length + 2];

		tag[tagList.length] = start;
		tag[tagList.length + 1] = end;

		for (int i = 0; i < tagList.length; i++) {
			where += " and r.tag like ?";
			tag[i] = "%" + tagList[i] + "%";
		}

		String orderBy = "r.seq desc";

		if ("reply".equals(sort)) {
			orderBy = "(select count(*) from review_reply rp where rp.review_seq = r.seq) desc, r.seq desc";
		} else if ("recommend".equals(sort)) {
			orderBy = "(select count(*) from review_recommend rr where rr.review_seq = r.seq) desc, r.seq desc";
		} else if ("view".equals(sort)) {
			orderBy = "r.view_count desc, r.seq desc";
		}

		String sql = "select * from (" + "select r.*, "
				+ "(select count(*) from review_recommend rr where rr.review_seq = r.seq) as recommend_count, "
				+ "ROW_NUMBER() OVER (ORDER BY " + orderBy + ") rn " + "from review r where 1 = 1 " + where
				+ ") where rn between ? and ?";

		return jdbc.query(sql, new BeanPropertyRowMapper<>(ReviewDTO.class), tag);
	}

	public int selectCount(String tag_list) {
		String[] tagList = TagSplitUtil.tagSplit(tag_list);
		String where = "";
		Object[] tag = new Object[tagList.length];

		for (int i = 0; i < tagList.length; i++) {
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
		return jdbc.update(sql, rdto.getTarget_type(), rdto.getTarget_id(), rdto.getRating(), rdto.getTag(),
				rdto.getContents(), rdto.getImage1(), rdto.getSeq());
	}

	public void viewCountUp(int seq) {
		String sql = "update review set view_count = view_count + 1 where seq = ?";
		jdbc.update(sql, seq);
	}

	public ArrayList<ReviewDTO> selectMyReview(String memberId, int cpage, int pagesize) {
	    int start = (cpage - 1) * pagesize + 1;
	    int end = cpage * pagesize;

	    String sql = "SELECT * FROM ("
	            + "SELECT r.*, "
	            + "(SELECT COUNT(*) FROM review_recommend rr "
	            + "WHERE rr.review_seq = r.seq) AS recommend_count, "
	            + "ROW_NUMBER() OVER (ORDER BY r.reg_date DESC) AS rn "
	            + "FROM review r WHERE r.member_id = ?"
	            + ") WHERE rn BETWEEN ? AND ?";

	    return (ArrayList<ReviewDTO>) jdbc.query(
	            sql,
	            new BeanPropertyRowMapper<>(ReviewDTO.class),
	            memberId, start, end
	    );
	}

	public int countMyReview(String memberId) {
		String sql = "SELECT COUNT(*) FROM review WHERE member_id = ?";
		return jdbc.queryForObject(sql, Integer.class, memberId);
	}

	public int reviewCount() {
		String sql = "SELECT COUNT(*) FROM review";
		return jdbc.queryForObject(sql, Integer.class);
	}

	public List<ReviewDTO> selectRecentReviews() {
		String sql = "select r.*, "
				+ "(select count(*) from review_recommend rr where rr.review_seq = r.seq) as recommend_count "
				+ "from review r order by r.reg_date desc";

		return jdbc.query(sql, new BeanPropertyRowMapper<>(ReviewDTO.class));
	}
	
	public List<ReviewDTO> selectLikeReviews() {
	    String sql = "select r.*, "
	            + "(select count(*) from review_recommend rr "
	            + "where rr.review_seq = r.seq) as recommend_count "
	            + "from review r "
	            + "order by recommend_count desc, r.reg_date desc";

	    return jdbc.query(sql, new BeanPropertyRowMapper<>(ReviewDTO.class));
	}
	

}
