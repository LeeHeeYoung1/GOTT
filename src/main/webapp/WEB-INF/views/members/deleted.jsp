<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/public.css">
    <title>GOTT 회원탈퇴</title>

    <style>
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
            min-height: 450px;
            display: flex;
            padding: 40px 60px;
            gap: 50px;
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

        /* 현재 페이지 표시 */
        .sideTitle li.active {
            background-color: #eff6ff;
        }

        .sideTitle li.active a {
            color: #2563eb;
            font-weight: 600;
        }

        /* 회원탈퇴 폼 */
        .mainright {
            max-width: 600px;
            width: 100%;
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

        .mainright .notice {
            margin-bottom: 25px;
            padding: 15px;
            border-radius: 6px;
            background-color: #f8fafc;
            color: #555;
            font-size: 13px;
            line-height: 1.6;
        }

        .mainright input[type="password"] {
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

        .mainright input[type="password"]:focus {
            border-color: #1d97c0;
        }

        .buttonbox {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 10px;
        }

        .mainright button {
            height: 45px;
            padding: 0 25px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
        }

        .deleted {
            background-color: #dc2626;
            color: white;
        }

        .cancel {
            background-color: #e5e7eb;
            color: #333;
        }

        .main > hr,
        .container > hr {
            margin: 0;
            border: none;
            border-top: 1px solid #e5e7eb;
        }

        /* 푸터 */
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

        /* 반응형 */
        @media (max-width: 768px) {
            .main {
                flex-direction: column;
                padding: 25px 16px;
                gap: 25px;
            }

            .mainleft {
                width: 100%;
            }

            .mainright {
                max-width: none;
                box-sizing: border-box;
                padding: 30px 20px;
            }

            .title {
                height: 90px;
            }

            .title h1 {
                font-size: 26px;
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
            <h1>회원탈퇴</h1>
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
                            <li><a href="/event/tourTypeTest">여행성향 테스트</a></li>
                        </ul>

                        <span>혜택</span>
                        <ul>
                            <li><a href="#">포인트 내역</a></li>
                            <li><a href="/coupon/myCoupon">쿠폰함</a></li>
                        </ul>

                        <span>계정</span>
                        <ul>
                            <li><a href="/members/update">내 정보 수정</a></li>
                            <li><a href="/members/pwsearchpage">비밀번호 변경</a></li>
                            <li><a href="#">알림 설정</a></li>
                            <li><a href="#">1:1 문의</a></li>
                            <li class="active"><a href="/members/deleted">회원탈퇴</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- 회원탈퇴 폼 -->
            <form action="/members/deleted" method="post">
                <fieldset class="mainright">
                    <legend>회원탈퇴</legend>

                    <div class="notice">
                        회원탈퇴를 진행하시려면
                        현재 계정의 비밀번호를 입력해주세요.<br>
                        탈퇴 후에는 회원 정보를 복구할 수 없습니다.
                    </div>

                    <input name="pw" type="password"
                           placeholder="Password를 입력하세요" required>

                    <div class="buttonbox">
                        <button type="submit" class="deleted">회원탈퇴</button>
                        <button type="button" class="cancel"
                                onclick="location.href='/members/mypage'">취소</button>
                    </div>
                </fieldset>
            </form>
        </div>

        <hr>

        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    </div>
</body>
</html>