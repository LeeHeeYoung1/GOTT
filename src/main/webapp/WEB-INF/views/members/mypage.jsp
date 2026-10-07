<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/public.css">
    <script src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <title>GOTT 여행 일정 플래너</title>

   <style>
* {
  box-sizing: border-box;
}

body {
  margin: 0;
  padding: 0;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  font-size: 16px;
  color: #263238;
  background-color: #f8fafa;
  line-height: 1.5;
}

/*  마이페이지 영역으로 스코프 한정 */
.mypageContainer a {
  color: inherit;
  text-decoration: none;
}

/*  마이페이지 버튼만 적용 */
.mypageContainer button {
  border: 1px solid black;
  background-color: white;
}

.mypageContainer button:hover {
  background-color: #222;
  color: white;
  border-color: #222;
}

/* 섹션 제목 + 더보기 (플래너 / 예약 / 찜 / 리뷰 공용) */
.sectionTitle {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.sectionTitle>span {
  font-size: 16px;
  font-weight: bold;
  line-height: 1;
}

.sectionTitle>a {
  font-size: 12px;
  color: #777;
  line-height: 1;
  align-self: center;
}


/* =========================================================
   3. 마이페이지 전체 틀
   ========================================================= */

.mypageContainer {
  width: 1200px;
  max-width: calc(100% - 40px);
  margin: 0 auto;
}


/* =========================================================
   4. 왼쪽 사이드바
   ========================================================= */

.sideBox {
  width: 17%;
  float: left;

  border: 1px solid #e5e7eb;
  border-radius: 10px;
  overflow: hidden;
  background-color: white;
}

/* 회원정보 */
.loginId {
  padding: 20px;
  text-align: center;
}

.loginId strong {
  font-size: 14px;
}

.loginId span {
  font-size: 12px;
  color: #797472;
}

/* 구분선 */
.sideBox hr {
  margin: 0;
  border: 0;
  border-top: 1px solid #e5e7eb;
}

.sideTitle {
  padding-bottom: 10px;
}

/* 메뉴 제목 */
.sideTitle>span {
  display: block;
  margin: 12px 20px 5px;
  font-size: 12px;
  color: #797472;
}

/* 메뉴 목록 */
.sideTitle ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

/* 메뉴 */
.sideTitle li {
  padding: 6px 20px;
  font-size: 14px;
}

/* 메뉴 링크 */
.sideTitle li a {
  display: block;
  color: #222;
  text-decoration: none;
}

/* 마우스 올렸을 때 */
.sideTitle li:hover {
  background-color: #f2f2f2;
}

/* 현재 페이지 표시 */
.sideTitle li.active {
  background-color: #eff6ff;
}

.sideTitle li.active a {
  color: #2563eb;
  font-weight: 600;
}


/* =========================================================
   5. 오른쪽 메인 영역
   ========================================================= */

.mainContainer {
  width: 83%;
  margin-left: 17%;
  padding-left: 20px;
}


/* ---------- 5-1. 상단 요약 바 (수정) ---------- */

.mybarBox {
  width: 100%;

  display: flex;

  border: 1px solid #e5e7eb;
  border-radius: 10px;
  overflow: hidden;
  background-color: white;
}

.a1,
.a2,
.a3,
.a4,
.a5 {
  width: 20%;
  height: 80px;

  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;

  cursor: pointer;
  transition: background-color 0.2s ease;
}

/* 구분선: 테두리 대신 요소 사이에만 선을 넣음 */
.a2,
.a3,
.a4,
.a5 {
  border-left: 1px solid #e5e7eb;
}

.a1 strong,
.a2 strong,
.a3 strong,
.a4 strong,
.a5 strong {
  margin: 0;
  font-size: 15px;
  font-weight: 700;
  color: #222;
}

.a1 span,
.a2 span,
.a3 span,
.a4 span,
.a5 span {
  margin-top: 4px;
  font-size: 12px;
  color: #797472;
}

.a1:hover,
.a2:hover,
.a3:hover,
.a4:hover,
.a5:hover {
  background-color: #f8fafa;
}
/* ---------- 5-2. 여행 일정 플래너 (수정) ---------- */

.plannerContainer {
  margin-top: 80px;
}

.plannerBox {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 20px;

  width: 100%;
  padding: 20px 24px;
  box-sizing: border-box;

  border: 1px solid #e5e7eb;
  border-radius: 10px;
  background-color: white;
}

.plannerBox .plannerText strong {
  display: block;
  margin-bottom: 6px;
  font-size: 15px;
  font-weight: 700;
  color: #222;
}

.plannerBox .plannerText p {
  margin: 0;
  font-size: 13px;
  color: #777;
  line-height: 1.5;
}

.plannerBox .plannerBtns {
  display: flex;
  gap: 8px;
  flex-shrink: 0;
}

.plannerBox .plannerBtns button {
  height: 34px;
  padding: 0 16px;
  border-radius: 5px;
  font-size: 12px;
  white-space: nowrap;
  cursor: pointer;
}

.plannerBox .plannerBtns .newScheduleBtn {
  border: none;
  background-color: #222;
  color: white;
  font-weight: 600;
}

.plannerBox .plannerBtns .newScheduleBtn:hover {
  background-color: #000;
}

.plannerBox .plannerBtns .viewShareBtn {
  border: 1px solid #d9d9d9;
  background-color: white;
  color: #333;
}

.plannerBox .plannerBtns .viewShareBtn:hover {
  background-color: #222;
  color: white;
  border-color: #222;
}


/* ---------- 5-2-1. 내가 공유한 여행 일정 (신규) ---------- */

.sharedPlanContainer {
  margin-top: 80px;
}

.sharedPlanCard {
  display: flex;
  align-items: stretch;

  width: 100%;
  min-height: 140px;
  margin-top: 12px;
  padding: 18px;
  box-sizing: border-box;

  border: 1px solid #e5e7eb;
  border-radius: 10px;
  background-color: white;

  transition: box-shadow 0.2s ease;
}

.sharedPlanCard:hover {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

.sharedPlanCard .img {
  width: 150px;
  height: 100px;
  flex-shrink: 0;
  overflow: hidden;
  border-radius: 8px;
  background-color: #f1f1f1;
}

.sharedPlanCard .img img {
  display: block;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.sharedPlanInfo {
  flex: 1;
  min-width: 0;
  padding: 2px 25px;
}

.sharedPlanInfo h3 {
  margin: 0 0 10px;
  font-size: 16px;
  font-weight: 700;
  color: #222;
}

.sharedPlanInfo p {
  margin: 4px 0;
  font-size: 13px;
  color: #666;
}

.sharedPlanCondition {
  width: 130px;
  flex-shrink: 0;

  display: flex;
  flex-direction: column;
  align-items: flex-end;
  justify-content: space-between;
}

.sharedPlanCondition .shareBadge {
  padding: 4px 10px;
  border-radius: 5px;
  background-color: #eff6ff;
  color: #2563eb;
  font-size: 12px;
  font-weight: 600;
}

.sharedPlanCondition .shareBadge.linkShare {
  background-color: #fff7ed;
  color: #c2410c;
}

.sharedPlanCondition .btnGroup {
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.sharedPlanCondition .btnGroup button {
  width: 100%;
  height: 32px;
  border: 1px solid #d9d9d9;
  border-radius: 5px;
  background-color: white;
  font-size: 12px;
  color: #333;
  cursor: pointer;
}

.sharedPlanCondition .btnGroup button:hover {
  background-color: #222;
  color: white;
  border-color: #222;
}

/* ---------- 5-3. 예약 리스트 ---------- */
.reservationContainer{
	margin-top: 80px;
}

/* 예약 상태 탭 */
.reservationVar {
    display: flex;
    align-items: center;

    margin-top: 20px;

    border-bottom: 1px solid #222;
}


/* 탭 */
.tab {
    width: 110px;
    height: 42px;

    display: flex;
    justify-content: center;
    align-items: center;

    border: 1px solid #ddd;
    border-bottom: none;
    border-radius: 7px 7px 0 0;

    background-color: #f8f8f8;

    font-size: 13px;
    color: #777;

    cursor: pointer;

    box-sizing: border-box;
}


/* 탭 사이 간격 */
.tab + .tab {
    margin-left: 3px;
}


/* 마우스 올렸을 때 */
.tab:hover {
    background-color: #222;
    color: white;
    border-color: #222;
}


/* 현재 선택된 탭 */
.tab.active {
    background-color: #222;
    color: white;
    border-color: #222;

    font-weight: 600;
}


/* ---------- 5-4. 찜한 여행지 · 숙소 ---------- */

.wishlistContainer {
  width: 100%;
  margin-top: 80px;
}

/* 탭 (전체 / 여행지 / 숙박업소) */
.wishlistTab {
  display: flex;
  gap: 8px;
  margin: 14px 0 16px;
}

.wishlistTab button {
  padding: 8px 16px;
  border: 1px solid #ddd;
  border-radius: 6px;
  background-color: white;
  font-size: 13px;
  color: #333;
  cursor: pointer;
}

.wishlistTab button.active {
  background-color: #222;
  color: white;
  border-color: #222;
  font-weight: 600;
}

.wishlistTab button:not(.active):hover {
  background-color: #f2f2f2;
}

/* 카드 그리드 */
.wishlistGrid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
}

/* 카드 한 장 */
.wishlistCard {
  border: 1px solid #e5e7eb;
  border-radius: 10px;
  overflow: hidden;
  background-color: white;
}

.wishlistCard .img {
  width: 100%;
  height: 200px;
  background-color: #f1f1f1;
  overflow: hidden;
}

.wishlistCard .img img {
  display: block;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.wishlistInfo {
  padding: 14px 16px;
}

.wishlistInfo h3 {
  margin: 0 0 6px;
  font-size: 15px;
  font-weight: 700;
  color: #222;
}

.wishlistInfo p {
  margin: 0 0 12px;
  font-size: 12px;
  color: #777;
  line-height: 1.4;
}

.wishlistInfo button {
  width: 100%;
  height: 34px;
  border: 1px solid #ccc;
  border-radius: 5px;
  background-color: white;
  font-size: 12px;
  color: #333;
  cursor: pointer;
}

.wishlistInfo button:hover {
  background-color: #222;
  color: white;
  border-color: #222;
}

/* =========================================================
   예약 카드 플립
   ========================================================= */

/* 기존 reservationList와 동일한 크기/여백 */
.flipCard {
    width: 100%;
    height: 200px;
    margin-top: 12px;
    perspective: 1000px;
}

/* 실제로 뒤집히는 영역 */
.flipCardInner {
    position: relative;
    width: 100%;
    height: 100%;
    transition: transform 0.6s ease;
    transform-style: preserve-3d;
}

/* 뒤집힌 상태 */
.flipCard.flipped .flipCardInner {
    transform: rotateY(180deg);
}


/* =========================================================
   앞면 / 뒷면 공통
   ========================================================= */

.flipCardFront,
.flipCardBack {
    position: absolute;

    width: 100%;
    height: 100%;

    padding: 18px;
    box-sizing: border-box;

    border: 1px solid #e5e7eb;
    border-radius: 10px;
    background-color: white;

    display: flex;
    flex-direction: row;
    align-items: stretch;

    backface-visibility: hidden;
}


/* 카드 마우스 올렸을 때 */
.flipCard:hover .flipCardFront,
.flipCard:hover .flipCardBack {
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}


/* =========================================================
   앞면
   ========================================================= */

.flipCardFront {
    transform: rotateY(0deg);
}


/* =========================================================
   뒷면
   ========================================================= */

.flipCardBack {
    transform: rotateY(180deg);
    background-color: #f8faff;
}


/* =========================================================
   이미지
   ========================================================= */

.flipCard .img {
    width: 210px;
    height: 145px;

    flex-shrink: 0;

    overflow: hidden;

    border-radius: 8px;
    background-color: #f1f1f1;
}

.flipCard .img img {
    display: block;

    width: 100%;
    height: 100%;

    object-fit: cover;
}


/* =========================================================
   예약 정보
   ========================================================= */

.flipCard .reservationInfo {
    flex: 1;
    min-width: 0;

    padding: 5px 25px;
}

.flipCard .reservationInfo h3 {
    margin: 0 0 12px;

    font-size: 18px;
    font-weight: 600;
    color: #222;
}

.flipCard .reservationInfo p {
    margin: 6px 0;

    font-size: 13px;
    color: #666;
}

.flipCard .reservationInfo p:last-child {
    margin-top: 4px;

    font-size: 15px;
    font-weight: 600;
    color: #222;
}


/* =========================================================
   오른쪽 버튼 영역
   ========================================================= */

.flipCard .reservationCondition {
    width: 120px;

    display: flex !important;
    flex-direction: column;
    justify-content: center;

    gap: 8px;

    padding-left: 15px;

    border-left: 1px solid #eee;

    flex-shrink: 0;
}

.flipCard .reservationCondition button {
    width: 100%;
    height: 34px;
    border: 1px solid #d9d9d9;
    border-radius: 5px;
    background-color: white;
    font-size: 12px;
    color: #333;
    cursor: pointer;
}


/* 예약 상태 버튼 */
.flipCard .reservationCondition button:first-child {
    border: none;
    background-color: #eff6ff;
    color: #2563eb;
    font-weight: 600;
    cursor: default;
}

.flipCard .reservationCondition button:disabled {
    opacity: 1;
}

/* 버튼 hover */
.flipCard .reservationCondition button:not(:disabled):hover {
    background-color: #222;
    color: white;
    border-color: #222;
}

/* ---------- 5-5. 내가 쓴 리뷰 ---------- */

.reviewContainer {
  margin-top: 80px;
}

/* 리뷰 카드 전체 */
.reviewList {
  display: flex;
  gap: 23px;
}

/* 리뷰 카드 */
.reviewCard {
  width: 250px;
  border: 1px solid #333;
  background-color: white;
}

/* 작성자 */
.reviewUser {
  height: 48px;
  display: flex;
  align-items: center;
  padding: 0 12px;
  border-bottom: 1px solid #333;
}

.reviewUser strong {
  font-size: 13px;
}

/* 리뷰 이미지 */
.reviewImage {
  width: 100%;
  height: 248px;
}

.reviewImage img {
  width: 100%;
  height: 100%;
  display: block;
  object-fit: cover;
}

/* 리뷰 정보 */
.reviewInfo {
  padding: 10px 12px 14px;
}

/* 아이콘 */
.reviewIcons {
  display: flex;
  gap: 15px;
  margin-bottom: 7px;
}

.reviewIcons span {
  font-size: 15px;
  cursor: pointer;
}

/* 좋아요 */
.reviewLike {
  margin: 0 0 4px;

  font-size: 12px;
  font-weight: bold;
}

/* 여행지 제목 */
.reviewTitleText {
  margin: 0 0 2px;
  font-size: 12px;
  font-weight: bold;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

/* 리뷰 내용 */
.reviewDescription {
  margin: 0;
  font-size: 12px;
  line-height: 1.5;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

/* 날짜 */
.reviewDate {
  margin: 7px 0 0;
  font-size: 10px;
  color: #777;
}

.reviewDate a {
  color: #777;
}


/* ---------- 5-6. 마일리지 · 쿠폰 ---------- */

.couponContainer {
  margin-top: 80px;
  width: 100%;
}

/* 제목 + 더보기 */
.couponSectionTitle {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.couponSectionTitle span {
  font-size: 18px;
  font-weight: bold;
}

.couponSectionTitle a {
  font-size: 13px;
  color: #888;
  text-decoration: none;
}

/* 마일리지 + 쿠폰 전체 박스 */
.coupon_point {
  border: 1px solid #555;
  box-sizing: border-box;
}

/* 마일리지 테이블 */
.coupon_point table {
  width: 100%;
  border-collapse: collapse;
}

.coupon_point th {
  height: 35px;
  border-top: 1px solid #333;
  border-bottom: 1px solid #999;
  font-size: 13px;
}

.coupon_point td {
  height: 35px;
  border-bottom: 1px solid #eee;
  font-size: 13px;
}

/* 마지막 줄 밑줄 제거 */
.coupon_point tbody tr:last-child td {
  border-bottom: none;
}

/* 날짜 */
.coupon_point th:nth-child(1),
.coupon_point td:nth-child(1) {
  width: 20%;
  text-align: left;
}

/* 내용 */
.coupon_point th:nth-child(2),
.coupon_point td:nth-child(2) {
  width: 40%;
  text-align: left;
}

/* 구분 */
.coupon_point th:nth-child(3),
.coupon_point td:nth-child(3) {
  width: 20%;
  text-align: center;
}

/* 포인트 */
.coupon_point th:nth-child(4),
.coupon_point td:nth-child(4) {
  width: 20%;
  text-align: right;
}

/* 쿠폰 목록 */
.couponList {
  display: flex;
  gap: 20px;
  margin-top: 14px;
}

/* 쿠폰 하나 */
.couponBox {
  width: 40%;
  min-height: 105px;

  border: 1px solid #555;
  padding: 13px 14px;

  box-sizing: border-box;
}

/* 쿠폰 제목 */
.couponBox strong {
  display: block;
  margin-bottom: 6px;

  font-size: 15px;
}

/* 쿠폰 설명 */
.couponBox p {
  margin: 0 0 12px;
  font-size: 12px;
  color: #777;
}

/* 사용하기 버튼 */
.couponBox button {
  width: 65px;
  height: 30px;
  background: white;
  border: 1px solid #777;
  font-size: 12px;
  cursor: pointer;
}
</style>
</head>

<body>

  <c:choose>

    <c:when test="${loginId != null}">

      <jsp:include page="/WEB-INF/views/common/header.jsp" />

      


      <div class="mypageContainer">
      <h2 style="margin: 24px 0 4px;">마이페이지</h2>
        <h5 style="font-size: 13px; color: #7c7c7c; margin: 0 0 16px;">예약 내역과 찜한 여행지, 내가 남긴 기록을 한 곳에서 관리</h5>
        <hr style="border: 1px solid rgb(248, 246, 246); margin: 0 0 20px;">

        <div class="breadcrumb" style="font-size: 12px; margin: 20px;">홈 > 마이페이지 > 대시보드</div>


        <!--여기부터 사이드박스 끼미히끼잉~~~~-->
       <div class="sideBox">

          <div class="loginId">
            <strong>${nickname}</strong><span>님</span>
            <br>
            <span>일반회원</span>
            <span>등급</span>
          </div>

          <hr>

          <div class="sideTitle">

            <span>예약/활동</span>
            <ul>
              <li class="active"><a href="/members/mypage">마이페이지 홈</a></li>
              <li><a href="#">예약 내역</a></li>
              <li><a href="/members/wishlist">찜한 여행지 · 숙소</a></li>
              <li><a href="/members/planner">여행 일정 플래너</a></li>
              <li><a href="#">내가 쓴 리뷰</a></li>
              <li><a href="#">내가 쓴 게시글</a></li>
              <li><a href="event/tourTypeTest">여행성향 테스트</a></li>
            </ul>

            <span>혜택</span>
            <ul>
              <li><a href="#">포인트 내역</a></li>
              <li><a href="#">쿠폰함</a></li>
            </ul>

            <span>계정</span>
            <ul>
              <li><a href="/members/update">내 정보 수정</a></li>
              <li><a href="/members/pwsearchpage">비밀번호 변경</a></li>
              <li><a href="#">알림 설정</a></li>
              <li><a href="#">1:1 문의</a></li>
              <li><a href="/members/deleted">회원탈퇴</a></li>
            </ul>

          </div>

       </div>


        <!--여기부터 메인 끼미히끼잉~~~~-->
        
        <div class="mainContainer">

			<nav class="mybarBox">
				<a class="a1"> <strong>??</strong> <span>다가오는 예약</span></a> 
				<a class="a2"> <strong>??</strong> <span>찜한 목록</span></a> 
				<a class="a3"> <strong>??</strong> <span>작성한 리뷰</span></a>
				<a class="a4"> <strong>${mileage}M</strong> <span>보유마일리지</span></a>
				<a class="a5"> <strong><fmt:formatDate value="${regdate}" pattern="yyyy-MM-dd"/></strong> <span>가입일자</span></a>
			</nav>

		<!--여기부터 일정 플래너-->
		
          <div class="plannerContainer">
		    <div class="sectionTitle">
		      <span>여행 일정 플래너</span>
		      <a href="/members/planner" style="float: right;">플래너 열기</a>
		    </div>
		
		    <div class="plannerBox">
		      <div class="plannerText">
		        <strong>찜해둔 장소를 일차별 일정으로 정리해보세요.</strong>
		        <p>관광지·맛집·숙소를 드래그해 일정에 추가하고 완성한 여행을 게시판에 공유할 수 있습니다.</p>
		      </div>
		
		      <div class="plannerBtns">
		        <button type="button" class="newScheduleBtn" onclick="location.href='/members/planner'">새 일정 만들기</button>
		        <button type="button" class="viewShareBtn" onclick="location.href='#'">공유한 일정 보기</button>
		      </div>
		    </div>
		</div>


		<!-- 여기부터 내가 공유한 여행 일정 -->
		<div class="sharedPlanContainer">
		
		    <div class="sectionTitle">
		      <span>내가 공유한 여행 일정</span>
		      <a href="#" style="float: right;">게시판에서 전체 보기</a>
		    </div>
		
		    <c:forEach var="plan" items="${myPlannerList}">
		      <div class="sharedPlanCard">
		
		        <div class="img">
		          <img src="${plan.image}" alt="${plan.title}">
		        </div>
		
		        <div class="sharedPlanInfo">
		          <h3>${plan.title}</h3>
		          <p>${plan.startDate} ~ ${plan.endDate} · 방문지 ${plan.spotCount}곳</p>
		          <p>공유일 ${plan.shareDate} · 조회 ${plan.viewCount} · 공감 ${plan.likeCount}</p>
		        </div>
		
		        <div class="sharedPlanCondition">
		          <c:choose>
		            <c:when test="${plan.shareType == '전체공개'}">
		              <span class="shareBadge">전체 공개</span>
		            </c:when>
		            <c:otherwise>
		              <span class="shareBadge linkShare">링크 공유</span>
		            </c:otherwise>
		          </c:choose>
		
		          <div class="btnGroup">
		            <button type="button" class="boardViewBtn" data-planner-id="${plan.plannerId}">게시글 보기</button>
		            <button type="button" class="planEditBtn" data-planner-id="${plan.plannerId}">일정 수정</button>
		          </div>
		        </div>
		
		      </div>
		    </c:forEach>
		
		</div>



          <!--여기부터 예약리스트-->
          
          <div class="reservationContainer">

            <div class="sectionTitle">
              <span>예약내역</span>
              <a href="#" style="float: right;">예약내역 열기</a>
            </div>


            <div class="reservationVar">
              <span class="tab active">전체</span>
              <span class="tab">이용 예정</span>
              <span class="tab">이용 완료</span>
              <span class="tab">취소 / 환불</span>
            </div>




			<c:forEach var="rs" items="${myRsList}">
			    <div class="flipCard">
			        <div class="flipCardInner">
			
			            <!-- 앞면: 기존 예약 내역 -->
			            <div class="flipCardFront">
			                <div class="img">
			                    <img src="${rs.image1}" alt="호텔 이미지">
			                </div>
			
			                <div class="reservationInfo">
			                    <h3>${rs.roomName}</h3>
			                    <p>· 체크인 ${rs.checkIn} / 체크아웃 ${rs.checkOut}</p>
			                    <p>· 성인 ${rs.guestNum}명<br>
			                        · 예약번호 ${rs.paymentId}<br>                        
			                        <c:choose>                        
			                            <c:when test="${rs.status ne '예약취소'}">
			                                <strong>· 적립 마일리지 + ${rs.mileage}M</strong>
			                            </c:when>
			                            
			                            <c:otherwise>
			                                <strong>· 회수 마일리지 - ${rs.mileage}M</strong>
			                            </c:otherwise>                           
			                        </c:choose>                     
			                    </p>
			                    
			                    <p>결제금액 ${rs.price}원</p>
			                </div>
			
			                <div class="reservationCondition">
			                    <button disabled>${rs.status}</button>
			                    <button type="button" class="detailBtn">예약 상세</button>
			                    <c:if test="${rs.status ne '예약취소'}">
			                        <button type="button" class="updateBtn" data-payment-id="${rs.paymentId}" style="background-color: red;">예약 변경</button>
			                        <button type="button" class="cancelBtn" data-payment-id="${rs.paymentId}" style="background-color: wheat;">예약 취소</button>
			                    </c:if>
			                </div>
			            </div>
			
			            <!-- 뒷면: 예약 상세 내역 -->
			            <div class="flipCardBack">
			                <div class="reservationInfo">
			                    <h3>${rs.roomName} 상세정보</h3>
			                    <p>· 체크인: ${rs.checkIn}</p>
			                    <p>· 체크아웃: ${rs.checkOut}</p>
			                    <p>· 성인: ${rs.guestNum}명</p>
			                    <p>· 예약번호: ${rs.paymentId}</p>
			                    <p>· 결제금액: ${rs.price}원</p>
			                    <p>· 예약일: ${rs.reserveDate}</p>
			                </div>
			
			                <div class="reservationCondition">
			                    <button type="button" class="backBtn">돌아가기</button>
			                    <c:if test="${rs.status ne '예약취소'}">
			                        <button type="button" class="updateBtn" data-payment-id="${rs.paymentId}" style="background-color: blue;">예약 변경</button>
			                        <button type="button" class="cancelBtn" data-payment-id="${rs.paymentId}" style="background-color: rgb(153, 44, 44);">예약 취소</button>
			                    </c:if>
			                </div>
			            </div>
			
			        </div>
			    </div>
			</c:forEach>



          </div>


          <!--여기부터 찜 리스트-->

          <div class="wishlistContainer">

			  <div class="sectionTitle">
			    <span>찜한 관광지 맛집 숙소</span>
			    <a href="#">더 보기 &gt;</a>
			  </div>
			
			  <div class="wishlistTab">
			    <button type="button" class="active" data-type="all">전체</button>
			    <button type="button" data-type="spot">관광지</button>
			    <button type="button" data-type="stay">맛집</button>
			    <button type="button" data-type="stay">숙박</button>
			  </div>
			
			  <div class="wishlistGrid">
			    <c:forEach var="wishList" items="${wishList}">
			      <div class="wishlistCard">
			        <div class="img">
			          <img src="${wishList.image_name}" alt="${wishList.name}">
			        </div>
			        <div class="wishlistInfo">
			          <h3>${wishList.name}</h3>
			          <p>${wishList.region}</p>
			          <button type="button">자세히 보기</button>
			        </div>
			      </div>
			    </c:forEach>
			  </div>
			
			</div>

          <!-- 여기부터 내가 쓴 리뷰 -->

          <div class="reviewContainer">

            <div class="sectionTitle">
              <span>내가 쓴 리뷰</span>
              <a href="#">더 보기 &gt;</a>
            </div>

            <div class="reviewList">

            <c:forEach var="review" items="${review}">

                <div class="reviewCard">

                  <div class="reviewUser">
                    <strong>${review.nickname}</strong>
                  </div>

                  <div class="reviewImage">
                    <img src="${review.image}" alt="${review.title}">
                  </div>

                  <div class="reviewInfo">

                    <div class="reviewIcons">
                      <span>♡</span>
                      <span>⊙</span>
                      <span>↗</span>
                    </div>


                    <p class="reviewLike">
                      좋아요 ${review.likeCount}개
                    </p>


                    <p class="reviewTitleText">
                      ${review.title}
                    </p>


                    <p class="reviewDescription">
                      후기 · "${review.description}"
                    </p>


                    <p class="reviewDate">
                      ${review.writeDate} · <a href="#">수정</a> / <a href="#">삭제</a>
                    </p>

                  </div>

                </div>

            </c:forEach>

            </div>

        

        </div>
        
        <div class="couponContainer">
        
        	<div class="couponSectionTitle">
    			<span>마일리지 · 쿠폰</span>
    			<a href="#">더 보기 &gt;</a>
			</div>
       		
       		<div class="coupon_point" style="padding:20px 20px 12px">      		
       			<table align="center">
	       			<thead>
	       				<tr>
	                		<th>날짜</th>
	                		<th>내용</th>
	                		<th>구분</th>
	                		<th>포인트</th>
	              		</tr>
	              	</thead>
              	
	              	<tbody>
	              		<tr>
	                		<td>2026-09-02</td>
	                		<td>리뷰 작성 적립</td>
	                		<td>적립</td>
	                		<td>+???M</td>
	                	</tr>
	              		<tr>
	                		<td>2026-08-14</td>
	                		<td>제주 오션뷰 호텔 결제 사용</td>
	                		<td>사용</td>
	                		<td>-????M</td>
	                	</tr>
	                	<tr>
	                		<td>2026-08-03</td>
	                		<td>첫 예약 이벤트 적립</td>
	                		<td>적립</td>
	                		<td>+????0M</td>
	              		</tr>
	              	</tbody>
       			</table>
       			
       			<div class="couponList">
       				<div class="couponBox">
       					<Strong>첫 회원가입 3%쿠폰</Strong>
       					<p>?????까지 100만원 이상 결제시</p>
       					<button type="button">사용하기</button>
       				</div>
       				
       				<div class="couponBox">
       					<Strong>첫 회원가입 10%쿠폰</Strong>
       					<p>?????까지 300만원 이상 결제시</p>
       					<button type="button">사용하기</button>
       				</div>
       			</div>
       			
       		</div>
       		
       		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
        </div>

      </div>

      </div>

    </c:when>

  </c:choose>

<script>

$(".cancelBtn").on("click", function() {

 let paymentId = $(this).data("payment-id");

 console.log("paymentId : " + paymentId);

 if (!confirm("이 예약을 취소할까요?")) {
     return;
 }

 $.ajax({
     url: "/reservation/cancelReservation",
     type: "POST",
     data: {
         paymentId: paymentId
     },
     success: function(result) {

         console.log("결과 : " + result);

         if (result.trim() == "OK") {
             alert("예약이 취소되었습니다.");
             location.reload();
         } else {
             alert(result);
         }
     },
     error: function() {
         alert("취소 요청 중 오류가 발생했습니다.");
     }
 });
});



$(".updateBtn").on("click", function() {

 let paymentId = $(this).data("payment-id");

 console.log("paymentId : " + paymentId);

 window.open(
     "/reservation/reservationUpdate?paymentId=" + paymentId,
     "reservationUpdate",
     "width=800,height=600,left=100,top=100"
 );
});


$(".detailBtn").on("click", function() {
 $(this).closest(".flipCard").addClass("flipped");
});



$(".backBtn").on("click", function() {
 $(this).closest(".flipCard").removeClass("flipped");
});

</script>
</body>

</html>