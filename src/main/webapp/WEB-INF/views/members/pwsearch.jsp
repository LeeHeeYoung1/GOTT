<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/public.css">
<script src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<title>GOTT 비밀번호 찾기</title>
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
            height: auto;
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
            height: auto;
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
        .mainright input {
            width: 100%;
            height: 48px;
            margin-bottom: 8px;
            padding: 0 15px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
        }
        #email,
        #emailcheck {
            width: 69%;
            height: 48px;
            margin-bottom: 8px;
            margin-right: 16px;
            padding: 0 15px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
        }

        .mainright button {
            width: 140px;
            height: 45px;
            padding: 0 25px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            background-color: #2563eb;
            color: white;
        }
        .mainright button:hover {
            background-color: #2463ebe5;
            color: white;
        }
        
        
    </style>
</head>

<body>

<div class="container">
    <div class="header flex-between">
        <div class="logobox">
            <img src="/images/logo.png" alt="GOTT 로고">
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
            <div class="icon"><i class="fa-solid fa-bars"></i></div>
        </div>

    </div>

    <div class="title">
        <h1>비밀번호 찾기</h1>
    </div>

    <div class="main">
        <div class="mainleft">
            <div class="linkbar">
                <div class="linkbartitle">메뉴</div>
                <div class="linkbarmain">
                	<a href="/">홈으로</a><br>
                    <a href="/members/loginpage">로그인</a><br>
                    <a href="/members/signuppage">회원가입</a><br>
                    <a href="/members/idsearchpage">아이디 찾기</a><br>
                    <a href="/members/pwsearchpage">비밀번호 찾기</a>
                </div>
            </div>
        </div>
            <fieldset class="mainright">
                <legend>비밀번호 찾기</legend>
                <input id="id" name="id" type="text" placeholder="아이디을 입력하세요">
                <input id="email" name="email" type="email" placeholder="회원가입시 기입한 이메일을 입력하세요">
                <button id="emailVerification" type="button">이메일 인증</button>

                <div id="emailcheckbox" style="display: none;">
                    <input id="emailcheck" type="text" placeholder="인증번호를 입력하세요.">
                    <button id="verifyemail" type="button">인증번호 확인</button>
                </div>
                <div id="updatepw" style="display: none;">
                    <input id="pw" name="pw" type="password" placeholder="새 비밀번호를 입력하세요">
                    <input id="pw2" type="password" placeholder="새 비밀번호를 재입력하세요"><br>
                    <span class="pwresult"></span><br>
                    <button id="pwchange" type="button">비밀번호 변경</button>
                </div>
                <div class="flex-center">
                    <button id="homebtn" type="button">홈으로</button>
                </div>
            </fieldset>
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

	$("#emailVerification").on("click", function() {
		
		let id = $("#id").val();
		let email = $("#email").val();
		
		if(id == "" || email == "") {
	        alert("아이디와 이메일을 입력해주세요.");
	        return;
	    }
		
		$.ajax({
	        url: "/members/sendpwcode",
	        type: "post",
	        data: {
	            id: id,
	            email: email
	        }
	    }).done(function(resp) {

	        if(resp == "success") {
	            alert("해당 이메일로 인증번호를 발송하였습니다.");

                $("#emailcheckbox").show();

	        } else if(resp == "notfound") {
	            alert("존재하지 않는 아이디와 이메일입니다.");
	        } else {
                alert("이메일 발송에 실패하였습니다.")
            }

	    });
	});

    $("#verifyemail").on("click", function(){
        let code = $("#emailcheck").val();

        if(code == "") {
            alert("인증번호를 입력하세요.");
            return;
        } 
        $.ajax({
            url: "/members/verifypwcode",
            type: "post",
            data: {
                code: code
            }
        }).done(function(resp) {
            if(resp == "success") {
                alert("이메일 인증이 완료되었습니다.");
                $("#emailcheckbox").hide();
                $("#updatepw").show();
            } else {
                alert("이메일 인증에 실패하였습니다.");
            }
        })
    });

    $("#pw2").on("input", function(){

        let pw = $("#pw").val();
        let pw2 = $("#pw2").val();
        let span = $(".pwresult");

        if(pw2 == "") {
            span.text("");
            return;
        }

        if(pw == pw2) {
            span.text("비밀번호가 일치합니다.").css("color", "green");
        } else {
            span.text("비밀번호가 일치하지 않습니다.").css("color", "red");
        }

        let pw1regex = /[A-Z]/
        let pw2regex = /[a-z]/
        let pw3regex = /[0-9]/
        let pw4regex = /^[A-Z0-9a-z]{8,}$/

        if(!pw1regex.test(pw)) {
            alert("비밀번호에 대문자를 포함해주세요.");
            return false;
        }

        if(!pw2regex.test(pw)) {
            alert("비밀번호에 소문자를 포함해주세요.");
            return false;
        }

        if(!pw3regex.test(pw)) {
            alert("비밀번호에 숫자를 포함해주세요.");
            return false;
        }

        if(!pw4regex.test(pw)) {
            alert("비밀번호는 알파벳 대문자,소문자,숫자로 8자 이상 입력해주세요.");
            return false;
        }

    })

    $("#pwchange").on("click", function() {
        let pw = $("#pw").val();
        let pw2 = $("#pw2").val();

        if(pw == "" || pw2 == "") {
            alert("새 비밀번호를 입력해주세요.");
            return;
        } 
        if(pw != pw2) {
            alert("비밀번호가 일치하지 않습니다.");
            return;
        }
        $.ajax({
            url: "/members/updatepw",
            type: "post",
            data: {
                pw: pw
            }
        }).done(function(resp) {
            if(resp=="success") {
                alert("비밀번호가 변경되었습니다.")
                location.href = "/members/loginpage";
            } else if (resp == "notVerified") {
                alert("이메일 인증을 먼저 진행하세요.");

            } else {
                alert("비밀번호 변경에 실패하였습니다.");
            }
        })
    });

    $("#homebtn").on("click", function(){
        location.href="/";
    });

</script>

</body>
</html>