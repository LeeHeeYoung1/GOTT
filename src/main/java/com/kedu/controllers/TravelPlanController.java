package com.kedu.controllers;

import java.sql.Date;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dao.TravelPlanDAO;
import com.kedu.dao.TravelPlanReplyDAO;
import com.kedu.dao.TravelPlanScrapDAO;
import com.kedu.dto.PlaceDTO;
import com.kedu.dto.ReviewDTO;
import com.kedu.dto.TravelPlanDTO;
import com.kedu.dto.TravelPlanDetailDTO;
import com.kedu.dto.TravelPlanReplyDTO;

@Controller
@RequestMapping("/travelPlan")
public class TravelPlanController {

	@Autowired
	private TravelPlanDAO dao;

	@Autowired
	private TravelPlanReplyDAO tprdao;

	@Autowired
	private TravelPlanScrapDAO tpsrdao;

	@RequestMapping("delete")
	public String delete(int planId, HttpSession session) {
		String memberId = (String) session.getAttribute("loginId");
		if (memberId == null) {
			return "redirect:/members/loginpage";
		}
		dao.deletePlan(planId, memberId);
		return "redirect:/members/mypage";
	}

	// 여행 일정 및 장소 저장
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	@Transactional
	public String save(String title, String startDate, String endDate, Integer count, String isPublic, int[] placeIds,
			int[] dayNos, String[] visitTimes, HttpSession session) {
		String memberId = (String) session.getAttribute("loginId");

		if (memberId == null) {
			return "redirect:/members/loginpage";
		}

		if (title == null || title.trim().isEmpty() || startDate == null || startDate.isEmpty() || endDate == null
				|| endDate.isEmpty() || count == null || count < 1 || count > 8) {
			return "INVALID_INPUT";
		}

		// 장소 배열 확인
		if (placeIds == null) {
			placeIds = new int[0];
		}

		if (dayNos == null) {
			dayNos = new int[0];
		}

		if (placeIds.length != dayNos.length) {
			return "INVALID_INPUT";
		}

		if (visitTimes != null && visitTimes.length != placeIds.length) {
			return "INVALID_INPUT";
		}

		// 일정 기본 정보 생성
		TravelPlanDTO dto = new TravelPlanDTO();
		int planId = dao.nextPlanId();

		dto.setPlan_id(planId);
		dto.setMember_id(memberId);
		dto.setPlan_title(title.trim());
		dto.setStart_date(Date.valueOf(startDate));
		dto.setEnd_date(Date.valueOf(endDate));
		dto.setPerson_count(count);
		dto.setIs_public("true".equals(isPublic) ? "Y" : "N");

		// 시작일과 종료일 확인
		if (dto.getEnd_date().before(dto.getStart_date())) {
			return "INVALID_DATE";
		}

		// 일정 기본 정보 저장
		int result = dao.insert(dto);

		if (result <= 0) {
			return "FAIL";
		}

		// 날짜별 장소 순서 관리
		Map<Integer, Integer> orderByDay = new HashMap<>();

		// 장소 상세 정보 저장
		for (int i = 0; i < placeIds.length; i++) {

			if (dayNos[i] < 1) {
				throw new IllegalArgumentException("잘못된 여행 날짜입니다.");
			}

			int order = orderByDay.getOrDefault(dayNos[i], 0) + 1;
			orderByDay.put(dayNos[i], order);

			TravelPlanDetailDTO detail = new TravelPlanDetailDTO();
			detail.setPlan_id(planId);
			detail.setDay_no(dayNos[i]);
			detail.setPlace_id(placeIds[i]);
			detail.setVisit_order(order);
			detail.setVisit_time(visitTimes != null && visitTimes[i] != null ? visitTimes[i] : "");

			dao.insertDetail(detail);
		}

		return "SUCCESS";
	}

