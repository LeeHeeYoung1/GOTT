<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<title>GOTT Q&A 게시판</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>

<style>
* {
    box-sizing: border-box;
}

.main {
    width: 1200px;
    max-width: calc(100% - 40px);
    margin: 0 auto;
    padding-bottom: 80px;
}

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

.freeBoardContentsBox {
    width: 900px;
    margin: 0 auto;
    border: 1px solid #ddd;
    border-radius: 7px;
    background: white;
    position: relative;
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

.number {
    width: 70px;
}

.title {
    width: auto;
    text-align: left !important;
}

.writer {
    width: 120px;
}

.date {
    width: 120px;
}

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

.freeBoardTable tr:hover {
    background: #fafafa;
}

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

#navigation a.current {
    background: #222;
    border-color: #222;
    color: white;
    font-weight: bold;
}

.btnbox {
    margin-top: 25px;
    padding-bottom: 30px;
    position: absolute;
    right: 20px;
    bottom: -10px;
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

<div class="main">

    <div class="titleBox">
        <h2>고객센터</h2>
        <h5>궁금한 점이나 도움이 필요한 내용을 질문해 주세요.</h5>
    </div>

    <div class="breadcrumb">
        홈 &nbsp;>&nbsp; 문의사항 &nbsp;>&nbsp; <span>Q&A</span>
    </div>

    <nav class="tabs">
        <a href="/notice/qna" class="on">Q&A</a>
        <a href="/notice/faq">FAQ</a>
    </nav>

    <div class="searchArea">
        <form>
            <input class="searchInput" type="text"
                placeholder="질문 제목 또는 내용 검색">
            <button type="button" class="searchBtn">🔍</button>
        </form>
    </div>

    <div class="searchOption">
        <div class="totalCount">총 <strong>0</strong>건</div>
        <button type="button" id="writeBtn">질문하기</button>
    </div>

    <div class="freeBoardContentsBox">

        <table class="freeBoardTable">
            <tr>
                <th class="number">번호</th>
                <th class="title">질문 제목</th>
                <th class="writer">작성자</th>
                <th class="date">작성일</th>
            </tr>
            <tr>
                <td colspan="4">등록된 질문이 없습니다.</td>
            </tr>
        </table>

        <div id="navigation"></div>

        <div class="btnbox">
            <button type="button" id="home">HOME</button>
        </div>

    </div>

</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>