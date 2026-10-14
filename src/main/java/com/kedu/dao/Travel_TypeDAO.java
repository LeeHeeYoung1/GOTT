
package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.Travel_TypeDTO;

@Repository
public class Travel_TypeDAO {

    @Autowired
    private JdbcTemplate jdbc;

    public void insertType(Travel_TypeDTO dto) {
        String sql = "insert into travel_type values(travel_type_seq.nextval, ?, ?, systimestamp, ?, ?, ?, ?, ?, ?)";

        jdbc.update(sql,
                dto.getMember_id(),
                dto.getType_code(),
                dto.getPlan_score(),
                dto.getExplore_score(),
                dto.getHealing_score(),
                dto.getEmotion_score(),
                dto.getFood_score(),
                dto.getActivity_score());
    }

    public String selectMyType(String memberId) {
        String sql = "select type_code from (select type_code from travel_type where member_id = ? order by reg_date desc) where rownum = 1";

        List<String> list = jdbc.queryForList(sql, String.class, memberId);

        if (list.size() > 0) {
            return list.get(0);
        }

        return null;
    }

    public int countMyType(String memberId) {
        String sql = "select count(*) from travel_type where member_id = ?";

        return jdbc.queryForObject(sql, Integer.class, memberId);
    }

    public int countTravelCoupon(String memberId) {
        String sql = "select count(*) from members_coupon where member_id = ? and coupon_id = 5";

        return jdbc.queryForObject(sql, Integer.class, memberId);
    }

    public void issueCoupon(String memberId) {
        String sql = "insert into members_coupon (member_coupon_id, coupon_id, member_id, issue_date, expire_date, status) "
                + "select member_coupon_seq.nextval, coupon_id, ?, sysdate, least(end_date, add_months(sysdate, 3)), 'AVAILABLE' "
                + "from coupon where coupon_id = 5 and active_yn = 'Y' and start_date <= sysdate and end_date >= sysdate";

        jdbc.update(sql, memberId);
    }
}
