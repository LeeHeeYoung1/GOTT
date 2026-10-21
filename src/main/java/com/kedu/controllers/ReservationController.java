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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kedu.commons.PriceUtil;
import com.kedu.dao.CouponDAO;
import com.kedu.dao.MembersDAO;
import com.kedu.dao.ReservationDAO;
import com.kedu.dao.RoomDAO;
import com.kedu.dto.CouponDTO;
import com.kedu.dto.PlaceDTO;
import com.kedu.dto.PlaceRoomDTO;
import com.kedu.dto.ReservationDTO;
import com.kedu.dto.RoomDTO;
import com.kedu.services.ReservationService;

@Controller
@RequestMapping("/reservation")
public class ReservationController {
	private String apiSecret = System.getenv("MY_API_KEY");
	
	@Autowired
	private ReservationService reservationService;

	@Autowired
	private ReservationDAO rdao;

	@Autowired
	private RoomDAO roomDao;
	
	@Autowired
	private MembersDAO mdao;
	
	@Autowired
	private CouponDAO cdao;
	
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
	    String id = (String) session.getAttribute("loginId");
	    if (id == null) {
	        return "redirect:/members/loginpage";
	    }
	
	    RoomDTO roomDto = roomDao.roomOne(roomId);
	    PlaceDTO placeOne = rdao.placeOne(placeId);
	
	    int total_price = PriceUtil.totalPrice(
	            checkIn, checkOut,
	            roomDto.getPriceWeekday(),
	            roomDto.getPriceWeekend()
	    );
	
	    List<CouponDTO> couponList = cdao.selectAvailableCoupons(id, total_price);
	    int mileage = mdao.getMileage(id);
	
	    model.addAttribute("couponList", couponList);
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


	



	@RequestMapping("/paymentComplete")
	public String paymentComplete(String paymentId, int roomId, String checkIn, String checkOut, int guest, int mileage,
	        Integer memberCouponId, HttpSession session, Model model) throws Exception {
	    String id = (String) session.getAttribute("loginId");
	    if (id == null) {
	        return "redirect:/members/loginpage";
	    }
	    if (paymentId == null || paymentId.trim().isEmpty()
	            || checkIn == null || checkIn.trim().isEmpty()
	            || checkOut == null || checkOut.trim().isEmpty()
	            || guest < 1 || mileage < 0) {
	        return "redirect:/";
	    }
	    try {
	        String encodedPaymentId = java.net.URLEncoder.encode(paymentId, "UTF-8");
	        String url = "https://api.portone.io/payments/" + encodedPaymentId;
	        HttpHeaders headers = new HttpHeaders();
	        headers.set("Authorization", "PortOne " + apiSecret);
	        HttpEntity<String> entity = new HttpEntity<>(headers);
	        RestTemplate restTemplate = new RestTemplate();
	        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
	        ObjectMapper mapper = new ObjectMapper();
	        JsonNode payment = mapper.readTree(response.getBody());
	        String status = payment.path("status").asText();
	        String currency = payment.path("currency").asText();
	        int paid = payment.path("amount").path("paid").asInt();
	        if (!"PAID".equals(status) || !"KRW".equals(currency) || paid <= 0) {
	            throw new Exception("결제 상태, 통화 또는 금액이 올바르지 않습니다.");
	        }
	        RoomDTO roomDto = roomDao.roomOne(roomId);
	        if (roomDto == null) {
	            throw new Exception("객실 정보를 찾을 수 없습니다.");
	        }
	        java.time.LocalDate inDate = java.time.LocalDate.parse(checkIn);
	        java.time.LocalDate outDate = java.time.LocalDate.parse(checkOut);
	        if (!inDate.isBefore(outDate)) {
	            throw new Exception("체크아웃 날짜는 체크인 날짜보다 늦어야 합니다.");
	        }
	        reservationService.saveReservation(id, mileage, roomDto, checkIn, checkOut,
	                paid, guest, paymentId, memberCouponId, session);
	        model.addAttribute("orderName", roomDto.getRoomName());
	        model.addAttribute("total", paid);
	        model.addAttribute("paymentId", paymentId);
	        return "reservation/paymentOk";
	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("errorMessage", "결제 후 예약 처리에 실패했습니다. 결제 내역을 확인해 주세요.");
	        return "redirect:/";
	    }
	}



