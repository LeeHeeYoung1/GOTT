<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/public.css">

<title>GOTT 자유게시판</title>

<script
  src="https://code.jquery.com/jquery-3.7.1.js"
  integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
  crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.3.1/css/all.min.css">

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
    background: #222;
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

#writeBtn {
    height: 32px;
    margin-left: 6px;
    padding: 0 15px;
    border: 1px solid #222;
    border-radius: 4px;
    background: #222;
    color: white;
    font-size: 11px;
}


/* 게시글 목록 */

.freeBoardContentsBox {
    width: 900px;
    margin: 0 auto;
    border: 1px solid #ddd;
    border-radius: 7px;
    background: white;
    position : relative;
    padding-bottom: 50px;
}

.freeBoardTable {
    width: 100%;
    border-collapse: collapse;
}

.freeBoardTable th {
    height: 45px;
    background: #f7f7f7;
    border-bottom: 1px solid #ddd;
    color: #555;
    font-size: 12px;
    font-weight: 600;
    text-align: center;
}

.freeBoardTable td {
    height: 48px;
    padding: 0 10px;
    border-bottom: 1px solid #eee;
    color: #555;
    font-size: 12px;
    text-align: center;
}

.freeBoardTable tr:last-child td {
    border-bottom: 0;
}


/* 각 열 크기 */

.number {
    width: 70px;
}

.title {
    width: auto;
    text-align: left !important;
}

.file {
    width: 90px;
}

.writer {
    width: 100px;
}

.view {
    width: 70px;
}

.date {
    width: 100px;
}


/* 제목 */

.title a {
    display: block;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    color: #333;
}

.title a:hover {
    text-decoration: underline;
}


/* 게시글 마우스 올렸을 때 */

.freeBoardTable tr:hover {
    background: #fafafa;
}


/* 페이지네이션 */

#navigation {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
    margin-top: 25px;
    padding-bottom: 5px;
}

#navigation a {
    min-width: 34px;
    height: 34px;
    padding: 0 10px;
    display: flex;
    justify-content: center;
    align-items: center;

    border: 1px solid #ddd;
    border-radius: 5px;

    background: white;
    color: #555;

    font-size: 12px;

    transition: 0.2s;
}

#navigation a:hover {
    background: #222;
    border-color: #222;
    color: white;
}


/* 현재 페이지 */

#navigation a.current {
    background: #222;
    border-color: #222;
    color: white;
    font-weight: bold;
}


/* HOME 버튼 */

.btnbox {
    margin-top: 25px;
    padding-bottom: 30px;
    position : absolute;
    right : 20px;
    bottom : -10px;
}

#home {
    height: 34px;
    padding: 0 18px;
	
    border: 1px solid #222;
    border-radius: 5px;

    background: #222;
    color: white;

    font-size: 12px;
}

#home:hover {
    background: #444;
}

</style>

</head>

<body>


<!-- 상단바 -->

<div class="headercontainer">

    <div class="logoBox">
        <a href="/">
            <img src="/images/logo.png" alt="GOTT 로고">
        </a>
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


<!-- 메인 -->

<div class="main">

    <div class="titleBox">
        <h2>게시판</h2>
        <h5>
            여행후기, 맛집, 관광지, 액티비티, 꿀팁까지 자유롭게 나눠보세요.
        </h5>
    </div>


    <div class="breadcrumb">
        홈 &nbsp;>&nbsp; <span>자유게시판</span>
    </div>


    <nav class="tabs">
        <a href="/board/freeBoard?cpage=1" class="on">
            자유게시판
        </a>

        <a href="/board/reviewBoard">
            리뷰게시판
        </a>
    </nav>


    <!-- 검색 -->

    <div class="searchArea">

        <input
            class="searchInput"
            type="text"
            placeholder="자유게시판 글 제목 + 내용 검색">

        <button class="searchBtn">🔍</button>

    </div>


    <!-- 게시판 정보 -->

    <div class="searchOption">

        <div class="totalCount">
            총 <strong>${boardCount}</strong>건
        </div>

        <select class="sort">
            <option>최신순</option>
            <option>조회순</option>
            <option>추천순</option>
            <option>댓글순</option>
        </select>

        <button id="writeBtn">글쓰기</button>

        <script>
            let writeBtn = document.getElementById("writeBtn");

            writeBtn.onclick = function() {
                location.href = "/board/boardWrite";
            };
        </script>

    </div>


    <!-- 게시글 목록 -->

    <div class="freeBoardContentsBox">

        <table class="freeBoardTable">

            <tr>
                <th class="number">번호</th>
                <th class="title">제목</th>
                <th class="file">첨부파일</th>
                <th class="writer">작성자</th>
                <th class="view">조회수</th>
                <th class="date">작성일</th>
            </tr>


            <c:forEach var="i" items="${boardList}">

                <tr>

                    <td class="number">
                        ${i.seq}
                    </td>

                    <td class="title">
                        <a href="/board/boardContent?seq=${i.seq}">
                            ${i.title}
                        </a>
                    </td>

                    <td class="file">
					<c:if test="${fileList.contains(i.seq)}"><i class="fa-solid fa-paperclip"></i></c:if>                       
                    </td>

                    <td class="writer">
                        ${i.writer}
                    </td>

                    <td class="view">
                        ${i.view_count}
                    </td>

                    <td class="date">
                        ${i.write_date.toString().substring(0, 10)}
                    </td>

                </tr>

            </c:forEach>

        </table>


        <!-- 페이지네이션 -->

        <div id="navigation"></div>


        <!-- HOME 버튼 -->

        <div class="btnbox">
            <button id="home">HOME</button>
        </div>

    </div>

</div>


<script>

document.getElementById("home").onclick = function() {
    location.href = "/";
};

let recordTotalCount = ${recordTotalCount};
let recordCountPerpage = ${recordCountPerPage};
let naviCountPerpage = ${naviCountPerpage};
let currentPage = ${cpage};


let pageTotalCount =
    Math.ceil(recordTotalCount / recordCountPerpage);

let startNavi =
    Math.floor((currentPage - 1) / naviCountPerpage)
    * naviCountPerpage + 1;

let endNavi =
    startNavi + naviCountPerpage - 1;

if(endNavi > pageTotalCount) {
    endNavi = pageTotalCount;
}

let needPrev = startNavi > 1;
let needNext = endNavi < pageTotalCount;
let navi = document.getElementById("navigation");

if(needPrev) {

    let prev = document.createElement("a");
	prev.setAttribute("href", "/board/freeBoard?cpage=" + (startNavi - 1));
	prev.innerHTML = "<";
	 navi.append(prev);
}

for(let i = startNavi; i <= endNavi; i++) {

    let num = document.createElement("a");
	num.setAttribute(
    "href", "/board/freeBoard?cpage=" + i);
	num.innerHTML = i;

    if(i == currentPage) {
        num.className = "current";
    }
	navi.append(num);
}

if(needNext) {

    let next = document.createElement("a");
	next.setAttribute("href", "/board/freeBoard?cpage=" + (endNavi + 1));
	next.innerHTML = ">";
	navi.append(next);
}

</script>


</body>
</html>
