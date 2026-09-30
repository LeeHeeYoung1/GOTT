package com.kedu.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.ReservationDAO;
import com.kedu.dao.RoomDAO;
import com.kedu.dto.PlaceDTO;
import com.kedu.dto.RoomDTO;

@Controller
@RequestMapping("/reservation")
public class ReservationController {

	@Autowired
	private ReservationDAO rdao;
	
	@Autowired
	private RoomDAO roomDao;

	@RequestMapping("/list")
	public String list(Model model) {
		List<PlaceDTO> roomList = rdao.roomList();
		model.addAttribute("roomList", roomList);
		return "reservation/room_search";
	}
	
	@RequestMapping("/search")
	public String search(PlaceDTO pdto, String[] amenity, Integer maxPrice, String checkIn, String checkOut, Integer adult, Integer child, Model model) {
		List<PlaceDTO> searchList = rdao.searchList(pdto, amenity, maxPrice, checkIn, checkOut, adult, child);
		model.addAttribute("roomList", searchList);
		return "reservation/room_search";
	}
	
	@RequestMapping("/room_detail")
	public String room_detail(int placeId, Model model) {
		PlaceDTO placeOne = rdao.placeOne(placeId);
		List<RoomDTO> detailList = roomDao.detailList(placeId);
		model.addAttribute("placeOne", placeOne);
		model.addAttribute("detailList", detailList);
		return "reservation/room_detail";
	}
}
