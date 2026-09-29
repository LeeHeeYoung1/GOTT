package com.kedu.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.ReservationDAO;
import com.kedu.dto.PlaceDTO;

@Controller
@RequestMapping("/reservation")
public class ReservationController {

	@Autowired
	private ReservationDAO rdao;

	@RequestMapping("/list")
	public String list(Model model) {
		List<PlaceDTO> roomList = rdao.roomList();
		model.addAttribute("roomList", roomList);
		return "reservation/room_search";
	}
	
	@RequestMapping("/search")
	public String search(PlaceDTO pdto, Model model) {
		List<PlaceDTO> searchList = rdao.searchList(pdto);
		model.addAttribute("roomList", searchList);
		return "reservation/room_search";
	}
}
