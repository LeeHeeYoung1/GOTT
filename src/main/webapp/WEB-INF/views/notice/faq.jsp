
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

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
	text-decoration: none;
}

.tabs a.on {
	background: #222;
	border-color: #222;
	color: white;
}

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
	background: #222;
	color: white;
	cursor: pointer;
}

.searchOption {
	width: 900px;
	max-width: 100%;
	margin: 0 auto 12px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	font-size: 11px;
	color: #777;
}

.totalCount {
	margin-right: auto;
}

.btnbox2 {
	margin-left: auto;
}

#write {
	height: 30px;
	padding: 0 14px;
	border: 1px solid #222;
	border-radius: 5px;
	background: #222;
	color: white;
	font-size: 11px;
	cursor: pointer;
}

#write:hover {
	background: #444;
}

.freeBoardContentsBox {
	width: 900px;
	max-width: 100%;
	margin: 0 auto;
	border: 1px solid #ddd;
	border-radius: 7px;
	background: white;
	position: relative;
	padding-bottom: 65px;
	overflow: hidden;
}

.freeBoardTable {
	width: 100%;
	table-layout: fixed;
	border-collapse: collapse;
}

.freeBoardTable th {
	height: 45px;
	padding: 0 10px;
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

.freeBoardTable .number {
	width: 70px;
}

.freeBoardTable .title {
	width: auto;
	text-align: left;
}

.freeBoardTable .writer {
	width: 130px;
}

.freeBoardTable .date {
	width: 140px;
}

.faqTitle {
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}

.faqWriter {
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}

.freeBoardTable tbody tr:hover {
	background: #fafafa;
}

.emptyMessage {
	height: 100px !important;
	text-align: center !important;
	color: #999 !important;
}

.btnbox {
	position: absolute;
	right: 20px;
	bottom: 15px;
}

#home {
	height: 34px;
	padding: 0 18px;
	border: 1px solid #222;
	border-radius: 5px;
	background: #222;
	color: white;
	font-size: 12px;
	cursor: pointer;
}

#home:hover {
	background: #444;
}

@media ( max-width : 700px) {
	.breadcrumb, .tabs {
		margin-left: 0;
		margin-right: 0;
	}
	.searchOption {
		width: 100%;
	}
	.freeBoardTable .number {
		width: 50px;
	}
	.freeBoardTable .writer {
		width: 80px;
	}
	.freeBoardTable .date {
		width: 100px;
	}
	.freeBoardTable th, .freeBoardTable td {
		padding: 0 5px;
		font-size: 11px;
	}
}
</style>

<div class="main">

	<div class="titleBox">
		<h2>고객센터</h2>
		<h5>자주 묻는 질문을 통해 궁금한 내용을 확인해 보세요.</h5>
	</div>

	<div class="breadcrumb">
		홈 &nbsp;>&nbsp; 문의사항 &nbsp;>&nbsp; <span>FAQ</span>
	</div>

	<nav class="tabs">
		<a href="/notice/qna">Q&A</a> <a href="/notice/faq" class="on">FAQ</a>
	</nav>

	<div class="searchArea">
		<form action="/notice/faq" method="get">
			<input class="searchInput" type="text" name="keyword"
				placeholder="자주 묻는 질문 검색">
			<button type="submit" class="searchBtn">🔍</button>
		</form>
	</div>

	<div class="searchOption">
	
		<div class="totalCount">
			총 <strong>${flist.size()}</strong>건
		</div>
		<c:if test="${loginId == 'admin0001'}">
			<div class="btnbox2">
				<button type="button" id="write"
					onclick="location.href='/notice/faq_register'">FAQ 작성</button>
			</div>
		</c:if>
	</div>

	<div class="freeBoardContentsBox">

		<table class="freeBoardTable">
			<colgroup>
				<col style="width: 70px;">
				<col>
				<col style="width: 130px;">
				<col style="width: 140px;">
			</colgroup>

			<thead>
				<tr>
					<th class="number">번호</th>
					<th class="title">질문</th>
					<th class="writer">작성자</th>
					<th class="date">작성일</th>
				</tr>
			</thead>

			<tbody>
				<c:choose>
					<c:when test="${empty flist}">
						<tr>
							<td colspan="4" class="emptyMessage">등록된 자주 묻는 질문이 없습니다.</td>
						</tr>
					</c:when>

					<c:otherwise>
						<c:forEach var="faq" items="${flist}">
							<tr>
								<td class="number">${faq.faq_id}</td>
								<td class="title faqTitle" title="${faq.title}">
									${faq.title}</td>
								<td class="writer faqWriter" title="${faq.writer}">
									${faq.writer}</td>
								<td class="date">${faq.regdate.toString().substring(0, 10)}
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>

		<div class="btnbox">
			<button type="button" id="home" onclick="location.href='/home'">HOME</button>
		</div>

	</div>

</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>