package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.FaqDTO;

@Repository
public class FaqDAO {

	@Autowired
	private JdbcTemplate jdbc;
	
	public int insert(FaqDTO dto) {
	    String sql = "insert into faq values (?, ?, ?, ?, sysdate, 0)";

	    return jdbc.update(sql,
	        dto.getFaq_id(),
	        dto.getWriter(),
	        dto.getTitle(),
	        dto.getContent());
	}
	
	public int updateViewCount(int faq_id) {
	    String sql = "update faq set view_count = view_count + 1 where faq_id = ?";
	    jdbc.update(sql, faq_id);

	    sql = "select view_count from faq where faq_id = ?";
	    return jdbc.queryForObject(sql, Integer.class, faq_id);
	}
	
	
    public List<FaqDTO> faqList(int start, int end, String keyword) {
        String sql = "select * from (" +
                "select faq_id, writer, title, content, regdate, view_count, " +
                "row_number() over(order by faq_id desc) rn " +
                "from faq " +
                "where title like ?" +
                ") where rn between ? and ?";

        String searchKeyword = "%" + keyword + "%";

        return jdbc.query(sql,
                new BeanPropertyRowMapper<>(FaqDTO.class),
                searchKeyword, start, end);
    }

	public int faqCount(String keyword) {
	    String sql = "select count(*) from faq " +
	            "where title like ?";

	    String searchKeyword = "%" + keyword + "%";

	    return jdbc.queryForObject(sql, Integer.class, searchKeyword);
	}
	
	public FaqDTO faqContent(int faq_id) {
    String sql = "select * from faq where faq_id = ?";
    return jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(FaqDTO.class), faq_id);
}
	
	public int getNextVal() {
	    String sql = "select faq_seq.nextval from dual";
	    return jdbc.queryForObject(sql, Integer.class);
	}
	

public int update(FaqDTO dto) {
    String sql = "update faq set title = ?, content = ? where faq_id = ?";

    return jdbc.update(sql,
        dto.getTitle(),
        dto.getContent(),
        dto.getFaq_id());
}

public int delete(int faq_id) {
    String sql = "delete from faq where faq_id = ?";

    return jdbc.update(sql, faq_id);
}

}
