<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reservation</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
<style>
* {
	box-sizing: border-box;
}

body {
	margin: 0;
	background: #F5F5F5;
	font-family: "Malgun Gothic", "맑은 고딕", sans-serif;
	color: #1a1a1f;
	-webkit-font-smoothing: antialiased;
}

.container {
	max-width: 760px;
	margin: 0 auto;
	background: #fff;
	padding: 34px 32px 48px;
	min-height: 100vh;
}

.header {
	font-size: 24px;
	font-weight: 800;
	letter-spacing: -0.03em;
	line-height: 1.3;
}

hr {
	margin: 18px 0 26px;
	border: 0;
	border-top: 1px solid #e3e6ea;
}

/* 버튼 위치의 기준점 */
form {
	position: relative;
	font-size: 13px;
	color: #6b6f76;
	line-height: 1.8;
}

/* ===== 사진 ===== */
.photo {
	position: relative;
	max-width: 580px;
	margin: 0 auto 26px;
	border-radius: 12px;
	overflow: hidden;
	background: #eef1f5;
}

.room_img {
	display: flex;
	transition: transform .3s ease;
}

.room_img img {
	width: 100%;
	height: 420px;
	object-fit: cover;
	flex-shrink: 0;
	display: block;
}

.no_img {
	width: 100%;
	height: 420px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 13px;
	color: #9a9aa0;
}

/* ===== 사진 넘김 버튼 ===== */
.leftBtn, .rightBtn {
	position: absolute;
	top: 210px;
	transform: translateY(-50%);
	width: 42px;
	height: 42px;
	border: 0;
	border-radius: 50%;
	background: rgba(255, 255, 255, .92);
	font-size: 0;
	color: #45484f;
	cursor: pointer;
	z-index: 2;
	box-shadow: 0 2px 10px rgba(0, 0, 0, .14);
	transition: background .15s, color .15s, transform .15s;
}

.leftBtn::before {
	content: "\2039";
	font-size: 26px;
	line-height: 1;
}

.rightBtn::before {
	content: "\203A";
	font-size: 26px;
	line-height: 1;
}

.leftBtn {
	left: 14px;
}

.rightBtn {
	right: 14px;
}

.leftBtn:hover, .rightBtn:hover {
	background: #1a1a1f;
	color: #fff;
}

.leftBtn:hover {
	transform: translateY(-50%) translateX(-2px);
}

.rightBtn:hover {
	transform: translateY(-50%) translateX(2px);
}

/* ===== 객실 정보 ===== */
.room_info {
	padding-bottom: 22px;
	border-bottom: 1px solid #eef0f2;
}

.room_info p {
	margin: 0;
}

.roomName {
	font-size: 21px;
	font-weight: 700;
	letter-spacing: -0.02em;
	color: #1a1a1f;
}

.roomCount {
	margin-top: 6px !important;
	font-size: 13px;
	color: #9a9aa0;
}

.roomAmenity {
	display: flex;
	flex-wrap: wrap;
	gap: 6px;
	margin-top: 14px;
}

.roomAmenity span {
	padding: 4px 11px;
	border: 1px solid #e8eaed;
	border-radius: 4px;
	background: #fafbfc;
	font-size: 11px;
	color: #6b6f76;
	white-space: nowrap;
}

/* ===== 예약 정보 ===== */
.checkIn, .checkOut, .guest {
	display: flex;
	flex-wrap: wrap;
	align-items: baseline;
	gap: 0 18px;
	padding: 14px 2px;
	border-bottom: 1px solid #f3f5f7;
}

.checkIn p, .checkOut p, .guest p {
	margin: 0;
	font-size: 14px;
	color: #45484f;
}

.guest p:first-child {
	width: 100%;
	margin-bottom: 4px;
	font-size: 13px;
	color: #9a9aa0;
}

.guest p+p {
	font-weight: 600;
}

/* ===== 정보 없음 ===== */
.emptyData {
	margin: 10px 0 4px;
	padding: 26px 20px;
	border: 1px dashed #d7dce2;
	border-radius: 10px;
	background: #fafbfc;
	font-size: 14px;
	color: #8b8f96;
	text-align: center;
	line-height: 1.6;
}

/* ===== 가격 ===== */
.room_price {
	display: flex;
	align-items: baseline;
	justify-content: flex-end;
	gap: 6px;
	padding: 22px 2px;
	border-bottom: 1px solid #eef0f2;
	font-size: 24px;
	font-weight: 800;
	letter-spacing: -0.02em;
	text-align: right;
	line-height: 1.4;
	color: #1a1a1f;
}

/* ===== 하단 버튼 ===== */
.buttons {
	display: flex;
	gap: 10px;
	margin-top: 32px;
}

