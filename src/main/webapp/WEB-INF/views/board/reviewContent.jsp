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

form {
	display: block;
}

/* ===== 상단 ===== */
.review_header {
	max-width: 900px;
	margin: 48px auto 18px;
	padding: 0 24px;
	font-size: 24px;
	font-weight: 800;
	letter-spacing: -0.03em;
}

#writer {
	display: inline-block;
	margin: 0 10px 0 0;
	vertical-align: middle;
	font-size: 13px;
	font-weight: 700;
	color: #333;
}

#nickname {
	display: inline-block;
	vertical-align: middle;
	width: 180px;
	height: 30px;
	margin: 0;
	padding: 0;
	border: 0;
	outline: 0;
	background: transparent;
	font-family: inherit;
	font-size: 14px;
	font-weight: 600;
	color: #1a1a1f;
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

.place_select select:disabled {
	background: #f6f6f6;
	color: #bbb;
	cursor: not-allowed;
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
	display: flex;
	flex-direction: column;
	padding: 20px;
	border-right: 1px solid #eceef1;
	background: #fafbfc;
}

.photo_head {
	display: flex;
	align-items: center;
	gap: 5px;
	margin: 0 0 12px;
	font-size: 13px;
	font-weight: 700;
	color: #333;
}

/* 사진 올리는 칸 */
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

#preview {
	width: 100%;
	height: 280px;
	border-radius: 10px;
	overflow: hidden;
	background: #eef1f5;
	box-shadow: 0 2px 10px rgba(15, 23, 42, .10);
}

#preview img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

#photo img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

/* 사진 삭제 버튼 */
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

/* --- 오른쪽 글 --- */
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
}

#contents[readonly] {
	cursor: default;
}

#contents:not([readonly]) {
	background: #fffdf9;
	box-shadow: inset 0 0 0 2px #FF6B35;
}

/* summernote 가 켜지면 오른쪽 칸 차지 */
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

/* ===== 하단 버튼 ===== */
.review_bottom {
	display: flex;
	justify-content: center;
	gap: 10px;
	max-width: 900px;
	margin: 24px auto 80px;
	padding: 0 24px;
}

/* 내 글 — 카드 안에 들어있어서 한 줄 전체 차지 */
.review_body>.review_bottom {
	width: 100%;
	max-width: none;
	margin: 0;
	padding: 18px 20px;
	border-top: 1px solid #eceef1;
	background: #fff;
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

</style>
</head>
<body>

	<c:choose>
		<c:when test="${sessionScope.loginId == rdto.member_id}">

			<form action="/review_update" method="post">
				<div class="review_header">
					<p id="writer">작성자</p>
					<input type="text" id="nickname" value="${sessionScope.nickname}"
						readonly> <input type="hidden" name="member_id"
						value="${sessionScope.loginId}">
					<div class="place_select">
						<select id="placeType" name="target_type">
							<option value="">유형</option>
							<option value="STAY">숙소</option>
							<option value="FOOD">맛집</option>
							<option value="SPOT">관광지</option>
						</select> <select id="region">
							<option value="">전체</option>
							<option value="서울특별시">서울특별시</option>
							<option value="부산광역시">부산광역시</option>
							<option value="대구광역시">대구광역시</option>
							<option value="인천광역시">인천광역시</option>
							<option value="대전광역시">대전광역시</option>
							<option value="울산광역시">울산광역시</option>
							<option value="세종특별자치시">세종특별자치시</option>
							<option value="경기도">경기도</option>
							<option value="강원특별자치도">강원특별자치도</option>
							<option value="충청북도">충청북도</option>
							<option value="충청남도">충청남도</option>
							<option value="전북특별자치도">전북특별자치도</option>
							<option value="전남광주통합특별시">전남광주통합특별시</option>
							<option value="경상북도">경상북도</option>
							<option value="경상남도">경상남도</option>
							<option value="제주특별자치도">제주특별자치도</option>
						</select> <select id="target_id" name="target_id">
							<option value="">장소</option>
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
						<span id="ratingText">0</span> <input type="hidden" name="rating"
							id="rating" value="0">
					</div>
				</div>
				<div class="review_body">
					<div class="photo_box">
						<p class="photo_head">사진 필수</p>
						<label for="photo" class="upload_box"> <span class="plus">+</span>
							<span class="add_photo">사진 추가</span>
						</label> <input type="file" id="photo" accept="image/*" hidden>

						<div id="preview"><img src="${rdto.image1}"></div>
						<input type="hidden" name="image1" id="image1">
						<div class="deletePhoto">
							<button type="button" id="photoDelete">사진 삭제</button>
						</div>
					</div>
					<textarea id="contents" name="contents" readonly>${rdto.contents}</textarea>
					<div class="tag_box">
						<span class="tag_label">태그</span>
						<div class="tag_list">
							<c:forEach var="i" items="${myTags}">
								<div class="tag">${i}</div>
							</c:forEach>
						</div>
					</div>

					<div class="review_bottom">
						<button type="button" id="updateBtn">수정</button>
						<button type="button" id="deleteBtn"">삭제</button>
						<button type="button" id="backBtn">뒤로가기</button>
					</div>
			</form>
		</c:when>
		<c:otherwise>
			<div class="review_header">${placeName}</div>
			<div class="review_body">
				<div class="photo_box">
					<div id="photo">
						<img src="${rdto.image1}">
					</div>
				</div>
				<textarea id="contents" name="contents" readonly>${rdto.contents}</textarea>
				<div class="tag_box">
					<span class="tag_label">태그</span>
					<div class="tag_list">
						<c:forEach var="i" items="${myTags}">
							<div class="tag">${i}</div>
						</c:forEach>
					</div>
				</div>
			</div>

			<div class="review_bottom">
				<button type="button" id="backBtn">뒤로가기</button>
			</div>
		</c:otherwise>
	</c:choose>
</body>
<script>
	$("#contents").val($("<div>").html($("#contents").val()).text());

	$("#backBtn").on("click", function() {
		history.back();
	})

	$("#deleteBtn").on("click", function() {
		location.href = "/review/delete?seq=${rdto.seq}";
	})

	$("#updateBtn")
			.on(
					"click",
					function(e) {
						$("#contents")
								.summernote(
										{
											height : 400,
											lang : 'ko-KR',
											placeholder : '다녀오신 곳은 어떠셨나요? 사진과 함께 남겨 주세요.',
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
</script>
</html>