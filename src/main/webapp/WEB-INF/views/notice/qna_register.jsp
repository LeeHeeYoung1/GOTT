<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Q&A 글쓰기</title>

<script src="https://code.jquery.com/jquery-3.7.1.js"
    integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
    crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>

<style>
.qnaWriteMain {
    width: 1200px;
    margin: 50px auto;
    min-height: 600px;
}

.qnaWriteTitle {
    text-align: center;
    margin-bottom: 15px;
    font-size: 30px;
    font-weight: bold;
}

.qnaWriteBreadcrumb {
    text-align: center;
    color: #888;
    font-size: 14px;
    margin-bottom: 35px;
}

.qnaWriteBox {
    width: 750px;
    margin: 0 auto;
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 30px;
    box-sizing: border-box;
}

.qnaWriteRow {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
}

.qnaWriteLabel {
    width: 80px;
    flex-shrink: 0;
    font-size: 15px;
    font-weight: bold;
}

.qnaWriteInput {
    width: 100%;
    height: 40px;
    padding: 0 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box;
    font-size: 14px;
}

.qnaWriteWriter {
    background-color: #f5f5f5;
}

.qnaWritePrivate {
    display: flex;
    align-items: center;
    gap: 8px;
    margin: 5px 0 20px 80px;
    font-size: 14px;
}

.qnaWritePrivate input {
    width: 16px;
    height: 16px;
    cursor: pointer;
}

.qnaWriteContentRow {
    display: flex;
}

.qnaWriteContentRow > div {
    width: 100%;
    min-width: 0;
}

.qnaWriteContentLabel {
    width: 80px;
    flex-shrink: 0;
    padding-top: 10px;
    font-size: 15px;
    font-weight: bold;
}

.qnaWriteButtonBox {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-top: 25px;
}

.qnaWriteButton {
    height: 40px;
    padding: 0 25px;
    border: none;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
}

.qnaWriteSubmit {
    background-color: #333;
    color: white;
}

.qnaWriteCancel {
    background-color: #eee;
    color: #333;
}

.qnaAttachRow {
    display: flex;
    align-items: flex-start;
    margin-top: 25px;
    margin-bottom: 20px;
}

.qnaAttachBox {
    flex: 1;
    min-width: 0;
}

.qnaFileItem {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 10px;
    padding: 7px;
    border: 1px solid #ddd;
    border-radius: 5px;
    background-color: #fafafa;
    box-sizing: border-box;
}

.qnaFileItem input {
    flex: 1;
    width: 0;
    min-width: 0;
    font-size: 12px;
    color: #555;
}

.qnaFileItem input::file-selector-button {
    padding: 8px 12px;
    margin-right: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: white;
    color: #444;
    cursor: pointer;
}

.qnaFileItem input::file-selector-button:hover {
    background-color: #eee;
}

.qnaDeleteFile {
    flex-shrink: 0;
    padding: 8px 12px;
    border: 1px solid #e0b7b7;
    border-radius: 4px;
    background-color: #fff;
    color: #c44;
    font-size: 12px;
    cursor: pointer;
}

.qnaDeleteFile:hover {
    background-color: #fff0f0;
}

.qnaAddFile {
    padding: 9px 14px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: white;
    color: #444;
    font-size: 12px;
    cursor: pointer;
}

.qnaAddFile:hover {
    background-color: #f1f1f1;
}

@media (max-width: 800px) {
    .qnaWriteMain {
        width: auto;
        margin: 30px 15px;
    }

    .qnaWriteBox {
        width: 100%;
        padding: 20px;
    }
}
</style>
</head>

<body>

