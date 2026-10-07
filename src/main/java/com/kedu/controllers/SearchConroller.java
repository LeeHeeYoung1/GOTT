package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dao.PlaceDAO;
import com.kedu.dao.WishlistDAO;
import com.kedu.dto.PlaceDTO;

@Controller
@RequestMapping("/place")
public class SearchConroller {

	@Autowired
	private PlaceDAO dao;
	
	@Autowired
	private WishlistDAO wdao;
	
	@RequestMapping("/search")
	public String search(String keyword, Integer cpage, String type, Model model, HttpSession session) {
		
		if(type == null) {
	        type = "전체";
	    }
		
		if(cpage == null) {
	        cpage = 1;
	    }
		
		int start = cpage * 9 - 8;
		int end = cpage * 9;
		
		List<PlaceDTO> list = dao.search(keyword, type, start, end);
		
		String memberId = (String) session.getAttribute("loginId");
		
		if(memberId != null) {
			for(PlaceDTO place : list) {
				int result = wdao.wishlistCheck(memberId, place.getPlace_id());
				place.setWish(result > 0);
			}
		}
		
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
