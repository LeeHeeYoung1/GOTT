package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.PlaceDTO;

@Repository
public class PlaceDAO {

    @Autowired
    private JdbcTemplate jdbc;


public List<PlaceDTO> search(String keyword, String type, int start, int end) {

    if(keyword == null) {
        keyword = "";
    }

    if(type == null) {
        type = "전체";
    }

    String[] words = keyword.trim().split("\\s+");

    String sql = "select * from "
               + "(select Place.*, row_number() over(order by name) rn "
               + "from Place where 1=1 ";

    List<Object> params = new java.util.ArrayList<>();

    if(!keyword.trim().isEmpty()) {

        for(int i = 0; i < words.length; i++) {

            String word = words[i];

            if(word.equals("전라도")) {

                sql += "and ((name like ? or region like ? or sigungu like ?) "
                     + "or region like ?) ";

                params.add("%전라%");
                params.add("%전라%");
                params.add("%전라%");
                params.add("%전북%");

            } else {

                if(word.endsWith("도") && word.length() > 1) {
                    word = word.substring(0, word.length() - 1);
                }else if(word.endsWith("시") && word.length() > 1) {
                    word = word.substring(0, word.length() - 1);
                }
                String search = "%" + word + "%";

                sql += "and (name like ? or region like ? or sigungu like ?) ";

                params.add(search);
                params.add(search);
                params.add(search);
            }
        }
    }

    String dbType = type;

    if(type.equals("관광지")) {
        dbType = "SPOT";
    } else if(type.equals("맛집")) {
        dbType = "FOOD";
    } else if(type.equals("숙박업소")) {
        dbType = "STAY";
    }

    if(!dbType.equals("전체")) {
        sql += "and place_type = ? ";
        params.add(dbType);
    }

    sql += ") where rn between ? and ?";

    params.add(start);
    params.add(end);

    return jdbc.query(
        sql,
        new BeanPropertyRowMapper<>(PlaceDTO.class),
        params.toArray()
    );
}



public int searchCount(String keyword, String type) {

    if(keyword == null) {
        keyword = "";
    }

    if(type == null) {
        type = "전체";
    }

    String[] words = keyword.trim().split("\\s+");

    String sql = "select count(*) from Place where 1=1 ";

    List<Object> params = new java.util.ArrayList<>();

    if(!keyword.trim().isEmpty()) {

        for(int i = 0; i < words.length; i++) {

            String word = words[i];

            if(word.equals("전라도")) {

                sql += "and ((name like ? or region like ? or sigungu like ?) "
                     + "or region like ?) ";

                params.add("%전라%");
                params.add("%전라%");
                params.add("%전라%");
                params.add("%전북%");

            } else {

                if(word.endsWith("도") && word.length() > 1) {
                    word = word.substring(0, word.length() - 1);
                }else if(word.endsWith("시") && word.length() > 1) {
                    word = word.substring(0, word.length() - 1);
                }
                String search = "%" + word + "%";

                sql += "and (name like ? or region like ? or sigungu like ?) ";

                params.add(search);
                params.add(search);
                params.add(search);
            }
        }
    }

    String dbType = type;

    if(type.equals("관광지")) {
        dbType = "SPOT";
    } else if(type.equals("맛집")) {
        dbType = "FOOD";
    } else if(type.equals("숙박업소")) {
        dbType = "STAY";
    }

    if(!dbType.equals("전체")) {
        sql += "and place_type = ? ";
        params.add(dbType);
    }

    return jdbc.queryForObject(
        sql,
        Integer.class,
        params.toArray()
    );
}


    public List<String> searchKeyword(String keyword) {

        String sql = "SELECT area "
                   + "FROM ("
                   + "    SELECT DISTINCT region AS area, 1 AS type_order "
                   + "    FROM Place "
                   + "    WHERE region LIKE ? "
                   + "    UNION "
                   + "    SELECT DISTINCT sigungu AS area, 2 AS type_order "
                   + "    FROM Place "
                   + "    WHERE sigungu LIKE ? "
                   + ") "
                   + "ORDER BY "
                   + "type_order, "
                   + "CASE WHEN area LIKE ? THEN 1 ELSE 2 END, "
                   + "area";

        String search = "%" + keyword + "%";
        String startSearch = keyword + "%";

        return jdbc.queryForList(
            sql,
            String.class,
            search,
            search,
            startSearch
        );
    }

    public List<PlaceDTO> placeList(String placeType, String region) {

        String sql = "select * from place where place_type = ? and region = ?";

        return jdbc.query(sql,
            new BeanPropertyRowMapper<>(PlaceDTO.class),
            placeType, region);
    }

    public List<PlaceDTO> mapPlaceList(String region, String sigungu, String type) {

        String sql = "select * from place where region = ?";

        if(sigungu != null && !sigungu.trim().isEmpty()) {
            sql += " and sigungu = ?";
        }

        String dbType = type;

        if(type != null && type.equals("관광지")) {
            dbType = "SPOT";
        } else if(type != null && type.equals("맛집")) {
            dbType = "FOOD";
        } else if(type != null && type.equals("숙박업소")) {
            dbType = "STAY";
        }

        if(dbType != null && !dbType.equals("전체")) {
            sql += " and place_type = ?";
        }

        sql += " order by name";

        if(sigungu != null && !sigungu.trim().isEmpty()) {

            if(dbType != null && !dbType.equals("전체")) {
                return jdbc.query(sql,
                    new BeanPropertyRowMapper<>(PlaceDTO.class),
                    region, sigungu, dbType);
            } else {
                return jdbc.query(sql,
                    new BeanPropertyRowMapper<>(PlaceDTO.class),
                    region, sigungu);
            }

        } else {

            if(dbType != null && !dbType.equals("전체")) {
                return jdbc.query(sql,
                    new BeanPropertyRowMapper<>(PlaceDTO.class),
                    region, dbType);
            } else {
                return jdbc.query(sql,
                    new BeanPropertyRowMapper<>(PlaceDTO.class),
                    region);
            }
        }
    }

    public PlaceDTO selectOne(int place_id) {

        String sql = "select * from place where place_id = ?";

        return jdbc.queryForObject(sql,
            new BeanPropertyRowMapper<>(PlaceDTO.class),
            place_id);
    }

    // 숙박업소 사진 랜덤으로 한 장 가져오기
    public String randomImgHotel() {

        String sql = "select * from (select image_name from place "
                   + "where place_type = 'STAY' "
                   + "and name like '%호텔%' "
                   + "and image_name is not null "
                   + "order by DBMS_RANDOM.VALUE) "
                   + "where ROWNUM = 1";

        return jdbc.queryForObject(sql, String.class);
    }

    public String randomImgMotel() {

        String sql = "select * from (select image_name from place "
                   + "where place_type = 'STAY' "
                   + "and name like '%모텔%' "
                   + "and image_name is not null "
                   + "order by DBMS_RANDOM.VALUE) "
                   + "where ROWNUM = 1";

        return jdbc.queryForObject(sql, String.class);
    }

    public String randomImgMB() {

        String sql = "select * from (select image_name from place "
                   + "where place_type = 'STAY' "
                   + "and name like '%민박%' "
                   + "and image_name is not null "
                   + "order by DBMS_RANDOM.VALUE) "
                   + "where ROWNUM = 1";

        return jdbc.queryForObject(sql, String.class);
    }
    
 	public String regionByPlaceId(int placeId) {
 		String sql = "select region from place where place_id = ?";
 		return jdbc.queryForObject(sql, String.class, placeId);
 	}
}