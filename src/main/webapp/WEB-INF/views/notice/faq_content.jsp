<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="/css/public.css">

<title>GOTT FAQ</title>

<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>

<style>
* {
	box-sizing: border-box;
}

body {
	margin: 0;
	padding: 0;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	font-size: 16px;
	line-height: 1.5;
}

a {
	color: inherit;
	text-decoration: none;
}

/* 상단바 */
.headercontainer {
	width: 1200px;
	max-width: calc(100% - 40px);
	height: 70px;
	margin: 0 auto;
	padding: 0 30px;
	display: flex;
	align-items: center;
}

.logoBox {
	width: 100px;
	height: 40px;
	display: flex;
	justify-content: center;
	align-items: center;
	margin-right: 45px;
}

.logoBox img {
	width: 100%;
	height: 100%;
	object-fit: contain;
}

.nav {
	display: flex;
	gap: 25px;
}

.nav a {
	color: #333;
	font-size: 13px;
	white-space: nowrap;
}

.signBox {
	margin-left: auto;
	display: flex;
	gap: 10px;
}

.signBox a {
	color: #555;
	font-size: 11px;
}

.menu-icon {
	margin-left: 18px;
	font-size: 20px;
	cursor: pointer;
}

hr {
	border: 0;
	border-top: 1px solid #e5e5e5;
	margin: 0;
}

/* 메인 */
.main {
	width: 1200px;
	max-width: calc(100% - 40px);
	margin: 0 auto;
	padding-bottom: 80px;
}

/* 제목 */
.titleBox {
	text-align: center;
	padding: 35px 0 20px;
}

.titleBox h2 {
	margin: 0 0 5px;
	font-size: 25px;
	color: #222;
}

.titleBox h5 {
	margin: 0;
	font-size: 12px;
	font-weight: 400;
	color: #888;
}

/* 경로 */
.breadcrumb {
	margin: 0 100px;
	padding: 10px 0;
	font-size: 10px;
	color: #999;
	border-top: 1px solid #eee;
}

.breadcrumb span {
	color: #333;
	font-weight: 600;
}

/* 게시글 */
.contentsBox {
	width: 900px;
	max-width: 100%;
	margin: 35px auto 0;
	border: 1px solid #ddd;
	border-radius: 7px;
	background: white;
	overflow: hidden;
}

/* 게시글 제목 */
.contentsTitle {
	padding: 25px 30px 18px;
	border-bottom: 1px solid #eee;
}

.contentsTitle h3 {
	margin: 0 0 10px;
	font-size: 20px;
	color: #222;
	overflow-wrap: anywhere;
}

/* 작성자 정보 */
.contentsInfo {
	display: flex;
	flex-wrap: wrap;
	gap: 15px;
	color: #888;
	font-size: 11px;
}

.contentsInfo span {
	padding-right: 15px;
	border-right: 1px solid #ddd;
}

.contentsInfo span:last-child {
	border-right: 0;
}

/* 첨부파일 */
.fileBox {
	padding: 15px 30px;
	border-bottom: 1px solid #eee;
	background: #fafafa;
}

.fileTitle {
	margin-bottom: 8px;
	font-size: 11px;
	font-weight: 600;
	color: #777;
}

.fileList {
	display: flex;
	flex-direction: column;
	gap: 5px;
}

.fileList a {
	display: inline-block;
	width: fit-content;
	max-width: 100%;
	padding: 7px 10px;
	border: 1px solid #e5e5e5;
	border-radius: 4px;
	background: white;
	color: #555;
	font-size: 11px;
	overflow-wrap: anywhere;
}

.fileList a:hover {
	background: #f1f1f1;
	color: #222;
}

/* 게시글 내용 */
.contents {
	min-height: 300px;
	padding: 30px;
	color: #444;
	font-size: 13px;
	overflow-wrap: anywhere;
}

.contents img {
	max-width: 100%;
	height: auto;
}

/* 하단 버튼 */
.buttonBox {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 8px;
	padding: 20px 30px;
	border-top: 1px solid #eee;
}

.buttonBox button {
	height: 35px;
	padding: 0 20px;
	border: 1px solid #ccc;
	border-radius: 4px;
	background: white;
	color: #555;
	font-size: 11px;
	cursor: pointer;
}

.buttonBox button:hover {
	background: #222;
	color: white;
	border-color: #222;
}

/* 추천 */
.recommendBtn .heart {
	color: #aaa;
}

.recommendBtn .heart.active {
	color: #e53935;
}

.recommendBtn:hover {
	background: #fff5f5;
	color: #e53935;
	border-color: #e57373;
}

/* 모바일 */
@media ( max-width : 900px) {
	.headercontainer {
		padding: 0;
	}
	.logoBox {
		margin-right: 15px;
		flex-shrink: 0;
	}
	.nav {
		gap: 10px;
		overflow-x: auto;
	}
	.nav a {
		font-size: 11px;
	}
	.signBox {
		display: none;
	}
	.breadcrumb {
		margin: 0;
	}
	.contentsBox {
		margin-top: 20px;
	}
	.contentsTitle, .contents, .fileBox {
		padding-left: 18px;
		padding-right: 18px;
	}
}
</style>
</head>

