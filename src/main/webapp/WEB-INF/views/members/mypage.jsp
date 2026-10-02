<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>

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

a {
  color: inherit;
  text-decoration: none;
}

/* 제목 */
h2,
h5 {
  display: flex;
  justify-content: center;
  align-items: center;
}

/* 버튼 */
button {
  border: 1px solid black;
  background-color: white;
}

button:hover {
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
}

.sectionTitle>a {
  font-size: 12px;
  color: #777;
}


/* =========================================================
   2. 헤더
   ========================================================= */

.headercontainer {
  width: 1200px;
  max-width: calc(100% - 40px);
  margin: 0 auto;

  display: flex;
  align-items: center;

  padding: 0 30px;
}

/* 로고 */
.logoBox {
  width: 100px;
  height: 40px;

  display: flex;
  justify-content: center;
  align-items: center;

  margin-right: 50px;
}

.logoBox img {
  width: 100%;
  height: 100%;
}

/* 메뉴 */
.nav {
  display: flex;
  gap: 30px;
}

.nav a {
  color: black;
}

/* 마이페이지 / 로그아웃 */
.signBox {
  margin-left: auto;
  margin-right: 40px;

  display: flex;
  gap: 10px;
}

.signBox a {
  color: black;
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


/* ---------- 5-1. 상단 요약 바 ---------- */

.mybarBox {
  width: 100%;

  display: flex;
}

.a1,
.a2,
.a3,
.a4,
.a5 {
  width: 20%;
  height: 80px;

  border: 1px solid black;

  display: flex;
  flex-direction: column;

  justify-content: center;
  align-items: center;
}

.a1 p,
.a2 p,
.a3 p,
.a4 p, 
.a5 p {
  margin: 0;
  font-size: 24px;
}

.a1 span,
.a2 span,
.a3 span,
.a4 span, 
.a5 span {
  margin: 0;
  font-size: 13px;
}


/* ---------- 5-2. 여행 일정 플래너 ---------- */

.plannerContainer {
  margin-top: 80px;
}

.plannerBox {
  border: 1px solid black;
  width: 100%;
  padding: 20px;
}


/* ---------- 5-3. 예약 내역 ---------- */

.reservationContainer {
  margin-top: 80px;
}

.reservationVar {
  display: flex;
  margin-top: 15px;
  border-bottom: 1px solid #222;
}

.tab {
  width: 100px;
  height: 40px;

  display: flex;
  justify-content: center;
  align-items: center;

  border: 1px solid #ccc;
  border-bottom: none;

  background-color: white;

  font-size: 13px;
  cursor: pointer;
}

.tab:hover {
  background-color: #222;
  color: white;
  border-color: #222;
}

.reservationList {
  display: flex;
  margin-top: 10px;
  padding: 20px;
  border: 1px solid #ccc;
}


/* ---------- 5-4. 찜한 여행지 · 숙소 ---------- */

.wishlistContainer {
  width: 100%;
  margin-top: 80px;
  display: flow-root;   /* 안의 float 카드 높이까지 감싸서 아래 영역이 올라오지 않게 */
}

/* 카드 */
.wishlistImg {
  width: 250px;
  float: left;
  margin-right: 23px;
  border: 1px solid #333;
  background-color: white;
}

/* 카드 이미지 */
.wishlistImg>img {
  display: block;

  width: 100%;
  height: 185px;

  object-fit: cover;
}

/* 카드 내용 */
.wishlistInfo {
  padding: 14px 15px 18px;
}

.wishlistInfo h3 {
  margin: 0 0 6px;

  font-size: 16px;
  font-weight: 500;
}

.wishlistInfo p {
  margin: 0 0 14px;

  font-size: 13px;
  color: #777;

  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

/* 자세히 보기 버튼 */
.wishlistInfo button {
  padding: 6px 12px;

  border: 1px solid #333;
  background-color: white;

  font-size: 12px;
  cursor: pointer;
}

.wishlistInfo button:hover {
  background-color: #222;
  color: white;
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

      <div class="headercontainer">
        <div class="logoBox">
        <a href="/"><img src="/images/logo.png" alt="GOTT 로고"></a>
        </div>

        <nav class="nav">
          <a href="#">이벤트</a>
          <a href="#">지역</a>
          <a href="#">추천여행지</a>
          <a href="#">숙박업소</a>
          <a href="#">리뷰</a>
          <a href="#">여행 플래너</a>
          <a href="#">공지사항</a>
        </nav>

        <div class="signBox">
          <a href="/members/mypage">마이페이지</a>
          <a href="/members/logout">로그아웃</a>
        </div>

        <div class="menu-icon">☰</div>
      </div>

      <hr>


      <h2>마이페이지</h2>
      <h5 style="font-size: 13px; color: #7c7c7c;">예약 내역과 찜한 여행지, 내가 남긴 기록을 한 곳에서 관리</h5>
      <hr style="border: 1px solid rgb(248, 246, 246);">




      <div class="mypageContainer">

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
              <li><a href="#">찜한 여행지 · 숙소</a></li>
              <li><a href="#">여행 일정 플래너</a></li>
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
              <a href="#" style="float: right;">플래너 열기</a>
            </div>
            
            <div class="plannerBox">
              <p>찜해둔 장소를 일차별 일정으로 정리해보세요.</p>
              <p>관광지·맛집·숙소를 드래그해 일정에 추가하고 완성한 여행을 게시판에 공유할 수 있습니다.</p>
              <button>새 일정 만들기</button>
            </div>
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


            <c:forEach var="roomList" items="${roomList}">

              <div class="reservationList">

                <div class="img">
                  <img src="${roomList.image}" alt="호텔 이미지">
                </div>

                <div class="reservationInfo">
                  <h3>${roomList.guestnum} · ${roomList.roomName}</h3>

                  <p>
                    체크인 ${reservation.check_in}
                    / 체크아웃 ${reservation.check_Out}
                    · 박
                  </p>

                  <p>
                    성인 ${reservation.guestnum}명
                    · 예약번호 ${reservation.reservationId}
                  </p>

                  <p>
                    결제금액 ${reservation.price}원
                  </p>
                </div>

                <div class="reservationCondition">
                  <button>${reservation.status}</button>
                  <button>예약 상세</button>
                  <button>예약 취소</button>
                </div>

              </div>

            </c:forEach>


          </div>


          <!--여기부터 찜 리스트-->

          <div class="wishlistContainer">
            <div class="sectionTitle">
              <span>찜한 여행지 숙소</span>
              <a href="#">더 보기 &gt;</a>
            </div>
            <c:forEach var="wishlist" items="${wishlist}">

              <div class="wishlistImg">

                <img src="${i.image}" alt="${i.title}">

                <div class="wishlistInfo">
                  <h3>${i.title}</h3>
                  <p>${i.description}</p>
                  <button>자세히 보기</button>
                </div>

              </div>
              
              <div class="wishlistImg">

                <img src="${i.image}" alt="${i.title}">

                <div class="wishlistInfo">
                  <h3>${i.title}</h3>
                  <p>${i.description}</p>
                  <button>자세히 보기</button>
                </div>

              </div>
              
              <div class="wishlistImg">

                <img src="${i.image}" alt="${i.title}">

                <div class="wishlistInfo">
                  <h3>${i.title}</h3>
                  <p>${i.description}</p>
                  <button>자세히 보기</button>
                </div>

              </div>

            </c:forEach>

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
       		
        </div>




      </div>

      </div>

    </c:when>
    
    <c:otherwise>
    	<div>로그인하세용 ㅈㅈ</div>
    </c:otherwise>





  </c:choose>

</body>

</html>
