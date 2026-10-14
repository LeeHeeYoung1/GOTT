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

        String search = "%" + keyword + "%";
        String sql;

        if(type.equals("전체")) {

            if(keyword.equals("")) {
                sql = "select * from "
                    + "(select Place.*, row_number() over(order by name) rn "
                    + "from Place) "
                    + "where rn between ? and ?";

                return jdbc.query(sql,
                    new BeanPropertyRowMapper<>(PlaceDTO.class),
                    start, end);
            }

            sql = "select * from "
                + "(select Place.*, row_number() over(order by name) rn "
                + "from Place "
                + "where name like ? "
                + "or region like ? "
                + "or sigungu like ?) "
                + "where rn between ? and ?";

            return jdbc.query(sql,
                new BeanPropertyRowMapper<>(PlaceDTO.class),
                search, search, search, start, end);

        } else {

            String dbType = type;

            if(type.equals("관광지")) {
                dbType = "SPOT";
            } else if(type.equals("맛집")) {
                dbType = "FOOD";
            } else if(type.equals("숙박업소")) {
                dbType = "STAY";
            }

            if(keyword.equals("")) {
                sql = "select * from "
                    + "(select Place.*, row_number() over(order by name) rn "
                    + "from Place where place_type = ?) "
                    + "where rn between ? and ?";

                return jdbc.query(sql,
                    new BeanPropertyRowMapper<>(PlaceDTO.class),
                    dbType, start, end);
            }

            sql = "select * from "
                + "(select Place.*, row_number() over(order by name) rn "
                + "from Place "
                + "where (name like ? "
                + "or region like ? "
                + "or sigungu like ?) "
                + "and place_type = ?) "
                + "where rn between ? and ?";

            return jdbc.query(sql,
                new BeanPropertyRowMapper<>(PlaceDTO.class),
                search, search, search, dbType, start, end);
        }
    }

    public int searchCount(String keyword, String type) {

        if(keyword == null) {
            keyword = "";
        }

        if(type == null) {
            type = "전체";
        }

        String search = "%" + keyword + "%";
        String sql;

        if(keyword.equals("")) {

            if(type.equals("전체")) {
                sql = "select count(*) from Place";

                return jdbc.queryForObject(sql, Integer.class);
            }

            String dbType = type;

            if(type.equals("관광지")) {
                dbType = "SPOT";
            } else if(type.equals("맛집")) {
                dbType = "FOOD";
            } else if(type.equals("숙박업소")) {
                dbType = "STAY";
            }

            sql = "select count(*) from Place where place_type = ?";

            return jdbc.queryForObject(sql, Integer.class, dbType);
        }

        if(type.equals("전체")) {

            sql = "select count(*) from Place "
                + "where name like ? "
                + "or region like ? "
                + "or sigungu like ?";

            return jdbc.queryForObject(sql,
                Integer.class, search, search, search);

        } else {

            String dbType = type;

            if(type.equals("관광지")) {
                dbType = "SPOT";
            } else if(type.equals("맛집")) {
                dbType = "FOOD";
            } else if(type.equals("숙박업소")) {
                dbType = "STAY";
            }

            sql = "select count(*) from Place "
                + "where (name like ? "
                + "or region like ? "
                + "or sigungu like ?) "
                + "and place_type = ?";

            return jdbc.queryForObject(sql,
                Integer.class, search, search, search, dbType);
        }
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
}