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

.notice_container {
	max-width: 900px;
	margin: 40px auto 80px;
	padding: 0 24px;
}

/* 제목 + 정보 */
.notice_header {
	padding: 26px 4px 18px;
	border-top: 2px solid #1a1a1f;
	border-bottom: 1px solid #e5e7eb;
}

.notice_title {
	margin-bottom: 12px;
	font-size: 23px;
	font-weight: 800;
	letter-spacing: -0.02em;
	color: #1a1a1f;
	line-height: 1.4;
}

.notice_header span {
	margin-right: 18px;
	font-size: 13px;
	color: #9a9aa0;
}

.notice_header span:first-of-type {
	font-weight: 600;
	color: #45484f;
}

/* 본문 */
.notice_body {
	padding: 32px 4px;
	background-color: white;
	border-bottom: 1px solid #e5e7eb;
}

.notice_contents {
	min-height: 220px;
	font-size: 15px;
	line-height: 1.85;
	color: #33363c;
	white-space: pre-wrap;
	word-break: break-all;
}

/* 버튼 */
.notice_bottom {
	margin-top: 28px;
	text-align: center;
}

#listBtn {
	padding: 12px 36px;
	border: 1px solid #1a1a1f;
	border-radius: 6px;
	background: #1a1a1f;
	font-family: inherit;
	font-size: 14px;
	font-weight: 700;
	color: #fff;
	cursor: pointer;
	transition: background .15s;
}

#listBtn:hover {
	background: #FF6B35;
	border-color: #FF6B35;
}
</style>

<div class="notice_container">
	<div class="notice_header">
		<div class="notice_title">${ndto.title}</div>
		<span>${ndto.writer}</span>
		<span>${ndto.view_count}</span>
		<span><fmt:formatDate value="${ndto.write_date}" pattern="yyyy.MM.dd HH:mm"/></span>
	</div>
	<div class="notice_body">
		<div class="notice_contents">${ndto.contents}</div>
	</div>
	<div class="notice_bottom">
		<button type="button" id="listBtn">목록으로</button>
	</div>
</div>

<script>
	$("#listBtn").on("click", function(){
		location.href="/notice/notice_list";
	})
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>