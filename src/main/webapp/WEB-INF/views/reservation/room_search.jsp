<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>


<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
<style>
* {
	box-sizing: border-box;
}

/* ===== 페이지 영역 ===== */
.main {
	padding: 0 24px 0 280px;
}

/* 전체를 감싼 form — 상자를 없애 레이아웃에 끼어들지 않게 */
.search_bar {
	display: contents;
}

/* ===== 상단 안내 ===== */
.body1 {
	padding: 48px 24px 32px;
	text-align: center;
}

.body_title h1 {
	margin: 0 0 10px;
	font-size: 28px;
	font-weight: 800;
	letter-spacing: -0.03em;
}

.body_contents p {
	margin: 0 0 6px;
	font-size: 14px;
	color: #6b6f76;
}

.body_contents a {
	font-size: 13px;
	font-weight: 600;
	color: #2563eb;
}

.body_contents a:hover {
	text-decoration: underline;
}

/* ===== 검색바 ===== */
.body_select {
	max-width: 920px;
	margin: 28px auto 0;
	display: flex;
	align-items: stretch;
	min-height: 68px;
	border: 1px solid #1a1a1f;
	border-radius: 10px;
	background: #fff;
	overflow: hidden;
	text-align: left;
	box-shadow: 0 2px 12px rgba(0, 0, 0, .06);
}

/* 빈 칸 숨김 */
.body_select>div:empty {
	display: none;
}

/* 여행지 · 체크인 · 체크아웃 */
.body_select>.sb_1, .body_select>.sb_2, .body_select>.sb_3 {
	flex: 1;
	min-width: 0;
	padding: 12px 18px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	gap: 4px;
	border-right: 1px solid #e3e6ea;
}

.body_select>.sb_1:hover, .body_select>.sb_2:hover, .body_select>.sb_3:hover
	{
	background: #fafbfc;
}

.body_select label {
	font-size: 11px;
	font-weight: 700;
	color: #9a9aa0;
	letter-spacing: .02em;
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
	padding-left: 18px;
}

.body_select>span {
	align-self: center;
	margin-left: 12px;
	font-size: 12px;
	color: #6b6f76;
}

.body_select>input[type=number] {
	align-self: center;
	width: 48px;
	margin-left: 5px;
	padding: 5px 4px;
	border: 1px solid #e3e6ea;
	border-radius: 4px;
	font-family: inherit;
	font-size: 13px;
	font-weight: 600;
	text-align: center;
}

.body_select>input[type=number]:focus {
	outline: 0;
	border-color: #1a1a1f;
}

/* 검색 버튼 */
.body_select>.sb_5 {
	margin-left: auto;
	display: flex;
	align-items: stretch;
}

.body_select>.sb_5 button {
	width: 120px;
	border: 0;
	background: #1a1a1f;
	font-family: inherit;
	font-size: 15px;
	font-weight: 700;
	color: #fff;
	cursor: pointer;
	transition: background .15s;
}

.body_select>.sb_5 button:hover {
	background: #FF6B35;
}

/* ===== 본문 2단 ===== */
.body2 {
	max-width: 1100px;
	margin: 0 auto;
	padding: 32px 0 60px;
	display: flex;
	align-items: flex-start;
	gap: 24px;
}

/* --- 왼쪽 필터 --- */
.filter {
	position: sticky;
	top: 20px;
	width: 240px;
	flex-shrink: 0;
	padding: 22px 20px;
	border: 1px solid #e5e7eb;
	border-radius: 12px;
	background: #fff;
}

.filter-group {
	display: grid;
	grid-template-columns: auto 1fr;
	align-items: center;
	gap: 10px 8px;
	margin-bottom: 24px;
	font-size: 13px;
	color: #45484f;
}

.filter-group>h4 {
	grid-column: 1/-1;
	margin: 0 0 6px;
	padding-bottom: 8px;
	border-bottom: 1px solid #f0f2f4;
	font-size: 13px;
	font-weight: 700;
	color: #1a1a1f;
}

.filter-group>div {
	grid-column: 1/-1;
}

.filter-group input[type=checkbox] {
	width: 15px;
	height: 15px;
	margin: 0;
	accent-color: #1a1a1f;
	cursor: pointer;
}

.price-range {
	padding-top: 4px;
}

.price-range input[type=range] {
	width: 100%;
	margin: 0;
	accent-color: #1a1a1f;
	cursor: pointer;
}

.price-range #maxPriceText {
	margin: 10px 0 0;
	font-size: 14px;
	font-weight: 700;
	color: #1a1a1f;
	text-align: center;
}

