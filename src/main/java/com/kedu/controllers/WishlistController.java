package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dao.WishlistDAO;
import com.kedu.dto.PlaceDTO;

@Controller
@RequestMapping("/wishlist")
public class WishlistController {
	
	@Autowired
	private WishlistDAO wdao;
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String wishlist(int placeId, HttpSession session) {
		String memberId = (String) session.getAttribute("loginId");
		int result = wdao.wishlistCheck(memberId, placeId);
		if(result == 0) {
			wdao.wishlistAdd(memberId, placeId);
			return "add";
		} else {
			wdao.wishlistDelete(memberId, placeId);
			return "delete";
		}
	}
	
	
	
}
