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
/* 표 전체 */
.notice {
	width: 100%;
	max-width: 1100px;
	margin: 40px auto 80px;
	border-collapse: collapse;
	border-top: 2px solid #1a1a1f;
	background: #fff;
}

/* 머리글 */
.notice .notice_header th {
	padding: 14px 10px;
	border-bottom: 1px solid #e5e7eb;
	background: #fafbfc;
	font-size: 13px;
	font-weight: 700;
	white-space: nowrap;
}

/* 본문 */
.notice .notice_body td {
	padding: 14px 10px;
	border-bottom: 1px solid #f0f2f4;
	font-size: 14px;
	text-align: center;
	color: #45484f;
}

.notice .notice_body:hover {
	background: #fafbfc;
}

/* 순번 */
.notice th:nth-child(1), .notice td:nth-child(1) {
	width: 70px;
}

/* 제목 */
.notice th:nth-child(2), .notice td:nth-child(2) {
	width: 25%;
	text-align: left;
	font-weight: 600;
	color: #1a1a1f;
}

/* 내용 — 길면 한 줄로 자름 */
.notice th:nth-child(3), .notice td:nth-child(3) {
	text-align: left;
	max-width: 0;
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
	width: 170px;
	font-size: 13px;
	color: #9a9aa0;
	white-space: nowrap;
}
</style>
<c:choose>
	<c:when test="${session.role=user}">
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
						<td>${i.writer}</td>
						<td>${i.view_count}</td>
						<td><fmt:formatDate value="${i.write_date}"
								pattern="yyyy.MM.dd HH:mm" /></td>
					</tr>
				</c:forEach>

			</table>

		</div>
	</c:when>
	<c:otherwise>
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
						<td>${i.writer}</td>
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
			})
			location.href = "/notice/notice_register";
		</script>
	</c:otherwise>
</c:choose>



<%@ include file="/WEB-INF/views/common/footer.jsp"%>