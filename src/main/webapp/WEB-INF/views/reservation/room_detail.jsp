<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Room reservation</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>

<style>
* {
	box-sizing: border-box;
}

body {
	margin: 0;
	background-color: #F5F5F5;
	font-family: "Malgun Gothic", "맑은 고딕", sans-serif;
	color: #1a1a1f;
}

.container {
	max-width: 1000px;
	margin: 0 auto;
	background: #fff;
	padding: 30px 24px;
}

a {
	text-decoration: none;
	color: inherit;
}

/* ===== 숙소 정보 ===== */
.place_info {
	padding-bottom: 24px;
	margin-bottom: 24px;
	border-bottom: 1px solid #e3e6ea;
}

.place_info>p:first-child {
	display: none; /* 대표사진 이라는 글자 숨김 */
}

.place_info img {
	width: 100%;
	height: 320px;
	object-fit: cover;
	border-radius: 8px;
	display: block;
	background: #eef1f5;
}

.place_info p {
	margin: 0;
}

.place_info p:nth-of-type(2) {
	margin-top: 16px;
	font-size: 24px;
	font-weight: 800;
	letter-spacing: -0.02em;
}

.place_info p:nth-of-type(3) {
	margin-top: 6px;
	font-size: 14px;
	color: #6b6f76;
}

/* ===== 객실 목록 ===== */
.room_list {
	display: flex;
	flex-direction: column;
	gap: 16px;
}

/* 카드 바깥 div — class가 안 먹어서 자식 선택자로 잡음 */
.room_list>div {
	border: 1px solid #e3e6ea;
	border-radius: 8px;
	background: #fff;
	overflow: hidden;
}

.room_list>div:hover {
	border-color: #b9bec5;
	box-shadow: 0 2px 10px rgba(0, 0, 0, .05);
}

.room_card {
	display: grid;
	grid-template-columns: 1fr auto;
	gap: 14px 18px;
	padding: 16px;
}

/* 사진 줄 — 카드 전체 폭 차지 */
.room_img {
	grid-column: 1/-1;
	display: flex;
	gap: 6px;
	overflow-x: auto;
	padding-bottom: 6px;
}

.room_img img {
	width: 200px;
	height: 150px;
	object-fit: cover;
	flex-shrink: 0;
	border-radius: 6px;
	display: block;
	background: #eef1f5;
}

.no_img {
	width: 200px;
	height: 150px;
	display: flex;
	align-items: center;
	justify-content: center;
	background: #eef1f5;
	border-radius: 6px;
	font-size: 12px;
	color: #9a9aa0;
}

/* 스크롤바 얇게 */
.room_img::-webkit-scrollbar {
	height: 6px;
}

.room_img::-webkit-scrollbar-thumb {
	background: #d4d8dd;
	border-radius: 3px;
}

/* 객실 정보 */
.room_info {
	min-width: 0;
}

.room_info p {
	margin: 0;
}

.roomName {
	font-size: 17px;
	font-weight: 700;
}

.roomCount {
	margin-top: 4px !important;
	font-size: 13px;
	color: #9a9aa0;
}

.roomAmenity {
	display: flex;
	flex-wrap: wrap;
	gap: 5px;
	margin-top: 10px;
}

.roomAmenity span {
	padding: 3px 9px;
	border: 1px solid #e8eaed;
	border-radius: 3px;
	font-size: 11px;
	color: #6b6f76;
}

/* 가격 */
.room_price {
	display: flex;
	flex-direction: column;
	align-items: flex-end;
	justify-content: flex-end;
	min-width: 160px;
	font-size: 16px;
	font-weight: 700;
	text-align: right;
	line-height: 1.5;
}

/* ===== 헤더 / 푸터 ===== */
.header {
	padding-bottom: 18px;
	margin-bottom: 20px;
	border-bottom: 1px solid #e3e6ea;
	font-size: 13px;
	color: #9a9aa0;
}

.footer {
	margin-top: 40px;
	padding-top: 20px;
	border-top: 1px solid #e3e6ea;
}
</style>
</head>
<body>
	<div class="container">
		<div class="header">나는 헤더요</div>
		<div class="place_info">
			<p>대표사진</p>
			<img src="${placeOne.image_name}">
			<p>숙소명 ${placeOne.name}</p>
			<p>위치 ${placeOne.address}</p>
		</div>
		<div class="room_list">
			<c:forEach var="i" items="${detailList}">
				<div class="room_card_div">
					<a class="room_card" href="/reservation/reservation?roomId=${i.roomId}&checkIn=${param.checkIn}&checkOut=${param.checkOut}&adult=${param.adult}&child=${param.child}">
						<div class="room_img">
							<c:if test="${not empty i.image1}">
								<img src="${i.image1}">
							</c:if>
							<c:if test="${not empty i.image2}">
								<img src="${i.image2}">
							</c:if>
							<c:if test="${not empty i.image3}">
								<img src="${i.image3}">
							</c:if>
							<c:if test="${not empty i.image4}">
								<img src="${i.image4}">
							</c:if>
							<c:if test="${not empty i.image5}">
								<img src="${i.image5}">
							</c:if>
							<c:if test="${empty i.image1}">
								<div class="no_img">사진 준비중</div>
							</c:if>
						</div>
						<div class="room_info">
							<p class="roomName">${i.roomName}</p>
							<p class="roomCount">잔여 객실 수 :
								${i.roomCount}</p>
							<div class="roomAmenity">
								<c:forEach var="j" items="${i.amenities}">
									<span>${j}</span>
								</c:forEach>
							</div>
						</div>

						<div class="room_price">
							<c:choose>
								<c:when test="${i.priceWeekday != null}">
									<fmt:formatNumber value="${i.priceWeekday}" pattern="#,###"/>
								원 ~
								<fmt:formatNumber value="${i.priceWeekend}" pattern="#,###"/>
								원</c:when>
								<c:otherwise>
								가격은 해당 숙소에 문의하여 주시기 바랍니다.
							</c:otherwise>
							</c:choose>
						</div>
					</a>
				</div>
			</c:forEach>
		</div>
		<div class="footer"></div>
	</div>
</body>
</html>