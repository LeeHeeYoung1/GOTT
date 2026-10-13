package com.kedu.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.TravelPlanDAO;


@Controller
public class HomeController {
	
	@Autowired
	TravelPlanDAO tpdao;
	
	@RequestMapping(value = "/")
	public String home(Model model, HttpSession session) {
		
		String memberId = (String) session.getAttribute("loginId");
		
		model.addAttribute("myPlannerList",tpdao.selectMyPlansWithCount(memberId));
		model.addAttribute("planList", tpdao.selectPublicPlans());
		
		return "home";
	}
	
}
