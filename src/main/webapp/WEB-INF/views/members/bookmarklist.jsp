<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<title>GOTT 북마크</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

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

button {
    border: 1px solid #d5d5d5;
    background-color: white;
    cursor: pointer;
}

button:hover {
    background-color: #222;
    color: white;
    border-color: #222;
}

.main {
    width: 1200px;
    max-width: calc(100% - 40px);
    margin: 0 auto;
    padding-bottom: 80px;
}

.titleBox {
    text-align: center;
    padding: 105px 0 20px;
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

.searchOption {
    width: 900px;
    margin: 20px auto 12px;
    display: flex;
    align-items: center;
    font-size: 11px;
    color: #777;
}

.totalCount {
    margin-right: auto;
}

.bookmarkContentsBox {
    width: 900px;
    margin: 0 auto;
    border: 1px solid #ddd;
    border-radius: 7px;
    background: white;
    position: relative;
    padding-bottom: 50px;
}

.bookmarkTable {
    width: 100%;
    border-collapse: collapse;
}

.bookmarkTable th {
    height: 45px;
    background: #f7f7f7;
    border-bottom: 1px solid #ddd;
    color: #555;
    font-size: 12px;
    font-weight: 600;
    text-align: center;
}

.bookmarkTable td {
    height: 48px;
    padding: 0 10px;
    border-bottom: 1px solid #eee;
    color: #555;
    font-size: 12px;
    text-align: center;
}

.bookmarkTable tr:last-child td {
    border-bottom: 0;
}

.number { width: 70px; }
.title {
    width: auto;
    text-align: left !important;
}
.writer  { width: 100px; }
.view    { width: 70px; }
.recommend { width: 70px; }
.date    { width: 100px; }
.cancel  { width: 80px; }

.title a {
    display: block;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    color: #333;
}

.title a:hover {
    text-decoration: underline;
}

.bookmarkTable tr:hover {
    background: #fafafa;
}

/* 북마크 취소 버튼 */
.cancelBookmarkBtn {
    height: 28px;
    padding: 0 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
    color: #aaa;
    font-size: 11px;
    cursor: pointer;
}

.cancelBookmarkBtn:hover {
    background: #fff3f3;
    color: #e53935;
    border-color: #e57373;
}

/* 빈 목록 */
.emptyBox {
    text-align: center;
    padding: 80px 0;
    color: #aaa;
    font-size: 13px;
}

.emptyBox p {
    margin: 8px 0 0;
    font-size: 11px;
}

/* HOME 버튼 */
.btnbox {
    margin-top: 25px;
    padding-bottom: 30px;
    position: absolute;
    right: 20px;
    bottom: -10px;
}

#home {
    height: 34px;
    padding: 0 18px;
    border: 1px solid #222;
    border-radius: 5px;
    background: #222;
    color: white;
    font-size: 12px;
}

#home:hover {
    background: #444;
}
</style>

<div class="main">

    <div class="titleBox">
        <h2>북마크</h2>
        <h5>내가 저장한 게시글을 모아볼 수 있어요.</h5>
    </div>

    <div class="breadcrumb">
        홈 &nbsp;>&nbsp; <span>북마크</span>
    </div>

    <div class="searchOption">
        <div class="totalCount">
            총 <strong>${bookmarkCount}</strong>건
        </div>
    </div>

    <div class="bookmarkContentsBox">

        <table class="bookmarkTable">

            <tr>
                <th class="number">번호</th>
                <th class="title">제목</th>
                <th class="recommend">추천</th>
                <th class="writer">작성자</th>
                <th class="view">조회수</th>
                <th class="date">작성일</th>
                <th class="cancel">북마크</th>
            </tr>

            <c:choose>

                <c:when test="${empty bookmarkList}">
                    <tr>
                        <td colspan="7">
                            <div class="emptyBox">
                                ☆ 북마크한 게시글이 없어요.
                                <p>게시글에서 북마크 버튼을 눌러 저장해보세요!</p>
                            </div>
                        </td>
                    </tr>
                </c:when>

                <c:otherwise>
                    <c:forEach var="i" items="${bookmarkList}">
                        <tr>
                            <td class="number">${i.seq}</td>

                            <td class="title">
                                <a href="/board/boardContent?seq=${i.seq}&cpage=1">
                                    ${i.title}
                                </a>
                            </td>

                            <td class="recommend">${i.recommendCount}</td>
                            <td class="writer">${i.writer}</td>
                            <td class="view">${i.view_count}</td>
                            <td class="date">${i.write_date.toString().substring(0, 10)}</td>

                            <td class="cancel">
                                <button class="cancelBookmarkBtn"
                                    data-seq="${i.seq}">
                                    ★ 취소
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>

            </c:choose>

        </table>

        <div class="btnbox">
            <button id="home">HOME</button>
        </div>

    </div>

</div>

<script>
document.getElementById("home").onclick = function() {
    location.href = "/";
};

/* 북마크 취소 */
$(".cancelBookmarkBtn").on("click", function() {

    let btn = $(this);
    let board_seq = btn.data("seq");

    if (confirm("북마크를 취소하시겠습니까?")) {

        $.ajax({
            url: "/board/bookmark",
            type: "post",
            data: {
                board_seq: board_seq
            },
            success: function() {
                btn.closest("tr").fadeOut(300, function() {
                    $(this).remove();

                    /* 총 개수 업데이트 */
                    let count = $(".bookmarkTable tr").length - 2; // 헤더 제외
                    $(".totalCount strong").text(count);

                    /* 목록 비었을 때 */
                    if (count <= 0) {
                        $(".bookmarkTable tbody").html(
                            '<tr><td colspan="7">' +
                            '<div class="emptyBox">☆ 북마크한 게시글이 없어요.' +
                            '<p>게시글에서 북마크 버튼을 눌러 저장해보세요!</p>' +
                            '</div></td></tr>'
                        );
                        $(".totalCount strong").text(0);
                    }
                });
            }
        });

    }

});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>