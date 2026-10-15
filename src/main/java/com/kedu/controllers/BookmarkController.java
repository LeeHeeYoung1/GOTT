package com.kedu.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/bookmark")
public class BookmarkController {

	@RequestMapping("/bookmarklist")
	public String bookmarklist() {
	    return "members/bookmarklist";
	}
}
