<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review Content</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="/summernote/summernote-lite.css">
<script src="/summernote/summernote-lite.js"></script>
<style>
* {
	box-sizing: border-box;
}

body {
	margin: 0;
	background: #f7f8f9;
	font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
	color: #1a1a1f;
}

/* ===== 상단 ===== */
.review_header {
	max-width: 900px;
	margin: 48px auto 10px;
	padding: 0 24px;
	font-size: 24px;
	font-weight: 800;
	letter-spacing: -0.03em;
}

.writer_box {
	max-width: 900px;
	margin: 0 auto 10px;
	padding: 0 24px;
	display: flex;
	align-items: center;
	gap: 10px;
}

#writer {
	margin: 0;
	font-size: 13px;
	font-weight: 700;
	color: #8b8f96;
	white-space: nowrap;
}

#nickname {
	width: 180px;
	margin: 0;
	padding: 0;
	border: 0;
	outline: 0;
	background: transparent;
	font-family: inherit;
	font-size: 14px;
	font-weight: 600;
	color: #45484f;
}

/* ===== 조회수 / 추천수 ===== */
.view_count_box, .recommend_box {
	max-width: 900px;
	margin: 0 auto 3px;
	padding: 0 24px;
	display: flex;
	align-items: center;
	gap: 5px;
	font-size: 12px;
	color: #a0a4ab;
}

.view_count_box p, .recommend_box p {
	margin: 0;
	font-weight: 700;
	color: #45484f;
}

.recommend_box {
	margin-bottom: 16px;
}

/* ===== 본문 — 사진 | 글, 아래 태그 ===== */
.review_body {
	max-width: 900px;
	margin: 0 auto;
	display: flex;
	flex-wrap: wrap;
	background: #fff;
	border: 1px solid #e5e7eb;
	border-top: 2px solid #222;
	border-radius: 8px;
	overflow: hidden;
}

/* --- 왼쪽: 사진 --- */
.photo_box {
	width: 320px;
	flex-shrink: 0;
	padding: 20px;
	border-right: 1px solid #eceef1;
	background: #fafbfc;
}

#photo {
	width: 100%;
	height: 280px;
	border-radius: 10px;
	overflow: hidden;
	background: #eef1f5;
	box-shadow: 0 2px 10px rgba(15, 23, 42, .10);
}

#photo img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

/* --- 오른쪽: 글 --- */
#contents {
	flex: 1 1 320px;
	min-width: 0;
	min-height: 320px;
	margin: 0;
	padding: 20px 24px;
	border: 0;
	outline: 0;
	resize: none;
	background: #fff;
	font-family: inherit;
	font-size: 15px;
	line-height: 1.8;
	color: #33363c;
	cursor: default;
}

/* --- 아래: 태그 --- */
.tag_box {
	width: 100%;
	display: flex;
	align-items: flex-start;
	gap: 12px;
	padding: 16px 20px;
	border-top: 1px solid #eceef1;
	background: #fafbfc;
}

.tag_label {
	padding-top: 5px;
	font-size: 13px;
	font-weight: 700;
	color: #333;
	white-space: nowrap;
}

.tag_list {
	display: flex;
	flex-wrap: wrap;
	gap: 6px;
}

.tag {
	padding: 6px 14px;
	border: 1px solid #FF6B35;
	border-radius: 18px;
	background: #fff5f0;
	font-size: 12px;
	font-weight: 700;
	color: #FF6B35;
}

/* ===== 추천 버튼 ===== */
.recommend {
	max-width: 900px;
	margin: 20px auto 0;
	padding: 0 24px;
	display: flex;
	justify-content: center;
}

.heartBtn {
	display: flex;
	align-items: center;
	gap: 8px;
	height: 44px;
	padding: 0 28px;
	border: 1px solid #e0e3e7;
	border-radius: 22px;
	background: #fff;
	font-family: inherit;
	font-size: 14px;
	font-weight: 700;
	color: #8b8f96;
	cursor: pointer;
	transition: background .15s, border-color .15s, color .15s, transform
		.12s;
}

.heartBtn:hover {
	border-color: #ffb3bb;
	background: #fff8f9;
	color: #FF4757;
	transform: translateY(-1px);
}

.heartBtn:active {
	transform: translateY(0) scale(0.97);
}

.heartBtn.on {
	border-color: #FF4757;
	background: #fff0f2;
	color: #FF4757;
}

.heartIcon {
	display: inline-block;
	font-size: 18px;
	line-height: 1;
}

.heartBtn.on .heartIcon {
	animation: pop .3s ease;
}

