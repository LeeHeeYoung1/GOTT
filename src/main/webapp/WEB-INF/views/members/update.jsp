<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/public.css">
<script src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<title>GOTT 회원정보 수정</title>
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

        /* form이 남은 공간을 차지하도록 */
        .main > form {
            flex: 1;
        }

        /* =========================
           마이페이지 사이드바
           ========================= */
        .mainleft {
            width: 220px;
            flex-shrink: 0;
        }

        .sideBox {
            width: 100%;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            overflow: hidden;
            background-color: white;
        }

        .loginId {
            padding: 20px;
            text-align: center;
        }

        .loginId strong {
            font-size: 14px;
        }

        .loginId span {
            font-size: 12px;
            color: #797472;
        }

        .sideBox hr {
            margin: 0;
            border: 0;
            border-top: 1px solid #e5e7eb;
        }

        .sideTitle {
            padding-bottom: 10px;
        }

        .sideTitle > span {
            display: block;
            margin: 12px 20px 5px;
            font-size: 12px;
            color: #797472;
        }

        .sideTitle ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sideTitle li {
            padding: 6px 20px;
            font-size: 14px;
        }

        .sideTitle li a {
            display: block;
            color: #222;
            text-decoration: none;
        }

        .sideTitle li:hover {
            background-color: #f2f2f2;
        }

        .sideTitle li.active {
            background-color: #eff6ff;
        }

        .sideTitle li.active a {
            color: #2563eb;
            font-weight: 600;
        }

        /* =========================
           회원정보 수정 폼
           ========================= */
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

        .mainbox input[readonly] {
            background-color: #f3f4f6;
            color: #777;
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
            <button onclick="location.href='/members/logout'">로그아웃</button>
            <button onclick="location.href='/members/mypage'">마이페이지</button>
            <div class="icon"><i class="fa-solid fa-bars"></i></div>
        </div>
    </div>

    <div class="title">
        <h1>회원정보 수정</h1>
    </div>

    <div class="main">

        <!-- 마이페이지 사이드바 -->
        <div class="mainleft">
            <div class="sideBox">

                <div class="loginId">
                    <strong>${nickname}</strong><span>님</span>
                    <br>
                    <span>일반회원</span>
                    <span>등급</span>
                </div>

                <hr>

                <div class="sideTitle">

                    <span>예약/활동</span>
                    <ul>
                        <li><a href="/members/mypage">마이페이지 홈</a></li>
                        <li><a href="#">예약 내역</a></li>
                        <li><a href="#">찜한 여행지 · 숙소</a></li>
                        <li><a href="#">여행 일정 플래너</a></li>
                        <li><a href="#">내가 쓴 리뷰</a></li>
                        <li><a href="#">내가 쓴 게시글</a></li>
                        <li><a href="event/tourTypeTest">여행성향 테스트</a></li>
                    </ul>

                    <span>혜택</span>
                    <ul>
                        <li><a href="#">포인트 내역</a></li>
                        <li><a href="#">쿠폰함</a></li>
                    </ul>

                    <span>계정</span>
                    <ul>
                        <li class="active"><a href="/members/update">내 정보 수정</a></li>
                        <li><a href="/members/pwsearchpage">비밀번호 변경</a></li>
                        <li><a href="#">알림 설정</a></li>
                        <li><a href="#">1:1 문의</a></li>
                        <li><a href="/members/deleted">회원탈퇴</a></li>
                    </ul>

                </div>

            </div>
        </div>

        <!-- 회원정보 수정 -->
        <form action="/members/update" id="frm" method="post">
            <fieldset class="mainbox">

                <legend>회원정보 수정</legend>

                <input type="text" value="${loginId}" readonly>
                <input type="text" value="${name}" readonly>

                <input id="nickname" name="nickname" type="text" value="${nickname}" placeholder="닉네임을 입력하세요">
                <button id="nicknamecheck" type="button">중복확인</button>
                <span class="nicknamecheckresult"></span>
                
                <input id="phone" name="phone" type="text" value="${phone}" placeholder="'-' 를 제외한 번호를 입력하세요">
                <input id="email" name="email" type="email" value="${email}" placeholder="email을 입력하세요.">

                <span>성별</span> 
                <input class="gender" name="gender" type="radio" value="남성" ${gender == '남성' ? 'checked' : ''}  disabled> 남성 
                <input class="gender" name="gender" type="radio" value="여성" ${gender == '여성' ? 'checked' : ''}  disabled> 여성 
                <input name="dob" type="date" value="${Dob}" style="margin-top: 5px;" readonly>

                <input id="zipcode" name="zipcode" type="text" value="${zipcode}" readonly placeholder="우편번호">
                <button id="postbtn" type="button">주소 찾기</button>
                <input id="address1" name="address1" type="text" value="${address1}" placeholder="주소 입력" readonly>
                <input id="address2" name="address2" type="text" value="${address2}" placeholder="상세주소">

                <div class="btnbox flex-between">
                    <button id="save" type="submit">저장</button>
                    <button id="cancel" type="button">취소</button>
                </div>

            </fieldset>
        </form>

    </div>
    
    <div class="point_coupon"></div>
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

    let originalNick = "${nickname}";
    
    $("#nickname").attr("check", "true");

    $("#nicknamecheck").on("click", function(){
        let nickname = $("#nickname").val();

        if(nickname == "") {
            alert("닉네임을 입력해주세요.")
            return;
        }
        if(nickname == originalNick) {
            $(".nicknamecheckresult").text("닉네임 확인 완료!").css("color", "green");
            $("#nickname").attr("check", "true");
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
        // 원래 닉네임으로 되돌리면 다시 통과, 바꾸면 중복검사 필요
        if($(this).val() == originalNick) {
            $(this).attr("check", "true");
        } else {
            $(this).removeAttr("check");
        }
        $(".nicknamecheckresult").text("");
    });

    $("#postbtn").on("click", function(){
        new kakao.Postcode({
            oncomplete: function(data) {
                let zipcode = $("#zipcode");
                let address1 = $("#address1");

                zipcode.val(data.zonecode);
                address1.val(data.jibunAddress);
                $("#address2").focus();
            }
        }).open();
    })

    $("#cancel").on("click", function(){
        location.href="/members/mypage";
    })

    $("#frm").on("submit", function(e) {

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

    });
</script>

</body>
</html>