	// 공개된 여행 일정 목록 조회
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(int cpage, String region, String nights, String sort, Model model) {
		if (region == null) {
			region = "";
		}
		if (nights == null) {
			nights = "";
		}
		if (sort == null) {
			sort = "new";
		}

		int start = cpage * 9 - 8;
		int end = cpage * 9;

		List<TravelPlanDTO> planList;
		int total;

		if (region.equals("") && nights.equals("")) {
			planList = dao.selectFromTo(start, end, sort);
			total = dao.countAll();

		} else if (!region.equals("") && nights.equals("")) {
			planList = dao.selectByRegion(start, end, sort, region);
			total = dao.countByRegion(region);

		} else if (region.equals("") && !nights.equals("")) {
			planList = dao.selectByNights(start, end, sort, nights);
			total = dao.countByNights(nights);

		} else {
			planList = dao.selectByRegionAndNights(start, end, sort, region, nights);
			total = dao.countByRegionAndNights(region, nights);
		}

		model.addAttribute("region", region);
		model.addAttribute("nights", nights);
		model.addAttribute("sort", sort);

		model.addAttribute("recordTotalCount", total);
		model.addAttribute("recordCountPerPage", 9);
		model.addAttribute("naviCountPerPage", 10);
		model.addAttribute("cpage", cpage);

		model.addAttribute("planList", planList);
		return "members/plannerList";
	}

	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String detail(Integer planId, Integer cpage, String region, String nights, String sort, Model model,
			HttpSession session) {

		if (cpage == null) {
			cpage = 1;
		}
		if (planId == null) {
			return "redirect:/travelPlan/list?cpage=1";
		}

		TravelPlanDTO plan = dao.selectPlanForView(planId);

		if (plan == null) {
			return "redirect:/travelPlan/list?cpage=1";
		}

		String memberId = (String) session.getAttribute("loginId");

		if (!"Y".equals(plan.getIs_public()) && (memberId == null || !memberId.equals(plan.getMember_id()))) {
			return "redirect:/travelPlan/list?cpage=1";
		}

		List<Map<String, Object>> detailList = dao.selectPlanDetailsWithPlace(planId);
		List<Integer> dayNumbers = new ArrayList<>();

		int totalDays = (int) ChronoUnit.DAYS.between(plan.getStart_date().toLocalDate(),
				plan.getEnd_date().toLocalDate()) + 1;

		for (int i = 1; i <= totalDays; i++) {
			dayNumbers.add(i);
		}

		List<TravelPlanReplyDTO> tprList = tprdao.selectByPlanId(planId);
		boolean isScrap = tpsrdao.isScrap(planId, memberId);
		List<PlaceDTO> idAndImg = dao.selectImages(planId);

		model.addAttribute("tprList", tprList);
		model.addAttribute("plan", plan);
		model.addAttribute("detailList", detailList);
		model.addAttribute("dayNumbers", dayNumbers);
		model.addAttribute("idAndImg", idAndImg);
		model.addAttribute("isScrap", isScrap);

		model.addAttribute("cpage", cpage);
		model.addAttribute("region", region == null ? "" : region);
		model.addAttribute("nights", nights == null ? "" : nights);
		model.addAttribute("sort", sort == null ? "new" : sort);

		return "members/planDetail";
	}

	@RequestMapping("/scrapUp")
	public String scrapUp(int seq, HttpSession session) {
		tpsrdao.scrapUp(seq, (String) session.getAttribute("loginId"));

		return "redirect:/travelPlan/detail?planId=" + seq;
	}

	@RequestMapping("/scrapDown")
	public String scrapDown(int seq, HttpSession session) {
		tpsrdao.scrapDown(seq, (String) session.getAttribute("loginId"));
		return "redirect:/travelPlan/detail?planId=" + seq;
	}

	@RequestMapping("/mypageScrapDown")
	public String mypageScrapDown(int seq, HttpSession session) {
		tpsrdao.scrapDown(seq, (String) session.getAttribute("loginId"));
		return "redirect:/members/mypage";
	}
}