	@RequestMapping("/cancel")
	@ResponseBody
	public String cancelPayment(String paymentId, HttpSession session, HttpServletResponse response) {
	    response.setCharacterEncoding("UTF-8");
	    response.setContentType("text/plain; charset=UTF-8");

	    String memberId = (String) session.getAttribute("loginId");
	    if (memberId == null) {
	        return "로그인이 필요합니다.";
	    }
	    if (paymentId == null || paymentId.trim().isEmpty()) {
	        return "결제 정보가 없습니다.";
	    }

	    try {
	        // 1. 로그인 회원의 예약인지 확인
	        ReservationDTO reservation = rdao.reservationOne(paymentId);
	        if (reservation == null || !memberId.equals(reservation.getMemberId())) {
	            return "예약 정보를 확인할 수 없습니다.";
	        }

	        // 2. PortOne 결제 취소 요청
	        String encodedPaymentId = java.net.URLEncoder.encode(paymentId, "UTF-8");
	        String url = "https://api.portone.io/payments/" + encodedPaymentId + "/cancel";

	        HttpHeaders headers = new HttpHeaders();
	        headers.set("Authorization", "PortOne " + apiSecret);
	        headers.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);

	        String body = "{\"reason\":\"CUSTOMER_REQUEST\"}";
	        HttpEntity<String> entity = new HttpEntity<>(body, headers);

	        RestTemplate restTemplate = new RestTemplate();
	        ResponseEntity<String> result = restTemplate.exchange(
	                url, HttpMethod.POST, entity, String.class);

	        if (!result.getStatusCode().is2xxSuccessful()) {
	            return "결제 취소에 실패했습니다.";
	        }

	        // 3. 예약 취소 및 마일리지 복구/회수
	        reservationService.cancelReservationAndRestoreMileage(paymentId, memberId);

	        return "OK";
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "취소 처리 중 오류가 발생했습니다. 결제 상태를 확인해 주세요.";
	    }
	}

	@RequestMapping("/reservationUpdate")
	public String reservationUpdate(String paymentId,RedirectAttributes redirectAttributes ,HttpSession session, Model model) {
	    String memberId = (String) session.getAttribute("loginId");
	    if (memberId == null) return "redirect:/members/loginpage";
	    
	    if (!rdao.canModifyReservation(paymentId, memberId)) {
	        redirectAttributes.addFlashAttribute("msg", "체크인 당일 또는 이후에는 예약을 변경할 수 없습니다.");
	        return "redirect:/members/reservationList";
	    }
	    if (paymentId == null || paymentId.trim().isEmpty()) {
	        return "redirect:/members/mypage";
	    }
	    ReservationDTO rsdto;
	    try {
	        rsdto = rdao.reservationOne(paymentId);
	    } catch (org.springframework.dao.EmptyResultDataAccessException e) {
	        return "redirect:/members/mypage";
	    }
	    if (!memberId.equals(rsdto.getMemberId())) {
	        return "redirect:/members/mypage";
	    }
	    if (!"예약완료".equals(rsdto.getStatus())) {
	        return "redirect:/members/mypage";
	    }
	    if (rsdto.getUpdateCount() >= 1) {
	        session.setAttribute("reservationUpdateMessage", "예약 변경은 한 번만 가능합니다.");
	        return "redirect:/members/mypage";
	    }
	    
	    int placeId = rsdto.getPlaceId();
	    int guest = rsdto.getGuestNum();
	    List<RoomDTO> all = roomDao.detailList(placeId, rsdto.getCheckIn().toString(), rsdto.getCheckOut().toString());
	    List<RoomDTO> detailList = new ArrayList<RoomDTO>();
	    for (RoomDTO room : all) {
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
	  

	@RequestMapping("/cancelMyReservation")
	@ResponseBody
	public String cancelMyReservation(String paymentId, HttpSession session) {
	    String memberId = (String) session.getAttribute("loginId");
	
	    if (memberId == null) {
	        return "로그인이 필요합니다.";
	    }
	    if (paymentId == null || paymentId.trim().isEmpty()) {
	        return "결제 정보가 없습니다.";
	    }
	
	    try {
	        // 1. 예약 및 회원 정보 확인
	        ReservationDTO reservation = rdao.reservationOne(paymentId);
	
	        if (reservation == null || !memberId.equals(reservation.getMemberId())) {
	            return "예약 정보를 찾을 수 없습니다.";
	        }
	        if (!"예약완료".equals(reservation.getStatus())) {
	            return "이미 취소되었거나 취소할 수 없는 예약입니다.";
	        }
	        if (!rdao.canModifyReservation(paymentId, memberId)) {
	            return "체크인 당일 또는 이후에는 예약을 취소할 수 없습니다.";
	        }
	        if (apiSecret == null || apiSecret.trim().isEmpty()) {
	            return "결제 API 설정을 확인해 주세요.";
	        }
	
	        // 2. PortOne에서 실제 결제 상태 조회
	        String encodedPaymentId =
	                java.net.URLEncoder.encode(paymentId, "UTF-8");
	
	        String paymentUrl =
	                "https://api.portone.io/payments/" + encodedPaymentId;
	
	        HttpHeaders headers = new HttpHeaders();
	        headers.set("Authorization", "PortOne " + apiSecret);
	
	        HttpEntity<String> entity = new HttpEntity<>(headers);
	        RestTemplate restTemplate = new RestTemplate();
	        ObjectMapper mapper = new ObjectMapper();
	
	        ResponseEntity<String> paymentResponse = restTemplate.exchange(
	                paymentUrl, HttpMethod.GET, entity, String.class);
	
	        JsonNode payment = mapper.readTree(paymentResponse.getBody());
	        String status = payment.path("status").asText();
	
	        // 이미 전액 취소된 결제는 중복 취소하지 않음
	        if ("CANCELLED".equals(status)) {
	            return "이미 전체 취소된 결제입니다. 예약 및 결제 내역을 확인해 주세요.";
	        }
	
	        // 정상 결제 및 부분 취소 결제 허용
	        if (!"PAID".equals(status)
	                && !"PARTIAL_CANCELLED".equals(status)) {
	            return "현재 결제 상태에서는 취소할 수 없습니다. 상태: " + status;
	        }
	
	        // 3. 남은 취소 가능 금액 전체 취소 요청
	        // amount를 생략하면 남은 취소 가능 금액 전체를 취소 요청함
	        HttpHeaders cancelHeaders = new HttpHeaders();
	        cancelHeaders.set("Authorization", "PortOne " + apiSecret);
	        cancelHeaders.setContentType(
	                org.springframework.http.MediaType.APPLICATION_JSON);
	
	        com.fasterxml.jackson.databind.node.ObjectNode cancelBody =
	                mapper.createObjectNode();
	        cancelBody.put("reason", "CUSTOMER_REQUEST");
	
	        HttpEntity<String> cancelEntity = new HttpEntity<>(
	                mapper.writeValueAsString(cancelBody), cancelHeaders);
	
	        String cancelUrl =
	                "https://api.portone.io/payments/"
	                + encodedPaymentId + "/cancel";
	
	        ResponseEntity<String> cancelResponse = restTemplate.exchange(
	                cancelUrl, HttpMethod.POST, cancelEntity, String.class);
	
	        JsonNode cancelResult = mapper.readTree(cancelResponse.getBody());
	        String cancelStatus =
	                cancelResult.path("cancellation").path("status").asText();
	
	        // 취소 완료 여부를 확인한 경우에만 DB 처리
	        if (!"SUCCEEDED".equals(cancelStatus)) {
	            return "결제 취소가 아직 완료되지 않았습니다. 상태: "
	                    + cancelStatus + ". 결제 내역을 확인해 주세요.";
	        }
	
	        // 4. 기존 서비스 로직으로 예약 취소 및 마일리지 처리
	        reservationService.cancelReservationAndRestoreMileage(
	                paymentId, memberId);
	
	        return "success";
	
	    } catch (org.springframework.web.client.HttpStatusCodeException e) {
	        // PortOne이 반환한 HTTP 오류 응답 확인
	        System.err.println("PortOne HTTP 상태: " + e.getStatusCode());
	        System.err.println("PortOne 오류 응답: " + e.getResponseBodyAsString());
	        return "결제 취소 요청이 거부되었습니다. 결제 내역을 확인해 주세요.";
	
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "예약 취소 처리 중 오류가 발생했습니다. 결제 내역을 확인해 주세요.";
	    }
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
		

	@RequestMapping("/PaymentUpdateComplete")
	@ResponseBody
	public String PaymentUpdateComplete(String paymentId, String newPaymentId,
	        int roomId, String checkIn, String checkOut, int guestNum,
	        HttpSession session) {
	    String memberId = (String) session.getAttribute("loginId");
	    if (memberId == null) return "로그인이 필요합니다.";
	    if (paymentId == null || paymentId.trim().isEmpty()
	            || newPaymentId == null || newPaymentId.trim().isEmpty()
	            || checkIn == null || checkOut == null
	            || checkIn.trim().isEmpty() || checkOut.trim().isEmpty()) {
	        return "예약 또는 결제 정보가 올바르지 않습니다.";
	    }
	    try {
	        if (apiSecret == null || apiSecret.trim().isEmpty()) {
	            return "PortOne API 설정을 확인해 주세요.";
	        }
	        java.time.LocalDate inDate = java.time.LocalDate.parse(checkIn);
	        java.time.LocalDate outDate = java.time.LocalDate.parse(checkOut);
	        if (!inDate.isBefore(outDate)) {
	            return "체크아웃 날짜는 체크인 날짜보다 늦어야 합니다.";
	        }
	        if (guestNum < 1) return "인원은 1명 이상이어야 합니다.";
	
	        ReservationDTO reservation = rdao.reservationOne(paymentId);
	        if (reservation == null || !memberId.equals(reservation.getMemberId())) {
	            return "예약 정보를 찾을 수 없습니다.";
	        }
	        if (!"예약완료".equals(reservation.getStatus())) {
	            return "변경할 수 있는 예약이 아닙니다.";
	        }
	
	        RoomDTO roomDto = roomDao.roomOne(roomId);
	        if (roomDto == null || roomDto.getMaxCount() == null
	                || guestNum > roomDto.getMaxCount()) {
	            return "선택한 객실의 최대 인원을 확인해 주세요.";
	        }
	        if (roomDto.getPlaceId() != reservation.getPlaceId()) {
	            return "다른 숙소의 객실로 변경할 수 없습니다.";
	        }
	
	        int newTotalPrice = PriceUtil.totalPrice(
	                checkIn, checkOut,
	                roomDto.getPriceWeekday(), roomDto.getPriceWeekend());
	        int difference = newTotalPrice - reservation.getTotalPrice();
	
	        if (difference <= 0) {
	            return "추가 결제가 필요한 예약이 아닙니다. 예약 변경 금액을 다시 확인해 주세요.";
	        }
	
	        if (rdao.countRePaymentHistory(newPaymentId) > 0) {
	            return "이미 처리된 결제입니다.";
	        }
	
	        String url = "https://api.portone.io/payments/"
	                + java.net.URLEncoder.encode(newPaymentId, "UTF-8");
	        HttpHeaders headers = new HttpHeaders();
	        headers.set("Authorization", "PortOne " + apiSecret);
	        HttpEntity<String> entity = new HttpEntity<>(headers);
	        RestTemplate restTemplate = new RestTemplate();
	
	        ResponseEntity<String> response = restTemplate.exchange(
	                url, HttpMethod.GET, entity, String.class);
	
	        ObjectMapper mapper = new ObjectMapper();
	        JsonNode payment = mapper.readTree(response.getBody());
	
	        String status = payment.path("status").asText();
	        String currency = payment.path("currency").asText();
	        int paid = payment.path("amount").path("paid").asInt();
	
	        if (!"PAID".equals(status)) {
	            return "결제가 완료된 상태가 아닙니다.";
	        }
	        if (!"KRW".equals(currency)) {
	            return "결제 통화가 올바르지 않습니다.";
	        }
	        if (paid != difference) {
	            return "결제 금액이 변경 금액과 일치하지 않습니다.";
	        }
	
	        reservationService.completeReservationUpdatePayment(
	                reservation,
	                newPaymentId,
	                memberId,
	                roomId,
	                java.sql.Date.valueOf(inDate),
	                java.sql.Date.valueOf(outDate),
	                guestNum,
	                paid,
	                newTotalPrice);
	
	        return "success";
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "예약 변경 결제 처리 중 오류가 발생했습니다.";
	    }
	}
	
	@RequestMapping("/PaymentUpdateRefund")
	@ResponseBody
	public String PaymentUpdateRefund(String paymentId, int roomId, String checkIn, String checkOut, int guestNum, HttpSession session) {
	    String memberId = (String) session.getAttribute("loginId");
	    if (memberId == null) return "로그인이 필요합니다.";
	    if (paymentId == null || paymentId.trim().isEmpty() || checkIn == null || checkOut == null || checkIn.trim().isEmpty() || checkOut.trim().isEmpty()) {
	        return "예약 정보가 올바르지 않습니다.";
	    }
	    try {
	        if (apiSecret == null || apiSecret.trim().isEmpty()) return "PortOne API 설정을 확인해 주세요.";
	        java.time.LocalDate inDate = java.time.LocalDate.parse(checkIn);
	        java.time.LocalDate outDate = java.time.LocalDate.parse(checkOut);
	        if (!inDate.isBefore(outDate)) return "체크아웃 날짜는 체크인 날짜보다 늦어야 합니다.";
	        if (guestNum < 1) return "인원은 1명 이상이어야 합니다.";

	        ReservationDTO reservation = rdao.reservationOne(paymentId);
	        if (reservation == null || !memberId.equals(reservation.getMemberId())) return "예약 정보를 찾을 수 없습니다.";
	        if (!"예약완료".equals(reservation.getStatus())) return "변경할 수 있는 예약이 아닙니다.";

	        RoomDTO roomDto = roomDao.roomOne(roomId);
	        if (roomDto == null || roomDto.getMaxCount() == null || guestNum > roomDto.getMaxCount()) return "선택한 객실의 최대 인원을 확인해 주세요.";
	        if (roomDto.getPlaceId() != reservation.getPlaceId()) return "다른 숙소의 객실로 변경할 수 없습니다.";

	        int newTotalPrice = PriceUtil.totalPrice(checkIn, checkOut, roomDto.getPriceWeekday(), roomDto.getPriceWeekend());
	        int refundAmount = reservation.getTotalPrice() - newTotalPrice;
	        if (refundAmount <= 0) return "부분 환불이 필요한 예약이 아닙니다.";
	        if (reservation.getPrice() < refundAmount) return "환불 금액이 실제 결제 잔액을 초과합니다.";

	        String paymentUrl = "https://api.portone.io/payments/" + java.net.URLEncoder.encode(paymentId, "UTF-8");
	        HttpHeaders headers = new HttpHeaders();
	        headers.set("Authorization", "PortOne " + apiSecret);
	        HttpEntity<String> getEntity = new HttpEntity<>(headers);
	        RestTemplate restTemplate = new RestTemplate();
	        ResponseEntity<String> paymentResponse = restTemplate.exchange(paymentUrl, HttpMethod.GET, getEntity, String.class);

	        ObjectMapper mapper = new ObjectMapper();
	        JsonNode payment = mapper.readTree(paymentResponse.getBody());
	        if (!"PAID".equals(payment.path("status").asText())) return "기존 결제 상태를 확인할 수 없습니다.";
	        if (!"KRW".equals(payment.path("currency").asText())) return "결제 통화가 올바르지 않습니다.";

	        int paidAmount = payment.path("amount").path("paid").asInt();
	        if (paidAmount <= 0) return "기존 결제 금액을 확인할 수 없습니다.";

	        int alreadyCancelled = payment.path("amount").path("cancelled").asInt(0);
	        int cancellableAmount = paidAmount - alreadyCancelled;
	        if (refundAmount > cancellableAmount) return "환불 가능 금액을 초과했습니다.";

	        org.springframework.http.HttpHeaders cancelHeaders = new org.springframework.http.HttpHeaders();
	        cancelHeaders.set("Authorization", "PortOne " + apiSecret);
	        cancelHeaders.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);

	        com.fasterxml.jackson.databind.node.ObjectNode cancelBody = mapper.createObjectNode();
	        cancelBody.put("amount", refundAmount);
	        cancelBody.put("currentCancellableAmount", cancellableAmount);
	        cancelBody.put("reason", "예약 변경에 따른 부분 환불");

	        HttpEntity<String> cancelEntity = new HttpEntity<>(mapper.writeValueAsString(cancelBody), cancelHeaders);
	        String cancelUrl = "https://api.portone.io/payments/" + java.net.URLEncoder.encode(paymentId, "UTF-8") + "/cancel";
	        ResponseEntity<String> cancelResponse = restTemplate.exchange(cancelUrl, HttpMethod.POST, cancelEntity, String.class);

	        JsonNode cancelResult = mapper.readTree(cancelResponse.getBody());
	        JsonNode cancellation = cancelResult.path("cancellation");
	        String cancelStatus = cancellation.path("status").asText();

	        if (!"SUCCEEDED".equals(cancelStatus)) {
	            return "환불 요청은 접수되었지만 완료 상태를 확인하지 못했습니다. 결제 내역을 확인해 주세요.";
	        }

	        reservationService.completeReservationUpdateRefund(
	                reservation, memberId, roomId,
	                java.sql.Date.valueOf(inDate), java.sql.Date.valueOf(outDate),
	                guestNum, refundAmount, newTotalPrice);

	        return "success";
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "환불 처리 중 오류가 발생했습니다. 결제 내역을 확인해 주세요.";
	    }
	}


}
