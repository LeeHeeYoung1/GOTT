package com.kedu.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.commons.EncryptionUtils;
import com.kedu.dao.MembersDAO;
import com.kedu.dao.Travel_TypeDAO;
import com.kedu.dto.MembersDTO;
import com.kedu.dto.Travel_TypeDTO;
import com.kedu.services.EmailService;

@Controller
@RequestMapping("/members")
public class MembersControllers {
	
	@Autowired
	private MembersDAO mdao;
	@Autowired
	private Travel_TypeDAO tdao;
	@Autowired
	private EmailService emailService;
	
	@RequestMapping("/loginpage")
	public String loginPage() {
	    return "members/login";
	}
	
	@ResponseBody
	@RequestMapping("/login")
	public int login(MembersDTO mdto, HttpSession session) {
		
		int result = mdao.login(mdto);
		
		if(result == 1) {
			MembersDTO member = mdao.selectById(mdto.getId());
			
			session.setAttribute("loginId", member.getId());
		    session.setAttribute("name", member.getName());
		    session.setAttribute("phone", member.getPhone());
		    session.setAttribute("email", member.getEmail());
		    session.setAttribute("gender", member.getGender());
		    session.setAttribute("Dob", member.getDob());
		    session.setAttribute("zipcode", member.getZipcode());
		    session.setAttribute("address1", member.getAddress1());
		    session.setAttribute("address2", member.getAddress2());
		    session.setAttribute("nickname", member.getNickname());
		    session.setAttribute("mileage", member.getMileage());
		    session.setAttribute("regdate", member.getRegdate());
		}
		return result;
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) throws Exception {
		session.invalidate(); 
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping("/idcheck")
	public int idcheck(String id) {
		
		return mdao.idcheck(id);
	}
	
	@RequestMapping("/signuppage")
	public String signuppage() {
		return "members/signup";
	}
	
	@ResponseBody
	@RequestMapping("/nicknamecheck")
	public int nicknamecheck(String nickname) {
		return mdao.nicknamecheck(nickname);
	}
	
	@RequestMapping("/signup")
	public String signup(MembersDTO mdto) {
		
		mdto.setPw(EncryptionUtils.encryptSHA512(mdto.getPw()));
		mdao.signup(mdto);
		
		return "redirect:/members/loginpage";
	}
	
	@RequestMapping("/mypage")
	public String mypage() {
		return "members/mypage";
	}
	
	@RequestMapping("/update")
	public String update() {
		return "members/update";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(MembersDTO mdto, HttpSession session) {
	    String id = (String) session.getAttribute("loginId");
	    mdto.setId(id);
	    int result = mdao.update(mdto);
	    if(result>0) {
	    	session.setAttribute("nickname", mdto.getNickname());
	    	session.setAttribute("phone", mdto.getPhone());
	    	session.setAttribute("email", mdto.getEmail());
	    	session.setAttribute("zipcode", mdto.getZipcode());
	    	session.setAttribute("address1", mdto.getAddress1());
	    	session.setAttribute("address2", mdto.getAddress2());
	    }
	    return "redirect:/members/mypage";
	}
	
	@RequestMapping("/deleted")
	public String deleted() {
		return "members/deleted";
	}
	
	@RequestMapping(value = "/deleted", method = RequestMethod.POST)
	public String deleted(MembersDTO mdto,HttpSession session) {
	    String id = (String) session.getAttribute("loginId");
	    mdto.setPw(EncryptionUtils.encryptSHA512(mdto.getPw()));
	    int result = mdao.deleted(id, mdto);
	    if (result > 0) {
	        session.invalidate();
	        return "redirect:/";
	    }
	    return "members/login";
	}
	
	
	@RequestMapping("event/tourTypeTest")
	public String tourTypeTest() {
		return "event/tourTypeTest";
	}
	
	@RequestMapping("/tourTypeTestResult")
	public String tourTypeTestResult(Travel_TypeDTO dto, HttpSession session) {
		String id = (String)session.getAttribute("loginId");
		dto.setMember_id(id);
		tdao.insertType(dto);
		return "redirect:/members/mypage";
	}
	
	@RequestMapping("/idsearchpage")
	public String idsearchpage() {
		return "members/idsearch";
	}
	
	@ResponseBody
	@RequestMapping("/idsearch")
	public String idsearch(MembersDTO mdto) {
		
		System.out.println("이름 : " + mdto.getName());
		System.out.println("이메일 : " + mdto.getEmail());
		
		String id = mdao.findId(mdto);
		
		System.out.println("찾은 ID : " + id);
		 
		if(id == null) {
			return "";
		}
		
		return id;
	}
	@ResponseBody
	@RequestMapping("/sendpwcode")
	public String sendpwcode(String id, String email, HttpSession session) {
		MembersDTO mdto = mdao.findEmail(id, email);
		
		if(mdto == null) {
			return "notfound";
		}
		
		int random = (int)(Math.random() * 900000) + 100000;
		String code = String.valueOf(random);
		
		try {
			emailService.sendEmail(email, code);
			session.setAttribute("pwEmailcode", code);
			session.setAttribute("pwFindId", id);
			session.setAttribute("pwFindEmail", email);
			
			return "success";
		} catch(Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}
	
	@RequestMapping("/pwsearchpage")
	public String pwsearchpage() {
		return "members/pwsearch";
	}
	
	@ResponseBody
	@RequestMapping("/verifypwcode")
	public String verifypwcode(String code, HttpSession session) {
		String savedCode = (String)session.getAttribute("pwEmailcode");
		
		if(savedCode == null) {
			return "fail";
		} else if(savedCode.equals(code)) {
			session.setAttribute("pwVerified", true);
			return "success";
		} else {
			return "fail";
		}
	}
	
	@ResponseBody
	@RequestMapping("/updatepw")
	public String updatepw(String pw, HttpSession session) {
		// 이메일 인증 여부 확인
	    Boolean verified = (Boolean)session.getAttribute("pwVerified");
	    if(verified == null || !verified) {
	        return "notVerified";
	    }
	    // 비밀번호를 변경할 아이디 가져오기
	    String id = (String)session.getAttribute("pwFindId");
	    if(id == null) {
	        return "fail";
	    }
	    // 비밀번호 암호화
	    String encryptedPw = EncryptionUtils.encryptSHA512(pw);
	    // DB 비밀번호 변경
	    int result = mdao.updatePassword(id, encryptedPw);
	    if(result > 0) {
	        // 비밀번호 찾기 관련 세션 삭제
	        session.removeAttribute("pwEmailcode");
	        session.removeAttribute("pwFindId");
	        session.removeAttribute("pwFindEmail");
	        session.removeAttribute("pwVerified");
	        return "success";
	    }
	    return "fail";
	}
	
	@RequestMapping("/planner")
	public String planner() {
		return "members/planner";
	}
	
}