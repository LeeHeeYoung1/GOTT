<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<style>
* {
	box-sizing: border-box;
}

a {
	color: inherit;
	text-decoration: none;
}

button {
	border: 1px solid #d5d5d5;
	background-color: white;
	cursor: pointer;
}

button:hover {
	background-color: #222;
	color: white;
	border-color: #222;
}

/* 메인 */
.main {
	width: 1200px;
	max-width: calc(100% - 40px);
	margin: 0 auto;
	padding-bottom: 80px;
}

/* 제목 */
.titleBox {
	text-align: center;
	padding: 35px 0 20px;
}

.titleBox h2 {
	margin: 0 0 5px;
	font-size: 25px;
	color: #222;
}

.titleBox h5 {
	margin: 0;
	font-size: 12px;
	font-weight: 400;
	color: #888;
}

/* 경로 */
.breadcrumb {
	margin: 0 100px;
	padding: 10px 0;
	font-size: 10px;
	color: #999;
	border-top: 1px solid #eee;
}

.breadcrumb span {
	color: #333;
	font-weight: 600;
}

/* 탭 */
.tabs {
	display: flex;
	margin: 10px 100px 0;
	border-bottom: 1px solid #222;
}

.tabs a {
	min-width: 120px;
	padding: 9px 18px;
	text-align: center;
	border: 1px solid #ddd;
	border-bottom: 0;
	background: white;
	color: #777;
	font-size: 12px;
}

.tabs a.on {
	background: #222;
	border-color: #222;
	color: white;
}

/* 검색 */
.searchArea {
	width: 650px;
	max-width: 100%;
	margin: 25px auto 18px;
	position: relative;
}

.searchInput {
	width: 100%;
	height: 42px;
	padding: 0 45px 0 15px;
	border: 1px solid #ccc;
	border-radius: 7px;
	background: white;
	font-size: 12px;
	outline: none;
}

.searchInput:focus {
	border-color: #555;
}

.searchBtn {
	position: absolute;
	right: 5px;
	top: 4px;
	width: 34px;
	height: 34px;
	border: 0;
	border-radius: 5px;
	color: white;
}

/* 카테고리 */
.categoryArea {
	display: flex;
	justify-content: center;
	flex-wrap: wrap;
	gap: 5px;
	margin-bottom: 25px;
}

.reviewType {
	padding: 6px 12px;
	border: 1px solid #ddd;
	border-radius: 18px;
	background: white;
	color: #666;
	font-size: 11px;
}

.reviewType.on {
	background: #222;
	border-color: #222;
	color: white;
}

/* 게시판 정보 */
.searchOption {
	width: 900px;
	max-width: 100%;
	margin: 0 auto 12px;
	display: flex;
	align-items: center;
	font-size: 11px;
	color: #777;
}

.totalCount {
	margin-right: auto;
}

.sort {
	height: 32px;
	padding: 0 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
	background: white;
	color: #555;
	font-size: 11px;
}

.writeBtn {
	height: 32px;
	margin-left: 6px;
	padding: 0 15px;
	border: 1px solid #222;
	border-radius: 4px;
	background: #222;
	color: white;
	font-size: 11px;
}

/* ===== 리뷰 카드 ===== */
.reviewList {
	width: 900px;
	max-width: 100%;
	margin: 0 auto;
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 18px;
}

/* 카드를 감싼 a — grid 칸을 꽉 채우게 */
.reviewList>a {
	display: flex;
	min-width: 0;
}

.reviewCard {
	flex: 1;
	min-width: 0;
	display: flex;
	flex-direction: column;
	border: 1px solid rgba(255, 255, 255, 0.15);
	border-radius: 12px;
	background: rgba(0, 0, 0, 0.78);
	overflow: hidden;
	cursor: pointer;
	transition: transform .18s, box-shadow .18s, border-color .18s;
}

.reviewCard:hover {
	transform: translateY(-3px);
	border-color: rgba(255, 255, 255, 0.35);
	box-shadow: 0 8px 22px rgba(0, 0, 0, .18);
}

/* --- 사진 --- */
.reviewCard>img {
	width: 100%;
	height: 230px;
	object-fit: cover;
	object-position: center;
	display: block;
	flex-shrink: 0;
	background: #2a2a2a;
	transition: transform .35s ease;
}

.reviewCard:hover>img {
	transform: scale(1.04);
}

/* --- 본문 — 항상 3줄 높이 --- */
.reviewContents {
	position: relative;
	flex-shrink: 0;
	padding: 14px 16px 0;
	height: calc(1.65em * 3 + 14px);
	overflow: hidden;
	font-size: 13px;
	line-height: 1.65;
	color: #f0f0f0;
	word-break: break-all;
}

/* summernote 가 넣은 태그 정리 */
.reviewContents p {
	margin: 0;
}

.reviewContents img, .reviewContents video, .reviewContents iframe {
	display: none;
}