/* ===== 하단 버튼 ===== */
.review_bottom {
	display: flex;
	justify-content: center;
	gap: 10px;
	max-width: 900px;
	margin: 20px auto 40px;
	padding: 0 24px;
}

.review_bottom button {
	min-width: 140px;
	height: 46px;
	border-radius: 7px;
	font-family: inherit;
	font-size: 14px;
	font-weight: 700;
	cursor: pointer;
	transition: background .15s, border-color .15s, color .15s;
}

#updateBtn {
	border: 1px solid #222;
	background: #222;
	color: #fff;
}

#updateBtn:hover {
	background: #FF6B35;
	border-color: #FF6B35;
}

#deleteBtn {
	border: 1px solid #ddd;
	background: #fff;
	color: #666;
}

#deleteBtn:hover {
	border-color: #c0392b;
	background: #fdecea;
	color: #c0392b;
}

#backBtn {
	border: 1px solid #ddd;
	background: #fff;
	color: #666;
	font-weight: 500;
}

#backBtn:hover {
	background: #f6f6f6;
	border-color: #bbb;
	color: #222;
}

/* ===== 댓글 ===== */
.reply_area {
	max-width: 900px;
	margin: 0 auto 80px;
	padding: 0 24px;
}

.reply_head {
	display: flex;
	align-items: center;
	gap: 6px;
	padding-bottom: 12px;
	border-bottom: 2px solid #222;
	font-size: 15px;
	font-weight: 800;
	color: #1a1a1f;
}

.reply_num {
	color: #FF6B35;
}

/* --- 댓글 쓰는 칸 --- */
.reply_form {
	margin-top: 16px;
	padding: 14px 16px;
	border: 1px solid #e5e7eb;
	border-radius: 8px;
	background: #fff;
	transition: border-color .15s;
}

.reply_form:focus-within {
	border-color: #222;
}

#replyContents {
	width: 100%;
	height: 72px;
	margin: 0;
	padding: 0;
	border: 0;
	outline: 0;
	resize: none;
	background: transparent;
	font-family: inherit;
	font-size: 14px;
	line-height: 1.7;
	color: #33363c;
}

#replyContents::placeholder {
	color: #b0b5bc;
}

.register_btn_box {
	display: flex;
	justify-content: flex-end;
	margin-top: 8px;
	padding-top: 10px;
	border-top: 1px solid #f1f3f5;
}

#replyBtn {
	height: 34px;
	padding: 0 22px;
	border: 1px solid #222;
	border-radius: 6px;
	background: #222;
	font-family: inherit;
	font-size: 13px;
	font-weight: 700;
	color: #fff;
	cursor: pointer;
	transition: background .15s, border-color .15s;
}

#replyBtn:hover {
	background: #FF6B35;
	border-color: #FF6B35;
}

/* --- 댓글 목록 --- */
.reply_list {
	margin-top: 10px;
}

/* 댓글 묶음 구분선 — 머리글 위에 둬서 대댓글이 같은 묶음에 들어가게 */
.reply_list .reply_header {
	display: flex;
	align-items: center;
	gap: 10px;
	max-width: none;
	margin: 0;
	padding: 18px 4px 0;
	border-top: 1px solid #eceef1;
	font-size: 13px;
	font-weight: 400;
	letter-spacing: 0;
}

.reply_list .reply_header:first-child {
	border-top: 0;
	padding-top: 6px;
}

.reply_list .nickname {
	font-size: 13px;
	font-weight: 700;
	color: #1a1a1f;
}

.reply_date {
	font-size: 11px;
	color: #a0a4ab;
}

/* 댓글 본문 — readonly 일 때는 테두리 없이 글처럼 */
.reply_contents {
	display: block;
	width: 100%;
	margin: 0;
	padding: 6px 4px 8px;
	border: 0;
	outline: 0;
	background: transparent;
	font-family: inherit;
	font-size: 14px;
	line-height: 1.75;
	color: #33363c;
	text-overflow: ellipsis;
}

/* 수정 모드 — readonly 가 풀리면 입력칸 모양 */
.reply_contents:not([readonly]) {
	margin: 4px 0 6px;
	padding: 9px 12px;
	border: 1px solid #222;
	border-radius: 6px;
	background: #fff;
	color: #1a1a1f;
}

/* --- 댓글별 버튼 줄 (대댓글 폼도 여기 안에 있음) --- */
.reply_btn_box {
	display: flex;
	flex-wrap: wrap;
	justify-content: flex-end;
	align-items: center;
	gap: 6px;
	padding: 0 4px;
}

