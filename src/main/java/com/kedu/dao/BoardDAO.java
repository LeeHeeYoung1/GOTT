package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.BoardDTO;
import com.kedu.dto.ReplyDTO;

@Repository
public class BoardDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public int insert(BoardDTO dto) {
		String sql = "insert into board values(?,?,?,0,systimestamp,?)";
		System.out.println("seq : " + dto.getSeq());
	    System.out.println("title : " + dto.getTitle());
	    System.out.println("writer : " + dto.getWriter());
	    System.out.println("contents : " + dto.getContents());

		 return jdbc.update(sql,
				 	dto.getSeq(),
		            dto.getTitle(),
		            dto.getWriter(),
		            dto.getContents());
	}
	
	public int getNextVal() {
		String sql = "select board_seq.nextval from dual";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	public List<BoardDTO> selectAll() {
		String sql = "select * from board order by seq desc";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(BoardDTO.class));
	}
	
	public BoardDTO boardContent(int seq) {
		String sql = "select * from board where seq = ?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(BoardDTO.class), seq);
	}
	
	public void update(BoardDTO dto, String nickname) {

	    String sql = "update board set title = ?, contents = ? " +
	                 "where seq = ? and writer = ?";

	    jdbc.update(
	        sql,
	        dto.getTitle(),
	        dto.getContents(),
	        dto.getSeq(),
	        nickname
	    );
	}
	
	public void delete(int seq, String nickname) {

	    String sql = "delete from board where seq = ? and writer = ?";

	    jdbc.update(sql, seq, nickname);
	}
	
	public int viewCount(int seq) {
		String sql = "update board set view_count = view_count + 1 where seq = ?";
		return jdbc.update(sql, seq);
	}
	public int boardCount() {
		String sql = "select count(*) from board";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	
	public List<BoardDTO> selectFromTo(int start, int end) {
		String sql = "select * from (select board.*, row_number() over(order by seq desc) rn from board) where rn between ? and ?";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(BoardDTO.class),start, end);
	}
	
	public List<BoardDTO> selectView(int start, int end) {

	    String sql = "select * from (select board.*, row_number() over(order by view_count desc) rn from board) where rn between ? and ?";

	    return jdbc.query(sql,
	            new BeanPropertyRowMapper<>(BoardDTO.class),
	            start, end);
	}
	
	public List<BoardDTO> selectRecommend(int start, int end) {

	    String sql = "select * from (select board.*, " +
                "row_number() over(order by nvl(recommend_count, 0) desc) rn " +
                "from board " +
                "left join (select board_seq, count(*) recommend_count " +
                "from board_recommend group by board_seq) r " +
                "on board.seq = r.board_seq) " +
                "where rn between ? and ?";

	    return jdbc.query(sql,
	            new BeanPropertyRowMapper<>(BoardDTO.class),
	            start, end);
	}
	

public List<BoardDTO> selectReplyCount(int start, int end) {
    String sql = "select * from ("
            + "select b.*, row_number() over(order by "
            + "(select count(*) from reply r where r.board_seq = b.seq) desc, "
            + "b.seq desc) rn "
            + "from board b"
            + ") where rn between ? and ?";

    System.out.println(sql);

    return jdbc.query(sql,
            new BeanPropertyRowMapper<>(BoardDTO.class),
            start, end);
}

public List<BoardDTO> searchFreeBoard(String keyword, String sort, int start, int end) {

    String orderBy = "b.seq desc";

    if ("view".equals(sort)) {
        orderBy = "b.view_count desc, b.seq desc";
    } else if ("recommend".equals(sort)) {
        orderBy = "nvl(rc.recommend_count, 0) desc, b.seq desc";
    } else if ("reply".equals(sort)) {
        orderBy = "(select count(*) from reply r "
                + "where r.board_seq = b.seq) desc, b.seq desc";
    }

    String sql = "select * from ("
            + "select b.*, row_number() over(order by " + orderBy + ") rn "
            + "from board b "
            + "left join (select board_seq, count(*) recommend_count "
            + "from board_recommend group by board_seq) rc "
            + "on b.seq = rc.board_seq "
            + "where (b.title like ? or b.writer like ?)"
            + ") where rn between ? and ?";

    return jdbc.query(sql,
            new BeanPropertyRowMapper<>(BoardDTO.class),
            "%" + keyword + "%",
            "%" + keyword + "%",
            start,
            end);
}

public int searchBoardCount(String keyword) {

    String sql = "select count(*) from board "
            + "where title like ? or writer like ?";

    return jdbc.queryForObject(sql, Integer.class,
            "%" + keyword + "%",
            "%" + keyword + "%");
}

}
