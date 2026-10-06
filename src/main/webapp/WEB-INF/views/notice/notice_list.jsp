<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<meta charset="UTF-8">
<title>Notice</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
<style>
/* ===== 공지사항 목록 ===== */
.notice {
	width: 100%;
	max-width: 1100px;
	margin: 28px auto 24px;
	border-collapse: collapse;
	border-top: 2px solid #1a1a1f;
	background: #fff;
	table-layout: fixed;
}

/* --- 머리글 --- */
.notice .notice_header th {
	padding: 14px 10px;
	border-bottom: 1px solid #e5e7eb;
	background: #fafbfc;
	font-size: 13px;
	font-weight: 700;
	color: #45484f;
	white-space: nowrap;
}

/* --- 본문 --- */
.notice .notice_body td {
	padding: 15px 10px;
	border-bottom: 1px solid #f0f2f4;
	font-size: 14px;
	text-align: center;
	color: #45484f;
	vertical-align: middle;
}

.notice .notice_body:hover {
	background: #fafbfc;
}

/* 순번 */
.notice th:nth-child(1), .notice td:nth-child(1) {
	width: 70px;
	font-size: 13px;
	color: #9a9aa0;
}

/* 제목 */
.notice th:nth-child(2), .notice td:nth-child(2) {
	width: 28%;
	text-align: left;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.notice td:nth-child(2) a {
	font-weight: 600;
	color: #1a1a1f;
	text-decoration: none;
}

.notice td:nth-child(2) a:hover {
	color: #FF6B35;
	text-decoration: underline;
	text-underline-offset: 3px;
}

/* 내용 — 길면 한 줄로 자름 */
.notice th:nth-child(3), .notice td:nth-child(3) {
	text-align: left;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	color: #6b6f76;
}

/* 작성자 */
.notice th:nth-child(4), .notice td:nth-child(4) {
	width: 110px;
}

/* 조회수 */
.notice th:nth-child(5), .notice td:nth-child(5) {
	width: 90px;
	color: #9a9aa0;
}

/* 작성일 */
.notice th:nth-child(6), .notice td:nth-child(6) {
	width: 160px;
	font-size: 13px;
	color: #9a9aa0;
	white-space: nowrap;
}

/* ===== 중요 공지 ===== */
.important {
	max-width: 1100px;
	margin: 48px auto 0;
}

.important_notice {
	width: 100%;
	border-collapse: collapse;
	border: 1px solid #ffd9c6;
	border-top: 2px solid #FF6B35;
	border-radius: 0 0 8px 8px;
	background: #fffaf7;
	overflow: hidden;
}

/* --- 머리글 바 --- */
.important_header th {
	padding: 13px 18px;
	border-bottom: 1px solid #ffd9c6;
	background: #fff3ec;
	font-size: 14px;
	font-weight: 800;
	color: #FF6B35;
	text-align: left;
	letter-spacing: -0.01em;
}

/* --- 본문 --- */
.important_body td {
	padding: 14px 10px;
	border-bottom: 1px solid #ffe7da;
	font-size: 14px;
	text-align: center;
	color: #45484f;
	vertical-align: middle;
}

.important_body:last-child td {
	border-bottom: 0;
}

.important_body:hover {
	background: #fff3ec;
}

/* 제목 */
.important_body td:nth-child(1) {
	width: 30%;
	max-width: 0;
	padding-left: 18px;
	text-align: left;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.important_body td:nth-child(1) a {
	font-weight: 700;
	color: #1a1a1f;
	text-decoration: none;
}

.important_body td:nth-child(1) a:hover {
	color: #FF6B35;
	text-decoration: underline;
	text-underline-offset: 3px;
}

/* 내용 */
.important_body td:nth-child(2) {
	max-width: 0;
	text-align: left;
	color: #8a7066;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

/* 작성자 */
.important_body td:nth-child(3) {
	width: 110px;
}

/* 조회수 */
.important_body td:nth-child(4) {
	width: 90px;
	color: #b09287;
}

/* 작성일 */
.important_body td:nth-child(5) {
	width: 160px;
	padding-right: 18px;
	font-size: 13px;
	color: #b09287;
	white-space: nowrap;
}

/* 중요 공지가 없으면 머리글만 남으므로 통째로 숨김 */
.important_notice:not(:has(.important_body)) {
	display: none;
}

/* --- 공지등록 버튼 (표 오른쪽 아래) --- */
#regBtn {
	display: block;
	margin-top: 0;
	margin-bottom: 100px;
	margin-left: auto;
	margin-right: max(24px, calc(( 100% - 1100px)/2));
	padding: 12px 30px;
	border: 1px solid #1a1a1f;
	border-radius: 7px;
	background: #1a1a1f;
	color: #fff;
	font-family: inherit;
	font-size: 14px;
	font-weight: 700;
	letter-spacing: -0.01em;
	cursor: pointer;
	transition: background .15s, border-color .15s;
}

#regBtn:hover {
	background: #FF6B35;
	border-color: #FF6B35;
}
</style>
<c:choose>
	<c:when test="${sessionScope.role=='admin'}">

		<div class="important">
			<table class="important_notice">
				<tr class="important_header">
					<th colspan="5">중요 공지사항</th>
				</tr>

				<c:forEach var="i" items="${ilist}">
					<tr class="important_body">
						<td><a href="/notice/detail?notice_id=${i.notice_id}">${i.title}</a></td>
						<td>${i.contents}</td>
						<td>${i.nickname}</td>
						<td>${i.view_count}</td>
						<td><fmt:formatDate value="${i.write_date}"
								pattern="yyyy.MM.dd HH:mm" /></td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div>
			<table class="notice">
				<tr class="notice_header">
					<th>순번</th>
					<th>제목</th>
					<th>내용</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>작성일</th>
				</tr>

				<c:forEach var="i" items="${nlist}">
					<tr class="notice_body">
						<td>${i.notice_id}</td>

						<td><a href="/notice/detail?notice_id=${i.notice_id}">${i.title}</a></td>
						<td>${i.contents}</td>
						<td>${i.nickname}</td>
						<td>${i.view_count}</td>
						<td><fmt:formatDate value="${i.write_date}"
								pattern="yyyy.MM.dd HH:mm" /></td>
					</tr>
				</c:forEach>
			</table>

		</div>

		<button type="button" id="regBtn">공지등록</button>

		<script>
			$("#regBtn").on("click", function() {
				location.href = "/notice/notice_register";
			})
		</script>

	</c:when>
	<c:otherwise>
		<div class="important">
			<table class="important_notice">
				<tr class="important_header">
					<th colspan="5">중요 공지사항</th>
				</tr>

				<c:forEach var="i" items="${ilist}">
					<tr class="important_body">
						<td><a href="/notice/detail?notice_id=${i.notice_id}">${i.title}</a></td>
						<td>${i.contents}</td>
						<td>${i.nickname}</td>
						<td>${i.view_count}</td>
						<td><fmt:formatDate value="${i.write_date}"
								pattern="yyyy.MM.dd HH:mm" /></td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div>
			<table class="notice">
				<tr class="notice_header">
					<th>순번</th>
					<th>제목</th>
					<th>내용</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>작성일</th>
				</tr>

				<c:forEach var="i" items="${nlist}">
					<tr class="notice_body">
						<td>${i.notice_id}</td>

						<td><a href="/notice/detail?notice_id=${i.notice_id}">${i.title}</a></td>
						<td>${i.contents}</td>
						<td>${i.nickname}</td>
						<td>${i.view_count}</td>
						<td><fmt:formatDate value="${i.write_date}"
								pattern="yyyy.MM.dd HH:mm" /></td>
					</tr>
				</c:forEach>

			</table>

		</div>
	</c:otherwise>
</c:choose>



<%@ include file="/WEB-INF/views/common/footer.jsp"%>