.replyUpdateBtn, .replyDeleteBtn, .replySaveBtn, .replyCancelBtn,
	.childReplyUpdateBtn, .childReplyDeleteBtn, .childReplySaveBtn,
	.childReplyCancelBtn {
	padding: 3px 10px;
	border: 1px solid #e0e3e7;
	border-radius: 4px;
	background: #fff;
	font-family: inherit;
	font-size: 11px;
	color: #8b8f96;
	cursor: pointer;
	transition: border-color .15s, background .15s, color .15s;
}

.replyUpdateBtn:hover, .replyCancelBtn:hover, .childReplyUpdateBtn:hover,
	.childReplyCancelBtn:hover {
	border-color: #222;
	background: #f6f6f6;
	color: #222;
}

.replyDeleteBtn:hover, .childReplyDeleteBtn:hover {
	border-color: #c0392b;
	background: #fdecea;
	color: #c0392b;
}

.replySaveBtn, .childReplySaveBtn {
	border-color: #222;
	background: #222;
	color: #fff;
	font-weight: 700;
}

.replySaveBtn:hover, .childReplySaveBtn:hover {
	border-color: #FF6B35;
	background: #FF6B35;
	color: #fff;
}

/* --- 답글 — 버튼 모양 없이 굵은 글씨만, 왼쪽에 --- */
.replyAnswerBtn {
	margin-right: auto;
	padding: 3px 2px;
	border: 0;
	background: transparent;
	font-family: inherit;
	font-size: 12px;
	font-weight: 700;
	color: #8b8f96;
	cursor: pointer;
	transition: color .15s;
}

.replyAnswerBtn:hover {
	color: #222;
	text-decoration: underline;
}

/* ===== 대댓글 쓰는 칸 ===== */
.child_reply_form {
	width: 100%;
	margin: 8px 0 2px 28px;
	padding: 7px 12px;
	border: 1px solid #eceef1;
	border-radius: 8px;
	background: #fafbfc;
	transition: border-color .15s, background .15s;
}

.child_reply_form:focus-within {
	border-color: #999;
	background: #fff;
}

.child_reply_form::before {
	content: "↳ 답글";
	display: block;
	margin-bottom: 3px;
	font-size: 11px;
	font-weight: 700;
	color: #a0a4ab;
}

.child_reply_form textarea {
	width: 100%;
	height: 30px;
	margin: 0;
	padding: 0;
	border: 0;
	outline: 0;
	resize: none;
	background: transparent;
	font-family: inherit;
	font-size: 13px;
	line-height: 1.6;
	color: #33363c;
	vertical-align: top;
}

.child_reply_form textarea::placeholder {
	color: #c0c5cb;
}

.child_register_btn_box {
	display: flex;
	justify-content: flex-end;
	margin-top: 3px;
}

.child_register_btn_box button {
	height: 26px;
	padding: 0 14px;
	border: 1px solid #b0b5bc;
	border-radius: 5px;
	background: #fff;
	font-family: inherit;
	font-size: 12px;
	font-weight: 600;
	color: #666;
	cursor: pointer;
	transition: border-color .15s, background .15s, color .15s;
}

.child_register_btn_box button:hover {
	border-color: #222;
	background: #222;
	color: #fff;
}

/* ===== 대댓글 목록 ===== */
.childList {
	margin: 0 0 0 28px;
	padding: 0 0 0 14px;
	border-left: 2px solid #eceef1;
}

.child_reply_header {
	display: flex;
	align-items: center;
	gap: 8px;
	padding: 12px 4px 0;
}

.child_reply_header::before {
	content: "↳";
	font-size: 12px;
	color: #c5c9ce;
}

.child_nickname {
	font-size: 12px;
	font-weight: 700;
	color: #45484f;
}

.child_reply_date {
	font-size: 10px;
	color: #b0b5bc;
}

.child_reply_contents {
	display: block;
	width: 100%;
	margin: 0;
	padding: 4px 4px 6px 18px;
	border: 0;
	outline: 0;
	background: transparent;
	font-family: inherit;
	font-size: 13px;
	line-height: 1.7;
	color: #45484f;
	text-overflow: ellipsis;
}

.child_reply_contents:not([readonly]) {
	margin: 4px 0 6px 18px;
	padding: 8px 10px;
	width: calc(100% - 18px);
	border: 1px solid #222;
	border-radius: 6px;
	background: #fff;
	color: #1a1a1f;
}

.child_reply_btn_box {
	display: flex;
	justify-content: flex-end;
	gap: 6px;
	padding: 0 4px 10px;
}

/* ===== 수정 모드 ===== */
.edit_mode {
	display: none;
}

