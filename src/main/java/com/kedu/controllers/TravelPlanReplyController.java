package com.kedu.controllers;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
		return "redirect:/travelPlan/detail?planId="+dto.getPlan_id();
	}
	
	@RequestMapping("/delete")
	public String tprDelete(int seq, int plan_id){
		tprdao.tprDelete(seq);
		return "redirect:/travelPlan/detail?planId="+plan_id;
	}
  
	@ResponseBody
	@RequestMapping("/update")
	public String update(int seq, String contents) {
		tprdao.tprUpdate(seq, contents);
		return "ok";
	}
}
