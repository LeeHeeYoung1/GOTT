package com.kedu.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dao.PlaceDAO;
import com.kedu.dto.PlaceDTO;

@Controller
@RequestMapping("/place")
public class PlaceController {

    @Autowired
    private PlaceDAO pdao;

    @RequestMapping("/mappage")
    public String mappage() {
        return "map/mappage";
    }

    // 지도에서 선택한 지역의 장소 목록 조회하기
    @ResponseBody
    @RequestMapping("/mapList")
    public List<PlaceDTO> mapList(
            @RequestParam("region") String region,
            @RequestParam(value = "sigungu", required = false) String sigungu,
            @RequestParam(value = "type", defaultValue = "전체") String type) {

        return pdao.mapPlaceList(region, sigungu, type);
    }
}