.edit_head {
	padding: 22px 24px !important;
	margin-bottom: 0 !important;
	background: #fff;
	border: 1px solid #e5e7eb;
	border-top: 2px solid #222;
	border-radius: 8px 8px 0 0;
	font-size: 16px !important;
	font-weight: 400 !important;
	letter-spacing: 0 !important;
}

.edit_head+.review_body {
	border-top: 0;
	border-radius: 0 0 8px 8px;
}

/* 수정 모드 안에서는 가운데 정렬·여백을 부모가 맡으므로 해제 */
.edit_head .writer_box, .edit_head .view_count_box, .edit_head .recommend_box
	{
	max-width: none;
	margin: 0 0 3px;
	padding: 0;
}

.edit_head .recommend_box {
	margin-bottom: 0;
}

/* --- 장소 선택 --- */
.place_select {
	display: flex;
	gap: 8px;
	margin-top: 18px;
}

.place_select select {
	height: 40px;
	padding: 0 10px;
	border: 1px solid #ccc;
	border-radius: 6px;
	background: #fff;
	font-family: inherit;
	font-size: 13px;
	color: #333;
	cursor: pointer;
	transition: border-color .15s;
}

.place_select select:hover {
	border-color: #999;
}

.place_select select:focus {
	outline: 0;
	border-color: #555;
}

#placeType {
	width: 110px;
}

#region {
	width: 160px;
}

#target_id {
	flex: 1;
	min-width: 0;
}

/* --- 별점 --- */
.rating {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-top: 18px;
}

.rating_label {
	font-size: 13px;
	font-weight: 700;
	color: #333;
}

#stars {
	display: flex;
	gap: 2px;
}

.star {
	font-size: 26px;
	line-height: 1;
	color: #e0e0e0;
	cursor: pointer;
	transition: color .1s;
	user-select: none;
}

.star.on {
	color: #FFB400;
}

#ratingText {
	min-width: 20px;
	font-size: 14px;
	font-weight: 700;
	color: #FFB400;
}

/* --- 사진 올리는 칸 --- */
.photo_head {
	display: flex;
	align-items: center;
	gap: 5px;
	margin: 0 0 12px;
	font-size: 13px;
	font-weight: 700;
	color: #333;
}

.edit_mode .photo_box {
	display: flex;
	flex-direction: column;
}

.upload_box {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	gap: 10px;
	width: 100%;
	height: 280px;
	border: 2px dashed #d5d9de;
	border-radius: 10px;
	background: #fff;
	cursor: pointer;
	transition: border-color .15s, background .15s;
}

.upload_box:hover {
	border-color: #FF6B35;
	background: #fff8f5;
}

.upload_box .plus {
	display: flex;
	align-items: center;
	justify-content: center;
	width: 42px;
	height: 42px;
	border-radius: 50%;
	background: #f1f3f5;
	font-size: 24px;
	line-height: 1;
	color: #9aa0a6;
	transition: background .15s, color .15s;
}

.upload_box:hover .plus {
	background: #ffe8df;
	color: #FF6B35;
}

.upload_box .add_photo {
	font-size: 12px;
	font-weight: 600;
	color: #9a9aa0;
}

.upload_box:hover .add_photo {
	color: #FF6B35;
}

.photo_box:has(#preview:not(:empty)) .upload_box {
	display: none;
}

#preview {
	width: 100%;
	height: 280px;
	border-radius: 10px;
	overflow: hidden;
	background: #eef1f5;
	box-shadow: 0 2px 10px rgba(15, 23, 42, .10);
}

#preview:empty {
	display: none;
}

#preview img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

.deletePhoto {
	margin-top: auto;
	padding-top: 14px;
}

#photoDelete {
	width: 100%;
	height: 36px;
	border: 1px solid #e0e3e7;
	border-radius: 7px;
	background: #fff;
	font-family: inherit;
	font-size: 12px;
	font-weight: 600;
	color: #8b8f96;
	cursor: pointer;
	transition: border-color .15s, background .15s, color .15s;
}

#photoDelete:hover {
	border-color: #c0392b;
	background: #fdecea;
	color: #c0392b;
}

/* --- summernote --- */
.review_body>.note-editor.note-frame {
	flex: 1 1 320px;
	min-width: 0;
	margin: 0;
	border: 0;
	border-radius: 0;
}

.note-toolbar {
	background: #fafbfc;
	border-bottom: 1px solid #eceef1;
}

.note-statusbar {
	display: none;
}

.note-editable {
	font-family: inherit;
	font-size: 15px;
	line-height: 1.8;
	color: #33363c;
}

.note-editable img {
	max-width: 100%;
	height: auto;
	border-radius: 6px;
}

/* --- 수정 모드 태그 — 체크박스 칩 --- */
.tag_list_edit {
	display: flex;
	flex-wrap: wrap;
	gap: 6px;
}

