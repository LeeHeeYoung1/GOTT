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
import com.kedu.dto.TravelPlanDTO;
import com.kedu.dto.TravelPlanDetailDTO;

@Controller
@RequestMapping("/travelPlan")
public class TravelPlanController {

    @Autowired
    private TravelPlanDAO dao;
    
    @RequestMapping("delete")
    public String delete(int planId,HttpSession session) {
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


        if (title == null || title.trim().isEmpty()
                || startDate == null || startDate.isEmpty()
                || endDate == null || endDate.isEmpty()
                || count == null || count < 1
                || count > 8) {
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
            detail.setVisit_time(
                    visitTimes != null && visitTimes[i] != null
                    ? visitTimes[i] : "");

            dao.insertDetail(detail);
        }

        return "SUCCESS";
    }
    
 // 공개된 여행 일정 목록 조회
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(Model model) {
        model.addAttribute("planList", dao.selectPublicPlans());
        return "members/plannerList";
    }

    // 여행 일정 상세 페이지
    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    public String detail(Integer planId, Model model, HttpSession session) {
        if (planId == null) {
            return "redirect:/travelPlan/list";
        }

        TravelPlanDTO plan = dao.selectPlanForView(planId);
        if (plan == null) {
            return "redirect:/travelPlan/list";
        }

        String memberId = (String) session.getAttribute("loginId");

        // 비공개 일정은 작성자만 조회 가능
        if (!"Y".equals(plan.getIs_public())
                && (memberId == null || !memberId.equals(plan.getMember_id()))) {
            return "redirect:/travelPlan/list";
        }

        List<Map<String, Object>> detailList = dao.selectPlanDetailsWithPlace(planId);
        List<Integer> dayNumbers = new ArrayList<>();

        int totalDays = (int) ChronoUnit.DAYS.between(
                plan.getStart_date().toLocalDate(),
                plan.getEnd_date().toLocalDate()) + 1;

        for (int i = 1; i <= totalDays; i++) {
            dayNumbers.add(i);
        }

        model.addAttribute("plan", plan);
        model.addAttribute("detailList", detailList);
        model.addAttribute("dayNumbers", dayNumbers);

        return "members/planDetail";
    }
}
