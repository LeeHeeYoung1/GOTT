package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kedu.dao.CouponDAO;
import com.kedu.dto.CouponDTO;

@Controller
@RequestMapping("/coupon")
public class CouponController {

    @Autowired
    private CouponDAO cdao;

    // 1. 마이페이지 쿠폰함
    @GetMapping("/myCoupon")
    public String myCoupons(HttpSession session, Model model) {
        String memberId = (String) session.getAttribute("loginId");
        if (memberId == null) {
            return "redirect:/members/loginpage";
        }

        List<CouponDTO> couponList = cdao.selectMyCoupons(memberId);
        model.addAttribute("couponList", couponList);

        return "/members/coupon";
    }

    // 2. 결제 시 사용 가능한 쿠폰 목록
    @GetMapping("/available")
	public String availableCoupons(@RequestParam("price") int price, HttpSession session, Model model,RedirectAttributes redirectAttributes) {
        String memberId = (String) session.getAttribute("loginId");
        if (memberId == null) {
            return "redirect:/members/loginpage";
        }

        if (price < 0) {
            redirectAttributes.addFlashAttribute("msg", "결제 금액이 올바르지 않습니다.");
            return "redirect:/";
        }

        List<CouponDTO> couponList = cdao.selectAvailableCoupons(memberId, price);

        model.addAttribute("couponList", couponList);
        model.addAttribute("price", price);

        return "members/availableCoupons";
    }

    // 3. 회원에게 쿠폰 발급
    @PostMapping("/issue")
	public String issueCoupon(@RequestParam("couponId") int couponId, HttpSession session,RedirectAttributes redirectAttributes) {
        String memberId = (String) session.getAttribute("loginId");
        if (memberId == null) {
            return "redirect:/members/loginpage";
        }
        redirectAttributes.addFlashAttribute("msg", "쿠폰 발급 기능은 DAO 발급 메서드 연결 후 사용할 수 있습니다.");
        return "redirect:/coupon/myCoupons";
    }
}
