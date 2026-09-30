<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reserve</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
<style>
* {
	box-sizing: border-box;
}

/* ===== 기본 ===== */
body {
	margin: 0;
	font-family: "Malgun Gothic", "맑은 고딕", sans-serif;
	color: #1a1a1f;
	background: #f4f5f7;
}

.container {
	background: #fff;
}

/* 전체를 감싼 form — 상자를 없애 레이아웃에 끼어들지 않게 */
.search_bar {
	display: contents;
}

/* ===== 헤더 ===== */
.header {
	width: 100%;
}

.header>.title {
	padding: 18px 24px 12px;
	border-bottom: 1px solid #d9d9d9;
}

.header>.title h1 {
	margin: 0;
	font-size: 26px;
	font-weight: 800;
	letter-spacing: -0.02em;
}

.header>.menu {
	height: 58px;
	padding: 0 20px;
	display: flex;
	align-items: center;
	gap: 20px;
	border-bottom: 1px solid #d9d9d9;
	background: #fff;
}

.header>.menu img {
	height: 34px;
	width: auto;
	object-fit: contain;
	flex-shrink: 0;
}

.menu>.nav {
	flex: 1;
	display: flex;
	justify-content: center;
	gap: 30px;
}

.menu>.nav a {
	font-size: 14px;
	color: #33363c;
	text-decoration: none;
	white-space: nowrap;
}

.menu>.nav a:hover {
	color: #FF6B35;
}

/* ===== 상단 안내 ===== */
.body1 {
	padding: 40px 24px 28px;
	text-align: center;
	border-bottom: 1px solid #eef0f2;
}

.body_title h1 {
	margin: 0 0 10px;
	font-size: 24px;
	font-weight: 800;
}

.body_contents p {
	margin: 0 0 6px;
	font-size: 14px;
	color: #6b6f76;
}

.body_contents a {
	font-size: 13px;
	font-weight: 600;
	color: #FF6B35;
}

/* ===== 검색바 ===== */
.body_select {
	max-width: 900px;
	margin: 24px auto 0;
	display: flex;
	align-items: stretch;
	min-height: 64px;
	border: 1px solid #1a1a1f;
	border-radius: 6px;
	background: #fff;
	overflow: hidden;
	text-align: left;
}

/* 빈 칸 숨김 */
.body_select>div:empty {
	display: none;
}

/* 여행지 · 체크인 · 체크아웃 */
.body_select>.sb_1, .body_select>.sb_2, .body_select>.sb_3 {
	flex: 1;
	min-width: 0;
	padding: 12px 16px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	gap: 5px;
	border-right: 1px solid #e3e6ea;
}

.body_select label {
	font-size: 11px;
	font-weight: 700;
	color: #9a9aa0;
}

.body_select select, .body_select input[type=date] {
	width: 100%;
	border: 0;
	outline: 0;
	background: transparent;
	font-family: inherit;
	font-size: 14px;
	font-weight: 600;
	color: #1a1a1f;
	cursor: pointer;
}

/* 인원 — 칸 밖에 흩어진 요소들 */
.body_select>label {
	align-self: center;
	padding-left: 16px;
}

.body_select>span {
	align-self: center;
	margin-left: 8px;
	font-size: 12px;
	color: #45484f;
}

.body_select>input[type=number] {
	align-self: center;
	width: 46px;
	margin-left: 4px;
	padding: 3px 4px;
	border: 1px solid #e3e6ea;
	border-radius: 3px;
	font-family: inherit;
	font-size: 13px;
	text-align: center;
}

/* 검색 버튼 */
.body_select>.sb_4 {
	margin-left: auto;
	display: flex;
	align-items: stretch;
	padding: 0;
	border: 0;
}

.body_select>.sb_4 button {
	width: 112px;
	border: 0;
	background: #1a1a1f;
	font-family: inherit;
	font-size: 15px;
	font-weight: 700;
	color: #fff;
	cursor: pointer;
}

.body_select>.sb_4 button:hover {
	background: #33363c;
}

/* ===== 본문 2단 ===== */
.body2 {
	max-width: 1100px;
	margin: 0 auto;
	padding: 26px 24px 50px;
	display: flex;
	align-items: flex-start;
	gap: 22px;
}

/* --- 왼쪽 필터 --- */
.filter {
	width: 236px;
	flex-shrink: 0;
	padding: 20px 18px;
	border: 1px solid #e3e6ea;
	border-radius: 8px;
	background: #fff;
}

.filter-group {
	display: grid;
	grid-template-columns: auto 1fr;
	align-items: center;
	gap: 9px 8px;
	margin-bottom: 22px;
	font-size: 13px;
	color: #45484f;
}

.filter-group>h4 {
	grid-column: 1/-1;
	margin: 0 0 2px;
	font-size: 13px;
	font-weight: 700;
}

