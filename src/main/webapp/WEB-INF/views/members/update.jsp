<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/public.css">
    <script src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
            crossorigin="anonymous"></script>
    <title>GOTT 회원정보 수정</title>

    <style>
        /* 페이지 제목 */
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

        /* 메인 레이아웃 */
        .main {
            width: 100%;
            min-height: 450px;
            display: flex;
            padding: 40px 60px;
            gap: 50px;
            box-sizing: border-box;
        }

        .main > form {
            flex: 1;
            min-width: 0;
        }

        /* 마이페이지 사이드바 */
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
            box-sizing: border-box;
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

        /* 회원정보 수정 폼 */
        .mainbox {
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
            padding: 35px 40px;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            background-color: white;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
            box-sizing: border-box;
        }

        .mainbox legend {
            padding: 0 10px;
            font-size: 20px;
            font-weight: 700;
        }

        .mainbox input:not([type="radio"]) {
            width: 100%;
            height: 48px;
            margin-bottom: 12px;
            padding: 0 15px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
            box-sizing: border-box;
        }

        .mainbox input:focus {
            border-color: #1d97c0;
        }

        .mainbox input[readonly] {
            background-color: #f3f4f6;
            color: #777;
        }

        /* 닉네임과 우편번호 입력 영역 */
        .inputRow {
            display: flex;
            align-items: flex-start;
            gap: 10px;
        }

        .inputRow input {
            flex: 1;
            min-width: 0;
        }

        .inputRow button {
            flex-shrink: 0;
        }

        /* 성별 */
        .genderBox {
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 5px 0 12px;
            font-size: 14px;
        }

        .mainbox .genderBox input[type="radio"] {
            width: 15px;
            height: 15px;
            margin: 0;
        }

        /* 버튼 */
        .mainbox button {
            min-width: 100px;
            height: 45px;
            padding: 0 18px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            background-color: #2A9D8F;
            color: white;
            transition: background-color 0.2s;
        }

        .mainbox button:hover {
            background-color: #238276;
        }

        .nicknamecheckresult {
            display: block;
            margin: -5px 0 12px;
            font-size: 13px;
        }

        .btnbox {
            display: flex;
            justify-content: center;
            gap: 12px;
            margin-top: 10px;
        }

        .btnbox button {
            margin: 0;
        }

        .btnbox #cancel {
            background-color: #e5e7eb;
            color: #333;
        }

        .btnbox #cancel:hover {
            background-color: #d1d5db;
        }

        /* 모바일 반응형 */
        @media (max-width: 768px) {
            .title {
                height: 90px;
            }

            .title h1 {
                font-size: 26px;
            }

            .main {
                flex-direction: column;
                padding: 25px 16px;
                gap: 25px;
            }

            .mainleft {
                width: 100%;
            }

            .mainbox {
                max-width: none;
                padding: 30px 20px;
            }

            .inputRow {
                gap: 6px;
            }

            .mainbox button {
                min-width: 85px;
                padding: 0 10px;
            }
        }
    </style>
</head>

