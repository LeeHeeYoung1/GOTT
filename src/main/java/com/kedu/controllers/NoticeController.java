package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.FaqDAO;
import com.kedu.dao.NoticeDAO;
import com.kedu.dto.FaqDTO;
import com.kedu.dto.NoticeDTO;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	private NoticeDAO ndao;
	
	@Autowired
	private FaqDAO fdao;
	
	@RequestMapping("/notice_list")
	public String noticeList(Model model) {
		List<NoticeDTO> nlist = ndao.list();
		model.addAttribute("nlist", nlist);
		
		List<NoticeDTO> ilist = ndao.important();
		model.addAttribute("ilist", ilist);
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
	public String register(NoticeDTO ndto, HttpSession session) {
		ndto.setWriter((String) session.getAttribute("loginId"));
		ndao.insert(ndto);
		return "redirect:/notice/notice_list";
	}
	
	@RequestMapping("/notice_delete")
	public String delete(int notice_id) {
		ndao.delete(notice_id);
		return "redirect:/notice/notice_list";
	}
	
	@RequestMapping("/notice_update")
	public String update(NoticeDTO ndto) {
		ndao.update(ndto);
		return "redirect:/notice/detail?notice_id="+ndto.getNotice_id();
	}
	
	@RequestMapping("/qna")
	public String qna(HttpSession session) {
		
		return "notice/qna";
	}
	
	@RequestMapping("/faq")
	public String faq(Model model, int cpage, String keyword) {

	    if (keyword == null) {
	        keyword = "";
	    }

	    int recordCountPerPage = 10;
	    int naviCountPerpage = 10;

	    int recordTotalCount = fdao.faqCount(keyword);

	    int start = cpage * recordCountPerPage - 9;
	    int end = cpage * recordCountPerPage;

	    List<FaqDTO> flist = fdao.faqList(start, end, keyword);

	    model.addAttribute("flist", flist);
	    model.addAttribute("recordTotalCount", recordTotalCount);
	    model.addAttribute("recordCountPerPage", recordCountPerPage);
	    model.addAttribute("naviCountPerpage", naviCountPerpage);
	    model.addAttribute("cpage", cpage);
	    model.addAttribute("keyword", keyword);

	    return "notice/faq";
	}
	
	@RequestMapping("/faq_register")
	public String faq_register(Model model, HttpSession session, int cpage) {

	    String loginId = (String) session.getAttribute("loginId");

	    if (!"admin0001".equals(loginId)) {
	        return "redirect:/notice/faq?cpage=" + cpage;
	    }

	    model.addAttribute("cpage", cpage);

	    return "notice/faq_register";
	}
	
	@RequestMapping("/write")
	public String write(FaqDTO dto, HttpSession session) {

	    String loginId = (String) session.getAttribute("loginId");

	    if (!"admin0001".equals(loginId)) {
	        return "redirect:/notice/faq";
	    }
	    fdao.insert(dto);

	    return "redirect:/notice/faq?cpage=1";
	}
	
	@RequestMapping("/faq_content")
	public String faqContent(Model model, int faq_id, int cpage, String keyword) {

	    FaqDTO dto = fdao.faqContent(faq_id);

	    model.addAttribute("faq", dto);
	    model.addAttribute("cpage", cpage);
	    model.addAttribute("keyword", keyword);

	    return "notice/faq_content";
	}
}