<body>

	<!-- 상단바 -->
	<div class="headercontainer">

		<div class="logoBox">
			<a href="/"> <img src="/images/logo.png" alt="GOTT 로고">
			</a>
		</div>

		<nav class="nav">
			<a href="#">이벤트</a> <a href="#">지역</a> <a href="#">추천여행지</a> <a
				href="/reservation/list">숙박업소</a> <a href="#">리뷰</a> <a href="#">여행
				플래너</a> <a href="#">공지사항</a>
		</nav>

		<div class="signBox">
			<a href="/members/mypage">마이페이지</a> <a href="/members/logout">로그아웃</a>
		</div>

		<div class="menu-icon">☰</div>

	</div>

	<hr>

	<!-- 메인 -->
	<div class="main">

		<div class="titleBox">
			<h2>FAQ</h2>
			<h5>가장 궁금해하는 정보들</h5>
		</div>

		<div class="breadcrumb">
			홈 &nbsp;&gt;&nbsp; 문의사항 &nbsp;&gt;&nbsp; <span>게시글</span>
		</div>

		<!-- 게시글 -->
		<div class="contentsBox">

			<div class="contentsTitle">
				<h3>${faq.title}</h3>

				<div class="contentsInfo">
					<span>작성자 ${faq.writer}</span> <span>${faq.regdate}</span>
				</div>
			</div>

			<div class="contents">${faq.content}</div>

			<div class="buttonBox">
				<button type="button" onclick="location.href='/notice/faq'">
					목록</button>
			</div>

		</div>
		<!-- 첨부파일 -->
		<c:if test="${not empty flist}">
			<div class="fileBox">

				<div class="fileTitle">첨부파일</div>

				<div class="fileList">
					<c:forEach var="i" items="${flist}">
						<a
							href="/board/download?oriname=${i.oriname}&sysname=${i.sysname}">
							${i.oriname} </a>
					</c:forEach>
				</div>

			</div>
		</c:if>

		<!-- 게시글 내용 -->
		<div class="contents boardContents">${boardContent.contents}</div>

		<!-- 버튼 -->
		<div class="buttonBox">

			<button class="recommendBtn" type="button">
				<span class="heart ${checkRecommend > 0 ? 'active' : ''}">${checkRecommend > 0 ? '♥' : '♡'}</span>
				<span class="recommendCount">${recommendCount}</span>
			</button>

			<c:if test="${nickname == boardContent.writer}">

				<button class="boardUpdate" type="button">수정</button>

				<button class="boardDelete" type="button">삭제</button>

				<button class="boardUpdateCom" type="button" style="display: none;">
					수정완료</button>

				<button class="boardBack" type="button" style="display: none;">
					취소</button>

			</c:if>

			<button id="goBack" type="button">목록</button>

		</div>

	</div>



	<hr>

	<script>
let boardTitle;
let boardContents;

/* 게시글 수정 */
$(".boardUpdate").on("click", function() {

    boardTitle = $(".boardTitle").html();
    boardContents = $(".boardContents").html();

    $(".boardTitle").attr("contenteditable", "true");
    $(".boardContents").attr("contenteditable", "true");

    $(".boardUpdate").css("display", "none");
    $(".boardDelete").css("display", "none");

    $(".boardUpdateCom").css("display", "inline");
    $(".boardBack").css("display", "inline");
});

/* 게시글 수정 취소 */
$(".boardBack").on("click", function() {

    $(".boardTitle").html(boardTitle);
    $(".boardContents").html(boardContents);

    $(".boardTitle").attr("contenteditable", "false");
    $(".boardContents").attr("contenteditable", "false");

    $(".boardUpdate").css("display", "inline");
    $(".boardDelete").css("display", "inline");

    $(".boardUpdateCom").css("display", "none");
    $(".boardBack").css("display", "none");
});

/* 게시글 수정 완료 */
$(".boardUpdateCom").on("click", function() {

    let title = $(".boardTitle").text();
    let contents = $(".boardContents").html();

    $.ajax({
        url: "/board/update",
        type: "post",
        data: {
            seq: ${boardContent.seq},
            title: title,
            contents: contents
        },
        success: function() {

            $(".boardTitle").attr("contenteditable", "false");
            $(".boardContents").attr("contenteditable", "false");

            $(".boardUpdate").css("display", "inline");
            $(".boardDelete").css("display", "inline");

            $(".boardUpdateCom").css("display", "none");
            $(".boardBack").css("display", "none");
        },
        error: function() {
            alert("게시글 수정에 실패했습니다.");
        }
    });
});

/* 게시글 삭제 */
$(".boardDelete").on("click", function() {

    if (confirm("게시글을 삭제하시겠습니까?")) {
        location.href = "/board/boardDelete?seq=${boardContent.seq}&cpage=${cpage}";
    }
});

/* 목록 */
$("#goBack").on("click", function() {
    location.href = "/board/freeBoard?cpage=1";
});
</script>

</body>
</html>