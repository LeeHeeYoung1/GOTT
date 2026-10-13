package com.kedu.controllers;

import java.io.File;
import java.io.FileInputStream;
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

import com.kedu.dao.FaqDAO;
import com.kedu.dao.FilesDAO;
import com.kedu.dao.NoticeDAO;
import com.kedu.dao.QnaDAO;
import com.kedu.dto.FaqDTO;
import com.kedu.dto.FilesDTO;
import com.kedu.dto.NoticeDTO;
import com.kedu.dto.QnaDTO;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	private NoticeDAO ndao;
	
	@Autowired
	private FaqDAO fdao;
	
	@Autowired
	private FilesDAO filesDAO;
	
	@Autowired
	private QnaDAO qdao;
	
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
	public String write(MultipartFile[] attachFiles, FaqDTO dto, HttpSession session) throws Exception {

	    String loginId = (String) session.getAttribute("loginId");

	    if (!"admin0001".equals(loginId)) {
	        return "redirect:/notice/faq?cpage=1";
	    }

	    String writer = (String) session.getAttribute("nickname");
	    dto.setWriter(writer);

	    int faqId = fdao.getNextVal();
	    dto.setFaq_id(faqId);

	    fdao.insert(dto);

	    String path = "\\\\10.5.4.10\\gott_uploads\\";

	    if (attachFiles != null) {
	        for (MultipartFile file : attachFiles) {

	            if (file.isEmpty()) {
	                continue;
	            }

	            String oriName = file.getOriginalFilename();
	            String sysName = UUID.randomUUID() + "_" + oriName;

	            file.transferTo(new File(path, sysName));

	            FilesDTO fdto = new FilesDTO(
	                0, oriName, sysName, null, faqId
	            );

	            filesDAO.fileRegi(fdto);
	        }
	    }

	    return "redirect:/notice/faq?cpage=1";
	}
	
	@RequestMapping("/download")
	public void download(String oriname, String sysname,
	        HttpServletResponse resp) throws Exception {

	    String path = "\\\\10.5.4.10\\gott_uploads\\";
	    File target = new File(path + sysname);

	    oriname = new String(oriname.getBytes(), "ISO-8859-1");

	    resp.setContentType("application/octet-stream");
	    resp.setHeader("Content-Disposition",
	            "attachment; filename=\"" + oriname + "\"");

	    FileInputStream fis = new FileInputStream(target);
	    FileCopyUtils.copy(fis, resp.getOutputStream());
	    fis.close();
	}
	
	@RequestMapping("/faq_content")
	public String faqContent(Model model, int faq_id, int cpage, String keyword) {

	    FaqDTO dto = fdao.faqContent(faq_id);

	    List<FilesDTO> fileList = filesDAO.getFile(faq_id);

	    model.addAttribute("faq", dto);
	    model.addAttribute("flist", fileList);
	    model.addAttribute("cpage", cpage);
	    model.addAttribute("keyword", keyword);

	    return "notice/faq_content";
	}
	
	@RequestMapping("/faq_update")
	public String faqUpdate(FaqDTO dto, int cpage, String keyword,
	        HttpSession session) {

	    String loginId = (String) session.getAttribute("loginId");

	    if (!"admin0001".equals(loginId)) {
	        return "redirect:/notice/faq?cpage=" + cpage;
	    }

	    fdao.update(dto);

	    if (keyword == null || keyword.equals(",")) {
	        keyword = "";
	    }

	    return "redirect:/notice/faq_content?faq_id=" + dto.getFaq_id()
	            + "&cpage=" + cpage
	            + "&keyword=" + keyword;
	}

	
	@RequestMapping("/faq_delete")
	public String faqDelete(int faq_id, int cpage, String keyword,
	        HttpSession session) {

	    String loginId = (String) session.getAttribute("loginId");

	    if (!"admin0001".equals(loginId)) {
	        return "redirect:/notice/faq?cpage=" + cpage;
	    }

	    fdao.delete(faq_id);

	    return "redirect:/notice/faq?cpage=" + cpage;
	}
	
	@RequestMapping("/qna")
	public String qna(Model model, Integer cpage, String keyword) {

	    if (cpage == null || cpage < 1) {
	        cpage = 1;
	    }

	    if (keyword == null) {
	        keyword = "";
	    }

	    int recordTotalCount = qdao.qnaCount(keyword);
	    List<QnaDTO> qList = qdao.selectQnaList(cpage * 10 - 9, cpage * 10, keyword);

	    model.addAttribute("qList", qList);
	    model.addAttribute("recordTotalCount", recordTotalCount);
	    model.addAttribute("recordCountPerPage", 10);
	    model.addAttribute("naviCountPerpage", 10);
	    model.addAttribute("cpage", cpage);
	    model.addAttribute("keyword", keyword);

	    return "notice/qna";
	}
	
	@RequestMapping("/qna_register")
	public String qnaRegister(int cpage,Model model) {
		model.addAttribute("cpage", cpage);
		return "notice/qna_register";
	}
	
	@RequestMapping("/qnaWrite")
	public String qnaWrite(QnaDTO dto, MultipartFile[] attachFiles,
	        int cpage, HttpSession session) throws Exception {

	    String memberId = (String) session.getAttribute("loginId");

	    if (memberId == null) {
	        return "redirect:/members/login";
	    }

	    if (dto.getIs_private() == null) {
	        dto.setIs_private("N");
	        dto.setPw(null);
	    }

	    dto.setStatus("답변대기");
	    dto.setMember_id(memberId);

	    int qid = qdao.getNextVal();
	    dto.setQid(qid);

	    qdao.insert(dto);

	    String path = "\\\\10.5.4.10\\gott_uploads\\";

	    if (attachFiles != null) {
	        for (MultipartFile file : attachFiles) {

	            if (file.isEmpty()) {
	                continue;
	            }

	            String oriName = file.getOriginalFilename();
	            String sysName = UUID.randomUUID() + "_" + oriName;

	            file.transferTo(new File(path, sysName));

	            FilesDTO fdto = new FilesDTO(
	                    0, oriName, sysName, null, qid
	            );

	            filesDAO.fileRegi(fdto);
	        }
	    }

	    return "redirect:/notice/qna?cpage=" + cpage;
	}
	
	@RequestMapping("/qna_content")
	public String qnaContent(String pw, int qid, int cpage,
	        Model model, HttpSession session) {

	    QnaDTO dto = qdao.qnaContent(qid);

	    if (dto == null) {
	        return "redirect:/notice/qna?cpage=" + cpage;
	    }

	    // 공개 글은 바로 상세 페이지로 이동
	    if (!"Y".equals(dto.getIs_private())) {
	        model.addAttribute("qna", dto);
	        model.addAttribute("cpage", cpage);
	        model.addAttribute("loginId", session.getAttribute("loginId"));
	        List<FilesDTO> fileList = filesDAO.getFile(qid);
	        model.addAttribute("fileList", fileList);

	        return "notice/qna_content";
	    }

	    // 비공개 글: 비밀번호 인증 성공 후 상세 페이지 표시
	    String authKey = "qnaAuth_" + qid;

	    if (Boolean.TRUE.equals(session.getAttribute(authKey))) {
	        session.removeAttribute(authKey);

	        model.addAttribute("qna", dto);
	        model.addAttribute("cpage", cpage);
	        model.addAttribute("loginId", session.getAttribute("loginId"));
	        List<FilesDTO> fileList = filesDAO.getFile(qid);
	        model.addAttribute("fileList", fileList);

	        return "notice/qna_content";
	    }

	    // 비밀번호 입력 후 확인
	    if (pw != null && !pw.isEmpty()) {

	        if (pw.equals(dto.getPw())) {
	            session.setAttribute(authKey, true);

	            model.addAttribute("qid", qid);
	            model.addAttribute("cpage", cpage);
	            model.addAttribute("success", true);

	            return "notice/qna_password";
	        }

	        model.addAttribute("msg", "비밀번호가 틀렸습니다.");
	    }

	    model.addAttribute("qid", qid);
	    model.addAttribute("cpage", cpage);

	    return "notice/qna_password";
	}
	
	@RequestMapping("/qna_reply")
	public String qnaReply(int qid, int cpage, String reply,
	        HttpSession session) {

	    String loginId = (String) session.getAttribute("loginId");

	    if (!"admin0001".equals(loginId)) {
	        return "redirect:/notice/qna?cpage=" + cpage;
	    }

	    if (reply != null && !reply.trim().isEmpty()) {
	        qdao.insertReply(qid, reply.trim());
	    }

	    return "redirect:/notice/qna_content?qid=" + qid
	            + "&cpage=" + cpage;
	}
	
	@ResponseBody
	@RequestMapping("/qna_reply_update")
	public String qnaReplyUpdate(int qid, String reply,
	        HttpSession session) {

	    String loginId = (String) session.getAttribute("loginId");

	    if (!"admin0001".equals(loginId)) {
	        return "fail";
	    }

	    if (reply == null || reply.trim().isEmpty()) {
	        return "fail";
	    }

	    int result = qdao.updateReply(qid, reply.trim());

	    if (result > 0) {
	        return "success";
	    }

	    return "fail";
	}

	@ResponseBody
	@RequestMapping("/qna_reply_delete")
	public String qnaReplyDelete(int qid, HttpSession session) {

	    String loginId = (String) session.getAttribute("loginId");

	    if (!"admin0001".equals(loginId)) {
	        return "fail";
	    }

	    int result = qdao.deleteReply(qid);

	    if (result > 0) {
	        return "success";
	    }

	    return "fail";
	}
	
	@RequestMapping("/qna_download")
	public void qnaDownload(String oriname, String sysname, HttpServletResponse resp) throws Exception {

	    String path = "\\\\10.5.4.10\\gott_uploads\\";
	    File target = new File(path + sysname);

	    oriname = new String(oriname.getBytes(), "ISO-8859-1");

	    resp.setContentType("application/octet-stream");
	    resp.setHeader("Content-Disposition",
	            "attachment; filename=\"" + oriname + "\"");

	    FileInputStream fis = new FileInputStream(target);
	    FileCopyUtils.copy(fis, resp.getOutputStream());
	    fis.close();
	}

}