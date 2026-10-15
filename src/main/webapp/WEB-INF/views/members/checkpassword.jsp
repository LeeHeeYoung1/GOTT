
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비밀번호 확인 | GOTT</title>
<style>
* { box-sizing: border-box; }
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f7f8fa;
    color: #222;
}
.checkContainer {
    width: 90%;
    max-width: 430px;
    margin: 100px auto;
    padding: 35px;
    background: white;
    border: 1px solid #e5e7eb;
    border-radius: 14px;
}
h2 { text-align: center; }
.description {
    text-align: center;
    color: #666;
    font-size: 14px;
    line-height: 1.7;
    margin-bottom: 28px;
}
label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold;
}
input {
    width: 100%;
    padding: 13px;
    border: 1px solid #ddd;
    border-radius: 7px;
}
button {
    width: 100%;
    padding: 13px;
    margin-top: 18px;
    border: none;
    border-radius: 7px;
    background: #222;
    color: white;
    cursor: pointer;
}
.error {
    color: #d93025;
    font-size: 13px;
}
.back {
    display: block;
    margin-top: 18px;
    text-align: center;
    color: #666;
    text-decoration: none;
}
</style>
</head>
<body>
<div class="checkContainer">
    <h2>비밀번호 확인</h2>
    <p class="description">
        회원정보 보호를 위해<br>
        현재 비밀번호를 입력해 주세요.
    </p>

    <form action="${pageContext.request.contextPath}/members/checkPassword"
          method="post">
        <label for="password">현재 비밀번호</label>
        <input type="password" id="password" name="password"
               placeholder="비밀번호 입력" required
               autocomplete="current-password">

        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>

        <button type="submit">비밀번호 확인</button>
    </form>

    <a class="back"
       href="${pageContext.request.contextPath}/members/mypage">
        마이페이지로 돌아가기
    </a>
</div>
</body>
</html>