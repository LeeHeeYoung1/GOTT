package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.BannerDAO;
import com.kedu.dao.NoticeDAO;
import com.kedu.dao.PlaceDAO;
import com.kedu.dao.ReviewDAO;
import com.kedu.dao.TravelPlanDAO;
import com.kedu.dto.BannerDTO;
import com.kedu.dto.NoticeDTO;
import com.kedu.dto.ReviewDTO;


@Controller
public class HomeController {
	
	@Autowired
	private TravelPlanDAO tpdao;
	
	@Autowired
	private PlaceDAO pdao;
	
	@Autowired
	private NoticeDAO ndao;
	
	@Autowired
	private BannerDAO bannerDAO;
	
	@Autowired
	private ReviewDAO rvdao;
	
	@RequestMapping(value = "/")
	public String home(Model model, HttpSession session) {
		
		String memberId = (String) session.getAttribute("loginId");
		String[] stayImgs = new String[3];
		
		stayImgs[0] = pdao.randomImgHotel();
		stayImgs[1] = pdao.randomImgMotel();
		stayImgs[2] = pdao.randomImgMB();
		
		List<NoticeDTO> ilist = ndao.important();
		List<BannerDTO> banner = bannerDAO.getBannerList();
		
		List<ReviewDTO> reviewList = rvdao.selectRecentReviews();
		
		model.addAttribute("planList", tpdao.selectPublicPlansWithCount());
		
		model.addAttribute("stayImgs", stayImgs);
		model.addAttribute("ilist", ilist);
		model.addAttribute("reviewList",reviewList);
		model.addAttribute("banner", banner);
		
		return "home";
	}
	
}
