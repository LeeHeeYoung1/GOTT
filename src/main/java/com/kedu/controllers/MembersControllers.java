
package com.kedu.controllers;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.commons.EncryptionUtils;
import com.kedu.dao.CouponDAO;
import com.kedu.dao.MembersDAO;
import com.kedu.dao.ReservationDAO;
import com.kedu.dao.ReviewDAO;
import com.kedu.dao.TravelPlanDAO;
import com.kedu.dao.TravelPlanScrapDAO;
import com.kedu.dao.Travel_TypeDAO;
import com.kedu.dao.WishlistDAO;
import com.kedu.dto.MembersDTO;
import com.kedu.dto.MileageHistoryDTO;
import com.kedu.dto.PlaceDTO;
import com.kedu.dto.ReservationDTO;
import com.kedu.dto.ReviewDTO;
import com.kedu.dto.TravelPlanDTO;
import com.kedu.dto.Travel_TypeDTO;
import com.kedu.services.EmailService;

@Controller
@RequestMapping("/members")
public class MembersControllers {
	
	@Autowired
	private MembersDAO mdao;
	@Autowired
	private Travel_TypeDAO tdao;
	@Autowired
	private ReservationDAO rdao;
	@Autowired
	private EmailService emailService;
	@Autowired
	private WishlistDAO wdao;
	@Autowired
	private TravelPlanDAO tpdao;
	@Autowired
	private ReviewDAO rvdao;
	@Autowired
	private CouponDAO cdao;
	
	@RequestMapping("/loginpage")
	public String loginPage() {
	    return "members/login";
	}
	
