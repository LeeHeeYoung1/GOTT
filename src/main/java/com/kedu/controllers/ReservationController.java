package com.kedu.controllers;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kedu.commons.PriceUtil;
import com.kedu.dao.MembersDAO;
import com.kedu.dao.ReservationDAO;
import com.kedu.dao.RoomDAO;
import com.kedu.dto.PlaceDTO;
import com.kedu.dto.PlaceRoomDTO;
import com.kedu.dto.ReservationDTO;
import com.kedu.dto.RoomDTO;
import com.kedu.services.ReservationService;

@Controller
@RequestMapping("/reservation")
public class ReservationController {
	
	@Autowired
	private ReservationService reservationService;

	@Autowired
	private ReservationDAO rdao;

	@Autowired
	private RoomDAO roomDao;
	
	@Autowired
	private MembersDAO mdao;
	
	@RequestMapping("/list")
	public String list(int cpage, Model model) {
		List<PlaceRoomDTO> roomList = roomDao.selectFromTo(cpage * 10 - 9, cpage * 10);
		model.addAttribute("roomList", roomList);

		model.addAttribute("recordTotalCount", rdao.selectCount());
		model.addAttribute("recordCountPerPage", 10);
		model.addAttribute("naviCountPerPage", 10);
		model.addAttribute("cpage", cpage);

		return "reservation/room_search";
	}

	@RequestMapping("/search")
	public String search(PlaceDTO pdto, String[] amenity, Integer maxPrice, String checkIn, String checkOut,
			Integer adult, Integer child, Integer cpage, Model model) {
		if (cpage == null) cpage = 1;
		
		List<PlaceRoomDTO> searchList = rdao.searchFromTo(pdto, amenity, maxPrice, checkIn, checkOut, adult, child,
				cpage * 10 - 9, cpage * 10);
		model.addAttribute("roomList", searchList);
		model.addAttribute("checkIn", checkIn);
		model.addAttribute("checkOut", checkOut);
		model.addAttribute("adult", adult);
		model.addAttribute("child", child);
		
		model.addAttribute("recordTotalCount", rdao.searchCount(pdto, amenity, maxPrice, checkIn, checkOut, adult, child));
		model.addAttribute("recordCountPerPage", 10);
		model.addAttribute("naviCountPerPage", 10);
		model.addAttribute("cpage", cpage);

		return "reservation/room_search";
	}

	@RequestMapping("/room_detail")
	public String room_detail(int placeId, String checkIn, String checkOut, Integer adult, Integer child, Model model) {

		PlaceDTO placeOne = rdao.placeOne(placeId);
		List<RoomDTO> detailList = roomDao.detailList(placeId, checkIn, checkOut);

		model.addAttribute("placeOne", placeOne);
		model.addAttribute("detailList", detailList);
		model.addAttribute("checkIn", checkIn);
		model.addAttribute("checkOut", checkOut);
		model.addAttribute("adult", adult);
		model.addAttribute("child", child);

		return "reservation/room_detail";
	}

	@RequestMapping("/reservation")
	public String reservation(int placeId, int roomId, String checkIn, String checkOut, Integer adult, Integer child,
			HttpSession session, Model model) {
		RoomDTO roomDto = roomDao.roomOne(roomId);
		PlaceDTO placeOne = rdao.placeOne(placeId);

		int total_price = PriceUtil.totalPrice(checkIn, checkOut, roomDto.getPriceWeekday(), roomDto.getPriceWeekend());

		model.addAttribute("placeOne", placeOne);
		model.addAttribute("placeId", placeId);
		model.addAttribute("roomDto", roomDto);
		model.addAttribute("checkIn", checkIn);
		model.addAttribute("checkOut", checkOut);
		model.addAttribute("adult", adult);
		model.addAttribute("child", child);
		model.addAttribute("total_price", total_price);

		return "reservation/reservation";
	}
	
