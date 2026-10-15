package com.kedu.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kedu.dao.BannerDAO;
import com.kedu.dto.BannerDTO;

@Controller
@RequestMapping("/event")
public class EventControllers {
	
	
	@Autowired
	private BannerDAO bannerDAO;
	
	@RequestMapping("/eventpage")
	public String eventpage(Model model) {
		
		List<BannerDTO> banner = bannerDAO.getBannerList();
		
		model.addAttribute("banner", banner);
		
		return "event/event";
	}
	

	@RequestMapping("/insert")
	public String insertEvent(BannerDTO dto) {
		
		bannerDAO.insertEvent(dto);
	    return "redirect:/event/eventpage";
	}
	
	@RequestMapping("/delete")
	public String deleteEvent(@RequestParam("bannerId") int banner_id) {
		bannerDAO.deleteEvent(banner_id);
		return "redirect:/event/eventpage";
	}

	@RequestMapping("/company")
	public String company() {
		return "company";
	}
}
