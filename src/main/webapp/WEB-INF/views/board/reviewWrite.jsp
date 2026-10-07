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

.review_container {
	max-width: 900px;
	margin: 40px auto 80px;
	padding: 0 24px;
}

/* ===== 상단 — 작성자 + 장소 선택 ===== */
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

/* ===== 본문 — summernote ===== */
.note-editor.note-frame {
	margin: 0;
	border: 1px solid #e5e7eb;
	border-top: 0;
	border-radius: 0;
}

.note-toolbar {
	background: #fafbfc;
	border-bottom: 1px solid #eceef1;
}

.note-statusbar {
	background: #fafbfc;
	border-top: 1px solid #eceef1;
	border-radius: 0 0 8px 8px;
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
	<div class="review_container">
		<div class="review_header">
			<p id="writer">작성자</p>
			<input type="text" id="member_id" name="member_id"
				value="${sessionScope.loginId}" readonly>
			<div class="place_select">
				<select id="placeType">
					<option value="">유형</option>
					<option value="STAY">숙소</option>
					<option value="FOOD">맛집</option>
					<option value="SPOT">관광지</option>
				</select> <select id="region" name="region">
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
		</div>

		<div class="review_body"></div>
		<textarea id="contents" name="contents"></textarea>
		<div class="review_bottom">
			<button id="submit">작성 완료</button>
			<button type="button" id="backBtn">취소</button>
		</div>
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

	$("#backBtn").on("click", function(){
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