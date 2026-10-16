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
<link rel="stylesheet" href="/summernote/summernote-lite.css">
<script src="/summernote/summernote-lite.js"></script>

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
	padding: 80px 0 20px;
}

.writeTitle h2 {
	margin: 0 0 8px;
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
}

/* Summernote */
.contentsRow .note-editor {
	flex: 1;
}

.contentsRow .note-editor .note-editable {
	font-size: 12px;
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

	<form class="writeBox" action="/board/writeRegi?cpage=${cpage}" method="post"  enctype="multipart/form-data">

		<div class="writeRow">
			<label>제목</label> <input type="text" id="title" name="title"
       class="writeInput" maxlength="100"  placeholder="제목을 입력해주세요." required>
		</div>


		<div class="writeRow">
			<label>작성자</label> <input type="text" class="writeInput writerInput" value="${nickname}" readonly>
		</div>


		<div class="contentsRow">
			<label>내용</label>

			<textarea id="summernote" name="contents" class="contents" placeholder="내용을 입력해주세요." required></textarea>
		</div>


		<div class="fileRow">
			<label>첨부파일</label> <input type="file" name="attachFiles" multiple>
		</div>


		<div class="buttonBox">

			<button type="button" onclick="history.back()">취소</button>

			<button type="submit" class="submitBtn">등록</button>

		</div>

	</form>

</div>
<script>
$(document).ready(function() {

    $('#summernote').summernote({
        toolbar: [
            ['fontname', ['fontname']],
            ['fontsize', ['fontsize']],
            ['style', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
            ['color', ['forecolor', 'color']],
            ['table', ['table']],
            ['para', ['ul', 'ol', 'paragraph']],
            ['height', ['height']],
            ['insert', ['picture', 'link', 'video']]
        ],

        fontNames: [
            'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New',
            '맑은 고딕', '궁서', '굴림체', '굴림', '돋움체', '바탕체'
        ],

        fontSizes: [
            '8', '9', '10', '11', '12', '14', '16', '18',
            '20', '22', '24', '28', '30', '36', '50', '72'
        ],

        height: 450,
        lang: "ko-KR",
        placeholder: "내용을 작성하세요.",

        callbacks: {
            onImageUpload: function(files) {
                for (let i = 0; i < files.length; i++) {
                    uploadImageFile(files[i], this);
                }
            }
        }
    });

    $(".submitBtn").click(function(e) {
        let title = $("#title").val().trim();
        let contents = $("#summernote").summernote("code");
        let text = $("<div>").html(contents).text().trim();

        if (title == "") {
            e.preventDefault();
            alert("제목을 입력해주세요.");
            return;
        }

        if (title.length > 100) {
            e.preventDefault();
            alert("제목은 100자 이하로 입력하세요.");
            return;
        }

        if ($("#summernote").summernote("isEmpty")) {
            e.preventDefault();
            alert("내용을 입력해주세요.");
            return;
        }

        if (text.length > 5000) {
            e.preventDefault();
            alert("본문은 5000자 이하로 입력하세요.");
            return;
        }
    });

    let draggingImage = null;

    $(document).on('dragstart', '.note-editable img', function(e) {
        draggingImage = this;
        e.originalEvent.dataTransfer.effectAllowed = "move";
        e.originalEvent.dataTransfer.setData("text/plain", "image");
        $(this).css("opacity", "0.5");
    });

    $(document).on('dragover', '.note-editable', function(e) {
        if (draggingImage == null) {
            return;
        }

        e.preventDefault();
        e.originalEvent.dataTransfer.dropEffect = "move";
    });

    $(document).on('drop', '.note-editable', function(e) {
        if (draggingImage == null) {
            return;
        }

        e.preventDefault();

        let range;

        if (document.caretRangeFromPoint) {
            range = document.caretRangeFromPoint(
                e.originalEvent.clientX,
                e.originalEvent.clientY
            );
        } else if (document.caretPositionFromPoint) {
            let position = document.caretPositionFromPoint(
                e.originalEvent.clientX,
                e.originalEvent.clientY
            );

            if (position) {
                range = document.createRange();
                range.setStart(position.offsetNode, position.offset);
                range.collapse(true);
            }
        }

        if (range) {
            let node = range.startContainer;

            if (node.nodeType === 3) {
                node = node.parentNode;
            }

            if (node !== draggingImage) {
                $(draggingImage).detach();

                if (node && node.parentNode) {
                    let targetRect = node.getBoundingClientRect();
                    let mouseX = e.originalEvent.clientX;

                    if (mouseX > targetRect.left + targetRect.width / 2) {
                        node.parentNode.insertBefore(
                            draggingImage,
                            node.nextSibling
                        );
                    } else {
                        node.parentNode.insertBefore(draggingImage, node);
                    }
                } else {
                    this.appendChild(draggingImage);
                }
            }
        }

        $(draggingImage).css("opacity", "1");
        draggingImage = null;
    });

    $(document).on('dragend', '.note-editable img', function() {
        $(this).css("opacity", "1");
        draggingImage = null;
    });

});

function uploadImageFile(file, el) {
    let data = new FormData();
    data.append("file", file);

    $.ajax({
        data: data,
        type: "POST",
        url: "/file/uploadImageFile",
        contentType: false,
        enctype: "multipart/form-data",
        processData: false,

        success: function(data) {
            $(el).summernote('editor.insertImage', data.url);
        },

        error: function(xhr) {
            alert("이미지 업로드에 실패했습니다.");
            console.log(xhr.responseText);
        }
    });
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>