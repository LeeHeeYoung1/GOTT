<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="/summernote/summernote-lite.css">
<script src="/summernote/summernote-lite.js"></script>

<style>
* {
	box-sizing: border-box;
}

.writeMain {
	width: 1200px;
	max-width: calc(100% - 40px);
	margin: 0 auto;
	padding-bottom: 80px;
}

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

.fileRow {
	display: flex;
	align-items: center;
	margin-bottom: 22px;
}

.fileRow label {
	width: 80px;
	flex-shrink: 0;
	font-size: 12px;
	font-weight: 600;
	color: #333;
}

.fileInput {
	flex: 1;
	min-width: 0;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	background: #fafafa;
	font-size: 12px;
	color: #555;
}

.fileHelp {
	margin: -12px 0 22px 80px;
	font-size: 11px;
	color: #888;
}

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

.writeBox {
	width: 750px;
	max-width: 100%;
	margin: 40px auto 0;
	border: 1px solid #ddd;
	border-radius: 7px;
	padding: 30px;
	background: white;
}

.writeRow {
	display: flex;
	align-items: center;
	margin-bottom: 18px;
}

.writeRow label {
	width: 80px;
	flex-shrink: 0;
	font-size: 12px;
	font-weight: 600;
	color: #333;
}

.writeInput {
	flex: 1;
	min-width: 0;
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

.contentsRow {
	display: flex;
	align-items: flex-start;
	margin-bottom: 25px;
}

.contentsRow label {
	width: 80px;
	flex-shrink: 0;
	padding-top: 10px;
	font-size: 12px;
	font-weight: 600;
	color: #333;
}

.contentsRow .note-editor {
	flex: 1;
	min-width: 0;
}

.contentsRow .note-editor .note-editable {
	font-size: 12px;
}

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

@media ( max-width : 600px) {
	.writeTitle {
		padding-top: 40px;
	}
	.writeBreadcrumb {
		margin: 0;
	}
	.writeBox {
		padding: 20px 15px;
	}
	.writeRow label, .contentsRow label {
		width: 65px;
	}
}
</style>

<div class="writeMain">

	<div class="writeTitle">
		<h2>FAQ 작성</h2>
		<h5>여행에 관한 자주 묻는 질문과 답변을 등록해 주세요.</h5>
	</div>

	<div class="writeBreadcrumb">
		홈 &nbsp;>&nbsp; 문의사항 &nbsp;>&nbsp; FAQ &nbsp;>&nbsp; <span>FAQ
			작성</span>
	</div>

	<form action="/notice/write" method="post"
		enctype="multipart/form-data">

		<div class="writeRow">
			<label>질문</label> <input type="text" name="title" id="writeInput" class="writeInput"
				placeholder="질문을 입력해주세요.">
		</div>

		<div class="writeRow">
			<label>작성자</label> <input name="writer" type="text"
				class="writeInput writerInput" value="${nickname}" readonly>
		</div>

		<div class="contentsRow">
			<label>답변</label>
			<textarea id="summernote" name="content" id="contents" class="contents"
				placeholder="답변을 작성해주세요."></textarea>
		</div>

		<div class="fileRow">
			<label for="attachFiles">첨부파일</label> <input type="file"
				id="attachFiles" name="attachFiles" class="fileInput" multiple>
		</div>

		<div class="fileHelp">여러 파일을 선택할 수 있습니다.</div>

		<div class="buttonBox">
			<button type="button"
				onclick="location.href='/notice/faq?cpage=${cpage}'">취소</button>

			<button type="submit" class="submitBtn" id="submitBtn">등록</button>
		</div>

	</form>

</div>


<script>
	
	$("#submitBtn").on("click", function() {
		
		if($("#writeInput").val().trim() == "") {
		alert("질문을 입력해주세요.");
		return false;
		}
		if($("#summernote").summernote("isEmpty")) {
	        alert("답변을 입력해주세요.");
	        return false;
	    }
	});
	
    $(document).ready(function() {

        $('#summernote').summernote({
            toolbar: [
                ['fontname', ['fontname']],
                ['fontsize', ['fontsize']],
                ['style', [
                    'bold', 'italic', 'underline',
                    'strikethrough', 'clear'
                ]],
                ['color', ['forecolor', 'color']],
                ['table', ['table']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']],
                ['insert', ['picture', 'link', 'video']]
            ],

            fontNames: [
                'Arial', 'Arial Black', 'Comic Sans MS',
                'Courier New', '맑은 고딕', '궁서',
                '굴림체', '굴림', '돋움체', '바탕체'
            ],

            fontSizes: [
                '8', '9', '10', '11', '12', '14', '16',
                '18', '20', '22', '24', '28', '30',
                '36', '50', '72'
            ],

            height: 450,
            lang: "ko-KR",
            placeholder: "답변을 작성해주세요.",

            callbacks: {
                onImageUpload: function(files) {
                    for (var i = 0; i < files.length; i++) {
                        uploadImageFile(files[i], this);
                    }
                }
            }
        });

        function uploadImageFile(file, el) {
            let data = new FormData();
            data.append("file", file);

            $.ajax({
                data: data,
                type: "POST",
                url: "/file/uploadImageFile",
                contentType: false,
                processData: false,

                success: function(data) {
                    $(el).summernote('editor.insertImage', data.url);
                },

                error: function(xhr) {
                    console.log("이미지 업로드 실패:", xhr.responseText);
                }
            });
        }

    });
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>