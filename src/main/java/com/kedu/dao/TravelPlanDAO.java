package com.kedu.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kedu.dto.PlaceDTO;
import com.kedu.dto.TravelPlanDTO;
import com.kedu.dto.TravelPlanDetailDTO;

@Repository
public class TravelPlanDAO {

    @Autowired
    private JdbcTemplate jdbc;
    
    @Autowired
    private TravelPlanDAO dao;
    
    // 새로운 여행 일정 번호 발급
    public int nextPlanId() {
        String sql = "SELECT TRAVEL_PLAN_SEQ.NEXTVAL FROM DUAL";
        return jdbc.queryForObject(sql, Integer.class);
    }

    // 여행 일정 기본 정보 저장
    public int insert(TravelPlanDTO dto) {
        String sql = "INSERT INTO TRAVEL_PLAN "
                + "(PLAN_ID, MEMBER_ID, PLAN_TITLE, START_DATE, END_DATE, PERSON_COUNT, IS_PUBLIC) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

		return jdbc.update(sql, dto.getPlan_id(), dto.getMember_id(), dto.getPlan_title(), dto.getStart_date(),
				dto.getEnd_date(), dto.getPerson_count(), dto.getIs_public());
	}

    // 여행 일정에 포함된 장소 저장
    public int insertDetail(TravelPlanDetailDTO dto) {
        String sql = "INSERT INTO TRAVEL_PLAN_DETAIL "
                + "(DETAIL_ID, PLAN_ID, DAY_NO, PLACE_ID, VISIT_ORDER, VISIT_TIME) "
                + "VALUES (TRAVEL_PLAN_DETAIL_SEQ.NEXTVAL, ?, ?, ?, ?, ?)";

		return jdbc.update(sql, dto.getPlan_id(), dto.getDay_no(), dto.getPlace_id(), dto.getVisit_order(),
				dto.getVisit_time());
	}

    // 회원이 저장한 여행 일정 목록 조회
    public List<TravelPlanDTO> selectMyPlans(String memberId) {
        String sql = "SELECT * FROM TRAVEL_PLAN "
                + "WHERE MEMBER_ID = ? "
                + "ORDER BY CREATED_AT DESC";

		return jdbc.query(sql, new BeanPropertyRowMapper<>(TravelPlanDTO.class), memberId);
	}

