package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kedu.commons.PriceUtil;
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
		model.addAttribute("checkIn", checkIn);
		model.addAttribute("checkOut", checkOut);
		model.addAttribute("adult", adult);
		model.addAttribute("child", child);
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
	public String reservation(int placeId, int roomId, String checkIn, String checkOut, Integer adult, Integer child, HttpSession session, Model model) {
		RoomDTO roomDto = roomDao.roomOne(roomId);
		PlaceDTO placeOne = rdao.placeOne(placeId);
		
		System.out.println("checkIn = [" + checkIn + "]");
	    System.out.println("checkOut = [" + checkOut + "]");
	    System.out.println("adult = [" + adult + "]");
	    System.out.println("child = [" + child + "]");
		
		
		int total_price = PriceUtil.totalPrice(checkIn, checkOut, roomDto.getPriceWeekday(), roomDto.getPriceWeekend());
		
		model.addAttribute("placeOne", placeOne);
		model.addAttribute("roomDto", roomDto);
		model.addAttribute("checkIn", checkIn);
		model.addAttribute("checkOut", checkOut);
		model.addAttribute("adult", adult);
		model.addAttribute("child", child);
		model.addAttribute("total_price", total_price);
		
		return "reservation/reservation";
	}
	
	@RequestMapping("/reserve")
	public String reserve(int roomId, String checkIn, String checkOut,int guest, HttpSession session) {
		RoomDTO roomDto = roomDao.roomOne(roomId);
		int price = roomDto.getPriceWeekday();
		rdao.insert(roomDto, checkIn, checkOut, price,guest, session);
		return "reservation/room_search";
	}
	@RequestMapping("/paymentComplete")
	public String paymentComplete(String paymentId, int roomId, String checkIn, String checkOut, int guest, HttpSession session,Model model) throws Exception {
	    System.out.println("===== 결제 완료 처리 시작 =====");
	    System.out.println("paymentId = " + paymentId);
	    System.out.println("roomId = " + roomId);
	    System.out.println("checkIn = " + checkIn);
	    System.out.println("checkOut = " + checkOut);
	    System.out.println("guest = " + guest);
	    String apiSecret = "1eCHxu85LeGUbtZZ3YDLU1SfgU2aZVuA6qROvuuNFiSuzSWOiRdaqGcoVVoMfbKxxbtNaRPOM6qsxBHH";
	    String url = "https://api.portone.io/payments/" + paymentId;
	    HttpHeaders headers = new HttpHeaders();
	    headers.set("Authorization", "PortOne " + apiSecret);
	    HttpEntity<String> entity = new HttpEntity<>(headers);
	    RestTemplate restTemplate = new RestTemplate();
	    ResponseEntity<String> response = restTemplate.exchange(
	            url,
	            HttpMethod.GET,
	            entity,
	            String.class
	    );
	    String body = response.getBody();
	    System.out.println("PortOne 응답 = " + body);
	    ObjectMapper mapper = new ObjectMapper();
	    JsonNode payment = mapper.readTree(body);
	    String status = payment.get("status").asText();
	    int paid = payment.get("amount").get("paid").asInt();
	    String currency = payment.get("currency").asText();

	    System.out.println("결제 상태 = " + status);
	    System.out.println("실제 결제 금액 = " + paid);
	    System.out.println("통화 = " + currency);

	    if (!"PAID".equals(status)) {
	        System.out.println("결제 상태가 PAID가 아닙니다.");
	        return "redirect:/";
	    }

	    if (!"KRW".equals(currency)) {
	        System.out.println("결제 통화가 KRW가 아닙니다.");
	        return "redirect:/";
	    }

	    RoomDTO roomDto = roomDao.roomOne(roomId);

	    if (roomDto == null) {
	        System.out.println("객실 정보를 찾을 수 없습니다.");
	        return "redirect:/";
	    }

	    int result = rdao.insert(roomDto, checkIn, checkOut, paid, guest, session);
	    if (result > 0) {
	        System.out.println("예약 저장 성공");
	        System.out.println("결제 금액 = " + paid);
	    } else {
	        System.out.println("예약 저장 실패");
	    }

	    System.out.println("===== 결제 완료 처리 종료 =====");

	    return "redirect:/";
	}
}
