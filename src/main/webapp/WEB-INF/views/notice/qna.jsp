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

.qnaMain {
	width: 1200px;
	max-width: calc(100% - 40px);
	margin: 0 auto;
	padding-bottom: 80px;
}

.qnaTitleBox {
	text-align: center;
	padding: 35px 0 20px;
}

.qnaTitleBox h2 {
	margin: 0 0 5px;
	font-size: 25px;
	color: #222;
}

.qnaTitleBox h5 {
	margin: 0;
	font-size: 12px;
	font-weight: 400;
	color: #888;
}

.qnaBreadcrumb {
	margin: 0 100px;
	padding: 10px 0;
	font-size: 10px;
	color: #999;
	border-top: 1px solid #eee;
}

.qnaBreadcrumb span {
	color: #333;
	font-weight: 600;
}

.qnaTabs {
	display: flex;
	margin: 10px 100px 0;
	border-bottom: 1px solid #222;
}

.qnaTabs a {
	min-width: 120px;
	padding: 9px 18px;
	text-align: center;
	border: 1px solid #ddd;
	border-bottom: 0;
	background: white;
	color: #777;
	font-size: 12px;
}

.qnaTabs a.on {
	background: #222;
	border-color: #222;
	color: white;
}

.qnaSearchArea {
	width: 650px;
	margin: 25px auto 18px;
	position: relative;
}

.qnaSearchInput {
	width: 100%;
	height: 42px;
	padding: 0 45px 0 15px;
	border: 1px solid #ccc;
	border-radius: 7px;
	background: white;
	font-size: 12px;
	outline: none;
}

.qnaSearchInput:focus {
	border-color: #555;
}

.qnaSearchBtn {
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

.qnaSearchOption {
	width: 900px;
	margin: 0 auto 12px;
	display: flex;
	align-items: center;
	font-size: 11px;
	color: #777;
}

.qnaTotalCount {
	margin-right: auto;
}

#qnaWriteBtn {
	height: 32px;
	margin-left: 6px;
	padding: 0 15px;
	border: 1px solid #222;
	border-radius: 4px;
	background: #222;
	color: white;
	font-size: 11px;
}

.qnaContentsBox {
	width: 900px;
	margin: 0 auto;
	border: 1px solid #ddd;
	border-radius: 7px;
	background: white;
	position: relative;
	padding-bottom: 50px;
}

.qnaTable {
	width: 100%;
	table-layout: fixed;
	border-collapse: collapse;
}

.qnaTable th {
	height: 45px;
	padding: 0 4px;
	background: #f7f7f7;
	border-bottom: 1px solid #ddd;
	color: #555;
	font-size: 12px;
	font-weight: 600;
	text-align: center;
}

.qnaTable td {
	height: 48px;
	padding: 0 4px;
	border-bottom: 1px solid #eee;
	color: #555;
	font-size: 12px;
	text-align: center;
}

.qnaTable tr:last-child td {
	border-bottom: 0;
}

.qnaNumber {
    width: 70px;
}

.qnaTitle {
    width: 330px;
    text-align: left !important;
    padding-left: 25px !important;
}

.qnaWriter {
    width: 110px;
}

.qnaPrivate {
    width: 100px;
}

.qnaStatus {
    width: 110px;
}

.qnaView {
    width: 70px;
}

.qnaDate {
    width: 110px;
}

.qnaTitle a {
	display: block;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
	color: #333;
}

.qnaTitle a:hover {
	text-decoration: underline;
}

.qnaTable tr:hover {
	background: #fafafa;
}

.qnaTitle a {
	display: block;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
	color: #333;
}

.qnaTitle a:hover {
	text-decoration: underline;
}

.qnaTable tr:hover {
	background: #fafafa;
}

#qnaNavigation {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 8px;
	margin-top: 25px;
	padding-bottom: 5px;
}

#qnaNavigation a {
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

#qnaNavigation a:hover {
	background: #222;
	border-color: #222;
	color: white;
}

#qnaNavigation a.current {
	background: #222;
	border-color: #222;
	color: white;
	font-weight: bold;
}

.qnaBtnBox {
	margin-top: 25px;
	padding-bottom: 30px;
	position: absolute;
	right: 20px;
	bottom: -10px;
}

#qnaHomeBtn {
	height: 34px;
	padding: 0 18px;
	border: 1px solid #222;
	border-radius: 5px;
	background: #222;
	color: white;
	font-size: 12px;
}

#qnaHomeBtn:hover {
	background: #444;
}

