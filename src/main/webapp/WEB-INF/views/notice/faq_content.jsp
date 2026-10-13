<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
.faqDetailMain {
    width: 1200px;
    max-width: calc(100% - 40px);
    margin: 0 auto;
    padding-bottom: 80px;
}

.faqDetailTitleBox {
    text-align: center;
    padding: 35px 0 20px;
}

.faqDetailTitleBox h2 {
    margin: 0 0 5px;
    font-size: 25px;
    color: #222;
}

.faqDetailTitleBox h5 {
    margin: 0;
    font-size: 12px;
    font-weight: 400;
    color: #888;
}

.faqDetailBreadcrumb {
    margin: 0 100px;
    padding: 10px 0;
    font-size: 10px;
    color: #999;
    border-top: 1px solid #eee;
}

.faqDetailBreadcrumb span {
    color: #333;
    font-weight: 600;
}

.faqDetailContentsBox {
    width: 900px;
    max-width: 100%;
    margin: 35px auto 0;
    border: 1px solid #ddd;
    border-radius: 7px;
    background: white;
    overflow: hidden;
}

.faqDetailContentsTitle {
    padding: 25px 30px 18px;
    border-bottom: 1px solid #eee;
}

.faqDetailContentsTitle h3 {
    margin: 0 0 10px;
    font-size: 20px;
    color: #222;
    overflow-wrap: anywhere;
}

.faqDetailContentsInfo {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    color: #888;
    font-size: 11px;
}

.faqDetailContentsInfo span {
    padding-right: 15px;
    border-right: 1px solid #ddd;
}

.faqDetailContentsInfo span:last-child {
    border-right: 0;
}

.faqDetailFileBox {
    padding: 15px 30px;
    border-bottom: 1px solid #eee;
    background: #fafafa;
}

.faqDetailFileTitle {
    margin-bottom: 8px;
    font-size: 11px;
    font-weight: 600;
    color: #777;
}

.faqDetailFileList {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.faqDetailFileList a {
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

.faqDetailFileList a:hover {
    background: #f1f1f1;
    color: #222;
}

.faqDetailContent {
    min-height: 300px;
    padding: 30px;
    color: #444;
    font-size: 13px;
    overflow-wrap: anywhere;
}

.faqDetailContent img {
    max-width: 100%;
    height: auto;
}

.faqDetailButtonBox {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 8px;
    padding: 20px 30px;
    border-top: 1px solid #eee;
}

.faqEditInput {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
}

.faqEditContent {
    width: 100%;
    min-height: 300px;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-family: inherit;
    font-size: 13px;
    resize: vertical;
}

.faqDetailButtonBox button {
    height: 35px;
    padding: 0 20px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background: white;
    color: #555;
    font-size: 11px;
    cursor: pointer;
}

.faqDetailButtonBox button:hover {
    background: #222;
    color: white;
    border-color: #222;
}

@media (max-width: 900px) {
    .faqDetailBreadcrumb {
        margin: 0;
    }

    .faqDetailContentsBox {
        margin-top: 20px;
    }

    .faqDetailContentsTitle,
    .faqDetailContent,
    .faqDetailFileBox {
        padding-left: 18px;
        padding-right: 18px;
    }
}
</style>

<div class="faqDetailMain">

    <div class="faqDetailTitleBox">
        <h2>FAQ</h2>
        <h5>가장 궁금해하는 정보들</h5>
    </div>

    <div class="faqDetailBreadcrumb">
        홈 &nbsp;&gt;&nbsp; 문의사항 &nbsp;&gt;&nbsp;
        <span>FAQ</span>
    </div>

    <div class="faqDetailContentsBox">

        <div class="faqDetailContentsTitle">
            <h3 id="faqTitle">${faq.title}</h3>

            <div class="faqDetailContentsInfo">
                <span>작성자 ${faq.writer}</span>
                <span>${faq.regdate}</span>
            </div>
        </div>

        <c:if test="${not empty flist}">
            <div class="faqDetailFileBox">

                <div class="faqDetailFileTitle">첨부파일</div>

                <div class="faqDetailFileList">
                    <c:forEach var="i" items="${flist}">
                        <a href="/notice/download?oriname=${i.oriname}&sysname=${i.sysname}">
                            ${i.sysname}
                        </a>
                    </c:forEach>
                </div>

            </div>
        </c:if>

        <div class="faqDetailContent" id="faqContent">${faq.content}</div>

        <form action="/notice/faq_update" method="post" id="updateForm">
            <input type="hidden" name="faq_id" value="${faq.faq_id}">
            <input type="hidden" name="cpage" value="${cpage}">
            <input type="hidden" name="keyword" value="${keyword}">
            <input type="hidden" name="title" id="formTitle">
            <input type="hidden" name="content" id="formContent">

            <div class="faqDetailButtonBox">
                <c:if test="${loginId == 'admin0001'}">
                    <button type="button" id="editBtn">수정</button>
                    <button type="button" id="deleteBtn">삭제</button>
                    <button type="submit" id="saveBtn" style="display: none;">수정 완료</button>
                    <button type="button" id="cancelBtn" style="display: none;">취소</button>
                </c:if>

                <button type="button" id="listBtn">목록</button>
            </div>
        </form>

    </div>
</div>

<script>
let title = $("#faqTitle");
let content = $("#faqContent");

let titleText = title.html();
let contentText = content.html();

let buttons = $(".faqDetailButtonBox");

let editBtn = $("#editBtn");
let deleteBtn = $("#deleteBtn");
let saveBtn = $("#saveBtn");
let cancelBtn = $("#cancelBtn");
let listBtn = $("#listBtn");

editBtn.on("click", function() {
    title.attr("contenteditable", "true");
    content.attr("contenteditable", "true");

    editBtn.css("display", "none");
    deleteBtn.css("display", "none");
    listBtn.css("display", "none");

    buttons.append(saveBtn);
    buttons.append(cancelBtn);

    saveBtn.css("display", "inline");
    cancelBtn.css("display", "inline");
});

cancelBtn.on("click", function() {
    title.html(titleText);
    content.html(contentText);

    title.attr("contenteditable", "false");
    content.attr("contenteditable", "false");

    saveBtn.css("display", "none");
    cancelBtn.css("display", "none");

    buttons.append(editBtn);
    buttons.append(deleteBtn);
    buttons.append(listBtn);

    editBtn.css("display", "inline");
    deleteBtn.css("display", "inline");
    listBtn.css("display", "inline");
});

listBtn.on("click", function() {
    location.href = "/notice/faq?cpage=${cpage}&keyword=${keyword}";
});

deleteBtn.on("click", function() {
    if (confirm("정말 삭제하시겠습니까?")) {
        location.href = "/notice/faq_delete?faq_id=${faq.faq_id}&cpage=${cpage}";
    }
});

$("#updateForm").on("submit", function() {
    let newTitle = title.html().trim();
    let newContent = content.html().trim();

    if (newTitle == "") {
        alert("제목을 입력해주세요.");
        return false;
    }

    if (newContent == "") {
        alert("내용을 입력해주세요.");
        return false;
    }

    $("#formTitle").val(newTitle);
    $("#formContent").val(newContent);
});

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>