package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.NoticeDAO;
import com.kedu.dto.NoticeDTO;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	private NoticeDAO ndao;
	
	@RequestMapping("/notice_list")
	public String noticeList(Model model, HttpSession session) {
		List<NoticeDTO> nlist = ndao.list();
		model.addAttribute("nlist", nlist);
		return "notice/notice_list";
	}
	
	@RequestMapping("/detail")
	public String detail(int notice_id, Model model) {
		ndao.viewCountUpdate(notice_id);
		NoticeDTO ndto = ndao.select(notice_id);
		model.addAttribute("ndto", ndto);
		return "notice/notice";
	}

	@RequestMapping("/notice_register")
	public String notice_register() {
		return "notice/register";
	}
	
	@RequestMapping("/register")
	public String register(NoticeDTO ndto) {
		ndao.insert(ndto);
		return "notice/notice_list";
	}
}