<div class="qnaWriteMain">

    <div class="qnaWriteTitle">Q&A</div>

    <div class="qnaWriteBreadcrumb">
        HOME &gt; 고객센터 &gt; Q&A 글쓰기
    </div>

    <form action="/notice/qnaWrite?cpage=${cpage}" method="post"
        enctype="multipart/form-data">

        <div class="qnaWriteBox">

            <div class="qnaWriteRow">
                <label class="qnaWriteLabel">제목</label>
                <input type="text" class="qnaWriteInput" id="title"
                    name="title" placeholder="제목을 입력해주세요.">
            </div>

            <div class="qnaWriteRow">
                <label class="qnaWriteLabel">작성자</label>
                <input type="text" class="qnaWriteInput qnaWriteWriter"
                    value="${nickname}" readonly>
            </div>

            <div class="qnaWriteRow">
                <label class="qnaWriteLabel">비밀번호</label>
                <input type="password" class="qnaWriteInput" id="pw"
                    name="pw" placeholder="비공개 글 확인용 비밀번호" disabled>
            </div>

            <div class="qnaWritePrivate">
                <input type="checkbox" id="qnaPrivate"
                    name="is_private" value="Y">
                <label for="qnaPrivate">비공개 글로 작성</label>
            </div>

            <div class="qnaWriteContentRow">
                <label class="qnaWriteContentLabel">내용</label>
                <div>
                    <textarea id="contents" name="contents"
                        placeholder="문의 내용을 입력해주세요."></textarea>
                </div>
            </div>

            <div class="qnaAttachRow">
                <label class="qnaWriteLabel">첨부파일</label>

                <div class="qnaAttachBox">
                    <div id="fileList">
                        <div class="qnaFileItem">
                            <input type="file" name="attachFiles">
                            <button type="button" class="qnaDeleteFile"
                                onclick="deleteFile(this)">삭제</button>
                        </div>
                    </div>

                    <button type="button" class="qnaAddFile"
                        onclick="addFile()">+ 파일 추가</button>
                </div>
            </div>

            <div class="qnaWriteButtonBox">
                <button type="submit" class="qnaWriteButton qnaWriteSubmit">
                    등록
                </button>

                <button type="button" class="qnaWriteButton qnaWriteCancel"
                    onclick="location.href='/notice/qna?cpage=${cpage}'">
                    취소
                </button>
            </div>

        </div>
    </form>
</div>

<script>
$("#qnaPrivate").on("click", function() {
    if ($(this).is(":checked")) {
        $("#pw").prop("disabled", false);
        $("#pw").attr("placeholder", "");
    } else {
        $("#pw").prop("disabled", true);
        $("#pw").val("");
        $("#pw").attr("placeholder", "비공개 글 확인용 비밀번호");
    }
});

$(document).ready(function() {
    $("#contents").summernote({
        height: 300,
        placeholder: "문의 내용을 입력해주세요.",
        lang: "ko-KR",
        toolbar: [
            ["font", ["bold", "underline", "clear"]],
            ["fontname", ["fontname"]],
            ["fontsize", ["fontsize"]],
            ["color", ["color"]],
            ["para", ["ul", "ol", "paragraph"]],
            ["insert", ["picture", "link"]],
            ["view", ["fullscreen", "codeview"]]
        ]
    });
});

function addFile() {
    let div = document.createElement("div");
    let input = document.createElement("input");
    let button = document.createElement("button");

    input.setAttribute("type", "file");
    input.setAttribute("name", "attachFiles");

    button.setAttribute("type", "button");
    button.setAttribute("class", "qnaDeleteFile");
    button.setAttribute("onclick", "deleteFile(this)");
    button.innerText = "삭제";

    div.className = "qnaFileItem";
    div.appendChild(input);
    div.appendChild(button);

    $("#fileList").append(div);
}

function deleteFile(button) {
    $(button).parent().remove();
}

$("form").on("submit", function() {
    if ($("#title").val().trim() == "") {
        alert("제목을 입력해주세요.");
        $("#title").focus();
        return false;
    }

    if ($("#contents").summernote("code").trim() == "") {
        alert("내용을 입력해주세요.");
        return false;
    }
});
</script>

</body>
</html>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>