.qnaSearchArea {
	width: 650px;
	max-width: 100%;
	margin: 25px auto 18px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.qnaSearchArea form {
	position: relative;
	flex: 1;
	min-width: 0;
	height: 42px;
}

.qnaSearchInput {
	width: 100%;
	height: 42px;
	padding: 0 45px 0 15px;
	border: 1px solid #ccc;
	border-radius: 7px;
	background: white;
	font-size: 12px;
	outline: none;
}

.qnaSearchInput:focus {
	border-color: #555;
}

.qnaSearchBtn {
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

.qnaSearchBtn:hover {
	background: #444;
}

.qnaResetBtn {
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

.qnaResetBtn:hover {
	background: #f2f2f2;
}

@media ( max-width : 700px) {
	.qnaSearchArea {
		width: 100%;
	}
	.qnaResetBtn {
		padding: 0 7px;
		font-size: 10px;
	}
}
</style>

<div class="qnaMain">

	<div class="qnaTitleBox">
		<h2>Q&A</h2>
		<h5>궁금한 점이나 도움이 필요한 내용을 질문해 주세요.</h5>
	</div>

	<div class="qnaBreadcrumb">
		홈 &nbsp;>&nbsp; 문의사항 &nbsp;>&nbsp; <span>Q&A</span>
	</div>

	<nav class="qnaTabs">
		<a href="/notice/qna?cpage=1" class="on">Q&A</a> <a
			href="/notice/faq?cpage=1">FAQ</a>
	</nav>

	<div class="qnaSearchArea">
		<form action="/notice/qna" method="get">
			<input type="hidden" name="cpage" value="1"> <input
				class="qnaSearchInput" type="text" name="keyword"
				placeholder="Q&A 제목 검색" value="${keyword}">

			<button type="submit" class="qnaSearchBtn">🔍</button>
		</form>

		<button type="button" class="qnaResetBtn"
			onclick="location.href='/notice/qna?cpage=1'">전체 목록</button>
	</div>

	<div class="qnaSearchOption">
		<div class="qnaTotalCount">
			총 <strong>${recordTotalCount}</strong>건
		</div>
		<button type="button" id="qnaWriteBtn"
			onclick="location.href='/notice/qna_register?cpage=${cpage}'">질문하기</button>
	</div>

	<div class="qnaContentsBox">

		<table class="qnaTable">
			<tr>
				<th class="qnaNumber">번호</th>
				<th class="qnaTitle">제목</th>
				<th class="qnaWriter">작성자</th>
				<th class="qnaPrivate">공개 여부</th>
				<th class="qnaStatus">답변 상태</th>
				<th class="qnaView">조회수</th>
				<th class="qnaDate">작성일</th>
			</tr>

			<c:choose>
				<c:when test="${empty qList}">
					<tr>
						<td colspan="7">등록된 질문이 없습니다.</td>
					</tr>
				</c:when>

				<c:otherwise>
					<c:forEach var="qna" items="${qList}">
						<tr>
							<td class="qnaNumber">${qna.qid}</td>

							<td class="qnaTitle"><c:choose>
									<c:when test="${qna.is_private == 'Y'}">
										<a href="#"
											onclick="window.open('/notice/qna_content?qid=${qna.qid}&cpage=${cpage}',
											'qnaPassword','width=400,height=300'); return false;">
											🔒 ${qna.title} </a>
									</c:when>

									<c:otherwise>
										<a href="/notice/qna_content?qid=${qna.qid}&cpage=${cpage}">
											${qna.title} </a>
									</c:otherwise>
								</c:choose></td>

							<td class="qnaWriter">${qna.nickname}</td>

							<td class="qnaPrivate"><c:choose>
									<c:when test="${qna.is_private == 'Y'}">
                                비공개
                            </c:when>
									<c:otherwise>
                                공개
                            </c:otherwise>
								</c:choose></td>

							<td class="qnaStatus"><c:choose>
									<c:when test="${qna.status == '답변완료'}">
										<span style="color: #198754; font-weight: 600;"> 답변완료 </span>
									</c:when>
									<c:otherwise>
										<span style="color: #dc3545; font-weight: 600;"> 답변대기 </span>
									</c:otherwise>
								</c:choose></td>

							<td class="qnaView">${qna.view_count}</td>

							<td class="qnaDate">${qna.write_date.toString().substring(0, 10)}
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>

		<div id="qnaNavigation"></div>

		<div class="qnaBtnBox">
			<button type="button" id="qnaHomeBtn" onclick="location.href='/'">HOME</button>
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

	let navigation = document.getElementById("qnaNavigation");

	if (needPrev) {
		let prev = document.createElement("a");

		prev.setAttribute("href", "/notice/qna?cpage=" + (startNavi - 1));

		prev.innerHTML = "<";

		navigation.append(prev);
	}

	for (let i = startNavi; i <= endNavi; i++) {
		let num = document.createElement("a");

		num.setAttribute("href", "/notice/qna?cpage=" + i);

		num.innerHTML = i;

		if (i == currentPage) {
			num.className = "current";
		}

		navigation.append(num);
	}

	if (needNext) {
		let next = document.createElement("a");

		next.setAttribute("href", "/notice/qna?cpage=" + (endNavi + 1));

		next.innerHTML = ">";

		navigation.append(next);
	}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>