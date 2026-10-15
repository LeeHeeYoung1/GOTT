<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<style>

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
	display: flex;
	align-items: center;
	gap: 10px;
}

.faqSearchArea form {
	position: relative;
	flex: 1;
	min-width: 0;
	height: 42px;
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
	padding: 0;
	border: 0;
	border-radius: 5px;
	background: #222;
	color: white;
	cursor: pointer;
}

.faqSearchBtn:hover {
	background: #444;
}

.faqResetBtn {
	position: static;
	flex-shrink: 0;
	height: 38px;
	padding: 0 12px;
	border: 1px solid #ccc;
	border-radius: 5px;
	background: white;
	color: #555;
	font-size: 11px;
	cursor: pointer;
}

.faqResetBtn:hover {
	background: #f2f2f2;
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
	padding: 0 4px;
	background: #f7f7f7;
	border-bottom: 1px solid #ddd;
	color: #555;
	font-size: 12px;
	font-weight: 600;
	text-align: center;
}

.faqTable td {
	height: 48px;
	padding: 0 4px;
	border-bottom: 1px solid #eee;
	color: #555;
	font-size: 12px;
	text-align: center;
}

.faqTable .manage {
	width: 120px;
}

.faqTable .manage button {
	padding: 5px 8px;
	margin: 0 2px;
	border: 1px solid #ddd;
	border-radius: 4px;
	background: white;
	color: #555;
	font-size: 11px;
	cursor: pointer;
}

.faqTable .manage button:hover {
	background: #222;
	color: white;
}

.faqTable tr:last-child td {
	border-bottom: 0;
}

.faqTable .number {
    width: 70px;
    text-align: center;
    padding-right: 0;
}

.faqTable .title {
    width: auto;
    text-align: left;
    padding-left: 25px;
}

.faqTable .writer {
    width: 100px;
    text-align: center;
    padding-left: 10px;
}

.faqTable .view {
    width: 80px;
    text-align: center;
    padding-left: 10px;
}

.faqTable .date {
    width: 110px;
    text-align: center;
    padding-left: 10px;
}

.faqTitleText, .faqWriterText {
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
	padding: 0 20px;
	border: 1px solid #ddd;
	border-radius: 5px;
	background: #fff;
	color: #555;
	font-size: 12px;
	font-weight: 500;
	cursor: pointer;
	transition: all 0.2s ease;
}

#faqHomeBtn:hover {
	background: #444;
	border-color: #222;
	color: #fff;
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

@media ( max-width : 700px) {
	.breadcrumb, .tabs {
		margin-left: 0;
		margin-right: 0;
	}
	.faqSearchOption {
		width: 100%;
	}
	.faqSearchArea {
		width: 100%;
	}
	.faqSearchInput {
		padding-right: 145px;
	}
	.faqResetBtn {
		padding: 0 7px;
		font-size: 10px;
	}
	.faqTable .number {
		width: 50px;
	}
	.faqTable .writer {
		width: 75px;
	}
	.faqTable .date {
		width: 90px;
	}
	.faqTable th, .faqTable td {
		padding: 0 5px;
		font-size: 11px;
	}
	.faqTable .title {
		padding-left: 15px;
	}
}
</style>

<div class="container">

	<div class="titleBox">
		<h2>FAQ</h2>
		<h5>자주 묻는 질문을 통해 궁금한 내용을 확인해 보세요.</h5>
	</div>

	<div class="breadcrumb">
		홈 &nbsp;>&nbsp; 문의사항 &nbsp;>&nbsp; <span>FAQ</span>
	</div>

	<nav class="tabs">
		<a href="/notice/qna?cpage=1">Q&A</a> <a href="/notice/faq?cpage=1"
			class="on">FAQ</a>
	</nav>

	<div class="faqSearchArea">
		<form action="/notice/faq" method="get">
			<input type="hidden" name="cpage" value="1"> <input
				class="faqSearchInput" type="text" name="keyword"
				placeholder="자주 묻는 질문 검색" value="${keyword}">
			<button type="submit" class="faqSearchBtn">🔍</button>
		</form>

		<button type="button" class="faqResetBtn"
			onclick="location.href='/notice/faq?cpage=1'">전체 목록</button>
	</div>

	<div class="faqSearchOption">

		<div class="faqTotalCount">
			총 <strong>${flist.size()}</strong>건
		</div>

		<c:if test="${loginId == 'admin0001'}">
			<div class="faqWriteBox">
				<button type="button" id="faqWriteBtn"
					onclick="location.href='/notice/faq_register?cpage=${cpage}'">FAQ
					작성</button>
			</div>
		</c:if>

	</div>

	<div class="faqContentsBox">

		<table class="faqTable">
			<thead>
				<tr>
					<th class="number">번호</th>
					<th class="title">질문</th>
					<th class="writer">작성자</th>
					<th class="view">조회수</th>
					<th class="date">작성일</th>
				</tr>
			</thead>
				<c:choose>
					<c:when test="${empty flist}">
						<tr>
							<td colspan="5" class="faqEmptyMessage">등록된 자주 묻는 질문이 없습니다.
							</td>
						</tr>
					</c:when>

					<c:otherwise>
						<c:forEach var="faq" items="${flist}">
							<tr>
								<td class="number">${faq.faq_id}</td>

								<td class="title faqTitleText" title="${faq.title}"><a
									href="/notice/faq_content?faq_id=${faq.faq_id}&cpage=${cpage}&keyword=${keyword}">
										${faq.title} </a></td>

								<td class="writer faqWriterText" title="${faq.writer}">
									${faq.writer}</td>

								<td class="view">${faq.view_count}</td>

								<td class="date">${faq.regdate.toString().substring(0, 10)}
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
		</table>

		<div id="navigation"></div>

		<div class="faqHomeBox">
			<button type="button" id="faqHomeBtn" onclick="location.href='/'">Home</button>
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

		prev.setAttribute("href", "/notice/faq?keyword=${keyword}&cpage="
				+ (startNavi - 1));

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

		next.setAttribute("href", "/notice/faq?keyword=${keyword}&cpage="
				+ (endNavi + 1));

		next.innerHTML = ">";

		navigation.append(next);
	}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>