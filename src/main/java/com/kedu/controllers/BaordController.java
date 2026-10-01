package com.kedu.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.BoardDAO;
import com.kedu.dao.ReviewDAO;

@Controller
@RequestMapping("/board")
public class BaordController {
	
	@Autowired
	private BoardDAO bdao;
	
	@Autowired
	private ReviewDAO rdao;
	
	@RequestMapping("/freeBoard")
	public String freeBoard() {
		return "board/freeBoard";
	}
	
	@RequestMapping("/reviewBoard")
	public String reviewBoard() {
		return "board/reviewBoard";
	}
}
