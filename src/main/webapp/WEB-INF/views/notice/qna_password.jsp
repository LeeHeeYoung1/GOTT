<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.7.1.js"
  integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
  crossorigin="anonymous"></script>
  
  <style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    padding: 25px;
    font-family: 'Segoe UI', sans-serif;
    color: #333;
}

h3 {
    margin: 0 0 10px;
    font-size: 18px;
}

p {
    font-size: 12px;
    color: #888;
}

input {
    width: 100%;
    height: 38px;
    padding: 0 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    margin-bottom: 12px;
}

button {
    width: 100%;
    height: 38px;
    border: 0;
    border-radius: 4px;
    background: #222;
    color: white;
    cursor: pointer;
}
</style>
</head>
<body>
	<h3>비밀번호 확인</h3>
<p>비공개 문의글입니다. 비밀번호를 입력해 주세요.</p>

<c:if test="${not empty msg}">
    <p style="color: red;">${msg}</p>
</c:if>

<form action="/notice/qna_content" method="post">
    <input type="hidden" name="qid" value="${qid}">
    <input type="hidden" name="cpage" value="${cpage}">

    <input type="password" name="pw"
        placeholder="비밀번호 입력" required>

    <button type="submit">확인</button>
    
    
</form>

<c:if test="${success}">
    <script>
        window.opener.location.href =
            "/notice/qna_content?qid=${qid}&cpage=${cpage}";
        window.close();
    </script>
</c:if>
</body>
</html>