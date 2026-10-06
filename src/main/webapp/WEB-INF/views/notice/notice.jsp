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
/* ===== 공지 상세 ===== */
.notice_container {
	max-width: 900px;
	margin: 48px auto 100px;
	padding: 0 24px;
}

/* --- 제목 + 정보 --- */
.notice_header {
	padding: 26px 4px 18px;
	border-top: 2px solid #1a1a1f;
	border-bottom: 1px solid #e5e7eb;
}

#title {
	display: block;
	width: 100%;
	margin-bottom: 14px;
	padding: 0;
	border: 1px solid transparent;
	border-radius: 6px;
	outline: 0;
	background: transparent;
	font-family: inherit;
	font-size: 23px;
	font-weight: 800;
	letter-spacing: -0.02em;
	line-height: 1.4;
	color: #1a1a1f;
}

/* readonly가 풀렸을 때만 입력칸처럼 */
#title:not([readonly]) {
	padding: 9px 12px;
	border-color: #FF6B35;
	background: #fff;
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

/* --- 본문 --- */
.notice_body {
	padding: 32px 4px;
	background: #fff;
	border-bottom: 1px solid #e5e7eb;
}

#contents {
	display: block;
	width: 100%;
	min-height: 260px;
	padding: 0;
	border: 1px solid transparent;
	border-radius: 6px;
	outline: 0;
	background: transparent;
	resize: none;
	font-family: inherit;
	font-size: 15px;
	line-height: 1.85;
	color: #33363c;
	white-space: pre-wrap;
	word-break: break-all;
}

#contents:not([readonly]) {
	padding: 14px 12px;
	border-color: #FF6B35;
	background: #fff;
	resize: vertical;
}

/* --- 버튼 --- */
.notice_bottom {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 28px;
}

.notice_bottom button {
	min-width: 120px;
	padding: 12px 28px;
	border-radius: 6px;
	font-family: inherit;
	font-size: 14px;
	font-weight: 700;
	letter-spacing: -0.01em;
	cursor: pointer;
	transition: background .15s, border-color .15s, color .15s;
}

/* 주요 동작 — 목록으로 / 수정 완료 */
#listBtn, #save {
	border: 1px solid #1a1a1f;
	background: #1a1a1f;
	color: #fff;
}

#listBtn:hover, #save:hover {
	background: #FF6B35;
	border-color: #FF6B35;
}

/* 보조 동작 — 수정 / 취소 */
#updateBtn, #cancel {
	border: 1px solid #dfe3e8;
	background: #fff;
	color: #45484f;
	font-weight: 500;
}

#updateBtn:hover, #cancel:hover {
	background: #f6f7f8;
	border-color: #b9bec5;
	color: #1a1a1f;
}

/* 삭제 */
#deleteBtn {
	border: 1px solid #e8c4bb;
	background: #fff;
	color: #c0392b;
	font-weight: 500;
}

#deleteBtn:hover {
	background: #fdf1ef;
	border-color: #c0392b;
	color: #fff;
	background: #c0392b;
}
</style>
<c:choose>
	<c:when test="${sessionScope.role=='admin'}">
		<div class="notice_container">
			<form action="/notice/notice_update" method="post">
				<div class="notice_header">
					<input type="hidden" name="notice_id" value="${ndto.notice_id}">
					<input type="text" id="title" name="title" readonly
						value="${ndto.title}"> <span>${ndto.nickname}</span> <span>${ndto.view_count}</span>
					<span><fmt:formatDate value="${ndto.write_date}"
							pattern="yyyy.MM.dd HH:mm" /></span>
				</div>
				<div class="notice_body">
					<textarea id="contents" name="contents" readonly>${ndto.contents}</textarea>
				</div>
				<div class="notice_bottom" id="btnBox">
					<button type="button" id="updateBtn">수정</button>
					<button type="button" id="deleteBtn">삭제</button>
					<button type="button" id="listBtn">목록으로</button>
				</div>
			</form>
		</div>
		<script>
			$("#deleteBtn")
					.on(
							"click",
							function() {
								location.href = "/notice/notice_delete?notice_id=${ndto.notice_id}";
							})
			$("#updateBtn").on(
					"click",
					function() {
						$("#title").prop("readonly", false);
						$("#contents").prop("readonly", false);

						$("#updateBtn").hide();
						$("#deleteBtn").hide();

						let saveBtn = $("<button>").attr("type", "submit")
								.attr("id", "save").text("수정 완료");
						let cancelBtn = $("<button>").attr("type", "button")
								.attr("id", "cancel").text("취소");

						$("#btnBox").prepend(saveBtn).prepend(cancelBtn);

						cancelBtn.on("click", function() {
							$("#title").prop("readonly", true);
							$("#contents").prop("readonly", true);

							saveBtn.remove();
							cancelBtn.remove();

							$("#updateBtn").show();
							$("#deleteBtn").show();
						})

					})
		</script>

	</c:when>
	<c:otherwise>
		<div class="notice_container">
			<div class="notice_header">
				<input type="text" id="title" name="title" readonly
					value="${ndto.title}"> <span>${ndto.nickname}</span> <span>${ndto.view_count}</span>
				<span><fmt:formatDate value="${ndto.write_date}"
						pattern="yyyy.MM.dd HH:mm" /></span>
			</div>
			<div class="notice_body">
				<textarea id="contents" name="contents" readonly>${ndto.contents}</textarea>
			</div>
			<div class="notice_bottom">
				<button type="button" id="listBtn">목록으로</button>
			</div>
		</div>
	</c:otherwise>
</c:choose>

<script>
	$("#listBtn").on("click", function() {
		location.href = "/notice/notice_list";
	})
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>