package com.kedu.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.BannerDAO;
import com.kedu.dto.BannerDTO;
import com.kedu.services.BannerService;

@Controller
@RequestMapping("/event")
public class EventControllers {
	
	@Autowired
	private BannerService bannerService;
	
	@Autowired
	private BannerDAO bannerDAO;
	
	@RequestMapping("/eventpage")
	public String eventpage(Model model) {
		
		List<BannerDTO> banner = bannerService.getBannerList();
		
		System.out.println("조회된 배너 개수: " + banner.size());
		
		model.addAttribute("banner", banner);
		
		return "event/event";
	}
	
}
