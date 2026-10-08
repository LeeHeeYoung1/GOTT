package com.kedu.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kedu.dao.BoardDAO;
import com.kedu.dao.FilesDAO;
import com.kedu.dao.RecommendDAO;
import com.kedu.dao.ReplyDAO;
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
	
	@Autowired
	private ReplyDAO redao;
	
	@Autowired
	private RecommendDAO recommendDao;
	
	@RequestMapping("/freeBoard")
	public String freeBoard(int cpage, Model model) {

		List<BoardDTO> list = bdao.selectFromTo(cpage * 10 - 9, cpage * 10);
		for(BoardDTO board : list) {
		    board.setRecommendCount(recommendDao.recommendCount(board.getSeq()));
		    
		}
		
		model.addAttribute("boardList", list);
		
		List<Integer> fileList = new ArrayList<>();
		for(BoardDTO board : list) {
			if(fdao.hasFile(board.getSeq())) {
				fileList.add(board.getSeq());
			}
		}
		model.addAttribute("fileList",fileList);
		
		int boardCount = bdao.boardCount();
		
		model.addAttribute("boardCount", boardCount);
		model.addAttribute("recordTotalCount", bdao.boardCount());
		model.addAttribute("recordCountPerPage", 10);
		model.addAttribute("naviCountPerpage", 10);
		model.addAttribute("cpage",cpage);
		
		return "board/freeBoard";
	}
	
	@RequestMapping("/boardWrite")
	public String boardWrite() {
		return "board/boardWrite";
	}
	
	@RequestMapping("/writeRegi")
	public String writeRegi(MultipartFile[] attachFiles, Model model,HttpSession session,BoardDTO dto) throws Exception {
		
		String nickname = (String)session.getAttribute("nickname");
		dto.setWriter(nickname);
		model.addAttribute("nickname",nickname);
		int seqValue = bdao.getNextVal();
		dto.setSeq(seqValue);
		bdao.insert(dto);
		
		String path = "\\\\10.5.4.10\\gott_uploads\\";
		
		for (MultipartFile file : attachFiles) {
			 System.out.println("첨부파일 : " + file.getOriginalFilename());
			if (file.isEmpty()) {
				continue;
			}
			
			String oriName = file.getOriginalFilename();
			String sysName = UUID.randomUUID() + "_" + oriName;
			
			file.transferTo(new File(path, sysName));
			
			FilesDTO fdto = new FilesDTO(0, oriName, sysName, null, seqValue);
			fdao.fileRegi(fdto);
		}
		
		return "redirect:/board/freeBoard?cpage=1";
	}
	
	@RequestMapping("/boardContent")
	public String boardContent(BoardDTO dto, Model model, int seq, int cpage, HttpSession session) {
		String nickname = (String)session.getAttribute("nickname");
		bdao.viewCount(seq);
		BoardDTO boardContent = bdao.boardContent(seq);
		List<FilesDTO> flist = fdao.getFile(seq);
		model.addAttribute("nickname", nickname);
		model.addAttribute("boardContent", boardContent);
		model.addAttribute("flist", flist);
		model.addAttribute("replyList", redao.selectByBoard(seq));
		model.addAttribute("replyCount", redao.replyCount(seq));
		model.addAttribute("recommendCount", recommendDao.recommendCount(seq));
		model.addAttribute("cpage",cpage);
		
		if(nickname != null ) {
			model.addAttribute("checkRecommend", recommendDao.checkRecommend(seq, nickname));
		}
		
		return "board/boardContent";
		
	}
	
	@RequestMapping("/download")
	public void download(String oriname, String sysname, HttpServletResponse resp, Model model) throws Exception {
		
	    String path = "\\\\10.5.4.10\\gott_uploads\\";
		File target = new File(path + sysname);
		
		oriname = new String(oriname.getBytes(), "ISO-8859-1");
		
		resp.setContentType("application/octet-stream");
		resp.setHeader("Content-Disposition", "attachment; filename=\"" + oriname + "\"");
		
		FileInputStream fis = new FileInputStream(target);
		FileCopyUtils.copy(fis, resp.getOutputStream());
	}
	
	@RequestMapping("/recommend")
	@ResponseBody
	public String recommend(HttpSession session, int board_seq) {

	    String writer = (String)session.getAttribute("nickname");

	    int check = recommendDao.checkRecommend(board_seq, writer);

	    if(check == 0) {
	        recommendDao.recommend(board_seq, writer);
	        return "recommend";
	    } else {
	        recommendDao.deleteRecommend(board_seq, writer);
	        return "cancel";
	    }
	}
}
