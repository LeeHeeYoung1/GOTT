<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>

<link rel="stylesheet" href="/css/public.css">
<title>GOTT 글쓰기</title>
<style>
.writeMain {
	width: 1200px;
	max-width: calc(100% - 40px);
	margin: 0 auto;
	padding-bottom: 80px;
}

/* 제목 */
.writeTitle {
	text-align: center;
	padding: 35px 0 20px;
}

.writeTitle h2 {
	margin: 0 0 5px;
	font-size: 25px;
	color: #222;
}

.writeTitle h5 {
	margin: 0;
	font-size: 12px;
	font-weight: 400;
	color: #888;
}

/* 경로 */
.writeBreadcrumb {
	margin: 0 100px;
	padding: 10px 0;
	font-size: 10px;
	color: #999;
	border-top: 1px solid #eee;
}

.writeBreadcrumb span {
	color: #333;
	font-weight: 600;
}

/* 글쓰기 박스 */
.writeBox {
	width: 750px;
	margin: 40px auto 0;
	border: 1px solid #ddd;
	border-radius: 7px;
	padding: 30px;
}

/* 제목 / 작성자 */
.writeRow {
	display: flex;
	align-items: center;
	margin-bottom: 18px;
}

.writeRow label {
	width: 80px;
	font-size: 12px;
	font-weight: 600;
	color: #333;
}

.writeInput {
	flex: 1;
	height: 40px;
	padding: 0 12px;
	border: 1px solid #ccc;
	border-radius: 5px;
	outline: none;
	font-size: 12px;
}

.writeInput:focus {
	border-color: #555;
}

.writerInput {
	background-color: #f7f7f7;
	color: #777;
}

/* 내용 */
.contentsRow {
	display: flex;
	align-items: flex-start;
	margin-bottom: 18px;
}

.contentsRow label {
	width: 80px;
	padding-top: 10px;
	font-size: 12px;
	font-weight: 600;
	color: #333;
}

.contents {
	flex: 1;
	height: 350px;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 5px;
	resize: none;
	outline: none;
	font-family: inherit;
	font-size: 12px;
}

.contents:focus {
	border-color: #555;
}

/* 첨부파일 */
.fileRow {
	display: flex;
	align-items: center;
	margin-bottom: 25px;
}

.fileRow label {
	width: 80px;
	font-size: 12px;
	font-weight: 600;
	color: #333;
}

.fileRow input {
	font-size: 11px;
}

/* 버튼 */
.buttonBox {
	display: flex;
	justify-content: center;
	gap: 8px;
	margin-top: 10px;
}

.buttonBox button {
	height: 36px;
	padding: 0 20px;
	border: 1px solid #222;
	border-radius: 4px;
	background: white;
	color: #222;
	font-size: 11px;
	cursor: pointer;
}

.buttonBox button:hover {
	background: #222;
	color: white;
}

.buttonBox .submitBtn {
	background: #222;
	color: white;
}

.buttonBox .submitBtn:hover {
	background: #444;
}
</style>


<div class="writeMain">

	<div class="writeTitle">
		<h2>글쓰기</h2>
		<h5>여행에 대한 이야기를 자유롭게 남겨보세요.</h5>
	</div>

	<div class="writeBreadcrumb">
		홈 &nbsp;>&nbsp; 게시판 &nbsp;>&nbsp; <span>글쓰기</span>
	</div>

	<form class="writeBox" action="/board/writeRegi">

		<div class="writeRow">
			<label>제목</label> <input type="text" name="title" class="writeInput"
				placeholder="제목을 입력해주세요.">
		</div>


		<div class="writeRow">
			<label>작성자</label> <input type="text" class="writeInput writerInput" value="${nickname}" readonly>
		</div>


		<div class="contentsRow">
			<label>내용</label>

			<textarea name="contents" class="contents" placeholder="내용을 입력해주세요."></textarea>
		</div>


		<div class="fileRow">
			<label>첨부파일</label> <input type="file" name="file">
		</div>


		<div class="buttonBox">

			<button type="button" onclick="location.href='/board/freeBoard'">
				취소</button>

			<button type="submit" class="submitBtn">등록</button>

		</div>

	</form>

</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>