	@RequestMapping("/finalPayment")
	public String finalPayment(int placeId, int roomId, String checkIn, String checkOut, Integer guest,
	        HttpSession session, Model model) {
	    RoomDTO roomDto = roomDao.roomOne(roomId);
	    PlaceDTO placeOne = rdao.placeOne(placeId);
	    int total_price = PriceUtil.totalPrice(checkIn, checkOut, roomDto.getPriceWeekday(), roomDto.getPriceWeekend());
	    String id = (String) session.getAttribute("loginId");
	    int mileage = mdao.getMileage(id);
	    model.addAttribute("mileage", mileage);
	    model.addAttribute("placeOne", placeOne);
	    model.addAttribute("placeId", placeId);
	    model.addAttribute("roomDto", roomDto);
	    model.addAttribute("checkIn", checkIn);
	    model.addAttribute("checkOut", checkOut);
	    model.addAttribute("guest", guest);
	    model.addAttribute("total_price", total_price);
	    return "reservation/finalPayment";
	}

	@RequestMapping("/reserve")
	public String reserve(int roomId, String checkIn, String checkOut, int guest, String paymentId,
			HttpSession session) {
		RoomDTO roomDto = roomDao.roomOne(roomId);
		int price = roomDto.getPriceWeekday();
		rdao.insert(roomDto, checkIn, checkOut, price, guest, paymentId, session);
		return "redirect:reservation/list?cpage=1";
	}


	@RequestMapping("/paymentComplete")
	public String paymentComplete(String paymentId, int roomId, String checkIn, String checkOut, int guest,
	        int mileage, HttpSession session, Model model) throws Exception {
	
		String apiSecret = "1eCHxu85LeGUbtZZ3YDLU1SfgU2aZVuA6qROvuuNFiSuzSWOiRdaqGcoVVoMfbKxxbtNaRPOM6qsxBHH";
	    if (apiSecret == null || apiSecret.isEmpty()) {
	        throw new IllegalStateException("PortOne API Secret 설정이 필요합니다.");
	    }
	
	    String url = "https://api.portone.io/payments/" + paymentId;
	    HttpHeaders headers = new HttpHeaders();
	    headers.set("Authorization", "PortOne " + apiSecret);
	    HttpEntity<String> entity = new HttpEntity<>(headers);
	
	    RestTemplate restTemplate = new RestTemplate();
	    ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
	
	    String body = response.getBody();
	    ObjectMapper mapper = new ObjectMapper();
	    JsonNode payment = mapper.readTree(body);
	    String status = payment.path("status").asText();
	    int paid = payment.path("amount").path("paid").asInt();
	    String currency = payment.path("currency").asText();
	
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
	
	    String id = (String) session.getAttribute("loginId");
	    if (id == null) {
	        System.out.println("로그인 정보를 찾을 수 없습니다.");
	        return "redirect:/";
	    }
	
	    try {
	        reservationService.saveReservation(id, mileage, roomDto, checkIn, checkOut,
	                paid, guest, paymentId, session);
	        System.out.println("예약 저장 및 마일리지 처리 성공");
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("예약 저장 또는 마일리지 처리 실패");
	        return "redirect:/";
	    }
	
	    model.addAttribute("orderName", roomDto.getRoomName());
	    model.addAttribute("total", paid);
	    model.addAttribute("paymentId", paymentId);
	    return "reservation/paymentOk";
	}


	@RequestMapping("/cancel")
	@ResponseBody
	public String cancelPayment(String paymentId, HttpServletResponse response) throws Exception {

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
			ResponseEntity<String> result = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);

