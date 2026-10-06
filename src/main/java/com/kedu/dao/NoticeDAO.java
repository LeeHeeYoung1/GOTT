package com.kedu.dao;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.NoticeDTO;

@Repository
public class NoticeDAO {

	@Autowired
	private JdbcTemplate jdbc;
	
	public List<NoticeDTO> list(){
		String sql = "select n.notice_id, n.title, n.contents, m.nickname, n.view_count, n.write_date, n.important "
				+ "FROM notice n "
				+ "JOIN members m ON n.writer = m.id";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(NoticeDTO.class));
	}
	
	public NoticeDTO select(int notice_id) {
		String sql = "select n.notice_id, n.title, n.contents, n.writer, n.view_count, n.write_date, n.important, m.nickname "
				+ "from notice n  join members m on n.writer = m.id where n.notice_id = ?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(NoticeDTO.class), notice_id);
	}
	
	public int viewCountUpdate(int notice_id) {
		String sql = "update notice set view_count = view_count + 1 where notice_id = ?";
		return jdbc.update(sql, notice_id);
	}
	
	public int insert(NoticeDTO dto) {
		String sql = "insert into notice values(notice_seq.nextval, ?, ?, ?, 0, systimestamp, ?)";
		return jdbc.update(sql, dto.getTitle(), dto.getContents(), dto.getWriter(), dto.getImportant());
	}
	
	public String getWriterNick(String id) {
		String sql = "select nickname from members where id = ?";
		return jdbc.queryForObject(sql, String.class, id);
	}
	
	public int delete(int notice_id) {
		String sql = "delete from notice where notice_id = ?";
		return jdbc.update(sql, notice_id);
	}
	
	public int update(NoticeDTO dto) {
		String sql = "update notice set title = ?, contents = ? where notice_id = ?";
		return jdbc.update(sql, dto.getTitle(), dto.getContents(), dto.getNotice_id());
	}
	
	public List<NoticeDTO> important(){
		String sql = "select n.notice_id, n.title, n.contents, m.nickname, n.view_count, n.write_date, n.important "
				+ "FROM notice n "
				+ "JOIN members m ON n.writer = m.id where n.important = 'Y'";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(NoticeDTO.class));
	}
}
