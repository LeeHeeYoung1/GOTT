package com.kedu.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/event")
public class EventControllers {
	
	@RequestMapping("/eventpage")
	public String eventpage() {
		return "event/event";
	}
	
}
