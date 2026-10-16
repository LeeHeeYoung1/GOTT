package com.kedu.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.ReplyDAO;
import com.kedu.dto.ReplyDTO;

@Controller
@RequestMapping("/reply")

public class ReplyController {

	@Autowired
	private ReplyDAO rdao;
	
	@RequestMapping("/writeReply")
	public String write(ReplyDTO dto, HttpSession session,Model model, int cpage) {

        String writer = (String)session.getAttribute("nickname");

        dto.setWriter(writer);
        System.out.println("board_seq: " + dto.getBoard_seq());
        System.out.println("parent_seq: " + dto.getParent_seq());
        System.out.println("writer: " + writer);
        model.addAttribute("nickname",writer);
        
        rdao.insert(dto);

        return "redirect:/board/boardContent?seq=" + dto.getBoard_seq() + "&cpage=" + cpage;
    }
	
	@RequestMapping("/delete")
	public String delete(ReplyDTO dto, HttpSession session, int cpage) {
		
		rdao.deleteChild(dto.getSeq());
	    rdao.delete(dto.getSeq());

	    return "redirect:/board/boardContent?seq=" + dto.getBoard_seq() + "&cpage=" + cpage;
	}
	
	@RequestMapping("/update")
	public String update(ReplyDTO dto, HttpSession session, int cpage) {

	    String writer = (String)session.getAttribute("nickname");

	    rdao.update(dto.getContents(), dto.getSeq(), writer);

	    return "redirect:/board/boardContent?seq=" + dto.getBoard_seq() + "&cpage=" + cpage;
	}
}
