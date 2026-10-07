<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<style>
* {
	box-sizing: border-box;
}

body {
	margin: 0;
	padding: 0;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	font-size: 16px;
	line-height: 1.5;
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

/* 상단바 */
.headercontainer {
	width: 1200px;
	max-width: calc(100% - 40px);
	height: 70px;
	margin: 0 auto;
	padding: 0 30px;
	display: flex;
	align-items: center;
}

.logoBox {
	width: 100px;
	height: 40px;
	display: flex;
	justify-content: center;
	align-items: center;
	margin-right: 45px;
}

.logoBox img {
	width: 100%;
	height: 100%;
	object-fit: contain;
}

.nav {
	display: flex;
	gap: 25px;
}

.nav a {
	color: #333;
	font-size: 13px;
	white-space: nowrap;
}

.signBox {
	margin-left: auto;
	display: flex;
	gap: 10px;
}

.signBox a {
	color: #555;
	font-size: 11px;
}

.menu-icon {
	margin-left: 18px;
	font-size: 20px;
	cursor: pointer;
}

hr {
	border: 0;
	border-top: 1px solid #e5e5e5;
	margin: 0;
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

/* 카드 */
.boardList {
	width: 900px;
	margin: 0 auto;
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 18px;
}

.boardCard {
	height: 200px;
	border: 1px solid #ddd;
	border-radius: 8px;
	background: white;
	transition: 0.2s;
}

.boardCard:hover {
	transform: translateY(-2px);
	border-color: #aaa;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.06);
}
</style>

</head>

<body>

	<!-- 상단바 -->

	<div class="headercontainer">

		<div class="logoBox">
			<a href="/"><img src="/images/logo.png" alt="GOTT 로고"></a>
		</div>

		<nav class="nav">
			<a href="#">이벤트</a> <a href="#">지역</a> <a href="#">추천여행지</a> <a
				href="#">숙박업소</a> <a href="#">리뷰</a> <a href="#">여행 플래너</a> <a
				href="#">공지사항</a>
		</nav>

		<div class="signBox">
			<a href="/members/mypage">마이페이지</a> <a href="/members/logout">로그아웃</a>
		</div>

		<div class="menu-icon">☰</div>

	</div>

	<hr>

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
			<a href="/board/freeBoard?cpage=1">자유게시판</a> <a href="/board/reviewBoard"
				class="on">리뷰게시판</a>
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
				총 <strong>120</strong>건
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

		<div class="boardList">

			<div class="boardCard"></div>
			<div class="boardCard"></div>
			<div class="boardCard"></div>

			<div class="boardCard"></div>
			<div class="boardCard"></div>
			<div class="boardCard"></div>

			<div class="boardCard"></div>
			<div class="boardCard"></div>
			<div class="boardCard"></div>

			<div class="boardCard"></div>
			<div class="boardCard"></div>
			<div class="boardCard"></div>

		</div>
	</div>

</body>

<script>
	$("#writeBtn").on("click", function(){
		location.href="/review/review_write";
	})
</script>
</html>