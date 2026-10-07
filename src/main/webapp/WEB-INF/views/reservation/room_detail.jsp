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
	-webkit-font-smoothing: antialiased;
}

.container {
	max-width: 1000px;
	margin: 0 auto;
	background: #fff;
	padding: 32px 28px 60px;
	min-height: 100vh;
}

a {
	text-decoration: none;
	color: inherit;
}

/* ===== 숙소 정보 ===== */
.place_info {
	padding-bottom: 26px;
	margin-bottom: 28px;
	border-bottom: 1px solid #e3e6ea;
}

.place_info>p:first-child {
	display: none; /* 대표사진 이라는 글자 숨김 */
}

.place_info img {
	width: 100%;
	height: 340px;
	object-fit: cover;
	border-radius: 10px;
	display: block;
	background: #eef1f5;
}

.place_info p {
	margin: 0;
}

/* 숙소명 */
.place_info p:nth-of-type(2) {
	margin-top: 20px;
	font-size: 26px;
	font-weight: 800;
	letter-spacing: -0.03em;
	line-height: 1.3;
}

/* 위치 */
.place_info p:nth-of-type(3) {
	margin-top: 8px;
	font-size: 14px;
	color: #6b6f76;
}

/* ===== 객실 목록 ===== */
.room_list {
	display: flex;
	flex-direction: column;
	gap: 14px;
}

/* 카드 바깥 div — class가 안 먹어서 자식 선택자로 잡음 */
.room_list>div {
	border: 1px solid #e3e6ea;
	border-radius: 10px;
	background: #fff;
	overflow: hidden;
	transition: border-color .15s, box-shadow .15s, transform .15s;
}

.room_list>div:hover {
	border-color: #c9ced5;
	box-shadow: 0 4px 16px rgba(0, 0, 0, .07);
	transform: translateY(-1px);
}

.room_card {
	display: grid;
	grid-template-columns: 1fr auto;
	gap: 16px 20px;
	padding: 18px;
	cursor: pointer;
}

/* 사진 줄 — 카드 전체 폭 차지 */
.room_img {
	grid-column: 1/-1;
	display: flex;
	gap: 8px;
	overflow-x: auto;
	padding-bottom: 8px;
	scroll-snap-type: x proximity;
}

.room_img img {
	width: 210px;
	height: 150px;
	object-fit: cover;
	flex-shrink: 0;
	border-radius: 8px;
	display: block;
	background: #eef1f5;
	scroll-snap-align: start;
}

.no_img {
	width: 210px;
	height: 150px;
	display: flex;
	align-items: center;
	justify-content: center;
	background: #eef1f5;
	border-radius: 8px;
	font-size: 12px;
	color: #9a9aa0;
	flex-shrink: 0;
}

/* 스크롤바 얇게 */
.room_img::-webkit-scrollbar {
	height: 6px;
}

.room_img::-webkit-scrollbar-track {
	background: transparent;
}

.room_img::-webkit-scrollbar-thumb {
	background: #d4d8dd;
	border-radius: 3px;
}

.room_img:hover::-webkit-scrollbar-thumb {
	background: #b9bec5;
}

/* ===== 객실 정보 ===== */
.room_info {
	min-width: 0;
	align-self: center;
}

.room_info p {
	margin: 0;
}

.roomName {
	font-size: 18px;
	font-weight: 700;
	letter-spacing: -0.02em;
}

.roomCount {
	margin-top: 6px !important;
	font-size: 13px;
	color: #9a9aa0;
}

.roomCount strong {
	color: #1a1a1f;
	font-weight: 800;
	font-size: 14px;
}

.soldout {
	display: inline-block;
	padding: 2px 9px;
	border-radius: 4px;
	background: #fdecea;
	color: #c0392b;
	font-size: 12px;
	font-weight: 700;
}

/* 편의시설 */
.roomAmenity {
	display: flex;
	flex-wrap: wrap;
	gap: 5px;
	margin-top: 12px;
}

.roomAmenity span {
	padding: 4px 10px;
	border: 1px solid #e8eaed;
	border-radius: 4px;
	background: #fafbfc;
	font-size: 11px;
	color: #6b6f76;
	white-space: nowrap;
}

.roomAmenity:empty {
	display: none;
}

/* ===== 가격 ===== */
.room_price {
	display: flex;
	flex-direction: column;
	align-items: flex-end;
	justify-content: center;
	min-width: 190px;
	padding-left: 20px;
	border-left: 1px solid #f0f2f4;
	font-size: 17px;
	font-weight: 800;
	text-align: right;
	letter-spacing: -0.02em;
	line-height: 1.5;
	color: #1a1a1f;
}

/* 가격 문의 문구는 작고 흐리게 */
.room_price:not(:has(*)) {
	font-size: 13px;
	font-weight: 500;
	color: #9a9aa0;
	letter-spacing: 0;
}

/* ===== 마감 처리 ===== */
.room_card.disabled {
	pointer-events: none;
	opacity: 0.45;
	cursor: default;
}

.room_list>div:has(.room_card.disabled) {
	background: #fafbfc;
}

.room_list>div:has(.room_card.disabled):hover {
	border-color: #e3e6ea;
	box-shadow: none;
	transform: none;
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
	padding-top: 24px;
	border-top: 1px solid #e3e6ea;
	display: flex;
	justify-content: center;
}

#backBtn {
	min-width: 160px;
	padding: 13px 34px;
	border: 1px solid #dfe3e8;
	border-radius: 8px;
	background: #fff;
	font-family: inherit;
	font-size: 14px;
	font-weight: 600;
	color: #45484f;
	cursor: pointer;
	transition: background .15s, border-color .15s, color .15s;
}

#backBtn:hover {
	background: #1a1a1f;
	border-color: #1a1a1f;
	color: #fff;
}
</style>
</head>
<body>
	<div class="container">

		<div class="place_info">
			<p>대표사진</p>
			<img src="${placeOne.image_name}">
			<p>숙소명 ${placeOne.name}</p>
			<p>위치 ${placeOne.address}</p>
		</div>
		<div class="room_list">
			<c:forEach var="i" items="${detailList}">
				<div class="room_card_div">
					<a class="room_card ${i.remainCount > 0 ? '' : 'disabled'}"
						href="/reservation/reservation?placeId=${placeOne.place_id}&roomId=${i.roomId}&checkIn=${param.checkIn}&checkOut=${param.checkOut}&adult=${param.adult}&child=${param.child}">
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
							<p class="roomCount">
								<c:choose>
									<c:when test="${empty param.checkIn}">
				전체 객실 ${i.remainCount}실
			</c:when>
									<c:when test="${i.remainCount > 0}">
				잔여 객실 <strong>${i.remainCount}</strong>실
			</c:when>
									<c:otherwise>
										<span class="soldout">예약 마감</span>
									</c:otherwise>
								</c:choose>
							</p>
							<div class="roomAmenity">
								<c:forEach var="j" items="${i.amenities}">
									<span>${j}</span>
								</c:forEach>
							</div>
						</div>

						<div class="room_price">
							<c:choose>
								<c:when test="${i.priceWeekday != null}">
									<fmt:formatNumber value="${i.priceWeekday}" pattern="#,###" />
								원 ~
								<fmt:formatNumber value="${i.priceWeekend}" pattern="#,###" />
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
		<div class="footer">
			<button type="button" id="backBtn">뒤로가기</button>
		</div>
	</div>
</body>
<script>
	$("#backBtn").on("click", function() {
		history.back();
	})
</script>
</html>