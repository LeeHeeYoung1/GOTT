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
}

.container {
	max-width: 760px;
	margin: 0 auto;
	background: #fff;
	padding: 30px 28px 40px;
	min-height: 100vh;
}

.header {
	font-size: 22px;
	font-weight: 800;
	letter-spacing: -0.02em;
}

hr {
	margin: 16px 0 24px;
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
	margin: 0 auto 22px;
	border-radius: 8px;
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
	width: 44px;
	height: 44px;
	border: 1px solid #ddd;
	border-radius: 50%;
	background: #fff;
	font-size: 0;
	color: #45484f;
	cursor: pointer;
	z-index: 2;
}

.leftBtn::before {
	content: "\2039";
	font-size: 24px;
	line-height: 1;
}

.rightBtn::before {
	content: "\203A";
	font-size: 24px;
	line-height: 1;
}

.leftBtn {
	left: 8px;
}

.rightBtn {
	right: 8px;
}

.leftBtn:hover, .rightBtn:hover {
	border-color: #1a1a1f;
	background: #f6f7f8;
	color: #1a1a1f;
}

/* ===== 객실 정보 ===== */
.room_info {
	padding-bottom: 20px;
	border-bottom: 1px solid #eef0f2;
}

.room_info p {
	margin: 0;
}

.roomName {
	font-size: 20px;
	font-weight: 700;
}

.roomCount {
	margin-top: 6px !important;
	font-size: 13px;
	color: #9a9aa0;
}

.roomAmenity {
	display: flex;
	flex-wrap: wrap;
	gap: 5px;
	margin-top: 12px;
}

.roomAmenity span {
	padding: 3px 9px;
	border: 1px solid #e8eaed;
	border-radius: 3px;
	font-size: 11px;
	color: #6b6f76;
}

/* ===== 가격 ===== */
.room_price {
	padding: 20px 0;
	border-bottom: 1px solid #eef0f2;
	font-size: 18px;
	font-weight: 700;
	text-align: right;
	line-height: 1.6;
}

/* ===== 하단 버튼 ===== */
.buttons {
	display: flex;
	gap: 10px;
	margin-top: 28px;
}

.buttons button {
	flex: 1;
	height: 52px;
	border: 1px solid #1a1a1f;
	border-radius: 6px;
	background: #1a1a1f;
	font-family: inherit;
	font-size: 16px;
	font-weight: 700;
	color: #fff;
	cursor: pointer;
}

.buttons button:hover {
	background: #33363c;
}

.buttons button[type=button] {
	flex: 0 0 140px;
	border-color: #ddd;
	background: #fff;
	color: #45484f;
	font-weight: 500;
}

.buttons button[type=button]:hover {
	background: #f6f7f8;
}
</style>
</head>
<body>
	<div class="container">
		<div class="header">${placeOne.name}</div>
		<hr>
		<form action="/reservation/reserve" method="post">
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
						<div class="no_img">사진 준비중</div>
					</c:if>
				</div>
			</div>

			<button type="button" class="leftBtn">왼쪽버튼</button>
			<button type="button" class="rightBtn">오른쪽버튼</button>


			<div class="room_info">
				<input type="hidden" name="roomId" value="${roomDto.roomId}">
				<p class="roomName">${roomDto.roomName}</p>
				<p class="roomCount">잔여 객실 수 : ${roomDto.roomCount}</p>
				<div class="roomAmenity">
					<c:forEach var="j" items="${roomDto.amenities}">
						<span>${j}</span>
					</c:forEach>
				</div>
			</div>
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
				<c:choose>
					<c:when test="${total_price != null}">
						<fmt:formatNumber value="${total_price}" pattern="#,###" />
								원
					</c:when>
				</c:choose>
			</div>

			<div class="buttons">
				<button type="button" class="payment">결제하기</button>
				<button type="button" class="backBtn">돌아가기</button>
			</div>
		</form>
	</div>

	<script>
		let idx = 0;
		let length = $(".room_img").find("img").length;

		$(".leftBtn").on(
				"click",
				function() {
					if (length < 2)
						return;
					idx = (idx - 1 + length) % length;
					$(".room_img").css("transform",
							"translateX(" + (-idx * 100) + "%)");
				})
		$(".rightBtn").on(
				"click",
				function() {
					if (length < 2)
						return;
					idx = (idx + 1 + length) % length;
					$(".room_img").css("transform",
							"translateX(" + (-idx * 100) + "%)");
				})
		$(".backBtn").on("click", function() {
			history.back();
		})
		
		
		
		$(".payment").on("click", async function() {

    const paymentId = "GOTT-" + crypto.randomUUID();

    const totalAmount = Number("${total_price}");

    try {

        const response = await PortOne.requestPayment({

            storeId: "store-d4a75cb3-13cc-4226-b7fc-33d40089bf40",

            channelKey: "channel-key-6b882be9-c6c2-4429-a3ba-2a04d40b1f0a",

            paymentId: paymentId,

            orderName: "${placeOne.name} ${roomDto.roomName}",

            totalAmount: totalAmount,

            currency: "CURRENCY_KRW",

            payMethod: "CARD",

            customer: {
            	fullName: "테스트",
                phoneNumber: "010-0000-1234",
                email: "test@test.com"
            }
        });

        console.log(response);

        if (response.code != null) {
            alert("결제 실패 : " + response.message);
            return;
        }

        location.href =
            "/reservation/paymentComplete?paymentId="
            + encodeURIComponent(paymentId);

    } catch (error) {

        console.error(error);
        alert("결제 중 오류가 발생했습니다.");

    }

});
	</script>
</body>
</html>