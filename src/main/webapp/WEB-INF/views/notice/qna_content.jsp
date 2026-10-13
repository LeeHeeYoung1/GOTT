<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>


<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-size: 16px;
    line-height: 1.5;
}

a {
    color: inherit;
    text-decoration: none;
}

button {
    cursor: pointer;
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

.contentsTitle {
    padding: 25px 30px 18px;
    border-bottom: 1px solid #eee;
}

.contentsTitle h3 {
    margin: 0 0 10px;
    font-size: 20px;
    color: #222;
}

.contentsInfo {
    display: flex;
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

.contents {
    min-height: 200px;
    padding: 30px;
    color: #444;
    font-size: 13px;
    white-space: pre-wrap;
    overflow-wrap: anywhere;
}

/* 게시글 버튼 */
.buttonBox {
    display: flex;
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
}

.buttonBox button:hover {
    background: #222;
    color: white;
    border-color: #222;
}

/* ===== 관리자 답변 (자유게시판 댓글 CSS와 동일) ===== */
.replyBox {
    width: 900px;
    max-width: 100%;
    margin: 30px auto 80px;
}

.replyHeader {
    display: flex;
    align-items: center;
    gap: 7px;
    margin-bottom: 15px;
}

.replyHeader h3 {
    margin: 0;
    font-size: 17px;
    color: #222;
}

.replyHeader span {
    font-size: 12px;
    color: #888;
}

.replyWrite {
    padding: 18px;
    border: 1px solid #ddd;
    border-radius: 7px;
    background: #fafafa;
}

.replyWriter {
    margin-bottom: 10px;
    font-size: 12px;
    font-weight: 600;
    color: #555;
}

.replyWrite textarea {
    display: block;
    width: 100%;
    height: 90px;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 5px;
    background: white;
    resize: none;
    outline: none;
    font-family: inherit;
    font-size: 12px;
}

.replyWrite textarea:focus {
    border-color: #999;
}

.replyWriteBottom {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 10px;
}

.replyWriteBottom span {
    font-size: 10px;
    color: #999;
}

.replyWriteBottom button {
    height: 32px;
    padding: 0 15px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background: white;
    color: #555;
    font-size: 11px;
    cursor: pointer;
}

.replyWriteBottom button:hover {
    background: #222;
    color: white;
    border-color: #222;
}

.replyList {
    margin-top: 10px;
}

.reply {
    position: relative;
    padding: 18px 5px;
    border-bottom: 1px solid #eee;
}

.replyInfo {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 8px;
}

.replyInfo strong {
    font-size: 12px;
    color: #333;
}

.replyInfo span {
    font-size: 10px;
    color: #aaa;
}

.replyContents {
    padding-right: 80px;
    color: #555;
    font-size: 12px;
    line-height: 1.6;
    white-space: pre-wrap;
    overflow-wrap: anywhere;
}

.replyButton {
    position: absolute;
    top: 17px;
    right: 5px;
}

.replyButton button {
    padding: 0;
    margin-left: 8px;
    border: 0;
    background: none;
    color: #aaa;
    font-size: 10px;
    cursor: pointer;
}

.replyButton button:hover {
    color: #333;
}

.noReply {
    padding: 30px 5px;
    border-bottom: 1px solid #eee;
    text-align: center;
    color: #aaa;
    font-size: 12px;
}

/* 반응형 */
@media (max-width: 960px) {
    .contentsBox,
    .replyBox {
        width: 100%;
    }

    .breadcrumb {
        margin: 0;
    }
}
</style>

<div class="main">

    <div class="titleBox">
        <h2>문의게시판</h2>
        <h5>궁금한 점을 문의해 주세요.</h5>
    </div>

    <div class="breadcrumb">
        홈 &nbsp;&gt;&nbsp; 문의게시판 &nbsp;&gt;&nbsp;
        <span>문의 상세</span>
    </div>

    <div class="contentsBox">

        <div class="contentsTitle">
            <h3>${qna.title}</h3>

            <div class="contentsInfo">
                <span>작성자 ${nickname}</span>
                <span>
                    ${qna.write_date.toString().substring(0, 10)}
                </span>
                <c:if test="${qna.is_private == 'Y'}">
                    <span>비밀글</span>
                </c:if>
            </div>
        </div>

<div class="contents">
    ${qna.contents}
</div>

<c:if test="${not empty fileList}">
    <div style="padding: 15px 30px; border-top: 1px solid #eee;">
        <strong>첨부파일</strong>

        <c:forEach var="file" items="${fileList}">
            <div style="margin-top: 8px;">
                <a href="/notice/qna_download?oriname=${file.oriname}&sysname=${file.sysname}"
                   style="color: #333; text-decoration: underline;">
                    ${file.oriname}
                </a>
            </div>
        </c:forEach>
    </div>
</c:if>

<div class="buttonBox">
    <button type="button" id="goList">목록</button>
</div>

    </div>

    <div class="replyBox">

        <div class="replyHeader">
            <h3>관리자 답변</h3>
            <span id="replyCount">${empty qna.reply ? 0 : 1}</span>
        </div>

        <!-- 답변 작성/수정창 (관리자 전용) -->
        <c:if test="${loginId == 'admin0001'}">

            <form id="replyForm" class="replyWrite"
                action="/notice/qna_reply" method="post"
                style="${empty qna.reply ? '' : 'display:none;'}">

                <input type="hidden" name="qid" value="${qna.qid}">
                <input type="hidden" name="cpage" value="${cpage}">

                <div class="replyWriter">${loginId}</div>

                <textarea id="replyInput" name="reply"
                    placeholder="답변을 입력해주세요."></textarea>

                <div class="replyWriteBottom">
                    <span>답변을 작성해 문의에 답변해 주세요.</span>

                    <div style="display:flex; gap:8px;">
                        <button type="button" id="saveBtn">답변 등록</button>
                        <button type="button" id="updateBtn"
                            style="display:none;">수정 완료</button>
                        <button type="button" id="cancelBtn"
                            style="display:none;">취소</button>
                    </div>
                </div>
            </form>

        </c:if>

        <!-- 답변 목록 -->
        <div class="replyList">

            <div class="reply" id="replyItem"
                style="${empty qna.reply ? 'display:none;' : ''}">

                <div class="replyInfo">
                    <strong>관리자</strong>
                </div>

                <div class="replyContents" id="replyContent"><c:out value="${qna.reply}" /></div>

                <c:if test="${loginId == 'admin0001'}">
                    <div class="replyButton" id="replyButtons">
                        <button type="button" id="editBtn">수정</button>
                        <button type="button" id="deleteBtn">삭제</button>
                    </div>
                </c:if>

            </div>

            <div class="noReply" id="noReply"
                style="${empty qna.reply ? '' : 'display:none;'}">
                아직 등록된 답변이 없습니다.
            </div>

        </div>

    </div>

</div>

<script>
let originalReply = "";

$("#goList").on("click", function() {
    location.href = "/notice/qna?cpage=${cpage}";
});

/* 답변 등록 */
$("#saveBtn").on("click", function() {
    let reply = $("#replyInput").val().trim();

    if (reply == "") {
        alert("답변을 입력해주세요.");
        return;
    }

    $.ajax({
        url: "/notice/qna_reply",
        type: "post",
        data: {
            qid: "${qna.qid}",
            cpage: "${cpage}",
            reply: reply
        },
        success: function() {
            $("#replyContent").text(reply);
            $("#replyItem").css("display", "block");
            $("#noReply").css("display", "none");
            $("#replyForm").css("display", "none");
            $("#replyButtons").css("display", "block");
            $("#replyCount").text(1);
        },
        error: function() {
            alert("답변 등록에 실패했습니다.");
        }
    });
});

/* 답변 수정창 열기 */
$("#editBtn").on("click", function() {
    originalReply = $("#replyContent").text().trim();

    $("#replyInput").val(originalReply);
    $("#replyForm").css("display", "block");
    $("#saveBtn").css("display", "none");
    $("#updateBtn").css("display", "inline");
    $("#cancelBtn").css("display", "inline");
    $("#replyButtons").css("display", "none");
});

/* 답변 수정 취소 */
$("#cancelBtn").on("click", function() {
    $("#replyForm").css("display", "none");
    $("#replyButtons").css("display", "block");
    $("#replyInput").val(originalReply);
});

/* 답변 수정 완료 */
$("#updateBtn").on("click", function() {
    let reply = $("#replyInput").val().trim();

    if (reply == "") {
        alert("답변을 입력해주세요.");
        return;
    }

    $.ajax({
        url: "/notice/qna_reply_update",
        type: "post",
        data: {
            qid: "${qna.qid}",
            cpage: "${cpage}",
            reply: reply
        },
        success: function() {
            $("#replyContent").text(reply);
            $("#replyForm").css("display", "none");
            $("#replyButtons").css("display", "block");
        },
        error: function() {
            alert("답변 수정에 실패했습니다.");
        }
    });
});

/* 답변 삭제 */
$("#deleteBtn").on("click", function() {
    if (!confirm("답변을 삭제하시겠습니까?")) {
        return;
    }

    $.ajax({
        url: "/notice/qna_reply_delete",
        type: "post",
        data: {
            qid: "${qna.qid}",
            cpage: "${cpage}"
        },
        success: function() {
            $("#replyItem").css("display", "none");
            $("#noReply").css("display", "block");
            $("#replyCount").text(0);

            /* 다시 작성 모드로 */
            $("#replyInput").val("");
            $("#replyForm").css("display", "block");
            $("#saveBtn").css("display", "inline");
            $("#updateBtn").css("display", "none");
            $("#cancelBtn").css("display", "none");
        },
        error: function() {
            alert("답변 삭제에 실패했습니다.");
        }
    });
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
