package com.kedu.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.commons.EncryptionUtils;
import com.kedu.dao.MembersDAO;
import com.kedu.dto.MembersDTO;

@Controller
@RequestMapping("/members")
public class MembersControllers {
	
	@Autowired
	private MembersDAO mdao;
	
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
		
		return "redirect:/members/login";
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
	
	
	
}