<body>
<div class="container">

    <!-- 공통 헤더 -->
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <!-- 페이지 제목 -->
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
                        <li><a href="/members/reservationpage">예약 내역</a></li>
                        <li><a href="/members/wishlist">찜한 여행지 · 숙소</a></li>
                        <li><a href="/members/planner">여행 일정 플래너</a></li>
                        <li><a href="/review/reviewlist">내가 쓴 리뷰</a></li>
                        <li><a href="/board/boardlist">내가 쓴 게시글</a></li>
                    </ul>

                    <span>혜택</span>
                    <ul>
                        <li><a href="/members/mileage">포인트 내역</a></li>
                        <li><a href="/coupon/myCoupon">쿠폰함</a></li>
                    </ul>

                    <span>계정</span>
                    <ul>
                        <li class="active"><a href="/members/update">내 정보 수정</a></li>
                        <li><a href="/members/pwsearchpage">비밀번호 변경</a></li>
                        <li><a href="#">1:1 문의</a></li>
                        <li><a href="/members/deleted">회원탈퇴</a></li>
                    </ul>
                </div>

            </div>
        </div>

        <!-- 회원정보 수정 폼 -->
        <form action="/members/update" id="frm" method="post">
            <fieldset class="mainbox">
                <legend>회원정보 수정</legend>

                <input type="text" value="${loginId}" readonly aria-label="아이디">
                <input type="text" value="${name}" readonly aria-label="이름">

                <div class="inputRow">
                    <input id="nickname" name="nickname" type="text"
                           value="${nickname}" placeholder="닉네임을 입력하세요" required>
                    <button id="nicknamecheck" type="button">중복확인</button>
                </div>
                <span class="nicknamecheckresult"></span>

                <input id="phone" name="phone" type="text"
                       value="${phone}" placeholder="'-'를 제외한 번호를 입력하세요" required>

                <input id="email" name="email" type="email"
                       value="${email}" placeholder="이메일을 입력하세요" required>

                <span>성별</span>
                <div class="genderBox">
                    <input class="gender" name="gender" type="radio"
                           value="남성" ${gender == '남성' ? 'checked' : ''} disabled>
                    <label>남성</label>

                    <input class="gender" name="gender" type="radio"
                           value="여성" ${gender == '여성' ? 'checked' : ''} disabled>
                    <label>여성</label>
                </div>

                <input name="dob" type="date" value="${Dob}" readonly aria-label="생년월일">

                <div class="inputRow">
                    <input id="zipcode" name="zipcode" type="text"
                           value="${zipcode}" readonly placeholder="우편번호">
                    <button id="postbtn" type="button">주소 찾기</button>
                </div>

                <input id="address1" name="address1" type="text"
                       value="${address1}" placeholder="주소" readonly>

                <input id="address2" name="address2" type="text"
                       value="${address2}" placeholder="상세주소">

                <div class="btnbox">
                    <button id="save" type="submit">저장</button>
                    <button id="cancel" type="button">취소</button>
                </div>
            </fieldset>
        </form>

    </div>

    <!-- 공통 푸터 -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</div>

<script>
    $(function() {
        const phoneText = $("#phone");
        const phoneRegex = /^010[0-9]{8}$/;
        const originalNick = $("#nickname").val().trim();

        // 기존 닉네임은 중복검사를 통과한 상태로 처리
        $("#nickname").attr("check", "true");

        // 닉네임 중복검사
        $("#nicknamecheck").on("click", function() {
            const nickname = $("#nickname").val().trim();

            if (nickname === "") {
                alert("닉네임을 입력해주세요.");
                return;
            }

            if (nickname === originalNick) {
                $(".nicknamecheckresult")
                    .text("닉네임 확인 완료!")
                    .css("color", "green");

                $("#nickname").attr("check", "true");
                return;
            }

            $.ajax({
                url: "/members/nicknamecheck",
                type: "GET",
                data: { nickname: nickname }
            }).done(function(resp) {
                if (resp == 1) {
                    $(".nicknamecheckresult")
                        .text("이미 사용 중인 닉네임입니다.")
                        .css("color", "red");

                    $("#nickname").removeAttr("check");
                } else {
                    $(".nicknamecheckresult")
                        .text("사용 가능한 닉네임입니다.")
                        .css("color", "green");

                    $("#nickname").attr("check", "true");
                }
            }).fail(function() {
                alert("닉네임 중복검사 중 오류가 발생했습니다.");
            });
        });

        // 닉네임 변경 시 중복검사 상태 초기화
        $("#nickname").on("input", function() {
            const nickname = $(this).val().trim();

            if (nickname === originalNick) {
                $(this).attr("check", "true");
            } else {
                $(this).removeAttr("check");
            }

            $(".nicknamecheckresult").text("");
        });

        // 주소 찾기
        $("#postbtn").on("click", function() {
            new kakao.Postcode({
                oncomplete: function(data) {
                    $("#zipcode").val(data.zonecode);

                    // 도로명 주소가 있으면 도로명 주소, 없으면 지번 주소 사용
                    const address = data.roadAddress || data.jibunAddress;
                    $("#address1").val(address);

                    $("#address2").focus();
                }
            }).open();
        });

        // 취소
        $("#cancel").on("click", function() {
            location.href = "/members/mypage";
        });

        // 저장 전 입력값 검사
        $("#frm").on("submit", function(e) {
            const nickname = $("#nickname").val().trim();
            const phone = phoneText.val().trim();

            if (nickname === "") {
                alert("닉네임을 입력해주세요.");
                e.preventDefault();
                return;
            }

            if (!$("#nickname").attr("check")) {
                alert("닉네임 중복검사를 실행해주세요.");
                e.preventDefault();
                return;
            }

            if (!phoneRegex.test(phone)) {
                alert("연락처는 010으로 시작하는 숫자 11자리를 입력해주세요.");
                e.preventDefault();
                return;
            }
        });
    });
</script>

</body>
</html>