.filter-group>div {
	grid-column: 1/-1;
}

.filter-group input[type=checkbox], .filter-group input[type=radio] {
	width: 14px;
	height: 14px;
	margin: 0;
	accent-color: #1a1a1f;
	cursor: pointer;
}

.price-range {
	padding-top: 2px;
}

.price-range input[type=range] {
	width: 100%;
	margin: 0;
	accent-color: #1a1a1f;
}

.price-range #maxPriceText {
	margin: 8px 0 0;
	font-size: 13px;
	font-weight: 700;
	color: #1a1a1f;
	text-align: center;
}

.reset {
	width: 100%;
	height: 38px;
	border: 1px solid #ddd;
	border-radius: 4px;
	background: #fff;
	font-family: inherit;
	font-size: 13px;
	color: #45484f;
	cursor: pointer;
}

.reset:hover {
	background: #f6f7f8;
}

.filter .reset[type=submit] {
	margin-bottom: 8px;
	border-color: #1a1a1f;
	background: #1a1a1f;
	color: #fff;
}

.filter .reset[type=submit]:hover {
	background: #33363c;
}

/* --- 오른쪽 목록 --- */
.room_select {
	flex: 1;
	min-width: 0;
}

.room_buttons {
	display: flex;
	gap: 6px;
	margin-bottom: 14px;
}

.room_buttons button {
	padding: 7px 16px;
	border: 1px solid #ddd;
	border-radius: 20px;
	background: #fff;
	font-family: inherit;
	font-size: 13px;
	color: #45484f;
	cursor: pointer;
}

.room_buttons button:first-child {
	background: #1a1a1f;
	border-color: #1a1a1f;
	color: #fff;
}

.room_buttons button:hover {
	border-color: #1a1a1f;
}

/* 카드 목록 */
.room_list {
	display: flex;
	flex-direction: column;
	gap: 14px;
}

.room_card {
	display: flex;
	align-items: stretch;
	border: 1px solid #e3e6ea;
	border-radius: 8px;
	background: #fff;
	overflow: hidden;
}

.room_card:hover {
	border-color: #b9bec5;
	box-shadow: 0 2px 10px rgba(0, 0, 0, .05);
}

