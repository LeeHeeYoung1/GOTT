package com.kedu.controllers;

import java.util.ArrayList;
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
import com.kedu.dao.ReviewRecommendDAO;
import com.kedu.dao.ReviewReplyDAO;
import com.kedu.dto.PlaceDTO;
import com.kedu.dto.ReviewDTO;
import com.kedu.dto.ReviewReplyDTO;

@Controller
@RequestMapping("/review")
public class ReviewController {

	@Autowired
	private ReviewDAO rdao;
	
	@Autowired
	private PlaceDAO pdao;
	
	@Autowired
	private ReviewReplyDAO rpdao;
	
	@Autowired
	private ReviewRecommendDAO rrdao;
	
	@RequestMapping("/reviewBoard")
	public String reviewList(int cpage, String sort, String tag_list, Model model) {
		if (sort == null) {
			sort = "new";
		}
		if (tag_list == null) {
			tag_list = "";
		}
		
		List<ReviewDTO> rList = rdao.selectSort(cpage * 9 - 8, cpage * 9, sort, tag_list);
		model.addAttribute("rList", rList);
		model.addAttribute("recordTotalCount", rdao.selectCount(tag_list));
		model.addAttribute("recordCountPerPage", 9);
		model.addAttribute("naviCountPerPage", 10);
		model.addAttribute("cpage", cpage);
		model.addAttribute("sort", sort);
		model.addAttribute("tag_list", tag_list);
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
	public String datail(int seq, int place_id, Model model, HttpSession session) {
		rdao.viewCountUp(seq);
		ReviewDTO rdto = rdao.selectOne(seq);
		String[] myTags = TagSplitUtil.tagSplit(rdto.getTag());
		String nickname = rdao.nicknameSearch(seq);
		String placeName = rdao.targetSearch(rdto.getTarget_id());
		PlaceDTO pdto = pdao.selectOne(place_id);
		int recommend_count = rrdao.recommendCount(seq);
		boolean isRecommend = rrdao.isRecommend(seq, (String)session.getAttribute("loginId"));
		List<ReviewReplyDTO> replyList = rpdao.selectAll(seq);
		List<ReviewReplyDTO> childList = rpdao.selectChild(seq);
		model.addAttribute("childList", childList);
		model.addAttribute("replyList", replyList);
		model.addAttribute("isRecommend", isRecommend);
		model.addAttribute("recommend_count", recommend_count);
		model.addAttribute("rdto", rdto);
		model.addAttribute("myTags", myTags);
		model.addAttribute("nickname", nickname);
		model.addAttribute("placeName", placeName);
		model.addAttribute("pdto", pdto);
		return "/board/reviewContent";
	}

	@RequestMapping("/delete")
	public String delete(int seq) {
		rdao.delete(seq);
		return "redirect:/review/reviewBoard?cpage=1";
	}
	
	@RequestMapping("/update")
	public String update(ReviewDTO rdto) {
		rdao.update(rdto);
		return "redirect:/review/reviewBoard?cpage=1";
	}
	
	@RequestMapping("/recommendUp")
	public String recommendUp(int seq, HttpSession session, Model model) {
		rrdao.recommendUp(seq, (String)session.getAttribute("loginId"));
		ReviewDTO rdto = rdao.selectOne(seq);
		return "redirect:/review/detail?seq="+seq+"&place_id="+rdto.getTarget_id();
	}
	
	@RequestMapping("/recommendDown")
	public String recommendDown(int seq, HttpSession session, Model model) {
		rrdao.recommendDown(seq, (String)session.getAttribute("loginId"));
		ReviewDTO rdto = rdao.selectOne(seq);
		return "redirect:/review/detail?seq="+seq+"&place_id="+rdto.getTarget_id();
	}
	
	@RequestMapping("/reviewlist")
	public String reviewlist(Integer cpage, HttpSession session, Model model) {
	    String memberId = (String) session.getAttribute("loginId");
	    if (memberId == null) {
	        return "redirect:/members/loginpage";
	    }
	    if (cpage == null || cpage < 1) {
	        cpage = 1;
	    }
	    int pagesize = 5;
	    int recordTotalCount = rdao.countMyReview(memberId);
	    int pageTotalCount = (int)Math.ceil(recordTotalCount / (double)pagesize);
	    if (pageTotalCount > 0 && cpage > pageTotalCount) {
	        cpage = pageTotalCount;
	    }
	    ArrayList<ReviewDTO> myReviewList = rdao.selectMyReview(memberId, cpage, pagesize);
	    model.addAttribute("myReviewList", myReviewList);
	    model.addAttribute("recordTotalCount", recordTotalCount);
	    model.addAttribute("cpage", cpage);
	    model.addAttribute("pageTotalCount", pageTotalCount);
	    return "members/reviewlist";
	}
	
	
}
