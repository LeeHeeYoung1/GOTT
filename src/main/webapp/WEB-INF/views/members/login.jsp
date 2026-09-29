<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/public.css">
<title>GOTT Login</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	
	 <style>

        .header {
            width: 100%;
            height: 70px;
            padding: 0 30px;
        }

        .logobox {
            width: 120px;
            height: 70px;
            margin-left: 50px;
        }

        .logobox img {
            width: 100%;
            height: 100%;
        }

        .nav {
            width: 50%;
            margin: 0 auto;
        }

        .textzone {
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
        }

        .textzone:hover {
            color: #2563eb;
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .textbox {
            padding: 7px 12px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 13px;
            cursor: pointer;
        }
        .textbox:hover {
            background-color: #f3f4f6;
        }

        .icon {
            margin-left: 10px;
            font-size: 20px;
        }
        .icon:hover {
            cursor: pointer;
        }
        .icon:active {

        }
        .title {
            width: 100%;
            height: 120px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8fafc;
        }

        .title h1 {
            margin: 0;
            font-size: 32px;
            font-weight: 700;
        }


        .main {
            width: 100%;
            height: 400px;
            display: flex;
            padding: 40px 60px;
            gap: 50px;
        }

        .mainleft {
            width: 220px;
            flex-shrink: 0;
        }

        .linkbar {
            width: 100%;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            overflow: hidden;
            background-color: white;
        }

        .linkbartitle {
            width: 100%;
            height: 60px;
            display: flex;
            align-items: center;
            padding: 0 20px;
            font-size: 17px;
            font-weight: 700;
            background-color: #f1f5f9;
            border-bottom: 1px solid #e5e7eb;
        }

        .linkbarmain {
            width: 100%;
            min-height: 180px;
            padding: 15px;
            line-height: 2;
        }
        .linkbarmain a:hover {
            cursor: pointer;
            color: #2563eb;
        }

        .mainright {
            flex: 1;
            max-width: 600px;
            margin: 0 auto;
            padding: 35px 40px;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            background-color: white;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        }

        .mainright legend {
            padding: 0 10px;
            font-size: 20px;
            font-weight: 700;
        }

        .mainright input {
            width: 100%;
            height: 48px;
            margin-bottom: 12px;
            padding: 0 15px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
        }

        .mainright input:focus {
            border-color: #1d97c0;
        }

        .mainright button {
            height: 45px;
            padding: 0 25px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            background-color: #2563eb;
            color: white;
        }

        hr {
            margin: 0;
            border: none;
            border-top: 1px solid #e5e7eb;
        }

        .footer {
            min-height: 180px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 8px;
            color: #777;
            background-color: #f8fafc;
            font-size: 13px;
        }

        .footer p {
            margin: 0;
        }
        .footer .textbox {
            margin-top: 10px;
            color: #6B7280;
            background-color: #F8FAFA;
        }

    </style>
</head>

<body>

<div class="container">
    <div class="header flex-between">
        <div class="logobox">
            <img src="images/logo.png" alt="GOTT 로고">
        </div>
        <div class="nav flex-between">
            <div class="textzone">이벤트</div>
            <div class="textzone">지역</div>
            <div class="textzone">추천여행지</div>
            <div class="textzone">숙박업소</div>
            <div class="textzone">리뷰</div>
            <div class="textzone">여행플래너</div>
            <div class="textzone">공지사항</div>
        </div>
        <div class="user-menu">
            <div class="textbox">마이페이지</div>
            <div class="icon"><i class="fa-solid fa-bars"></i></div>
        </div>

    </div>

    <div class="title">
        <h1>로그인</h1>
    </div>

    <div class="main">
        <div class="mainleft">
            <div class="linkbar">
                <div class="linkbartitle">메뉴</div>
                <div class="linkbarmain">
                    <a href="/members/login">로그인</a><br>
                    <a href="/members/signup">회원가입</a><br>
                    <a href="/members/idsearch">아이디 찾기</a><br>
                    <a href="/members/pwsearch">비밀번호 찾기</a>
                </div>
            </div>
        </div>
        <form action="">
            <fieldset class="mainright">
                <legend>로그인</legend>
                <input name="id" type="text" placeholder="ID를 입력하세요">
                <input name="pw" type="password" placeholder="Password를 입력하세요">
                <button type="submit">로그인</button>
                <button id="signup" type="button"> 회원가입</button>
            </fieldset>
        </form>
    </div>
    <hr>
    <div class="footer">
        <p>AAAAAAAAAAAAAAAAAAAAAAAAAAAAA</p>
        <p>회사명 : GOTT | 대표 : ??? | 사업자등록번호 : 123-45-67890</p>
        <p>이용약관 | 개인정보처리방침 | 고객센터</p>
        <div class="textbox">사이트로고</div>
    </div>
</div>

<script>
    $("#signup").on("click", function(){
        location.href="/members/signuppage";
    })

</script>

</body>
</html>