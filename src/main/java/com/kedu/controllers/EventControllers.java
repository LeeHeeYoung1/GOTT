package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kedu.dao.BannerDAO;
import com.kedu.dao.CouponDAO;
import com.kedu.dto.BannerDTO;

@Controller
@RequestMapping("/event")
public class EventControllers {
	
	
	@Autowired
	private BannerDAO bannerDAO;
	
	@Autowired
	private CouponDAO cdao;
	
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
	
	@RequestMapping("/autumn")
	public String autumn(HttpSession session, Model model) {
		
		String id = (String) session.getAttribute("loginId");
		
		if (id == null) {
			return "/members/loginpage";
		}
		
		int count = cdao.countMyAutumn(id);
		
		if(count == 0) {
			cdao.insertAutumn(id);
			session.setAttribute("autumn", "단풍 명소 숙소 쿠폰이 발급되었습니다.");
		} else {
			session.setAttribute("autumn", "해당 쿠폰은 중복 발급이 불가능합니다.");
		}
		
		return "redirect:/coupon/myCoupon";
	}
	
}
