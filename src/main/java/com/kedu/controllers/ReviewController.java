package com.kedu.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dao.PlaceDAO;
import com.kedu.dao.ReviewDAO;
import com.kedu.dto.PlaceDTO;

@Controller
@RequestMapping("/review")
public class ReviewController {

	@Autowired
	private ReviewDAO rdao;
	
	@Autowired
	private PlaceDAO pdao;
	
	@RequestMapping("/review_write")
	public String review_write() {
		return "board/reviewWrite";
	}
	
	@ResponseBody
	@RequestMapping("/placeList")
	public List<PlaceDTO> placeList(String placeType, String region) {
		return pdao.placeList(placeType, region);
	}
	
}