			if (result.getStatusCode().is2xxSuccessful()) {
				rdao.delete(paymentId);
				return "OK";
			}
		} catch (Exception e) {
			return "결제 취소에 실패했습니다.";
		}

		return "결제 취소에 실패했습니다.";
	}

	@RequestMapping("/cancelReservation")
	@ResponseBody
	public String cancelReservation(String paymentId) {
		rdao.updateReservation(paymentId, "예약취소");
		return "OK";
	}

	@RequestMapping("/reservationUpdate")
	   public String reservationUpdate(String paymentId, Model model) {

	      ReservationDTO rsdto = rdao.reservationOne(paymentId);
	      int placeId = rsdto.getPlaceId();
	      int guest = rsdto.getGuestNum();

	      List<RoomDTO> all = roomDao.detailList(placeId, rsdto.getCheckIn().toString(), rsdto.getCheckOut().toString());

	      List<RoomDTO> detailList = new ArrayList<RoomDTO>();
	      for (int i = 0; i < all.size(); i++) {
	         RoomDTO room = all.get(i);
	         if (room.getMaxCount() >= guest) {
	            detailList.add(room);
	         }
	      }

	      model.addAttribute("reservation", rsdto);
	      model.addAttribute("placeOne", rdao.placeOne(placeId));
	      model.addAttribute("detailList", detailList);

	      return "reservation/reservationUpdate";
	   }
	
	  @RequestMapping("/calculateUpdatePrice")
	  @ResponseBody
	  public int calculateUpdatePrice(int roomId, String checkIn, String checkOut, int guestNum) {
	      RoomDTO roomDto = roomDao.roomOne(roomId);
	      if (roomDto == null || roomDto.getMaxCount() == null || guestNum < 1 || guestNum > roomDto.getMaxCount()) {
	          throw new IllegalArgumentException("객실 최대 인원을 확인해 주세요.");
	      }
	      return PriceUtil.totalPrice(checkIn, checkOut, roomDto.getPriceWeekday(), roomDto.getPriceWeekend());
	  }


		@RequestMapping("/reservationUpdateSave")
		@ResponseBody
		public String reservationUpdateSave(String paymentId, int roomId, String checkIn, String checkOut, int guestNum, HttpSession session) {
		    String memberId = (String) session.getAttribute("loginId");
		    if (memberId == null) return "로그인이 필요합니다.";
		    if (paymentId == null || paymentId.trim().isEmpty() || checkIn == null || checkOut == null || checkIn.trim().isEmpty() || checkOut.trim().isEmpty()) {
		        return "예약 정보가 올바르지 않습니다.";
		    }
		    try {
		        java.time.LocalDate inDate = java.time.LocalDate.parse(checkIn);
		        java.time.LocalDate outDate = java.time.LocalDate.parse(checkOut);
		        if (!inDate.isBefore(outDate)) return "체크아웃 날짜는 체크인 날짜보다 늦어야 합니다.";
		        if (guestNum < 1) return "인원은 1명 이상이어야 합니다.";
		
		        ReservationDTO reservation = rdao.reservationOne(paymentId);
		        if (reservation == null || !memberId.equals(reservation.getMemberId())) return "예약 정보를 찾을 수 없습니다.";
		        if (!"예약완료".equals(reservation.getStatus())) return "변경할 수 있는 예약이 아닙니다.";
		
		        RoomDTO roomDto = roomDao.roomOne(roomId);
		        if (roomDto == null || roomDto.getMaxCount() == null || guestNum > roomDto.getMaxCount()) {
		            return "선택한 객실의 최대 인원을 확인해 주세요.";
		        }
		        if (roomDto.getPlaceId() != reservation.getPlaceId()) return "다른 숙소의 객실로 변경할 수 없습니다.";
		
		        int newTotalPrice = PriceUtil.totalPrice(checkIn, checkOut, roomDto.getPriceWeekday(), roomDto.getPriceWeekend());
		        int oldTotalPrice = reservation.getTotalPrice();
		        int difference = newTotalPrice - oldTotalPrice;
		
		        if (difference > 0) {
		            return "추가 결제 필요: " + difference;
		        } else if (difference < 0) {
		            return "부분 환불 필요: " + Math.abs(difference);
		        }
		
		        int result = rdao.updateReservationDetails(
		                paymentId, memberId, roomId,
		                java.sql.Date.valueOf(inDate),
		                java.sql.Date.valueOf(outDate),
		                guestNum, newTotalPrice
		        );
		        if (result > 0) return "success";
		        return "예약 변경에 실패했습니다. 다시 시도해 주세요.";
		    } catch (Exception e) {
		        e.printStackTrace();
		        return "예약 변경 중 오류가 발생했습니다.";
		    }
		}

}
