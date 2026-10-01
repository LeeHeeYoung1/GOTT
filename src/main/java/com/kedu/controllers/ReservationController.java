package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.ReservationDAO;
import com.kedu.dao.RoomDAO;
import com.kedu.dto.PlaceDTO;
import com.kedu.dto.PlaceRoomDTO;
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
		List<PlaceRoomDTO> roomList = rdao.roomList();
		model.addAttribute("roomList", roomList);
		return "reservation/room_search";
	}
	
	@RequestMapping("/search")
	public String search(PlaceDTO pdto, String[] amenity, Integer maxPrice, String checkIn, String checkOut, Integer adult, Integer child, Model model) {
		List<PlaceRoomDTO> searchList = rdao.searchList(pdto, amenity, maxPrice, checkIn, checkOut, adult, child);
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
	
	@RequestMapping("/reservation")
	public String reservation(int roomId, String checkIn, String checkOut, Integer adult, Integer child, HttpSession session, Model model) {
		RoomDTO roomDto = roomDao.roomOne(roomId);
		model.addAttribute("roomDto", roomDto);
		model.addAttribute("checkIn", checkIn);
		model.addAttribute("checkOut", checkOut);
		model.addAttribute("adult", adult);
		model.addAttribute("child", child);
		return "reservation/reservation";
	}
	
	@RequestMapping("/reserve")
	public String reserve(int roomId, String checkIn, String checkOut, int guest, HttpSession session) {
		RoomDTO roomDto = roomDao.roomOne(roomId);
		rdao.insert(roomDto, checkIn, checkOut, guest, session);
		return "reservation/room_search";
	}
}