.reviewContents * {
	font-size: 13px !important;
	line-height: 1.65 !important;
	color: #f0f0f0 !important;
	background: transparent !important;
}

/* --- 날짜 --- */
.reviewDate {
	margin-top: auto;
	padding: 10px 16px 14px;
	font-size: 11px;
	color: rgba(255, 255, 255, 0.5);
	text-align: right;
	letter-spacing: .02em;
}

.reviewDate p {
	margin: 0;
}

/* ===== 페이지네이션 ===== */
#navi {
	width: 900px;
	max-width: 100%;
	margin: 28px auto 0;
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	align-items: center;
	gap: 6px;
}

#navi a {
	min-width: 34px;
	height: 34px;
	padding: 0 10px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	border: 1px solid #ddd;
	border-radius: 6px;
	background: white;
	font-size: 12px;
	font-weight: 600;
	color: #777;
	text-decoration: none;
	transition: background .15s, border-color .15s, color .15s;
}

#navi a:hover {
	border-color: #222;
	color: #222;
}

#navi a.on {
	background: #222;
	border-color: #222;
	color: white;
}
</style>

<!-- 메인 -->

<div class="main">

	<div class="titleBox">
		<h2>게시판</h2>
		<h5>여행후기, 맛집, 관광지, 액티비티, 꿀팁까지 자유롭게 나눠보세요.</h5>
	</div>

	<div class="breadcrumb">
		홈 &nbsp;>&nbsp; <span>리뷰게시판</span>
	</div>

	<nav class="tabs">
		<a href="/board/freeBoard?cpage=1">자유게시판</a> <a
			href="/review/reviewBoard?cpage=1" class="on">리뷰게시판</a>
	</nav>

	<!-- 검색 -->

	<div class="searchArea">

		<input class="searchInput" type="text" placeholder="리뷰 제목 + 내용 검색">

		<button class="searchBtn">🔍</button>

	</div>

	<!-- 카테고리 -->

	<div class="categoryArea">

		<button class="reviewType on">전체</button>
		<button class="reviewType">여행지 정보</button>
		<button class="reviewType">관광지</button>
		<button class="reviewType">맛집</button>
		<button class="reviewType">카페</button>
		<button class="reviewType">액티비티</button>
		<button class="reviewType">숙소</button>
		<button class="reviewType">여행후기</button>
		<button class="reviewType">여행 일정 공유</button>
		<button class="reviewType">여행 꿀팁</button>
		<button class="reviewType">기타</button>

	</div>

	<!-- 게시판 정보 -->

	<div class="searchOption">

		<div class="totalCount">
			총 <strong>${recordTotalCount}</strong>건
		</div>

		<select class="sort">
			<option>최신순</option>
			<option>조회순</option>
			<option>추천순</option>
			<option>댓글순</option>
		</select>

		<button class="writeBtn" id="writeBtn">글쓰기</button>

	</div>

	<!-- 카드 -->

	<div class="reviewList">

		<c:forEach var="i" items="${rList}">

			<a href="/review/detail?seq=${i.seq}">
				<div class="reviewCard">
					<img src="${i.image1}">
					<div class="reviewContents">${i.contents}</div>
					<div class="reviewDate">
						<p>
							<fmt:formatDate value="${i.reg_date}" pattern="yyyy.MM.dd" />
						</p>
					</div>
				</div>
			</a>
		</c:forEach>
	</div>

	<div class="reviewNavi" id="navi">${navi}</div>
</div>



<script>
	$("#writeBtn").on("click", function() {
		location.href = "/review/review_write";
	})

	let recordTotalCount = ${recordTotalCount};
	let recordCountPerPage = ${recordCountPerPage};
	let naviCountPerPage = ${naviCountPerPage};
	let currentPage = ${cpage};

	let pageTotalCount = Math.ceil(recordTotalCount / recordCountPerPage);

	let startNavi = Math.floor((currentPage - 1) / naviCountPerPage)
			* naviCountPerPage + 1;
	let endNavi = startNavi + naviCountPerPage - 1;

	if (endNavi > pageTotalCount) {
		endNavi = pageTotalCount;
	}

	let needPrev = startNavi > 1;
	let needNext = endNavi < pageTotalCount;

	let navi = document.getElementById("navi");

	if (needPrev) {
		let prev = document.createElement("a");
		prev.setAttribute("href", "/review/reviewBoard?cpage="
				+ (startNavi - 1));
		prev.innerHTML = "<";
		navi.append(prev);
	}
	for (let i = startNavi; i <= endNavi; i++) {
		let num = document.createElement("a");
		num.setAttribute("href", "/review/reviewBoard?cpage=" + i);
		if (i == currentPage) {
			num.setAttribute("class", "on");
		}
		num.innerHTML = i;
		navi.append(num);
	}
	if (needNext) {
		let next = document.createElement("a");
		next.setAttribute("href", "/review/reviewBoard?cpage=" + (endNavi + 1));
		next.innerHTML = ">";
		navi.append(next);
	}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>