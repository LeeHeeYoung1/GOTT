<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/public.css">
    <script src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <title>GOTT 여행 일정 플래너</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

    <style>
        * {
            box-sizing: border-box;
        }

        hr {
            margin: 0;
            border: none;
            border-top: 1px solid #e5e7eb;
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


        /* =========================================================
   2. 헤더
   ========================================================= */

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

        .icon {
            margin-left: 10px;
            font-size: 20px;
        }

        .icon:hover {
            cursor: pointer;
        }


        /* =========================================================
   3. 제목 영역
   ========================================================= */

        .title {
            width: 100%;
            height: 120px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: #f8fafc;
        }

        .title h1 {
            margin: 0;
            font-size: 32px;
            font-weight: 700;
        }


        /* =========================================================
   4. 메인 (위: 일정 입력 바 / 아래: 3단 플래너)
   ========================================================= */

        .main {
            width: 100%;
            height: auto;
            display: flex;
            flex-direction: column;
            /* 위에서 아래로 쌓기 */
            padding: 40px 60px;
            gap: 50px;
        }


        /* ---------- 4-1. 일정 입력 바 ---------- */

        .barContainer {
            width: 100%;
            border: 1px solid black;
            padding: 15px 20px;
        }

        .barContainer form {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        .formItem {
            display: flex;
            align-items: center;
            gap: 6px;
            white-space: nowrap;
            flex-shrink: 1;
        }

        .formItem span {
            font-size: 13px;
        }

        .formItem input,
        .formItem select {
            height: 36px;
            padding: 0 8px;
            border: 1px solid #d1d5db;
            border-radius: 5px;
        }

        .formItem input[name="title"] {
            width: 180px;
        }

        .formItem input[type="date"] {
            width: 125px;
        }

        .formItem select {
            width: 80px;
        }

        .createBtn {
            height: 36px;
            padding: 0 15px;
            border: 1px solid #333;
            border-radius: 5px;
            background-color: #222;
            color: white;
            cursor: pointer;
            white-space: nowrap;
            flex-shrink: 0;
        }

        /* ---------- 4-2. 3단 틀: 찜 목록 | 일정표 | 지도 ---------- */

        .plannerLayout {
            display: grid;
            grid-template-columns: 280px 1fr 320px;
            gap: 24px;
            align-items: start;
        }


        /* ---------- 4-3. 왼쪽: 찜 목록 패널 ---------- */

        /* 패널 전체 박스 (탭 + 검색창 + 카드 목록) */
        .trableContainer {
            border: 1px solid #333;
            background-color: white;
        }

        /* 탭 줄: 3칸을 똑같은 너비로 */
        .wishList {
            display: flex;
        }

        .trableTitle {
            flex: 1;
            padding: 12px 0;
            text-align: center;
            border-bottom: 1px solid #333;
            cursor: pointer;
        }

        .trableTitle+.trableTitle {
            border-left: 1px solid #333;
        }

        /* 선택된 탭 */
        .trableTitle.active {
            background-color: #222;
            color: white;
        }

        /* 검색창 */
        .wishSearch {
            padding: 12px;
        }

        .wishSearch input {
            width: 100%;
            height: 40px;
            padding: 0 12px;
            border: 1px solid #333;
        }

        /* 카드 목록 영역 (길어지면 안에서 스크롤) */
        .tablewishContainer {
            padding: 12px;
            max-height: 560px;
            overflow-y: auto;
        }

        /* 카드 하나: 안쪽 요소를 가로로 한 줄 배치 */
        .wishItem {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px;
            margin-bottom: 12px;
            border: 1px solid #333;
            background-color: white;
        }

        /* 이미지 */
        .wishThumb img {
            width: 60px;
            height: 60px;
            display: block;
        }

        /* 지역 + 이름 (남는 공간을 차지해서 + 버튼이 오른쪽 끝으로 감) */
        .wishText {
            flex: 1;
        }

        .wishText p {
            margin: 0;
            font-size: 10px;
            color: #777;
        }

        /* + 버튼 */
        .addBtn {
            width: auto;
            height: 20px;
            font-size: 15px;
            display: flex;
            justify-content: center;
            align-items: center;
        }


        /* ---------- 4-4. 가운데: 일정표 ---------- */

        .addContainer {
            border: 1px solid #333;
            background-color: white;
        }

        /* Day 탭 */
        .dayTabs {
            display: flex;
            flex-wrap: wrap;
            border-bottom: 1px solid #333;
        }

        .dayTab {
            padding: 12px 20px;
            font-size: 13px;
            border-right: 1px solid #333;
            cursor: pointer;
        }

        .dayTab.active {
            background-color: #222;
            color: white;
        }

        .dayBody {
            padding: 20px;
        }

        .dayDate {
            margin: 0 0 16px;
            font-size: 12px;
            color: #666;
        }

        /* 타임라인 한 줄: 번호 + 카드 */
        .timelineItem {
            display: flex;
            gap: 14px;
            margin-bottom: 16px;
        }

        .orderMark {
            width: 26px;
            height: 26px;
            flex-shrink: 0;
            border: 1px solid #333;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: 600;
        }

        .timelineCard {
            flex: 1;
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px;
            border: 1px solid #333;
        }

        .timeInput {
            width: 84px;
            padding: 6px 8px;
            border: 1px solid #333;
            font-size: 12px;
        }

        /* 장소 사이 이동 안내 */
        .transport {
            margin: -4px 0 16px 40px;
            font-size: 11px;
            color: #666;
        }

        /* 비어 있을 때 안내 */
        .dropEmpty {
            padding: 28px;
            border: 1px dashed #999;
            text-align: center;
            font-size: 12px;
            color: #666;
        }

        .dayFooter {
            padding: 14px 20px;
            border-top: 1px solid #eee;
            font-size: 12px;
            color: #666;
        }


        /* ---------- 4-5. 오른쪽: 지도 ---------- */

        .mapContainer {
            border: 1px solid #333;
            background-color: white;
            position: sticky;
            /* 스크롤해도 따라오게 */
            top: 20px;
        }

        .mapTitle {
            padding: 12px 14px;
            border-bottom: 1px solid #333;
            font-size: 13px;
            font-weight: 600;
        }

        .mapSlot {
            width: 100%;
            aspect-ratio: 3 / 4;
            background-color: #e6e6e6;
            border-bottom: 1px solid #333;
        }

        .mapSummary {
            padding: 14px;
            font-size: 12px;
            color: #666;
        }

        .mapSummary div {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
        }


        /* ---------- 4-6. 하단 완료 바 ---------- */

        .finishBar {
            position: sticky;
            bottom: 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 60px;
            border-top: 1px solid #333;
            background-color: white;
            font-size: 13px;
        }

        .finishBtns {
            display: flex;
            gap: 8px;
        }

        .finishBtns button {
            padding: 9px 16px;
            font-size: 12px;
            cursor: pointer;
        }


        /* =========================================================
   5. 푸터
   ========================================================= */

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


        /* =========================================================
   6. 좁은 화면
   ========================================================= */

        @media (max-width: 1024px) {
            .plannerLayout {
                grid-template-columns: 1fr;
            }

            .mapContainer {
                position: static;
            }
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
            <h1>나만의 여행일정 만들기</h1>
            <br>
            <p style="font-size: 13px;">찜해둔 관광지 맛집 숙소를 끌어다 놓아 일차별 일정표를 완성해보세요.</p>
        </div>

        <hr>

        <div class="main">

            <!-- 위: 일정 입력 바 -->
            <div class="barContainer">

                <form action="">

                    <div class="formItem">
                        <span>일정 제목</span>
                        <input type="text" name="title" placeholder="예: 제주도 3박 4일 힐링 여행">
                    </div>

                    <div class="formItem">
                        <span>시작일</span>
                        <input type="date" name="startDate">
                    </div>

                    <div class="formItem">
                        <span>종료일</span>
                        <input type="date" name="endDate">
                    </div>

                    <div class="formItem">
                        <span>인원</span>
                        <select id="count" name="count">
                            <option value="1">1명</option>
                            <option value="2" selected>2명</option>
                            <option value="3">3명</option>
                            <option value="4">4명</option>
                            <option value="5">5명</option>
                            <option value="6">6명</option>
                            <option value="7">7명</option>
                            <option value="8">8명</option>
                        </select>
                    </div>

                    <div class="formItem">
                        <span>공개범위</span>
                        <select id="tf" name="tf">
                            <option value="true">전체 공개</option>
                            <option value="false">비공개</option>
                        </select>
                    </div>

                    <button type="submit" class="createBtn">일정 생성</button>

                </form>

            </div>

            <!-- 아래: 3단 (찜 목록 | 일정표 | 지도) -->
            <div class="plannerLayout">

                <!-- 왼쪽: 찜 목록 -->
                <div class="trableContainer">

                    <div class="wishList">
                        <div class="trableTitle active"><span>관광지</span></div>
                        <div class="trableTitle"><span>맛집</span></div>
                        <div class="trableTitle"><span>숙소</span></div>
                    </div>

                    <div class="wishSearch">
                        <input type="text" name="search" placeholder="찜 목록 내 검색">
                    </div>

                    <div class="tablewishContainer">

                        <div class="wishItem" draggable="true">
                            <span class="dragHandle">⋮⋮</span>
                            <div class="wishThumb">
                                <img src="/images/logo.png" style="width: 50px; height: 50px;">
                            </div>

                            <div class="wishText">
                                <p>제주특별자치도</p>
                                <span>한라산 국립공원</span>
                            </div>

                            <button type="button" class="addBtn">+</button>
                        </div>

                        <div class="wishItem" draggable="true">
                            <span class="dragHandle">⋮⋮</span>
                            <div class="wishThumb">
                                <img src="/images/logo.png" style="width: 50px; height: 50px;">
                            </div>

                            <div class="wishText">
                                <p>제주특별자치도</p>
                                <span>협재 해수욕장</span>
                            </div>

                            <button type="button" class="addBtn">+</button>
                        </div>

                    </div>
                </div>

                <!-- 가운데: 일정표 -->
                <div class="addContainer">

                    <div class="dayTabs">
                        <div class="dayTab active">Day 1</div>
                        <div class="dayTab">Day 2</div>
                        <div class="dayTab">Day 3</div>
                        <div class="dayTab">Day 4</div>
                        <div class="dayTab">＋ 일자 추가</div>
                    </div>

                    <div class="dayBody">
                        <p class="dayDate">2026.10.10 (토) · 1일차</p>

                        <div class="timelineItem">
                            <span class="orderMark">1</span>
                            <div class="timelineCard">
                                <span class="dragHandle">⋮⋮</span>
                                <div class="wishThumb"><img src="/images/logo.png" style="width: 50px; height: 50px;">
                                </div>
                                <div class="wishText">
                                    <p>관광지</p>
                                    <span>제주국제공항 도착</span>
                                </div>
                                <input type="text" class="timeInput" value="09:30">
                                <button type="button">✕</button>
                            </div>
                        </div>

                        <p class="transport">🚗 차량 이동 · 약 35분 · 22.4km</p>

                        <div class="timelineItem">
                            <span class="orderMark">2</span>
                            <div class="timelineCard">
                                <span class="dragHandle">⋮⋮</span>
                                <div class="wishThumb"><img src="/images/logo.png" style="width: 50px; height: 50px;">
                                </div>
                                <div class="wishText">
                                    <p>맛집</p>
                                    <span>협재 흑돼지 맛집</span>
                                </div>
                                <input type="text" class="timeInput" value="12:00">
                                <button type="button">✕</button>
                            </div>
                        </div>

                        <div class="dropEmpty">＋ 왼쪽 목록에서 장소를 끌어다 놓거나 ＋ 버튼으로 추가하세요</div>
                    </div>

                    <div class="dayFooter">Day 1 · 방문지 2곳 · 이동거리 약 22.4km</div>

                </div>

                <!-- 오른쪽: 지도 + 요약 -->
                <div class="mapContainer">
                    <div class="mapTitle">동선 미리보기</div>
                    <div class="mapSlot" id="map"></div>
                    <div class="mapSummary">
                        <div><span>총 일정 기간</span><b>3박 4일</b></div>
                        <div><span>총 방문지 수</span><b>14곳</b></div>
                    </div>
                </div>

            </div>

        </div>

        <!-- 하단 완료 바 -->
        <div class="finishBar">
            <div>총 <b>4일</b> 일정 · 방문지 <b>14곳</b> 등록됨</div>
            <div class="finishBtns">
                <button type="button">취소</button>
                <button type="button">미리보기</button>
                <button type="button">완성하고 링크 공유하기</button>
            </div>
        </div>

        <hr>
        <div class="footer">
            <p>AAAAAAAAAAAAAAAAAAAAAAAAAAAAA</p>
            <p>회사명 : GOTT | 대표 : ??? | 사업자등록번호 : 123-45-67890</p>
            <p>이용약관 | 개인정보처리방침 | 고객센터</p>
            <div class="textbox">사이트로고</div>
        </div>
    </div>

</body>

</html>