.tag_list_edit label {
	padding: 6px 14px;
	border: 1px solid #ddd;
	border-radius: 18px;
	background: #fff;
	font-size: 12px;
	color: #666;
	cursor: pointer;
	user-select: none;
	transition: border-color .15s, background .15s, color .15s;
}

.tag_list_edit label:hover {
	border-color: #999;
}

.tag_list_edit label:has(input:checked) {
	border-color: #FF6B35;
	background: #fff5f0;
	color: #FF6B35;
	font-weight: 700;
}

.tag_list_edit input {
	display: none;
}

/* --- 수정 모드 버튼 --- */
#saveBtn {
	border: 1px solid #222;
	background: #222;
	color: #fff;
}

#saveBtn:hover {
	background: #FF6B35;
	border-color: #FF6B35;
}

#cancelBtn {
	border: 1px solid #ddd;
	background: #fff;
	color: #666;
	font-weight: 500;
}

#cancelBtn:hover {
	background: #f6f6f6;
	border-color: #bbb;
	color: #222;
}

/* ===== 보기 모드 본문 ===== */
#viewContents {
	flex: 1 1 320px;
	min-width: 0;
	min-height: 320px;
	padding: 20px 24px;
	background: #fff;
	font-size: 15px;
	line-height: 1.8;
	color: #33363c;
	word-break: break-all;
}

#viewContents p {
	margin: 0 0 8px;
}

