package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.commons.TagSplitUtil;
import com.kedu.dao.PlaceDAO;
import com.kedu.dao.ReviewDAO;
import com.kedu.dto.PlaceDTO;
import com.kedu.dto.ReviewDTO;

@Controller
@RequestMapping("/review")
public class ReviewController {

	@Autowired
	private ReviewDAO rdao;
	
	@Autowired
	private PlaceDAO pdao;
	
	@RequestMapping("/reviewBoard")
	public String reviewBoard(int cpage, Model model) {
		List<ReviewDTO> rList = rdao.selectFromTo(cpage * 9 - 8, cpage * 9);
		model.addAttribute("rList", rList);
		model.addAttribute("recordTotalCount", rdao.selectCount());
		model.addAttribute("recordCountPerPage", 9);
		model.addAttribute("naviCountPerPage", 10);
		model.addAttribute("cpage", cpage);
		return "board/reviewBoard";
	}
	
	@RequestMapping("/review_write")
	public String review_write() {
		return "board/reviewWrite";
	}
	
	@ResponseBody
	@RequestMapping("/placeList")
	public List<PlaceDTO> placeList(String placeType, String region) {
		return pdao.placeList(placeType, region);
	}
	
	@RequestMapping("/write")
	public String write(ReviewDTO dto) {
		rdao.insert(dto);
		return "redirect:/review/reviewBoard?cpage=1";
	}
	
	@RequestMapping("/detail")
	public String datail(int seq, Model model) {
		ReviewDTO rdto = rdao.selectOne(seq);
		String[] myTags = TagSplitUtil.tagSplit(rdto.getTag());
		String nickname = rdao.nicknameSearch(seq);
		String placeName = rdao.targetSearch(rdto.getTarget_id());
		model.addAttribute("rdto", rdto);
		model.addAttribute("myTags", myTags);
		model.addAttribute("nickname", nickname);
		model.addAttribute("placeName", placeName);
		return "/board/reviewContent";
	}

	@RequestMapping("/delete")
	public String delete(int seq) {
		rdao.delete(seq);
		return "redirect:/review/reviewBoard?cpage=1";
	}
}