.room_img {
	width: 180px;
	min-height: 150px;
	flex-shrink: 0;
	position: relative;
	background: linear-gradient(135deg, #eef1f5, #e2e7ee);
	border-right: 1px solid #eef0f2;
}

.room_img::after {
	content: "GOTT";
	position: absolute;
	inset: 0;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 15px;
	font-weight: 800;
	letter-spacing: .08em;
	color: #c3cad4;
}

.room_img img {
	position: relative;
	z-index: 1;
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

.room_img img[src=""] {
	display: none;
}

.room_info {
	flex: 1;
	padding: 16px 18px;
	min-width: 0;
}

.room_info .type {
	margin: 0 0 4px;
	font-size: 11px;
	color: #9a9aa0;
}

.room_info .addr {
	margin: 0;
	font-size: 15px;
	font-weight: 700;
	color: #1a1a1f;
}

.room_info .tags {
	display: flex;
	flex-wrap: wrap;
	gap: 5px;
	margin-top: 12px;
}

.room_info .tags span {
	padding: 3px 9px;
	border: 1px solid #e8eaed;
	border-radius: 3px;
	font-size: 11px;
	color: #6b6f76;
}

.room_price {
	width: 160px;
	flex-shrink: 0;
	padding: 16px;
	display: flex;
	flex-direction: column;
	align-items: flex-end;
	justify-content: center;
	border-left: 1px solid #eef0f2;
	font-size: 15px;
	font-weight: 700;
	color: #1a1a1f;
	text-align: right;
}

/* 결과 없음 */
.room_empty {
	padding: 60px 20px;
	border: 1px dashed #dfe3e8;
	border-radius: 8px;
	font-size: 14px;
	color: #9a9aa0;
	text-align: center;
}

/* ===== 푸터 ===== */
.footer {
	padding: 22px 24px;
	border-top: 1px solid #e3e6ea;
	background: #fafbfc;
	font-size: 12px;
	line-height: 1.7;
	color: #9a9aa0;
	text-align: center;
}

.footer p {
	margin: 0;
}

a {
	text-decoration: none;
	color: inherit;
}
</style>
</head>
<body>
	<div class="container">
		<div class="header">
			<div class="title">
				<h1>숙박업소 예약</h1>
			</div>
			<div class="menu">
				<img src="/images/logo.png">
				<nav class="nav">
					<a href="#">이벤트</a> <a href="#">지역</a> <a href="#">추천여행지</a> <a
						href="#">숙박업소</a> <a href="#">리뷰</a> <a href="#">여행플래너</a> <a
						href="#">공지사항</a>
				</nav>
			</div>
		</div>
		<form class="search_bar" action="/reservation/search">
			<div class="body1">
				<div class="body_title">
					<h1>숙박업소 예약하기</h1>
				</div>
				<div class="body_contents">
					<p>지금 가장 인기 있는 숙박업소를 찾아 바로 예약해보세요.</p>
					<a href="#">숙소를 일정에 담아 플래너로 이동</a>
				</div>
				<div class="body_select">

					<div class="sb_1">
						<label for="region">여행지</label> <select id="region" name="region">
							<option value="">전체</option>
							<option value="서울특별시">서울특별시</option>
							<option value="부산광역시">부산광역시</option>
							<option value="대구광역시">대구광역시</option>
							<option value="인천광역시">인천광역시</option>
							<option value="대전광역시">대전광역시</option>
							<option value="울산광역시">울산광역시</option>
							<option value="세종특별자치시">세종특별자치시</option>
							<option value="경기도">경기도</option>
							<option value="강원특별자치도">강원특별자치도</option>
							<option value="충청북도">충청북도</option>
							<option value="충청남도">충청남도</option>
							<option value="전북특별자치도">전북특별자치도</option>
							<option value="전남광주통합특별시">전남광주통합특별시</option>
							<option value="경상북도">경상북도</option>
							<option value="경상남도">경상남도</option>
							<option value="제주특별자치도">제주특별자치도</option>
						</select>
					</div>
					<div class="sb_2">
						<label for="checkIn">체크인</label> <input type="date" id="checkIn"
							name="checkIn">
					</div>
					<div class="sb_3">
						<label for="checkOut">체크아웃</label> <input type="date"
							id="checkOut" name="checkOut">
					</div>
					<div class="sb_4"></div>
					<label>인원</label> <span>성인</span> <input type="number" name="adult"
						id="adult" min="1" max="10" value="2"> <span>아동</span> <input
						type="number" name="child" id="child" min="0" max="10" value="0">
					<div class="sb_5">
						<button>검색</button>
					</div>


				</div>
			</div>
			<div class="body2">
				<div class="filter">
					<div class="filter-group">
						<h4>1박 가격</h4>
						<div class="price-range">
							<input type="range" id="maxPrice" name="maxPrice" min="50000"
								max="300000" step="10000" value="180000">
							<p id="maxPriceText"></p>
						</div>
					</div>
					<div class="filter-group">
						<h4>편의 시설</h4>
						<input type="checkbox" class="amenity" name="amenity" value="에어컨">에어컨
						<input type="checkbox" class="amenity" name="amenity" value="인터넷">인터넷
						<input type="checkbox" class="amenity" name="amenity" value="취사">취사
						가능 <input type="checkbox" class="amenity" name="amenity"
							value="냉장고">냉장고 <input type="checkbox" class="amenity"
							name="amenity" value="PC">PC
					</div>
					<button type="submit" class="reset">필터 적용</button>
					<button type="reset" class="reset">필터 초기화</button>

				</div>

				<div class="room_list">
					<c:forEach var="i" items="${roomList}">
						<a class="room_card"
							href="/reservation/room_detail?placeId=${i.place_id}">
							<div class="room_img">
								<img src="${i.room_img}">
							</div>
							<div class="room_info">
								<p class="type">${i.intro}</p>
								<p class="addr">${i.name}</p>
								<div class="tags">
									<c:forEach var="j" items="${i.amenities}">
										<span>${j}</span>
									</c:forEach>
								</div>
							</div>

							<div class="room_price">
								<c:choose>
									<c:when test="${i.min_price != null}">
										<fmt:formatNumber value="${i.min_price}" pattern="#,###" />
								원 ~</c:when>
									<c:otherwise>
								가격은 해당 숙소에 문의하여 주시기 바랍니다.
							</c:otherwise>
								</c:choose>
							</div>
						</a>
					</c:forEach>
				</div>


			</div>
		</form>
		<div class="footer">
			<p>Copyright 2026 여행사이트 - GOTT go to travel-</p>
			<p>회사명: GOTT | 대표: 이승조라 | 사업자등특번호: 000-00-00000</p>
			<p>이용약관 | 개인정보처리방침 | 고객센터</p>
		</div>

	</div>

	<script>
		let maxPrice = $("#maxPrice");
		let maxPriceText = $("#maxPriceText");

		maxPrice.on("input", function() {
			let price = Number(maxPrice.val());
			maxPriceText.text(price);
		});

		$("#region").val("${param.region}");
		$("#checkIn").val("${param.checkIn}");
		$("#checkOut").val("${param.checkOut}");
		if ("${param.adult}" !== "")
			$("#adult").val("${param.adult}");
		if ("${param.child}" !== "")
			$("#child").val("${param.child}");

		<c:forEach var="i" items="${paramValues.amenity}">
		$(".amenity[value='${i}']").prop("checked", true);
		</c:forEach>
	</script>
</body>
</html>