	@ResponseBody
	@RequestMapping("/login")
	public int login(MembersDTO mdto, HttpSession session) {
		
		int result = mdao.login(mdto);
		
		if(result == 1) {
			MembersDTO member = mdao.selectById(mdto.getId());
			
			session.setAttribute("loginId", member.getId());
		    session.setAttribute("name", member.getName());
		    session.setAttribute("phone", member.getPhone());
		    session.setAttribute("email", member.getEmail());
		    session.setAttribute("gender", member.getGender());
		    session.setAttribute("Dob", member.getDob());
		    session.setAttribute("zipcode", member.getZipcode());
		    session.setAttribute("address1", member.getAddress1());
		    session.setAttribute("address2", member.getAddress2());
		    session.setAttribute("nickname", member.getNickname());
		    session.setAttribute("mileage", member.getMileage());
		    session.setAttribute("regdate", member.getRegdate());
		    session.setAttribute("role", member.getRole());
		    session.setAttribute("privacy_agree", member.getPrivacy_agree());
		}
		return result;
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) throws Exception {
		session.invalidate(); 
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping("/idcheck")
	public int idcheck(String id) {
		
		return mdao.idcheck(id);
	}
	
	@RequestMapping("/signuppage")
	public String signuppage() {
		return "members/signup";
	}
	
	@ResponseBody
	@RequestMapping("/nicknamecheck")
	public int nicknamecheck(String nickname) {
		return mdao.nicknamecheck(nickname);
	}
	
	@RequestMapping("/signup")
	public String signup(MembersDTO mdto) {
		
		mdto.setPw(EncryptionUtils.encryptSHA512(mdto.getPw()));
		mdao.signup(mdto);
		
		return "redirect:/members/loginpage";
	}
	
	@RequestMapping("/mypage")
	public String mypage(Integer cpage, Integer wishCpage, Integer mileageCpage, Integer plannerCpage, Integer reviewCpage, HttpSession session, Model model){
	    String memberId = (String) session.getAttribute("loginId");
	    if (memberId == null) {
	        return "redirect:/members/loginpage";
	    }
	    int pagesize = 3;
	    
	    String tourType = tdao.selectMyType(memberId);
	       
	    
	    // 1. 예약 내역 페이징
	    if(cpage == null || cpage < 1) cpage = 1;
	    int totalCount = rdao.reservationCount(memberId);
	    int totalPage = (int)Math.ceil((double)totalCount / pagesize);
	    if(totalPage > 0 && cpage > totalPage) cpage = totalPage;
	    if(totalPage == 0) cpage = 1;
	    ArrayList<ReservationDTO> myRsList = rdao.myRsList(memberId, cpage, pagesize);
	    LocalDate today = LocalDate.now();
	    for (ReservationDTO rs : myRsList) {
	        if ("예약취소".equals(rs.getStatus())) {
	            rs.setReservationType("cancelled");
	        } else if (rs.getCheckOut().toLocalDate().isBefore(today)) {
	            rs.setReservationType("completed");
	        } else if (rs.getCheckIn().toLocalDate().isAfter(today)) {
	            rs.setReservationType("confirmed");
	        } else {
	            rs.setReservationType("upcoming");
	        }
	    }

	    // 2. 찜 목록 페이징
	    if(wishCpage == null || wishCpage < 1) wishCpage = 1;
	    int wishTotalCount = wdao.countByWish(memberId);
	    int wishTotalPage = (int)Math.ceil((double)wishTotalCount / pagesize);
	    if(wishTotalPage > 0 && wishCpage > wishTotalPage) wishCpage = wishTotalPage;
	    if(wishTotalPage == 0) wishCpage = 1;
	    int wishStart = (wishCpage - 1) * pagesize + 1;
	    int wishEnd = wishCpage * pagesize;
	    List<PlaceDTO> wishList = wdao.selectByWish(memberId, wishStart, wishEnd);

	    // 3. 마일리지 내역 페이징
	    int mileagePagesize = 10;
	    if (mileageCpage == null || mileageCpage < 1) mileageCpage = 1;
	    int mileageTotalCount = mdao.mileageHistoryCount(memberId);
	    int mileageTotalPage = (int) Math.ceil((double) mileageTotalCount / mileagePagesize);
	    if (mileageTotalPage > 0 && mileageCpage > mileageTotalPage) {
	        mileageCpage = mileageTotalPage;
	    }
	    if (mileageTotalPage == 0) mileageCpage = 1;
	    int mileage = mdao.getMileage(memberId);
	    List<MileageHistoryDTO> mileageHistory = mdao.mileageHistory(memberId, mileageCpage, mileagePagesize);

	    // 4. 마이페이지 요약 정보
	    int myWishTotalCount = wdao.countByWish(memberId);
	    int upcomingCount = rdao.upcomingReservationCount(memberId);
	    int reviewCount = rvdao.selectCount(memberId);

	    // 5. 이용 예정 및 이용 완료 예약
	    ArrayList<ReservationDTO> upcomingList = rdao.myUpcomingList(memberId);
	    ArrayList<ReservationDTO> completedList = rdao.myCompletedList(memberId);

	 // 6. 내가 작성한 리뷰 페이징
	    int reviewPagesize = 3;
	    if (reviewCpage == null || reviewCpage < 1) reviewCpage = 1;
	    int reviewTotalCount = rvdao.countMyReview(memberId);
	    int reviewTotalPage = (int)Math.ceil((double)reviewTotalCount / reviewPagesize);
	    if (reviewTotalPage > 0 && reviewCpage > reviewTotalPage) reviewCpage = reviewTotalPage;
	    if (reviewTotalPage == 0) reviewCpage = 1;
	    List<ReviewDTO> reviewList = rvdao.selectMyReview(memberId, reviewCpage, reviewPagesize);

	    // 7. 내가 공유한 여행 일정 페이징
	    int plannerPagesize = 3;
	    if (plannerCpage == null || plannerCpage < 1) plannerCpage = 1;

	    List<?> allPlannerList = tpdao.selectMyPlansWithCount(memberId);
	    int plannerTotalCount = allPlannerList.size();
	    int plannerTotalPage = (int)Math.ceil((double)plannerTotalCount / plannerPagesize);

	    if (plannerTotalPage > 0 && plannerCpage > plannerTotalPage) {
	        plannerCpage = plannerTotalPage;
	    }
	    if (plannerTotalPage == 0) plannerCpage = 1;

	    int plannerStart = (plannerCpage - 1) * plannerPagesize;
	    int plannerEnd = Math.min(plannerStart + plannerPagesize, plannerTotalCount);
	    List<?> myPlannerList = allPlannerList.subList(plannerStart, plannerEnd);
	    
	    // 8. 내가 스크랩한 여행일정
	    List<Map<String, Object>> scrapPlanList = tpdao.scrapPlan(memberId);
	    
	    // 9. 모델 전달
	    model.addAttribute("tourType", tourType);
	    model.addAttribute("reviewCount", reviewCount);
	    model.addAttribute("reviewList", reviewList);
	    model.addAttribute("reviewCpage", reviewCpage);
	    model.addAttribute("reviewTotalPage", reviewTotalPage);
	    model.addAttribute("myCoupons", cdao.selectMyCoupons(memberId));
	    model.addAttribute("mileageCpage", mileageCpage);
	    model.addAttribute("mileageTotalPage", mileageTotalPage);
	    model.addAttribute("mileageHistory", mileageHistory);
	    model.addAttribute("upcomingCount", upcomingCount);
	    model.addAttribute("today", LocalDate.now());
	    model.addAttribute("upcomingList", upcomingList);
	    model.addAttribute("completedList", completedList);
	    model.addAttribute("myWishTotalCount", myWishTotalCount);
	    model.addAttribute("myPlannerList", myPlannerList);
	    model.addAttribute("plannerCpage", plannerCpage);
	    model.addAttribute("plannerTotalPage", plannerTotalPage);
	    model.addAttribute("mileage", mileage);
	    model.addAttribute("myRsList", myRsList);
	    model.addAttribute("cpage", cpage);
	    model.addAttribute("totalPage", totalPage);
	    model.addAttribute("wishList", wishList);
	    model.addAttribute("wishCpage", wishCpage);
	    model.addAttribute("wishTotalPage", wishTotalPage);
	    model.addAttribute("scrapPlanList", scrapPlanList);

	    Object message = session.getAttribute("reservationUpdateMessage");
	    if (message != null) {
	        model.addAttribute("reservationUpdateMessage", message);
	        session.removeAttribute("reservationUpdateMessage");
	    }

	    return "members/mypage";
	}
	
	
	@RequestMapping("/update")
	public String update() {
		return "members/update";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(MembersDTO mdto, HttpSession session) {
	    String id = (String) session.getAttribute("loginId");
	    mdto.setId(id);
	    int result = mdao.update(mdto);
	    if(result>0) {
	    	session.setAttribute("nickname", mdto.getNickname());
	    	session.setAttribute("phone", mdto.getPhone());
	    	session.setAttribute("email", mdto.getEmail());
	    	session.setAttribute("zipcode", mdto.getZipcode());
	    	session.setAttribute("address1", mdto.getAddress1());
	    	session.setAttribute("address2", mdto.getAddress2());
	    }
	    return "redirect:/members/mypage";
	}
	
	@RequestMapping("/deleted")
	public String deleted() {
		return "members/deleted";
	}
	
	@RequestMapping(value = "/deleted", method = RequestMethod.POST)
	public String deleted(MembersDTO mdto,HttpSession session) {
	    String id = (String) session.getAttribute("loginId");
	    mdto.setPw(EncryptionUtils.encryptSHA512(mdto.getPw()));
	    int result = mdao.deleted(id, mdto);
	    if (result > 0) {
	        session.invalidate();
	        return "redirect:/";
	    }
	    return "members/login";
	}
	
	
	@RequestMapping("/tourTypeTest")
	public String tourTypeTest() {
		return "event/tourTypeTest";
	}
	
	@RequestMapping("/tourTypeTestResult")
	public String tourTypeTestResult(Travel_TypeDTO dto, HttpSession session) {
		String id = (String)session.getAttribute("loginId");
		dto.setMember_id(id);
		tdao.insertType(dto);
		return "redirect:/members/mypage";
	}
	
	@RequestMapping("/idsearchpage")
	public String idsearchpage() {
		return "members/idsearch";
	}
	
	@ResponseBody
	@RequestMapping("/idsearch")
	public String idsearch(MembersDTO mdto) {
		
		String id = mdao.findId(mdto);
		
		if(id == null) {
			return "";
		}
		
		return id;
	}
	@ResponseBody
	@RequestMapping("/sendpwcode")
	public String sendpwcode(String id, String email, HttpSession session) {
		MembersDTO mdto = mdao.findEmail(id, email);
		
		if(mdto == null) {
			return "notfound";
		}
		
		int random = (int)(Math.random() * 900000) + 100000;
		String code = String.valueOf(random);
		
		try {
			emailService.sendEmail(email, code);
			session.setAttribute("pwEmailcode", code);
			session.setAttribute("pwFindId", id);
			session.setAttribute("pwFindEmail", email);
			
			return "success";
		} catch(Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}
	
	@RequestMapping("/pwsearchpage")
	public String pwsearchpage() {
		return "members/pwsearch";
	}
	
	@ResponseBody
	@RequestMapping("/verifypwcode")
	public String verifypwcode(String code, HttpSession session) {
		String savedCode = (String)session.getAttribute("pwEmailcode");
		
		if(savedCode == null) {
			return "fail";
		} else if(savedCode.equals(code)) {
			session.setAttribute("pwVerified", true);
			return "success";
		} else {
			return "fail";
		}
	}
	
	@ResponseBody
	@RequestMapping("/updatepw")
	public String updatepw(String pw, HttpSession session) {
		// 이메일 인증 여부 확인
	    Boolean verified = (Boolean)session.getAttribute("pwVerified");
	    if(verified == null || !verified) {
	        return "notVerified";
	    }
	    // 비밀번호를 변경할 아이디 가져오기
	    String id = (String)session.getAttribute("pwFindId");
	    if(id == null) {
	        return "fail";
	    }
	    // 비밀번호 암호화
	    String encryptedPw = EncryptionUtils.encryptSHA512(pw);
	    // DB 비밀번호 변경
	    int result = mdao.updatePassword(id, encryptedPw);
	    if(result > 0) {
	        // 비밀번호 찾기 관련 세션 삭제
	        session.removeAttribute("pwEmailcode");
	        session.removeAttribute("pwFindId");
	        session.removeAttribute("pwFindEmail");
	        session.removeAttribute("pwVerified");
	        return "success";
	    }
	    return "fail";
	}
	
	@RequestMapping("/planner")
	public String planner(HttpSession session, Model model) {
		String memberId = (String) session.getAttribute("loginId");		
		List<PlaceDTO> wishList = wdao.selectByWish(memberId);
	    model.addAttribute("wishList", wishList);	
		return "members/planner";
	}
	
	@RequestMapping("/wishlist")
	public String wishlist(HttpSession session, Model model) {
	    String memberId = (String) session.getAttribute("loginId");
	    List<PlaceDTO> wishList = wdao.selectByWish(memberId);
	    model.addAttribute("wishList", wishList);
	    return "members/wishlist";
	}
	
	@RequestMapping("/reservationpage")
	public String reservationpage(HttpSession session, Model model) {
		String memberId = (String) session.getAttribute("loginId");
		ArrayList<ReservationDTO> myRsList = rdao.myRsList(memberId);
		
		model.addAttribute("today", java.sql.Date.valueOf(java.time.LocalDate.now()));
		model.addAttribute("myRsList", myRsList);
	    return "members/reservationpage";
	}
	


	@RequestMapping("/mileage")
	public String milagelist(Integer mileageCpage, HttpSession session, Model model) {
	    String memberId = (String) session.getAttribute("loginId");
	    if (memberId == null) {
	        return "redirect:/members/loginpage";
	    }
	
	    int pagesize = 10;
	    if (mileageCpage == null || mileageCpage < 1) mileageCpage = 1;
	
	    int mileageTotalCount = mdao.mileageHistoryCount(memberId);
	    int mileageTotalPage = (int) Math.ceil((double) mileageTotalCount / pagesize);
	
	    if (mileageTotalPage > 0 && mileageCpage > mileageTotalPage) {
	        mileageCpage = mileageTotalPage;
	    }
	    if (mileageTotalPage == 0) mileageCpage = 1;
	
	    int mileage = mdao.getMileage(memberId);
	    List<MileageHistoryDTO> mileageHistory =
	            mdao.mileageHistory(memberId, mileageCpage, pagesize);
	
	    model.addAttribute("mileage", mileage);
	    model.addAttribute("mileageHistory", mileageHistory);
	    model.addAttribute("mileageCpage", mileageCpage);
	    model.addAttribute("mileageTotalPage", mileageTotalPage);
	
	    return "members/mileage";
	}


}