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

.faqSearchArea {
	width: 650px;
	max-width: 100%;
	margin: 25px auto 18px;
	position: relative;
}

.faqSearchInput {
	width: 100%;
	height: 42px;
	padding: 0 45px 0 15px;
	border: 1px solid #ccc;
	border-radius: 7px;
	background: white;
	font-size: 12px;
	outline: none;
}

.faqSearchInput:focus {
	border-color: #555;
}

.faqSearchBtn {
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

.faqSearchOption {
	width: 900px;
	max-width: 100%;
	margin: 0 auto 12px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	font-size: 11px;
	color: #777;
}

.faqTotalCount {
	margin-right: auto;
}

.faqWriteBox {
	margin-left: auto;
}

#faqWriteBtn {
	height: 30px;
	padding: 0 14px;
	border: 1px solid #222;
	border-radius: 5px;
	background: #222;
	color: white;
	font-size: 11px;
	cursor: pointer;
}

#faqWriteBtn:hover {
	background: #444;
}

.faqContentsBox {
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

.faqTable {
	width: 100%;
	table-layout: fixed;
	border-collapse: collapse;
}

.faqTable th {
	height: 45px;
	padding: 0 10px;
	background: #f7f7f7;
	border-bottom: 1px solid #ddd;
	color: #555;
	font-size: 12px;
	font-weight: 600;
	text-align: center;
}

.faqTable td {
	height: 48px;
	padding: 0 10px;
	border-bottom: 1px solid #eee;
	color: #555;
	font-size: 12px;
	text-align: center;
}

.faqTable tr:last-child td {
	border-bottom: 0;
}

.faqTable .number {
	width: 70px;
}

.faqTable .title {
	width: auto;
	text-align: left;
}

.faqTable .writer {
	width: 130px;
}

.faqTable .date {
	width: 140px;
}

.faqTitleText,
.faqWriterText {
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}

.faqTitleText a {
	color: #555;
	text-decoration: none;
}

.faqTitleText a:hover {
	color: #222;
	text-decoration: underline;
}

.faqTable tbody tr:hover {
	background: #fafafa;
}

.faqEmptyMessage {
	height: 100px !important;
	text-align: center !important;
	color: #999 !important;
}

.faqHomeBox {
	position: absolute;
	right: 20px;
	bottom: 15px;
}

#faqHomeBtn {
	height: 34px;
	padding: 0 18px;
	border: 1px solid #222;
	border-radius: 5px;
	background: #222;
	color: white;
	font-size: 12px;
	cursor: pointer;
}

#faqHomeBtn:hover {
	background: #444;
}

#navigation {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
    padding: 20px 0;
}

#navigation a {
    display: inline-block;
    min-width: 28px;
    padding: 6px 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    text-align: center;
    color: #555;
    text-decoration: none;
    font-size: 12px;
}

#navigation a.current {
    background: #222;
    color: white;
    border-color: #222;
}

@media (max-width: 700px) {
	.breadcrumb, .tabs {
		margin-left: 0;
		margin-right: 0;
	}

	.faqSearchOption {
		width: 100%;
	}

	.faqTable .number {
		width: 50px;
	}

	.faqTable .writer {
		width: 80px;
	}

	.faqTable .date {
		width: 100px;
	}

	.faqTable th, .faqTable td {
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
		<a href="/notice/qna">Q&A</a>
		<a href="/notice/faq?cpage=1" class="on">FAQ</a>
	</nav>

	<div class="faqSearchArea">
		<form action="/notice/faq" method="get">
		 <input type="hidden" name="cpage" value="1">
			<input class="faqSearchInput" type="text" name="keyword"
				placeholder="자주 묻는 질문 검색">
			<button type="submit" class="faqSearchBtn">🔍</button>
		</form>
	</div>

	<div class="faqSearchOption">

		<div class="faqTotalCount">
			총 <strong>${flist.size()}</strong>건
		</div>

		<c:if test="${loginId == 'admin0001'}">
			<div class="faqWriteBox">
				<button type="button" id="faqWriteBtn"
					onclick="location.href='/notice/faq_register?cpage=${cpage}'">FAQ 작성</button>
			</div>
		</c:if>

	</div>

	<div class="faqContentsBox">

		<table class="faqTable">
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
							<td colspan="4" class="faqEmptyMessage">
								등록된 자주 묻는 질문이 없습니다.
							</td>
						</tr>
					</c:when>

					<c:otherwise>
						<c:forEach var="faq" items="${flist}">
							<tr>
								<td class="number">${faq.faq_id}</td>

								<td class="title faqTitleText" title="${faq.title}">
									<a href="/notice/faq_content?faq_id=${faq.faq_id}&cpage=${cpage}&keyword=${keyword}">
										${faq.title}
									</a>
								</td>

								<td class="writer faqWriterText" title="${faq.writer}">
									${faq.writer}
								</td>

								<td class="date">
									${faq.regdate.toString().substring(0, 10)}
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		
		<div id="navigation"></div>
		
		<div class="faqHomeBox">
			<button onclick="location.href="/">목록</button>
		</div>

	</div>

</div>

<script>
let recordTotalCount = ${recordTotalCount};
let recordCountPerPage = ${recordCountPerPage};
let naviCountPerPage = ${naviCountPerpage};
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

let navigation = document.getElementById("navigation");

if (needPrev) {
	let prev = document.createElement("a");

	prev.setAttribute("href", "/notice/faq?keyword=${keyword}&cpage=" + (startNavi - 1));

	prev.innerHTML = "<";

	navigation.append(prev);
}

for (let i = startNavi; i <= endNavi; i++) {
	let num = document.createElement("a");

	num.setAttribute("href", "/notice/faq?keyword=${keyword}&cpage=" + i);

	num.innerHTML = i;

	if (i == currentPage) {
		num.className = "current";
	}

	navigation.append(num);
}

if (needNext) {
	let next = document.createElement("a");

	next.setAttribute("href", "/notice/faq?keyword=${keyword}&cpage=" + (endNavi + 1));

	next.innerHTML = ">";

	navigation.append(next);
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>