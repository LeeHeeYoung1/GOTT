package com.kedu.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dao.PlaceDAO;
import com.kedu.dto.PlaceDTO;

@Controller
@RequestMapping("/place")
public class SearchConroller {

	@Autowired
	private PlaceDAO dao;
	
	@RequestMapping("/search")
	public String search(String keyword,Integer cpage, String type, Model model) {
		
		if(type == null) {
	        type = "ÀüÃ¼";
	    }
		
		if(cpage == null) {
		        cpage = 1;
		}
		
		int start = cpage * 9 - 8;
		int end = cpage * 9;
		
		List<PlaceDTO> list = dao.search(keyword, type, start, end);
		model.addAttribute("recordTotalCount", dao.searchCount(keyword, type));
		model.addAttribute("recordCountPerPage", 9);
		model.addAttribute("naviCountPerPage", 10);
		model.addAttribute("cpage", cpage);
		model.addAttribute("type", type);

	    model.addAttribute("list", list);
	    model.addAttribute("keyword", keyword);

	    return "placeSearch";
	}
	
	@RequestMapping("/keyword")
	@ResponseBody
	public List<String> keyword(String keyword) {
		
		return dao.searchKeyword(keyword);
	}
}
