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
	
	@RequestMapping("/")
	public String wishlist(HttpSession session, Model model) {
	    String memberId = (String) session.getAttribute("loginId");

	    System.out.println("로그인 아이디 : " + memberId);

	    List<PlaceDTO> wishList = wdao.selectByWish(memberId);

	    System.out.println("찜 목록 개수 : " + wishList.size());

	    model.addAttribute("wishList", wishList);

	    return "members/wishlist";
	}
	
	
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