    // 여행 일정 하나의 기본 정보 조회
    public TravelPlanDTO selectPlan(int planId) {
        String sql = "SELECT * FROM TRAVEL_PLAN WHERE PLAN_ID = ?";

		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(TravelPlanDTO.class), planId);
	}

    // 여행 일정에 포함된 장소 목록 조회
    public List<TravelPlanDetailDTO> selectDetails(int planId) {
        String sql = "SELECT * FROM TRAVEL_PLAN_DETAIL "
                + "WHERE PLAN_ID = ? "
                + "ORDER BY DAY_NO, VISIT_ORDER";

		return jdbc.query(sql, new BeanPropertyRowMapper<>(TravelPlanDetailDTO.class), planId);
	}
    
    // 여행 일정에 포함된 장소 사진 조회
    public List<PlaceDTO> selectImages(int plan_Id) {
        String sql = "select distinct p.place_id, p.image_name from travel_plan_detail d "
        		+ "join place p on p.place_id = d.place_id "
        		+ "where d.plan_id = ? "
        		+ "and p.image_name is not null "
        		+ "order by p.place_id asc";

		return jdbc.query(sql, new BeanPropertyRowMapper<>(PlaceDTO.class), plan_Id);
	}

    // 여행 일정 삭제
    public int deletePlan(int planId, String memberId) {
        String detailSql = "DELETE FROM TRAVEL_PLAN_DETAIL "
                + "WHERE PLAN_ID = ?";

        jdbc.update(detailSql, planId);

        String planSql = "DELETE FROM TRAVEL_PLAN "
                + "WHERE PLAN_ID = ? AND MEMBER_ID = ?";

        return jdbc.update(planSql, planId, memberId);
    }
    
    // 공개된 여행 일정 목록 조회
    public List<TravelPlanDTO> selectPublicPlans() {
        String sql = "select * from ( "
				+ " select p.*, ROW_NUMBER() OVER (order by p.plan_id desc) rn "
				+ " from travel_plan p where p.is_public = 'Y'";

		return jdbc.query(sql, new BeanPropertyRowMapper<>(TravelPlanDTO.class));
	}
    
    // 비공개 여행 일정 목록 조회
 
    
    
    // 1. sort만 선택 시
 	public List<TravelPlanDTO> selectFromTo(int start, int end, String sort) {

 		if (sort.equals("scrap")) {
 			String sql = "select * from ( "
 					+ "   select p.*, ROW_NUMBER() OVER ( "
 					+ "          order by (select count(*) from travel_plan_scrap s "
 					+ "                     where s.plan_id = p.plan_id) desc, p.plan_id desc) rn "
 					+ "     from travel_plan p "
 					+ "    where p.is_public = 'Y' "
 					+ " ) where rn between ? and ?";

 			return jdbc.query(sql, new BeanPropertyRowMapper<>(TravelPlanDTO.class), start, end);

 		} else {
 			String sql = "select * from ( "
 					+ "   select p.*, ROW_NUMBER() OVER (order by p.plan_id desc) rn "
 					+ "     from travel_plan p "
 					+ "    where p.is_public = 'Y' "
 					+ " ) where rn between ? and ?";

 			return jdbc.query(sql, new BeanPropertyRowMapper<>(TravelPlanDTO.class), start, end);
 		}
 	}

 	// 2. 지역&sort 선택 시
 	public List<TravelPlanDTO> selectByRegion(int start, int end, String sort, String region) {

 		if (sort.equals("scrap")) {
 			String sql = "select * from ( "
 					+ "   select p.*, ROW_NUMBER() OVER ( "
 					+ "          order by (select count(*) from travel_plan_scrap s "
 					+ "                     where s.plan_id = p.plan_id) desc, p.plan_id desc) rn "
 					+ "     from travel_plan p "
 					+ "    where p.is_public = 'Y' "
 					+ "      and exists (select 1 from travel_plan_detail d "
 					+ "                    join place p2 on p2.place_id = d.place_id "
 					+ "                   where d.plan_id = p.plan_id and p2.region = ?) "
 					+ " ) where rn between ? and ?";

 			return jdbc.query(sql, new BeanPropertyRowMapper<>(TravelPlanDTO.class), region, start, end);

 		} else {
 			String sql = "select * from ( "
 					+ "   select p.*, ROW_NUMBER() OVER (order by p.plan_id desc) rn "
 					+ "     from travel_plan p "
 					+ "    where p.is_public = 'Y' "
 					+ "      and exists (select 1 from travel_plan_detail d "
 					+ "                    join place p2 on p2.place_id = d.place_id "
 					+ "                   where d.plan_id = p.plan_id and p2.region = ?) "
 					+ " ) where rn between ? and ?";

 			return jdbc.query(sql, new BeanPropertyRowMapper<>(TravelPlanDTO.class), region, start, end);
 		}
 	}

 	// 3. 기간&sort 선택 시
 	public List<TravelPlanDTO> selectByNights(int start, int end, String sort, String nights) {

 		int night = Integer.parseInt(nights);

 		if (sort.equals("scrap") && nights.equals("4")) {
 			String sql = "select * from ( "
 					+ "   select p.*, ROW_NUMBER() OVER ( "
 					+ "          order by (select count(*) from travel_plan_scrap s "
 					+ "                     where s.plan_id = p.plan_id) desc, p.plan_id desc) rn "
 					+ "     from travel_plan p "
 					+ "    where p.is_public = 'Y' "
 					+ "      and (p.end_date - p.start_date) >= ? "
 					+ " ) where rn between ? and ?";

 			return jdbc.query(sql, new BeanPropertyRowMapper<>(TravelPlanDTO.class), night, start, end);

 		} else if (sort.equals("scrap")) {
 			String sql = "select * from ( "
 					+ "   select p.*, ROW_NUMBER() OVER ( "
 					+ "          order by (select count(*) from travel_plan_scrap s "
 					+ "                     where s.plan_id = p.plan_id) desc, p.plan_id desc) rn "
 					+ "     from travel_plan p "
 					+ "    where p.is_public = 'Y' "
 					+ "      and (p.end_date - p.start_date) = ? "
 					+ " ) where rn between ? and ?";

 			return jdbc.query(sql, new BeanPropertyRowMapper<>(TravelPlanDTO.class), night, start, end);

 		} else if (nights.equals("4")) {
 			String sql = "select * from ( "
 					+ "   select p.*, ROW_NUMBER() OVER (order by p.plan_id desc) rn "
 					+ "     from travel_plan p "
 					+ "    where p.is_public = 'Y' "
 					+ "      and (p.end_date - p.start_date) >= ? "
 					+ " ) where rn between ? and ?";

 			return jdbc.query(sql, new BeanPropertyRowMapper<>(TravelPlanDTO.class), night, start, end);

 		} else {
 			String sql = "select * from ( "
 					+ "   select p.*, ROW_NUMBER() OVER (order by p.plan_id desc) rn "
 					+ "     from travel_plan p "
 					+ "    where p.is_public = 'Y' "
 					+ "      and (p.end_date - p.start_date) = ? "
 					+ " ) where rn between ? and ?";

 			return jdbc.query(sql, new BeanPropertyRowMapper<>(TravelPlanDTO.class), night, start, end);
 		}
 	}

 	// 4. 지역&기간&sort 선택 시
 	public List<TravelPlanDTO> selectByRegionAndNights(int start, int end, String sort,
 			String region, String nights) {

 		int night = Integer.parseInt(nights);

 		if (sort.equals("scrap") && nights.equals("4")) {
 			String sql = "select * from ( "
 					+ "   select p.*, ROW_NUMBER() OVER ( "
 					+ "          order by (select count(*) from travel_plan_scrap s "
 					+ "                     where s.plan_id = p.plan_id) desc, p.plan_id desc) rn "
 					+ "     from travel_plan p "
 					+ "    where p.is_public = 'Y' "
 					+ "      and exists (select 1 from travel_plan_detail d "
 					+ "                    join place p2 on p2.place_id = d.place_id "
 					+ "                   where d.plan_id = p.plan_id and p2.region = ?) "
 					+ "      and (p.end_date - p.start_date) >= ? "
 					+ " ) where rn between ? and ?";

 			return jdbc.query(sql, new BeanPropertyRowMapper<>(TravelPlanDTO.class), region, night, start, end);

 		} else if (sort.equals("scrap")) {
 			String sql = "select * from ( "
 					+ "   select p.*, ROW_NUMBER() OVER ( "
 					+ "          order by (select count(*) from travel_plan_scrap s "
 					+ "                     where s.plan_id = p.plan_id) desc, p.plan_id desc) rn "
 					+ "     from travel_plan p "
 					+ "    where p.is_public = 'Y' "
 					+ "      and exists (select 1 from travel_plan_detail d "
 					+ "                    join place p2 on p2.place_id = d.place_id "
 					+ "                   where d.plan_id = p.plan_id and p2.region = ?) "
 					+ "      and (p.end_date - p.start_date) = ? "
 					+ " ) where rn between ? and ?";

 			return jdbc.query(sql, new BeanPropertyRowMapper<>(TravelPlanDTO.class), region, night, start, end);

 		} else if (nights.equals("4")) {
 			String sql = "select * from ( "
 					+ "   select p.*, ROW_NUMBER() OVER (order by p.plan_id desc) rn "
 					+ "     from travel_plan p "
 					+ "    where p.is_public = 'Y' "
 					+ "      and exists (select 1 from travel_plan_detail d "
 					+ "                    join place p2 on p2.place_id = d.place_id "
 					+ "                   where d.plan_id = p.plan_id and p2.region = ?) "
 					+ "      and (p.end_date - p.start_date) >= ? "
 					+ " ) where rn between ? and ?";

 			return jdbc.query(sql, new BeanPropertyRowMapper<>(TravelPlanDTO.class), region, night, start, end);

 		} else {
 			String sql = "select * from ( "
 					+ "   select p.*, ROW_NUMBER() OVER (order by p.plan_id desc) rn "
 					+ "     from travel_plan p "
 					+ "    where p.is_public = 'Y' "
 					+ "      and exists (select 1 from travel_plan_detail d "
 					+ "                    join place p2 on p2.place_id = d.place_id "
 					+ "                   where d.plan_id = p.plan_id and p2.region = ?) "
 					+ "      and (p.end_date - p.start_date) = ? "
 					+ " ) where rn between ? and ?";

 			return jdbc.query(sql, new BeanPropertyRowMapper<>(TravelPlanDTO.class), region, night, start, end);
 		}
 	}

 	// ===== 개수 =====

 	public int countAll() {
 		String sql = "select count(*) from travel_plan p where p.is_public = 'Y'";

 		return jdbc.queryForObject(sql, Integer.class);
 	}

 	public int countByRegion(String region) {
 		String sql = "select count(*) from travel_plan p "
 				+ " where p.is_public = 'Y' "
 				+ "   and exists (select 1 from travel_plan_detail d "
 				+ "                 join place p2 on p2.place_id = d.place_id "
 				+ "                where d.plan_id = p.plan_id and p2.region = ?)";

 		return jdbc.queryForObject(sql, Integer.class, region);
 	}

 	public int countByNights(String nights) {

 		int night = Integer.parseInt(nights);

 		if (nights.equals("4")) {
 			String sql = "select count(*) from travel_plan p "
 					+ " where p.is_public = 'Y' "
 					+ "   and (p.end_date - p.start_date) >= ?";

 			return jdbc.queryForObject(sql, Integer.class, night);

 		} else {
 			String sql = "select count(*) from travel_plan p "
 					+ " where p.is_public = 'Y' "
 					+ "   and (p.end_date - p.start_date) = ?";

 			return jdbc.queryForObject(sql, Integer.class, night);
 		}
 	}

 	public int countByRegionAndNights(String region, String nights) {

 		int night = Integer.parseInt(nights);

 		if (nights.equals("4")) {
 			String sql = "select count(*) from travel_plan p "
 					+ " where p.is_public = 'Y' "
 					+ "   and exists (select 1 from travel_plan_detail d "
 					+ "                 join place p2 on p2.place_id = d.place_id "
 					+ "                where d.plan_id = p.plan_id and p2.region = ?) "
 					+ "   and (p.end_date - p.start_date) >= ?";

 			return jdbc.queryForObject(sql, Integer.class, region, night);

 		} else {
 			String sql = "select count(*) from travel_plan p "
 					+ " where p.is_public = 'Y' "
 					+ "   and exists (select 1 from travel_plan_detail d "
 					+ "                 join place p2 on p2.place_id = d.place_id "
 					+ "                where d.plan_id = p.plan_id and p2.region = ?) "
 					+ "   and (p.end_date - p.start_date) = ?";

 			return jdbc.queryForObject(sql, Integer.class, region, night);
 		}
 	}
    
    // 모든 회원의 공개 여행 일정 조회 + 첫 번째 장소 이미지
    // 쿼리문 실화냐 이해 못할거같은데
    public List<Map<String, Object>> selectPublicPlansWithCount() {

        String sql =
                "SELECT T.PLAN_ID, "
              + "       T.MEMBER_ID, "
              + "       T.PLAN_TITLE, "
              + "       TO_CHAR(T.START_DATE, 'YYYY-MM-DD') AS START_DATE, "
              + "       TO_CHAR(T.END_DATE, 'YYYY-MM-DD') AS END_DATE, "
              + "       T.PERSON_COUNT, "
              + "       T.IS_PUBLIC, "
              + "       T.CREATED_AT, "
              + "       (SELECT COUNT(*) "
              + "          FROM TRAVEL_PLAN_DETAIL D "
              + "         WHERE D.PLAN_ID = T.PLAN_ID) AS SPOT_COUNT, "
              + "       P.IMAGE_NAME AS IMAGE_NAME "
              + "FROM TRAVEL_PLAN T "
              + "LEFT JOIN ( "
              + "    SELECT D.PLAN_ID, "
              + "           PL.IMAGE_NAME, "
              + "           ROW_NUMBER() OVER ( "
              + "               PARTITION BY D.PLAN_ID "
              + "               ORDER BY D.DAY_NO, D.VISIT_ORDER "
              + "           ) AS RN "
              + "    FROM TRAVEL_PLAN_DETAIL D "
              + "    JOIN PLACE PL "
              + "      ON D.PLACE_ID = PL.PLACE_ID "
              + ") P "
              + "  ON T.PLAN_ID = P.PLAN_ID "
              + " AND P.RN = 1 "
              + "WHERE T.IS_PUBLIC = 'Y' "
              + "ORDER BY T.CREATED_AT DESC";

        return jdbc.queryForList(sql);
    }
    
    
    
    // 일정 상세 조회
    public TravelPlanDTO selectPlanForView(int planId) {
        String sql = "SELECT * FROM TRAVEL_PLAN WHERE PLAN_ID = ?";
        List<TravelPlanDTO> list = jdbc.query(sql, new BeanPropertyRowMapper<>(TravelPlanDTO.class), planId);
        return list.isEmpty() ? null : list.get(0);
    }

    // 일정에 포함된 장소 조회
    public List<Map<String, Object>> selectPlanDetailsWithPlace(int planId) {
        String sql = "SELECT D.PLAN_ID, D.DAY_NO, D.PLACE_ID, D.VISIT_ORDER, D.VISIT_TIME, "
                + "P.NAME AS PLACE_NAME, P.PLACE_TYPE, P.REGION, P.ADDRESS "
                + "FROM TRAVEL_PLAN_DETAIL D "
                + "JOIN PLACE P ON D.PLACE_ID = P.PLACE_ID "
                + "WHERE D.PLAN_ID = ? "
                + "ORDER BY D.DAY_NO, D.VISIT_ORDER";
        return jdbc.queryForList(sql, planId);
    }
    


	public List<Map<String, Object>> selectMyPlansWithCount(String memberId) {
		String sql = "SELECT T.PLAN_ID, T.PLAN_TITLE, " + "TO_CHAR(T.START_DATE, 'YYYY-MM-DD') AS START_DATE, "
				+ "TO_CHAR(T.END_DATE, 'YYYY-MM-DD') AS END_DATE, " + "T.IS_PUBLIC, T.CREATED_AT, "
				+ "(SELECT COUNT(*) FROM TRAVEL_PLAN_DETAIL D WHERE D.PLAN_ID = T.PLAN_ID) AS SPOT_COUNT, "
				+ "P.IMAGE_NAME AS IMAGE_NAME " + "FROM TRAVEL_PLAN T " + "LEFT JOIN ("
				+ "SELECT D.PLAN_ID, PL.IMAGE_NAME, "
				+ "ROW_NUMBER() OVER (PARTITION BY D.PLAN_ID ORDER BY D.DAY_NO, D.VISIT_ORDER) AS RN "
				+ "FROM TRAVEL_PLAN_DETAIL D " + "JOIN PLACE PL ON D.PLACE_ID = PL.PLACE_ID"
				+ ") P ON T.PLAN_ID = P.PLAN_ID AND P.RN = 1 " + "WHERE T.MEMBER_ID = ? " + "ORDER BY T.CREATED_AT DESC";
	
	    return jdbc.queryForList(sql, memberId);
	}

    
    // 내가 스크랩한 여행 일정 목록
 	public List<Map<String, Object>> scrapPlan(String loginId) {
 		String sql = "SELECT T.PLAN_ID, T.PLAN_TITLE, "
 				+ "TO_CHAR(T.START_DATE, 'YYYY-MM-DD') AS START_DATE, "
 				+ "TO_CHAR(T.END_DATE, 'YYYY-MM-DD') AS END_DATE, "
 				+ "T.PERSON_COUNT, M.NICKNAME, "
 				+ "(SELECT COUNT(*) FROM TRAVEL_PLAN_DETAIL D WHERE D.PLAN_ID = T.PLAN_ID) AS SPOT_COUNT, "
 				+ "P.IMAGE_NAME AS IMAGE_NAME "
 				+ "FROM TRAVEL_PLAN_SCRAP S "
 				+ "JOIN TRAVEL_PLAN T ON T.PLAN_ID = S.PLAN_ID "
 				+ "JOIN MEMBERS M ON M.ID = T.MEMBER_ID "
 				+ "LEFT JOIN ("
 				+ "SELECT D.PLAN_ID, PL.IMAGE_NAME, "
 				+ "ROW_NUMBER() OVER (PARTITION BY D.PLAN_ID ORDER BY D.DAY_NO, D.VISIT_ORDER) AS RN "
 				+ "FROM TRAVEL_PLAN_DETAIL D "
 				+ "JOIN PLACE PL ON D.PLACE_ID = PL.PLACE_ID"
 				+ ") P ON T.PLAN_ID = P.PLAN_ID AND P.RN = 1 "
 				+ "WHERE S.MEMBER_ID = ? "
 				+ "ORDER BY S.REG_DATE DESC, T.PLAN_ID DESC";
 		return jdbc.queryForList(sql, loginId);
 	}
 	
 	public String placeImagename(int placeId) {
		String sql = "select image_name from place where place_id = ?";
		List<String> list = jdbc.queryForList(sql, String.class, placeId);
		if (list.size() == 0) {
			return null;
		} else {
			return list.get(0);
		}
	}
    
    public int recordCount() {
    	String sql = "select count(*) from travel_plan";
    	return jdbc.queryForObject(sql, Integer.class);
    }
    
    public TravelPlanDTO selectOne(int plan_id){
    	String sql = "select * from travel_plan where plan_id = ?";
    	return jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(TravelPlanDTO.class), plan_id);
    }
    
    public Integer getPlaceId(int plan_id) {
		String sql = "select place_id from (select place_id from travel_plan_detail where plan_id = ? order by day_no, visit_order) where rownum = 1";
		List<Integer> list = jdbc.queryForList(sql, Integer.class, plan_id);

		if (list.size() == 0) {
			return null;
		} else {
			return list.get(0);
		}
	}
}