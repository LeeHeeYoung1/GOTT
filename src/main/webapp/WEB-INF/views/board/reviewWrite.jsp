<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>
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

/* ===== 페이지 제목 ===== */
.review_title {
	max-width: 900px;
	margin: 48px auto 0;
	padding: 0 24px;
}

.review_title h1 {
	margin: 0 0 8px;
	font-size: 26px;
	font-weight: 800;
	letter-spacing: -0.03em;
	color: #1a1a1f;
}

.review_title p {
	margin: 0;
	font-size: 13px;
	color: #8b8f96;
	letter-spacing: -0.01em;
}

.review_container {
	max-width: 900px;
	margin: 22px auto 80px;
	padding: 0 24px;
}

/* ===== 상단 — 작성자 + 장소 + 별점 ===== */
.review_header {
	padding: 22px 24px;
	background: #fff;
	border: 1px solid #e5e7eb;
	border-top: 2px solid #222;
	border-radius: 8px 8px 0 0;
}

#writer {
	display: inline-block;
	margin: 0 10px 0 0;
	vertical-align: middle;
	font-size: 13px;
	font-weight: 700;
	color: #333;
}

#member_id {
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

/* ===== 별점 ===== */
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
	display: flex;
	flex-wrap: wrap;
	background: #fff;
	border: 1px solid #e5e7eb;
	border-top: 0;
	border-radius: 0 0 8px 8px;
	overflow: hidden;
}

/* --- 왼쪽: 사진 --- */
.photo_box {
	width: 250px;
	flex-shrink: 0;
	display: flex;
	flex-direction: column;
	padding: 18px 16px;
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

/* 필수 표시 점 */
.photo_head::after {
	content: "";
	width: 5px;
	height: 5px;
	border-radius: 50%;
	background: #FF6B35;
}

/* 사진 올리는 칸 */
.upload_box {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	gap: 10px;
	width: 100%;
	height: 210px;
	border: 2px dashed #d5d9de;
	border-radius: 10px;
	background: #fff;
	cursor: pointer;
	transition: border-color .15s, background .15s, transform .15s;
}

.upload_box:hover {
	border-color: #FF6B35;
	background: #fff8f5;
	transform: translateY(-1px);
}

.upload_box:active {
	transform: translateY(0);
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

/* 사진이 올라오면 "사진 추가" 칸 숨김 */
.photo_box:has(#preview:not(:empty)) .upload_box {
	display: none;
}

/* 미리보기 */
#preview:empty {
	display: none;
}

.thumb {
	position: relative;
	width: 100%;
	height: 210px;
	border-radius: 10px;
	overflow: hidden;
	background: #eef1f5;
	box-shadow: 0 2px 10px rgba(15, 23, 42, .10);
}

.thumb img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

/* 사진 삭제 버튼 — 항상 맨 아래 고정 */
.deletePhoto {
	margin-top: auto;
	padding-top: 14px;
}

#deleteBtn {
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

#deleteBtn:hover {
	border-color: #c0392b;
	background: #fdecea;
	color: #c0392b;
}

/* --- 오른쪽: summernote --- */
.review_body>.note-editor.note-frame {
	flex: 1 1 300px;
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
	background: #fafbfc;
	border-top: 1px solid #eceef1;
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

/* --- 아래: 태그 (한 줄 전체) --- */
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
	padding-top: 7px;
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

.tag_list label {
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

.tag_list label:hover {
	border-color: #999;
}

.tag_list label:has(input:checked) {
	border-color: #FF6B35;
	background: #fff5f0;
	color: #FF6B35;
	font-weight: 700;
}

.tag_list input {
	display: none;
}

/* ===== 버튼 ===== */
.review_bottom {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 28px;
}

.review_bottom button {
	min-width: 150px;
	height: 46px;
	border-radius: 7px;
	font-family: inherit;
	font-size: 14px;
	font-weight: 700;
	letter-spacing: -0.01em;
	cursor: pointer;
	transition: background .15s, border-color .15s, color .15s;
}

#submit {
	border: 1px solid #222;
	background: #222;
	color: #fff;
}

#submit:hover {
	background: #FF6B35;
	border-color: #FF6B35;
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
	<div class="review_title">
		<h1>리뷰 작성</h1>
		<p>방문한 숙소, 맛집, 관광지의 리뷰를 사진과 함께 남겨주세요</p>
	</div>
	<div class="review_container">
		<form action="/review/write" method="post">
			<div class="review_header">
				<p id="writer">작성자</p>
				<input type="text" id="member_id" name="member_id"
					value="${sessionScope.nickname}" readonly>
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

					<div id="preview"></div>
					<input type="hidden" name="image1" id="image1">
					<div class="deletePhoto">
						<button type="button" id="deleteBtn">사진 삭제</button>
					</div>
				</div>
				<textarea id="contents" name="contents"></textarea>
				<div class="tag_box">
					<span class="tag_label">태그</span>
					<div class="tag_list">
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
				<button id="submit">작성 완료</button>
				<button type="button" id="backBtn">취소</button>
			</div>
		</form>
	</div>
</body>

<script>
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

	$("#placeType").on("change", function() {
		$("#region").trigger("change");
	})

	$(".star").on("click", function() {
		let val = $(this).data("val");
		$("#rating").val(val);
		$("#ratingText").text(val);
		paintStars(val);
	})

	function paintStars(val) {
		$(".star").each(function() {
			if ($(this).data("val") <= val) {
				$(this).addClass("on");
			} else {
				$(this).removeClass("on");
			}
		});
	}

	$("#photo").on(
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

	$("#deleteBtn").on("click", function(){
		$("#preview").empty();
		$("photo").val("");
		$("#image1").val("");
	})
	$("#backBtn").on("click", function() {
		history.back();
	})

	$("#contents")
			.summernote(
					{
						height : 400,
						lang : 'ko-KR',
						placeholder : '다녀오신 곳은 어떠셨나요? 사진과 함께 남겨 주세요.',
						toolbar : [
								[ 'fontname', [ 'fontname' ] ],
								[ 'fontsize', [ 'fontsize' ] ],
								[
										'style',
										[ 'bold', 'italic', 'underline',
												'strikethrough', 'clear' ] ],
								[ 'color', [ 'forecolor', 'color' ] ],
								[ 'table', [ 'table' ] ],
								[ 'para', [ 'ul', 'ol', 'paragraph' ] ],
								[ 'height', [ 'height' ] ],
								[ 'insert', [ 'picture', 'link', 'video' ] ] ],

						fontNames : [ 'Arial', 'Arial Black', 'Comic Sans MS',
								'Courier New', '맑은 고딕', '궁서', '굴림체', '굴림',
								'돋움체', '바탕체' ],

						fontSizes : [ '8', '9', '10', '11', '12', '14', '16',
								'18', '20', '22', '24', '28', '30', '36', '50',
								'72' ]

					})
</script>
</html>