#viewContents img {
	max-width: 100%;
	height: auto;
	border-radius: 6px;
}
</style>
</head>
<body>

	<c:choose>
		<c:when test="${sessionScope.loginId == rdto.member_id}">
			<!-- 보기 모드 -->
			<div class="view_mode">
				<div class="review_header">${placeName}</div>
				<div class="writer_box">
					<p id="writer">작성자</p>
					<input type="text" id="nickname" value="${nickname}" readonly>
				</div>
				<div class="view_count_box">
					조회수 :
					<p>${rdto.view_count}</p>
				</div>
				<div class="recommend_box">
					추천수 :
					<p>${recommend_count}</p>
				</div>
				<div class="review_body">
					<div class="photo_box">
						<div id="photo">
							<img src="${rdto.image1}">
						</div>
					</div>
					<div id="viewContents">${rdto.contents}</div>
					<div class="tag_box">
						<span class="tag_label">태그</span>
						<div class="tag_list">
							<c:forEach var="i" items="${myTags}">
								<div class="tag">${i}</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="recommend">
					<button type="button" class="heartBtn">
						<span class="heartIcon">♡</span>
					</button>
				</div>
				<div class="review_bottom">
					<button type="button" id="updateBtn">수정하기</button>
					<button type="button" id="deleteBtn">삭제하기</button>
					<button type="button" id="backBtn">뒤로가기</button>
				</div>
			</div>

			<!-- 수정모드 -->
			<form class="edit_mode" action="/review/update" method="post">
				<input type="hidden" name="seq" value="${rdto.seq}"> <input
					type="hidden" name="member_id" value="${rdto.member_id}">

				<div class="review_header edit_head">
					<div class="writer_box">
						<p id="writer">작성자</p>
						<input type="text" id="nickname" value="${nickname}" readonly>
					</div>
					<div class="view_count_box">
						조회수 :
						<p>${rdto.view_count}</p>
					</div>
					<div class="recommend_box">
						추천수 :
						<p>${recommend_count}</p>
					</div>
					<div class="place_select">
						<select id="placeType" name="target_type">
							<option value="">유형</option>
							<option value="STAY">숙소</option>
							<option value="FOOD">맛집</option>
							<option value="SPOT">관광지</option>
						</select> <select id="region">
							<option value="">전체</option>
							<option>서울특별시</option>
							<option>부산광역시</option>
							<option>대구광역시</option>
							<option>인천광역시</option>
							<option>대전광역시</option>
							<option>울산광역시</option>
							<option>세종특별자치시</option>
							<option>경기도</option>
							<option>강원특별자치도</option>
							<option>충청북도</option>
							<option>충청남도</option>
							<option>전북특별자치도</option>
							<option>전남광주통합특별시</option>
							<option>경상북도</option>
							<option>경상남도</option>
							<option>제주특별자치도</option>
						</select> <select id="target_id" name="target_id">
							<option value="${pdto.place_id}">${pdto.name}</option>
						</select>
					</div>
					<div class="rating">
						<span class="rating_label">별점</span>
						<div id="stars">
							<span class="star" data-val="1">★</span> <span class="star"
								data-val="2">★</span> <span class="star" data-val="3">★</span> <span
								class="star" data-val="4">★</span> <span class="star"
								data-val="5">★</span>
						</div>
						<span id="ratingText">${rdto.rating}</span> <input type="hidden"
							name="rating" id="rating" value="${rdto.rating}">
					</div>
				</div>

				<div class="review_body">
					<div class="photo_box">
						<p class="photo_head">사진</p>
						<label for="photoFile" class="upload_box"> <span
							class="plus">+</span> <span class="add_photo">사진 추가</span>
						</label> <input type="file" id="photoFile" accept="image/*" hidden>
						<div id="preview">
							<img src="${rdto.image1}">
						</div>
						<input type="hidden" name="image1" id="image1"
							value="${rdto.image1}">
						<div class="deletePhoto">
							<button type="button" id="photoDelete">사진 삭제</button>
						</div>
					</div>

					<textarea id="contents" name="contents">${rdto.contents}</textarea>

					<div class="tag_box">
						<span class="tag_label">태그</span>
						<div class="tag_list_edit">
							<label><input type="checkbox" name="tag" value="청결">청결</label>
							<label><input type="checkbox" name="tag" value="가성비">가성비</label>
							<label><input type="checkbox" name="tag" value="뷰맛집">뷰맛집</label>
							<label><input type="checkbox" name="tag" value="조용함">조용함</label>
							<label><input type="checkbox" name="tag" value="친절">친절</label>
							<label><input type="checkbox" name="tag" value="주차편함">주차편함</label>
							<label><input type="checkbox" name="tag" value="재방문의사">재방문의사</label>
							<label><input type="checkbox" name="tag" value="사진맛집">사진맛집</label>
							<label><input type="checkbox" name="tag" value="교통편리">교통편리</label>
							<label><input type="checkbox" name="tag" value="아이동반">아이동반</label>
						</div>
					</div>
				</div>

				<div class="review_bottom">
					<button type="submit" id="saveBtn">수정 완료</button>
					<button type="button" id="cancelBtn">취소</button>
				</div>
			</form>
		</c:when>
		<c:otherwise>
			<div class="review_header">${placeName}</div>
			<div class="writer_box">
				<p id="writer">작성자</p>
				<input type="text" id="nickname" value="${nickname}" readonly>
			</div>
			<div class="view_count_box">
				조회수 :
				<p>${rdto.view_count}</p>
			</div>
			<div class="recommend_box">
				추천수 :
				<p>${recommend_count}</p>
			</div>
			<div class="review_body">
				<div class="photo_box">
					<div id="photo">
						<img src="${rdto.image1}">
					</div>
				</div>
				<div id="viewContents">${rdto.contents}</div>
				<div class="tag_box">
					<span class="tag_label">태그</span>
					<div class="tag_list">
						<c:forEach var="i" items="${myTags}">
							<div class="tag">${i}</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="recommend">
				<button type="button" class="heartBtn">
					<span class="heartIcon">♡</span>
				</button>
			</div>
			<div class="review_bottom">
				<c:if test="${sessionScope.role == 'admin'}">
					<button type="button" id="deleteBtn">삭제하기</button>
				</c:if>
				<button type="button" id="backBtn">뒤로가기</button>
			</div>
		</c:otherwise>
	</c:choose>

	<div class="reply_area">

		<div class="reply_head">
			댓글 <span class="reply_num">${reply_count}</span>
		</div>

		<form class="reply_form" action="/review/reply/write" method="post">
			<input type="hidden" name="review_seq" value="${rdto.seq}">
			<textarea name="contents" id="replyContents"
				placeholder="댓글을 입력해 주세요."></textarea>
			<div class="register_btn_box">
				<button type="submit" id="replyBtn">등록</button>
			</div>
		</form>

		<div class="reply_list">
			<c:forEach var="i" items="${replyList}">
				<div class="reply_header">
					<span class="nickname">${i.nickname}</span> <span
						class="reply_date"> <fmt:formatDate value="${i.reg_date}"
							pattern="yyyy.MM.dd HH:mm" />
					</span>
				</div>
				<input type="text" class="reply_contents"
					id="reply_contents${i.seq}" value="${i.contents}" readonly>
				<div class="reply_btn_box" id="reply_btn_box${i.seq}">
					<button type="button" class="replyAnswerBtn"
						id="replyAnswerBtn${i.seq}">답글</button>
					<c:if test="${sessionScope.loginId == i.member_id}">
						<button type="button" class="replyUpdateBtn"
							id="replyUpdateBtn${i.seq}">수정</button>
					</c:if>
					<c:if
						test="${sessionScope.loginId == i.member_id or sessionScope.role == 'admin'}">
						<button type="button" class="replyDeleteBtn"
							id="replyDeleteBtn${i.seq}">삭제</button>
					</c:if>
					<form class="child_reply_form" id="child_reply_form${i.seq}"
						action="/review/reply/childWrite" method="post" hidden>
						<input type="hidden" name="review_seq" value="${rdto.seq}">
						<input type="hidden" name="parent_seq" value="${i.seq}">
						<textarea name="contents" id="childReplyContents${i.seq}"></textarea>
						<div class="child_register_btn_box">
							<button type="submit" id="childReplyBtn${i.seq}">등록</button>
						</div>
					</form>
				</div>
				<c:forEach var="j" items="${childList}">
					<c:if test="${j.parent_seq == i.seq}">
						<div class="childList">
							<div class="child_reply_header">
								<span class="child_nickname">${j.nickname}</span> <span
									class="child_reply_date"> <fmt:formatDate
										value="${j.reg_date}" pattern="yyyy.MM.dd HH:mm" />
								</span>
							</div>
							<input type="text" class="child_reply_contents"
								id="child_reply_contents${j.seq}" value="${j.contents}" readonly>
							<div class="child_reply_btn_box" id="child_reply_btn_box${j.seq}">
								<c:if test="${sessionScope.loginId == j.member_id}">
									<button type="button" class="childReplyUpdateBtn"
										id="childReplyUpdateBtn${j.seq}">수정</button>
								</c:if>
								<c:if
									test="${sessionScope.loginId == j.member_id or sessionScope.role == 'admin'}">
									<button type="button" class="childReplyDeleteBtn"
										id="childReplyDeleteBtn${j.seq}">삭제</button>
								</c:if>
							</div>
						</div>
						<script>
							$("#childReplyDeleteBtn${j.seq}").on("click", function() {
								location.href = "/review/reply/delete?seq=${j.seq}&review_seq=${rdto.seq}";
										
							})

							$("#childReplyUpdateBtn${j.seq}").on("click", function() {
								let input = $("#child_reply_contents${j.seq}");
								let before = input.val();

								input.prop("readonly", false).focus();

								$("#childReplyUpdateBtn${j.seq}").hide();
								$("#childReplyDeleteBtn${j.seq}").hide();

								let saveBtn = $("<button>").attr("type", "button")
									.addClass("childReplySaveBtn").text("저장");
								let cancelBtn = $("<button>").attr("type", "button")
									.addClass("childReplyCancelBtn").text("취소");

								$("#child_reply_btn_box${j.seq}").append(saveBtn).append(cancelBtn);

								saveBtn.on("click", function() {

									let contents = input.val().trim();

									$.ajax({
										url : "/review/reply/update",
										type : "post",
										data : {
											seq : ${j.seq},
											contents : contents
												},
												success : function() {
													input.prop("readonly", true);
													saveBtn.remove();
													cancelBtn.remove();
													$("#childReplyUpdateBtn${j.seq}").show();
													$("#childReplyDeleteBtn${j.seq}").show();
												}
											})
										})

										cancelBtn.on("click", function() {
											input.val(before).prop("readonly", true);
											saveBtn.remove();
											cancelBtn.remove();
											$("#childReplyUpdateBtn${j.seq}").show();
											$("#childReplyDeleteBtn${j.seq}").show();
										})
									})
									</script>
					</c:if>
				</c:forEach>

				<script>
					$("#replyDeleteBtn${i.seq}").on("click", function() {
						location.href = "/review/reply/delete?seq=${i.seq}&review_seq=${rdto.seq}";
						
					})

					$("#replyUpdateBtn${i.seq}").on("click", function() {

						let input = $("#reply_contents${i.seq}");
						let before = input.val();

						input.prop("readonly", false).focus();

						$("#replyUpdateBtn${i.seq}").hide();
						$("#replyDeleteBtn${i.seq}").hide();

						let saveBtn = $("<button>").attr("type", "button")
								.addClass("replySaveBtn").text("저장");
						let cancelBtn = $("<button>").attr("type", "button")
								.addClass("replyCancelBtn").text("취소");

						$("#reply_btn_box${i.seq}").append(saveBtn).append(cancelBtn);

						saveBtn.on("click", function() {

							let contents = input.val().trim();

							$.ajax({
								url : "/review/reply/update",
								type : "post",
								data : {
									seq : ${i.seq},
									contents : contents
								},
								success : function() {
									input.prop("readonly", true);
									saveBtn.remove();
									cancelBtn.remove();
									$("#replyUpdateBtn${i.seq}").show();
									$("#replyDeleteBtn${i.seq}").show();
								}
							})
						})

						cancelBtn.on("click", function() {
							input.val(before).prop("readonly", true);
							saveBtn.remove();
							cancelBtn.remove();
							$("#replyUpdateBtn${i.seq}").show();
							$("#replyDeleteBtn${i.seq}").show();
						})
					})
					
					$("#replyAnswerBtn${i.seq}").on("click", function() {
							$("#child_reply_form${i.seq}").show();
							$("#childReplyContents${i.seq}").focus();
						})
				</script>
			</c:forEach>
		</div>
	</div>

