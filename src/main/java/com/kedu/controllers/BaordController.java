package com.kedu.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.kedu.dao.BoardDAO;
import com.kedu.dao.FilesDAO;
import com.kedu.dao.ReviewDAO;
import com.kedu.dto.BoardDTO;
import com.kedu.dto.FilesDTO;

@Controller
@RequestMapping("/board")
public class BaordController {
	
	@Autowired
	private BoardDAO bdao;
	
	@Autowired
	private ReviewDAO rdao;
	
	@Autowired
	private FilesDAO fdao;
	
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
	public String writeRegi(MultipartFile[] files, Model model,HttpSession session,BoardDTO dto) throws Exception {
		
		String nickname = (String)session.getAttribute("nickname");
		dto.setWriter(nickname);
		model.addAttribute("nickname",nickname);
		int seqValue = bdao.getNextVal();
		dto.setSeq(seqValue);
		bdao.insert(dto);
		
		String path = "resources/uploads/";
		
		for (MultipartFile file : files) {
			if (file.isEmpty()) {
				continue;
			}
			
			String oriName = file.getOriginalFilename();
			String sysName = UUID.randomUUID() + "_" + oriName;
			
			file.transferTo(new File(path, sysName));
			
			FilesDTO fdto = new FilesDTO(0, oriName, sysName, null, seqValue);
			fdao.fileRegi(fdto);
		}
		
		return "redirect:/board/freeBoard";
	}
	
	@RequestMapping("/boardContent")
	public String boardContent(BoardDTO dto, Model model, int seq) {
		bdao.count(seq);
		BoardDTO boardContent = bdao.boardContent(seq);
		List<FilesDTO> flist = fdao.getFile(seq);
		model.addAttribute("boardContent", boardContent);
		model.addAttribute("flist", flist);
		return "board/boardContent";
		
	}
	
	@RequestMapping("/download")
	public void download(String oriname, String sysname, HttpServletResponse resp, Model model) throws Exception {
		File target = new File("resources/uploads/" + sysname);
		
		oriname = new String(oriname.getBytes(), "ISO-8859-1");
		
		resp.setContentType("application/octet-stream");
		resp.setHeader("Content-Disposition", "attachment; filename=\"" + oriname + "\"");
		
		FileInputStream fis = new FileInputStream(target);
		FileCopyUtils.copy(fis, resp.getOutputStream());
	}
}
