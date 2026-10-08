package com.kedu.dto;

import java.sql.Timestamp;

public class RecommendDTO {

    private int board_seq;
    private String writer;
    private Timestamp recommend_date;

    public int getBoard_seq() {
        return board_seq;
    }

    public void setBoard_seq(int board_seq) {
        this.board_seq = board_seq;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public Timestamp getRecommend_date() {
        return recommend_date;
    }

    public void setRecommend_date(Timestamp recommend_date) {
        this.recommend_date = recommend_date;
    }
}