</body>
<script>
	$("#placeType").val("${pdto.place_type}");

	$("#region").val("${pdto.region}");

	function paintStars(val) {
		$(".star").each(function() {
			if ($(this).data("val") <= val) {
				$(this).addClass("on");
			} else {
				$(this).removeClass("on");
			}
		});
	}
	
	paintStars(${rdto.rating});
	
	$(".star").on("click", function() {
		let val = $(this).data("val");
		$("#rating").val(val);
		$("#ratingText").text(val);
		paintStars(val);
	})
	
	$("#region").on(
			"change",
			function() {
				let region = $(this).val();
				let placeType = $("#placeType").val();

				$("#target_id").empty().append("<option value=''>장소</option>");

				$.ajax({
					url : "/review/placeList",
					type : "get",
					data : {
						placeType : placeType,
						region : region
					},
					dataType : "json",
					success : function(list) {
						for (let i = 0; i < list.length; i++) {
							$("<option>").val(list[i].place_id).text(
									list[i].name).appendTo($("#target_id"));
						}
					}
				})
			})

	$("#photoFile").on(
		"change",
		function() {
			let form = new FormData();
			form.append("file", this.files[0]);

			$.ajax({
				url : "/file/uploadImageFile",
				type : "post",
				data : form,
				contentType : false,
				processData : false,
				dataType : "json",
				success : function(data) {
					$("#image1").val(data.url);

					$("#preview").append(
						$("<div class='thumb'>").append(
								$("<img>").attr("src", data.url)));
			}
		})
	})
	
	$("#photoDelete").on("click", function(){
		$("#preview").empty();
		$("#photoFile").val("");
		$("#image1").val("");
	})
	
	$("#backBtn").on("click", function() {
		location.href = "/review/reviewBoard?cpage=1";
	})

	$("#deleteBtn").on("click", function() {
		location.href = "/review/delete?seq=${rdto.seq}";
	})

	$("#updateBtn")
			.on(
					"click",
					function() {
						$(".view_mode").hide();
						$(".edit_mode").show();
						
						let myTags = [];
						<c:forEach var="i" items="${myTags}">
						myTags.push("${i}");
						</c:forEach>
						
						for (let i = 0; i < myTags.length; i++) {
							$(".tag_list_edit input[value=" + myTags[i] + "]").prop("checked", true);
						}
						
						$("#contents")
								.summernote(
										{
											height : 400,
											lang : 'ko-KR',
											toolbar : [
													[ 'fontname',
															[ 'fontname' ] ],
													[ 'fontsize',
															[ 'fontsize' ] ],
													[
															'style',
															[
																	'bold',
																	'italic',
																	'underline',
																	'strikethrough',
																	'clear' ] ],
													[
															'color',
															[ 'forecolor',
																	'color' ] ],
													[ 'table', [ 'table' ] ],
													[
															'para',
															[ 'ul', 'ol',
																	'paragraph' ] ],
													[ 'height', [ 'height' ] ],
													[
															'insert',
															[ 'picture',
																	'link',
																	'video' ] ] ],

											fontNames : [ 'Arial',
													'Arial Black',
													'Comic Sans MS',
													'Courier New', '맑은 고딕',
													'궁서', '굴림체', '굴림', '돋움체',
													'바탕체' ],

											fontSizes : [ '8', '9', '10', '11',
													'12', '14', '16', '18',
													'20', '22', '24', '28',
													'30', '36', '50', '72' ]

										})
										
										
					})
					
	$("#cancelBtn").on("click", function() {
		$(".view_mode").show();
		$(".edit_mode").hide();
	})
	
	let isRecommend = ${isRecommend};
	
	if (isRecommend) {
		$(".heartIcon").css("color", "#FF4757").text("♥");
	} else {
		$(".heartIcon").css("color", "#ccc").text("♡");
	}

	$(".heartBtn").on("click", function() {
		if (isRecommend) {
			location.href = "/review/recommendDown?seq=${rdto.seq}";
		} else {
			location.href = "/review/recommendUp?seq=${rdto.seq}";
		}
	})
	
	
	
</script>
</html>