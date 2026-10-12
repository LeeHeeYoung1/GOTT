package com.kedu.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dao.ReviewDAO;
import com.kedu.dao.ReviewReplyDAO;
import com.kedu.dto.ReviewDTO;
import com.kedu.dto.ReviewReplyDTO;

@Controller
@RequestMapping("/review/reply")
public class ReviewReplyController {

	@Autowired
	private ReviewReplyDAO rpdao;
	
	@Autowired
	private ReviewDAO rdao;
	
	@RequestMapping("/write")
	public String write(ReviewReplyDTO rpdto, HttpSession session) {
		rpdto.setMember_id((String)session.getAttribute("loginId"));
		rpdao.insert(rpdto);

		ReviewDTO rdto = rdao.selectOne(rpdto.getReview_seq());
		return "redirect:/review/detail?seq=" + rpdto.getReview_seq() + "&place_id=" + rdto.getTarget_id();
	}
	
	@RequestMapping("/delete")
	public String delete(int seq, int review_seq) {
		ReviewDTO rdto = rdao.selectOne(review_seq);
		rpdao.delete(seq);
		return "redirect:/review/detail?seq=" + review_seq + "&place_id=" + rdto.getTarget_id();
	}
	
	@ResponseBody
	@RequestMapping("/update")
	public String update(int seq, String contents) {
		rpdao.update(seq, contents);
		return "ok";
	}
	
	@RequestMapping("/childWrite")
	public String childWrite(ReviewReplyDTO rpdto, HttpSession session) {
		rpdto.setMember_id((String)session.getAttribute("loginId"));
		rpdao.insert(rpdto);
		ReviewDTO rdto = rdao.selectOne(rpdto.getReview_seq());
		return "redirect:/review/detail?seq=" + rpdto.getReview_seq()
				+ "&place_id=" + rdto.getTarget_id();
	}
	
	@ResponseBody
	@RequestMapping("/childUpdate")
	public String childUpdate(int seq, String contents) {
		rpdao.childUpdate(seq, contents);
		return "ok";
	}
}
