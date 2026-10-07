<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="/css/public.css">

<title>GOTT 게시글</title>

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

/* 게시글 */

.contentsBox {
    width: 900px;
    margin: 35px auto 0;
    border: 1px solid #ddd;
    border-radius: 7px;
    background: white;
    overflow: hidden;
}

/* 게시글 제목 */

.contentsTitle {
    padding: 25px 30px 18px;
    border-bottom: 1px solid #eee;
}

.contentsTitle h3 {
    margin: 0 0 10px;
    font-size: 20px;
    color: #222;
}

/* 작성자 정보 */

.contentsInfo {
    display: flex;
    gap: 15px;
    color: #888;
    font-size: 11px;
}

.contentsInfo span {
    padding-right: 15px;
    border-right: 1px solid #ddd;
}

.contentsInfo span:last-child {
    border-right: 0;
}

/* 내용 */

.contents {
    min-height: 300px;
    padding: 30px;
    color: #444;
    font-size: 13px;
    white-space: pre-wrap;
}

/* 버튼 */

.buttonBox {
    display: flex;
    justify-content: center;
    gap: 8px;
    padding: 20px 30px;
    border-top: 1px solid #eee;
}

.buttonBox button {
    height: 35px;
    padding: 0 20px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background: white;
    color: #555;
    font-size: 11px;
    cursor: pointer;
}

.buttonBox button:hover {
    background: #222;
    color: white;
    border-color: #222;
}

.fileBox {
    padding: 15px 30px;
    border-top: 1px solid #eee;
    border-bottom: 1px solid #eee;
    background: #fafafa;
}

.fileTitle {
    margin-bottom: 8px;
    font-size: 11px;
    font-weight: 600;
    color: #777;
}

.fileList {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.fileList a {
    display: inline-block;
    padding: 7px 10px;
    border: 1px solid #e5e5e5;
    border-radius: 4px;
    background: white;
    color: #555;
    font-size: 11px;
}

.fileList a:hover {
    background: #f1f1f1;
    color: #222;
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

        홈 &nbsp;>&nbsp; 자유게시판 &nbsp;>&nbsp;

        <span>게시글</span>

    </div>


    <!-- 게시글 -->

    <div class="contentsBox">

        <!-- 제목 -->

        <div class="contentsTitle">

            <h3>${boardContent.title}</h3>

            <div class="contentsInfo">

                <span>작성자 ${boardContent.writer}</span>

                <span>조회수 ${boardContent.view_count}</span>

                <span>
                    ${boardContent.write_date.toString().substring(0, 10)}<br>
                </span>
              
            </div>

        </div>
        
        <!-- 첨부파일 -->

<c:if test="${not empty flist}">

    <div class="fileBox">

        <div class="fileTitle">
            첨부파일
        </div>

        <div class="fileList">

            <c:forEach var="i" items="${flist}">

                <a href="/board/download?oriname=${i.oriname}&sysname=${i.sysname}">
                    ${i.oriname}
                </a>

            </c:forEach>

        </div>

    </div>

</c:if>

       <!-- 내용 -->

        <div class="contents">

            ${boardContent.contents}

        </div>


        <!-- 버튼 -->

        <div class="buttonBox">

            <button onclick="location.href='/board/freeBoard'">
                목록
            </button>

        </div>

    </div>

</div>

</body>
</html>