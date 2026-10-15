package com.kedu.controllers;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kedu.dao.BoardDAO;
import com.kedu.dao.MembersDAO;
import com.kedu.dao.PlaceDAO;
import com.kedu.dao.ReservationDAO;
import com.kedu.dao.ReviewDAO;
import com.kedu.dto.PlaceDTO;

@Controller
@RequestMapping("/dashBoard")
public class DashBoardController {
	
	@Autowired
	MembersDAO mdao;
	
	@Autowired
	ReservationDAO rdao;
	
	@Autowired
	BoardDAO bdao
	;
	@Autowired
	ReviewDAO rvdao;
	
	@Autowired
	PlaceDAO pdao;
	
	@RequestMapping("/dashHome")
	public String dashHome(Model model){
		LocalDate today = java.time.LocalDate.now();
		int[] monthlySales = new int[3];
		
		for (int i = 0; i < 3; i++) {
			LocalDate target = today.minusMonths(2 - i);
			LocalDate first = target.withDayOfMonth(1);
			LocalDate last = target.withDayOfMonth(target.lengthOfMonth());

			monthlySales[i] = rdao.monthlySales(first.toString(), last.toString());
		}
		
		List<Integer> placeIds = rdao.reservedPlaceIds();
		
		List<String> regions = new ArrayList<>();
		for (int i : placeIds) {
			regions.add(pdao.regionByPlaceId(i));
		}
		
		List<Integer> topFiveReserved  = rdao.topFiveReserved();
		List<PlaceDTO> topFiveStay = new ArrayList<>();
		for (int i : topFiveReserved) {
			topFiveStay.add(rdao.placeOne(i));
		}
		
		model.addAttribute("totalMembers", mdao.totalMembers());
		model.addAttribute("totalReservation", rdao.totalReservation());
		model.addAttribute("cancelReservation", rdao.cancelReservation());
		model.addAttribute("cancelRatio", (double)rdao.cancelReservation()/rdao.totalReservation()*100);
		model.addAttribute("totalSales", rdao.totalSales());
		model.addAttribute("boardCount", bdao.boardCount());
		model.addAttribute("reviewCount", rvdao.reviewCount());
		model.addAttribute("monthlySales", monthlySales);
		model.addAttribute("regions", regions);
		model.addAttribute("topFiveStay", topFiveStay);
		
		return "/dashBoard/dashBoard";
	}

}
