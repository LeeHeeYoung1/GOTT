package com.kedu.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
			session.setAttribute("loginId", mdto.getId());
			
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
	
}
