package com.kedu.controllers;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.TravelPlanReplyDAO;
import com.kedu.dto.TravelPlanReplyDTO;

@Controller
@RequestMapping("/travelPlanReply")
public class TravelPlanReplyController {

	@Autowired
    private TravelPlanReplyDAO tprdao;
    
	@RequestMapping("/insert")
	public String tprInsert(TravelPlanReplyDTO dto){
		tprdao.tprInsert(dto);
		return "/members/planDetail";
	}
  
}
