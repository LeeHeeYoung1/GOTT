package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.FilesDTO;

@Repository
public class FilesDAO {

	@Autowired
	private JdbcTemplate jdbc;
	
	public int fileRegi(FilesDTO dto) {
		String sql = "insert into files values(files_seq.nextval, ?, ?, sysdate, ?)";
		return jdbc.update(sql, dto.getOriname(), dto.getSysname(), dto.getParent_seq());
	}
	
	public List<FilesDTO> getFile(int seq) {
		String sql = "select * from files where parent_seq = ?";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(FilesDTO.class), seq);
	}
	
	public boolean hasFile(int seq) {
		String sql = "select count(*) from files where parent_seq = ?";
		int count = jdbc.queryForObject(sql, Integer.class, seq);
		return count > 0;
	}
}
