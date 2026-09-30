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
}

.container {
	max-width: 1000px;
	margin: 0 auto;
	background: #fff;
	padding: 30px 24px;
}
.room_img {
	display: flex;
	gap: 4px;
	overflow-x: auto;
	padding-bottom: 4px;
}

.room_img img {
	width: 200px;
	height: 150px;
	object-fit: cover;
	flex-shrink: 0;
	border-radius: 4px;
	display: block;
}

.no_img {
	width: 200px;
	height: 150px;
	display: flex;
	align-items: center;
	justify-content: center;
	background: #eef1f5;
	border-radius: 4px;
	font-size: 12px;
	color: #9a9aa0;
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
				<a class="room_card" href="#">
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
						<p class="roomCount">${i.roomCount}</p>
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
			</c:forEach>
		</div>
		<div class="footer"></div>
	</div>
</body>
</html>