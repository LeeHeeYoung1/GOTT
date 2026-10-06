package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	public String reserve(int roomId, String checkIn, String checkOut,int guest,String paymentId,HttpSession session) {
		RoomDTO roomDto = roomDao.roomOne(roomId);
		int price = roomDto.getPriceWeekday();
		rdao.insert(roomDto, checkIn, checkOut, price,guest, paymentId,session);
		return "reservation/room_search";
	}
	
	@RequestMapping("/paymentComplete")
	public String paymentComplete(String paymentId, int roomId, String checkIn, String checkOut, int guest, HttpSession session,Model model) throws Exception {
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
	    ObjectMapper mapper = new ObjectMapper();
	    JsonNode payment = mapper.readTree(body);
	    String status = payment.get("status").asText();
	    int paid = payment.get("amount").get("paid").asInt();
	    String currency = payment.get("currency").asText();

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

	    int result = rdao.insert(roomDto, checkIn, checkOut, paid, guest, paymentId,session);
	    if (result > 0) {
	        System.out.println("예약 저장 성공");
	        System.out.println("결제 금액 = " + paid);
	    } else {
	        System.out.println("예약 저장 실패");
	    }
	    model.addAttribute("orderName", roomDto.getRoomName());
	    model.addAttribute("total", paid);
	    model.addAttribute("paymentId", paymentId);
	    return "reservation/paymentOk";
	}
	
	@RequestMapping("/cancel")
	@ResponseBody
	public String cancelPayment(
	    @RequestParam String paymentId,
	    HttpServletResponse response) throws Exception {
	    
	    response.setCharacterEncoding("UTF-8");
	    response.setContentType("text/plain; charset=UTF-8");
	    
	    String apiSecret = "1eCHxu85LeGUbtZZ3YDLU1SfgU2aZVuA6qROvuuNFiSuzSWOiRdaqGcoVVoMfbKxxbtNaRPOM6qsxBHH";
	    String url = "https://api.portone.io/payments/" + paymentId + "/cancel";
	    
	    HttpHeaders headers = new HttpHeaders();
	    headers.set("Authorization", "PortOne " + apiSecret);
	    headers.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);
	    
	    String body = "{\"reason\": \"CUSTOMER_REQUEST\"}";
	    HttpEntity<String> entity = new HttpEntity<>(body, headers);
	    
	    RestTemplate restTemplate = new RestTemplate();
	    
	    try {
	        ResponseEntity<String> result = restTemplate.exchange(
	            url,
	            HttpMethod.POST,
	            entity,
	            String.class
	        );
	        
	        if (result.getStatusCode().is2xxSuccessful()) {
	            rdao.delete(paymentId);
	            return "OK";
	        }
	    } catch (Exception e) {
	        return "결제 취소에 실패했습니다.";
	    }
	    
	    return "결제 취소에 실패했습니다.";
	}

}
