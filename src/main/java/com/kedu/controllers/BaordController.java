package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.BoardDAO;
import com.kedu.dao.ReviewDAO;
import com.kedu.dto.BoardDTO;

@Controller
@RequestMapping("/board")
public class BaordController {
	
	@Autowired
	private BoardDAO bdao;
	
	@Autowired
	private ReviewDAO rdao;
	
	@RequestMapping("/freeBoard")
	public String freeBoard(Model model) {
		List<BoardDTO> boardList = bdao.selectAll();
		model.addAttribute("boardList", boardList);
		return "board/freeBoard";
	}
	
	@RequestMapping("/reviewBoard")
	public String reviewBoard() {
		return "board/reviewBoard";
	}
	
	@RequestMapping("/boardWrite")
	public String boardWrite() {
		return "board/boardWrite";
	}
	
	@RequestMapping("/writeRegi")
	public String writeRegi(Model model,HttpSession session,BoardDTO dto) {
		 System.out.println("세션 닉네임 = " + session.getAttribute("nickname"));
		String nickname = (String)session.getAttribute("nickname");
		dto.setWriter(nickname);
		model.addAttribute("nickname",nickname);
		System.out.println("writer = " + dto.getWriter());
		bdao.insert(dto);

		return "redirect:/board/freeBoard";
	}
	
	@RequestMapping("/boardContent")
	public String boardContent(BoardDTO dto, Model model, int seq) {
		BoardDTO boardContent = bdao.boardContent(seq);
		model.addAttribute("boardContent", boardContent);
		return "board/boardContent";
		
	}
}
