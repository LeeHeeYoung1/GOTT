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
<title>GOTT Sign up</title>
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
        .logobox:hover {
            cursor: pointer;
        }

        .logobox img {
            width: 80%;
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
            margin: 0 10px;
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

        .mainbox {
            max-width: 600px;
            margin: 0 auto;
            padding: 35px 40px;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            background-color: white;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        }

        .mainbox legend {
            padding: 0 10px;
            font-size: 20px;
            font-weight: 700;
        }

        .mainbox input {
            width: 100%;
            height: 48px;
            margin-bottom: 8px;
            padding: 0 15px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
        }
        
        #id,
        #nickname,
        #zipcode {
            width: 70%;
            height: 48px;
            margin-bottom: 8px;
            margin-right: 16px;
            padding: 0 15px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
        }
        .mainbox .gender {
            width: 15px;
            height: 15px;
            margin: 0 5px 0 0;
            padding: 0;
            border: none;
            align-items: center;
            line-height: 2;
        }

        .mainbox input:focus {
            border-color: #1d97c0;
        }

        .mainbox button {
            width: 135px;
            height: 45px;
            padding: 0 25px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            background-color: #2A9D8F;
            color: white;

            transition: 0.2s;
        }
        .mainbox button:hover {
            background-color: #238276;
            color: #FFF8F0;
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
        .btnbox button {
            margin: auto;
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
            <div class="textzone">추천 여행지</div>
            <div class="textzone">숙박업소</div>
            <div class="textzone">리뷰</div>
            <div class="textzone">여행 플래너</div>
            <div class="textzone">공지사항</div>
        </div>
        <div class="user-menu">
            <div class="icon"><i class="fa-solid fa-bars"></i></div>
        </div>
    </div>

    <div class="title">
        <h1>회원가입</h1>
    </div>

    <div class="main flex-center">
        <form action="/members/signup" id="frm" method="post">
            <fieldset class="mainbox">

                <legend>회원가입</legend>

                <input id="id" name="id" type="text" placeholder="ID를 입력하세요">
                <button id="idcheck" type="button">ID중복검사</button>
                <span class="idcheckresult"></span>
                <input id="pw" name="pw" type="password" placeholder="Password를 입력하세요">
                <input id="pw2" type="password" placeholder="Password를 재입력하세요">
                <span class="pwresult"></span>
                
                <input name="name" type="text" placeholder="이름을 입력하세요">
                <input id="nickname" name="nickname" type="text" placeholder="닉네임을 입력하세요">
                <button id="nicknamecheck" type="button">중복확인</button>
                <span class="nicknamecheckresult"></span>

                <input id="phone" name="phone" type="text" placeholder="'-' 를 제외한 번호를 입력하세요">
                <input id="email" name="email" type="email" placeholder="email을 입력하세요.">
                <span>* 성별을 선택하세요</span>
                <input class="gender" name="gender" type="radio" value="남성">남성
                <input class="gender" name="gender" type="radio" value="여성">여성

                <input name="dob" type="date" style="margin-top: 5px;">

                <input id="zipcode" name="zipcode" type="text" readonly placeholder="우편번호">
                <button id="postbtn" type="button">주소 찾기</button>
                <input id="address1" name="address1" type="text" readonly placeholder="주소 입력">
                <input id="address2" name="address2" type="text" placeholder="상세주소">

                <div class="btnbox flex-between">
                    <button id="signup" type="submit">회원가입</button>
                    <button id="cancel" type="button">취소</button>
                </div>

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

    let phonetext = $("#phone");
    let phoneregex = /^010[0-9]{8}$/
    
    $("#idcheck").on("click", function(){
        let id = $("#id").val();

        if(id=="") {
            alert("아이디를 입력해주세요.")
            return;
        }
        $.ajax({
            url:"/members/idcheck",
            data:{id: id}
        }).done(function(resp) {
            if(resp == 1) {
                $(".idcheckresult").text("이미 사용 중인 아이디입니다.").css("color", "red");
                $("#id").removeAttr("check");
            } else {
                $(".idcheckresult").text("사용 가능한 아이디입니다.").css("color", "green");
                $("#id").attr("check", "true");
            }
        })
    })

    $("#id").on("input", function(){
        $(this).removeAttr("check");
        $(".idcheckresult").text("");
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
            alert("비밀번호는 영문과 숫자로 8자 이상 입력해주세요.");
            return false;
        }

    })
    
    $("#nicknamecheck").on("click", function(){
        let nickname = $("#nickname").val();

        if(nickname == "") {
            alert("닉네임을 입력해주세요.")
            return;
        }
        $.ajax({
            url:"/members/nicknamecheck",
            data:{nickname: nickname}
        }).done(function(resp) {
            if(resp == 1) {
                $(".nicknamecheckresult").text("이미 사용 중인 닉네임입니다.").css("color", "red");
                $("#nickname").removeAttr("check");
            } else {
                $(".nicknamecheckresult").text("사용 가능한 닉네임입니다.").css("color", "green");
                $("#nickname").attr("check", "true");
            }
        })
    })

    $("#nickname").on("input", function(){
        $(this).removeAttr("check");
        $(".nicknamecheckresult").text("");
    });

    $("#postbtn").on("click", function(){
        new kakao.Postcode({
            oncomplete: function(data) {
                console.log(data)
                let zipcode = $("#zipcode");
                let address1 = $("#address1");

                zipcode.val(data.zonecode);
                address1.val(data.jibunAddress);
            }
        }).open();
    })

    $("#cancel").on("click", function(){
        location.href="/";
    })
	
    $("#frm").on("submit", function(e) {

        let pw = $("#pw").val();
        let pw2 = $("#pw2").val();

	    if(!$("#id").attr("check")) {
	        alert("아이디 중복검사를 실행해주세요.");
	        e.preventDefault();
	        return;
	    }
	
	    if(!$("#nickname").attr("check")) {
	        alert("닉네임 중복검사를 실행해주세요.");
	        e.preventDefault();
	        return;
	    }
	
	    if(!phoneregex.test(phonetext.val())) {
	        alert("연락처의 양식에 맞춰 입력해주세요.");
	        e.preventDefault();
	        return;
	    }

        if(pw == "" || pw2 == "") {
            alert("비밀번호를 입력해주세요.");
            e.preventDefault();
            return;
        }
        if(pw != pw2) {
            alert("비밀번호가 일치하지 않습니다.");
            e.preventDefault();
            return;
        }
        alert("회원가입을 환영합니다.")
	});
    
</script>

</body>
</html>