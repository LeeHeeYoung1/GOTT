package com.kedu.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.commons.EncryptionUtils;
import com.kedu.dao.MembersDAO;
import com.kedu.dto.MembersDTO;

@Controller
@RequestMapping("/Members")
public class MembersControllers {
	
	private MembersDAO mdao;
	
	@RequestMapping("/login")
	public String login(MembersDTO mdto, HttpSession session) {
		int result = mdao.login(mdto);
		
		if(result == 1) {
			session.setAttribute("loginId", mdto.getId());
			
			return "redirect:/";
		}
		return "redirect:/members/login";
	}
	
	@ResponseBody
	@RequestMapping("/idcheck")
	public int idcheck(String id) {
		
		return mdao.idcheck(id);
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
