<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<meta charset="UTF-8">
<title>Notice Register</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
<style>
/* ===== 공지 등록 ===== */
.register_container {
	max-width: 900px;
	margin: 48px auto 100px;
	padding: 0 24px;
}

/* 폼 자체는 배경 없음 — 버튼 뒤가 페이지 바탕색으로 비침 */
.register_container form {
	display: block;
	background: transparent;
}

/* --- 제목 --- */
.register_header {
	padding: 20px 24px;
	background: #fff;
	border: 1px solid #e5e7eb;
	border-top: 2px solid #1a1a1f;
	border-bottom: 1px solid #eceef1;
}

#title {
	width: 100%;
	border: 0;
	outline: 0;
	background: transparent;
	font-family: inherit;
	font-size: 21px;
	font-weight: 700;
	line-height: 1.4;
	color: #1a1a1f;
	letter-spacing: -0.02em;
}

#title::placeholder {
	color: #c3c7cc;
	font-weight: 500;
}

.register_header:focus-within {
	border-bottom-color: #1a1a1f;
}

/* --- 내용 --- */
.register_body {
	padding: 22px 24px 28px;
	background: #fff;
	border-left: 1px solid #e5e7eb;
	border-right: 1px solid #e5e7eb;
	border-bottom: 1px solid #eceef1;
}

#contents {
	display: block;
	width: 100%;
	min-height: 340px;
	border: 0;
	outline: 0;
	background: transparent;
	resize: vertical;
	font-family: inherit;
	font-size: 15px;
	line-height: 1.85;
	color: #33363c;
	letter-spacing: -0.01em;
}

#contents::placeholder {
	color: #c3c7cc;
}

/* --- 공지 구분 --- */
.register_option {
	display: flex;
	align-items: center;
	gap: 22px;
	padding: 16px 24px;
	background: #fafbfc;
	border: 1px solid #e5e7eb;
	border-top: 0;
	border-radius: 0 0 8px 8px;
	font-size: 14px;
	color: #45484f;
}

.register_option label {
	display: inline-flex;
	align-items: center;
	gap: 7px;
	cursor: pointer;
	white-space: nowrap;
}

.register_option input {
	width: 15px;
	height: 15px;
	margin: 0;
	accent-color: #1a1a1f;
	cursor: pointer;
}

/* --- 버튼 (배경 없음) --- */
.register_bottom {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 28px;
	padding: 0;
	background: transparent;
	border: 0;
}

.register_bottom button {
	min-width: 140px;
	padding: 13px 34px;
	border-radius: 7px;
	font-family: inherit;
	font-size: 15px;
	font-weight: 700;
	letter-spacing: -0.01em;
	cursor: pointer;
	transition: background .15s, border-color .15s, color .15s;
}

#regBtn {
	border: 1px solid #1a1a1f;
	background: #1a1a1f;
	color: #fff;
}

#regBtn:hover {
	background: #FF6B35;
	border-color: #FF6B35;
}

#cancelBtn {
	border: 1px solid #dfe3e8;
	background: #fff;
	color: #45484f;
	font-weight: 500;
}

#cancelBtn:hover {
	background: #f6f7f8;
	border-color: #b9bec5;
	color: #1a1a1f;
}


</style>

<div class="register_container">
	<form action="/notice/register" method="post">
		<div class="register_header">
			<input type="hidden" id="writer" name="writer"
				value="${sessionScope.id}">
			<input type="text" id="title" name="title"
				placeholder="공지 제목을 입력하세요.">
		</div>
		<div class="register_body">
			<textarea id="contents" name="contents"
				placeholder="공지 내용을 입력하세요."></textarea>
		</div>
		
		<div class="register_option">
			<label><input type="radio" name="important" value="N" checked>일반
				공지</label> <label><input type="radio" name="important" value="Y">중요
				공지</label>
		</div>
		
		<div class="register_bottom">
			<button type="submit" id="regBtn">등록</button>
			<button type="button" id="cancelBtn">취소</button>
		</div>

	</form>
</div>


<script>
	$("#cancelBtn").on("click", function() {
		history.back();
	})
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>