.buttons button {
	flex: 1;
	height: 54px;
	border: 1px solid #1a1a1f;
	border-radius: 8px;
	background: #1a1a1f;
	font-family: inherit;
	font-size: 16px;
	font-weight: 700;
	letter-spacing: -0.02em;
	color: #fff;
	cursor: pointer;
	transition: background .15s, box-shadow .15s, transform .15s;
}

.buttons button:hover {
	background: #33363c;
	box-shadow: 0 6px 16px rgba(26, 26, 31, .18);
	transform: translateY(-1px);
}

.buttons button:active {
	transform: translateY(0);
	box-shadow: none;
}

.buttons button[type=button] {
	flex: 0 0 140px;
	border-color: #dfe3e8;
	background: #fff;
	color: #45484f;
	font-weight: 500;
}

.buttons button[type=button]:hover {
	background: #f6f7f8;
	box-shadow: none;
	transform: none;
}
</style>
</head>
<body>
	<div class="container">
		<div class="header">${placeOne.name}</div>
		<hr>
		<form
			action="${pageContext.request.contextPath}/reservation/finalPayment"
			method="get">
			<div class="photo">
				<div class="room_img">
					<c:if test="${not empty roomDto.image1}">
						<img src="${roomDto.image1}">
					</c:if>
					<c:if test="${not empty roomDto.image2}">
						<img src="${roomDto.image2}">
					</c:if>
					<c:if test="${not empty roomDto.image3}">
						<img src="${roomDto.image3}">
					</c:if>
					<c:if test="${not empty roomDto.image4}">
						<img src="${roomDto.image4}">
					</c:if>
					<c:if test="${not empty roomDto.image5}">
						<img src="${roomDto.image5}">
					</c:if>
					<c:if test="${empty roomDto.image1}">
						<img src="${placeOne.image_name}">
					</c:if>
				</div>
			</div>

			<button type="button" class="leftBtn">왼쪽버튼</button>
			<button type="button" class="rightBtn">오른쪽버튼</button>


			<div class="room_info">
				<input type="hidden" name="placeId" value="${placeId}"> <input
					type="hidden" name="roomId" value="${roomDto.roomId}">
				<p class="roomName">${roomDto.roomName}</p>
				<p class="roomCount">잔여 객실 수 : ${roomDto.roomCount}</p>
				<div class="roomAmenity">
					<c:forEach var="j" items="${roomDto.amenities}">
						<span>${j}</span>
					</c:forEach>
				</div>
			</div>

			<c:choose>
				<c:when test="${empty checkIn or empty checkOut or empty adult or empty child or empty total_price}">
			 		<div class="emptyData">날짜 혹은 인원이 선택되지 않았습니다.</div>
				</c:when>
				<c:otherwise>
					<div class="checkIn">
						<input type="hidden" name="checkIn" value="${checkIn }">
						<p>체크인 : ${checkIn}</p>
					</div>
					<div class="checkOut">
						<input type="hidden" name="checkOut" value="${checkOut }">
						<p>체크아웃 : ${checkOut}</p>
					</div>
					<div class="guest">
						<input type="hidden" name="guest" value="${adult +child}">
						<p>숙박인원</p>
						<p>성인 : ${adult}</p>
						<p>아동 : ${child}</p>
					</div>
					<div class="room_price">
						<fmt:formatNumber value="${total_price}" pattern="#,###" />
						원
					</div>
				</c:otherwise>
			</c:choose>

			<div class="buttons">
				<button class="payment">결제하기</button>
				<button type="button" class="backBtn" onclick="history.back()">뒤로가기</button>
			</div>
		</form>
	</div>

</body>
<script>
	let photoIdx = 0;
	let photoCount = $(".room_img img").length;

	if (photoCount <= 1) {
		$(".leftBtn").hide();
		$(".rightBtn").hide();
	}

	$(".rightBtn").on("click", function() {
		photoIdx = photoIdx + 1;
		if (photoIdx > photoCount - 1) {
			photoIdx = 0;
		}
		moveSlide();
	});

	$(".leftBtn").on("click", function() {
		photoIdx = photoIdx - 1;
		if (photoIdx < 0) {
			photoIdx = photoCount - 1;
		}
		moveSlide();
	});

	function moveSlide() {
		$(".room_img").css("transform",
				"translateX(-" + (photoIdx * 100) + "%)");
	}
	
	let isEmptyData = ${empty checkIn or empty checkOut or empty adult or empty child or empty total_price ? 'true' : 'false'};

	$("form").on("submit", function(e) {
		if (isEmptyData) {
			e.preventDefault();
			alert("날짜와 인원을 먼저 선택해 주세요.");
			location.href = "/reservation/list?cpage=1";
		}
	});
</script>

</html>