.reset {
	width: 100%;
	height: 40px;
	border: 1px solid #ddd;
	border-radius: 6px;
	background: #fff;
	font-family: inherit;
	font-size: 13px;
	color: #45484f;
	cursor: pointer;
	transition: background .15s, border-color .15s;
}

.reset:hover {
	background: #f6f7f8;
	border-color: #b9bec5;
}

.filter .reset[type=submit] {
	margin-bottom: 8px;
	border-color: #1a1a1f;
	background: #1a1a1f;
	color: #fff;
	font-weight: 700;
}

.filter .reset[type=submit]:hover {
	background: #FF6B35;
	border-color: #FF6B35;
}

/* --- 오른쪽 목록 --- */
.room_list {
	flex: 1;
	min-width: 0;
	display: flex;
	flex-direction: column;
	gap: 14px;
}

.room_card {
	display: flex;
	align-items: stretch;
	border: 1px solid #e5e7eb;
	border-radius: 12px;
	background: #fff;
	overflow: hidden;
	text-decoration: none;
	color: inherit;
	transition: box-shadow .15s, transform .15s, border-color .15s;
}

.room_card:hover {
	border-color: #d4d8dd;
	box-shadow: 0 6px 20px rgba(0, 0, 0, .08);
	transform: translateY(-2px);
}

.room_img {
	width: 200px;
	min-height: 160px;
	flex-shrink: 0;
	position: relative;
	background: linear-gradient(135deg, #eef1f5, #e2e7ee);
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
	padding: 18px 20px;
	min-width: 0;
	display: flex;
	flex-direction: column;
}

.room_info .info {
	margin: 0;
	font-size: 16px;
	font-weight: 700;
	color: #1a1a1f;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.room_info .info+.info {
	margin-top: 5px;
	font-size: 13px;
	font-weight: 400;
	color: #6b6f76;
}

.room_info .tags {
	display: flex;
	flex-wrap: wrap;
	gap: 5px;
	margin-top: auto;
	padding-top: 14px;
}

.room_info .tags span {
	padding: 3px 10px;
	border-radius: 12px;
	background: #f3f4f6;
	font-size: 11px;
	color: #6b6f76;
}

.room_price {
	width: 170px;
	flex-shrink: 0;
	padding: 18px;
	display: flex;
	flex-direction: column;
	align-items: flex-end;
	justify-content: center;
	border-left: 1px solid #f0f2f4;
	font-size: 18px;
	font-weight: 800;
	color: #1a1a1f;
	text-align: right;
	line-height: 1.4;
	letter-spacing: -0.02em;
}

/* 가격 없는 숙소는 작게 */
.room_price:not(:has(*)) {
	font-size: 12px;
	font-weight: 400;
	color: #9a9aa0;
}

/* 결과 없음 */
.room_empty {
	padding: 80px 20px;
	border: 1px dashed #dfe3e8;
	border-radius: 12px;
	font-size: 14px;
	color: #9a9aa0;
	text-align: center;
}

/* ===== 좁은 화면 ===== */
@media ( max-width : 1400px) {
	.main {
		padding-left: 24px;
	}
	.linkbar {
		display: none;
	}
}

@media ( max-width : 860px) {
	.body2 {
		flex-direction: column;
	}
	.filter {
		position: static;
		width: 100%;
	}
	.body_select {
		flex-wrap: wrap;
		min-height: 0;
	}
	.room_card {
		flex-direction: column;
	}
	.room_img {
		width: 100%;
		height: 180px;
	}
	.room_price {
		width: 100%;
		align-items: flex-start;
		border-left: 0;
		border-top: 1px solid #f0f2f4;
		text-align: left;
	}
}
</style>


<div class="main">
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
					<label for="checkOut">체크아웃</label> <input type="date" id="checkOut"
						name="checkOut">
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
						href="/reservation/room_detail?placeId=${i.place_id}&checkIn=${param.checkIn}&checkOut=${param.checkOut}&adult=${param.adult}&child=${param.child}"">
						<div class="room_img">
							<c:choose>
								<c:when test="${not empty i.image_name}">
									<img src="${i.image_name}">
								</c:when>
								<c:otherwise>
									<img src="${i.alter_image}">
								</c:otherwise>
							</c:choose>
						</div>
						<div class="room_info">
							<p class="info">${i.name}</p>
							<p class="info">${i.address}</p>
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

<%@ include file="/WEB-INF/views/common/footer.jsp"%>