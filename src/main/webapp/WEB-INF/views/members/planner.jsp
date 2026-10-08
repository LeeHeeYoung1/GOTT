<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<!DOCTYPE html>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/public.css">
<script src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<title>GOTT 여행 일정 플래너</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
    integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=ea87fc26ee3f75472cb75c454c18b302"></script>

<style>

/* =========================================================
   1. 플래너 제목 영역
   기존 public.css의 전역 스타일은 수정하지 않음
   ========================================================= */

.title {
    width: 100%;
    min-height: 155px;
    padding: 30px 24px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    text-align: center;
    background: linear-gradient(120deg, #ffffff 0%, #eef8f7 100%);
}

.title h1 {
    margin: 0 0 12px;
    color: #263238;
    font-size: 30px;
    font-weight: 700;
    letter-spacing: -1px;
    text-align: center;
}

.title p {
    margin: 0;
    color: #64748b;
    font-size: 14px !important;
    line-height: 1.7;
    text-align: center;
}


/* =========================================================
   2. 플래너 메인 영역
   ========================================================= */

.main {
    width: 100%;
    padding: 26px 24px 36px;
    display: flex;
    flex-direction: column;
    gap: 24px;
}


/* =========================================================
   3. 상단 일정 입력 영역
   ========================================================= */

.barContainer {
    width: 100%;
    padding: 24px;
    display: block;
    background-color: #ffffff;
    border: 1px solid #e2e8f0;
    border-radius: 15px;
    box-shadow: 0 4px 14px rgba(38, 50, 56, 0.04);
}

.barContainer form {
    width: 100%;
    display: grid;
    grid-template-columns: minmax(180px, 1.8fr) repeat(4, minmax(95px, 1fr)) auto;
    align-items: end;
    gap: 14px;
}

.barContainer form > div {
    min-width: 0;
    margin: 0 !important;
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    gap: 9px;
}

.barContainer form span {
    min-height: 18px;
    display: flex;
    align-items: center;
    color: #475569;
    font-size: 13px !important;
    font-weight: 600;
    line-height: 18px;
}

.barContainer input[type="text"],
.barContainer input[type="date"],
.barContainer select {
    width: 100%;
    min-width: 0;
    height: 44px;
    padding: 0 11px;
    color: #263238;
    background-color: #ffffff;
    border: 1px solid #dbe3ed;
    border-radius: 9px;
    outline: none;
    font-size: 13px;
    transition: border-color 0.2s, box-shadow 0.2s;
}

.barContainer input::placeholder {
    color: #94a3b8;
}

.barContainer input:focus,
.barContainer select:focus {
    border-color: #0f766e;
    box-shadow: 0 0 0 3px rgba(15, 118, 110, 0.1);
}

#createPlaner {
    min-width: 104px;
    height: 44px;
    padding: 0 18px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #ffffff;
    background-color: #0f766e;
    border: 1px solid #0f766e;
    border-radius: 9px;
    font-size: 13px;
    font-weight: 700;
    white-space: nowrap;
    transition: background-color 0.2s, transform 0.2s;
}

#createPlaner:hover {
    background-color: #115e59;
    transform: translateY(-1px);
}


/* =========================================================
   4. 3단 플래너 레이아웃
   찜 목록 | 일정표 | 지도
   ========================================================= */

.plannerLayout {
    display: grid;
    grid-template-columns: minmax(0, 0.9fr) minmax(0, 1.7fr) minmax(0, 1fr);
    gap: 18px;
    align-items: start;
}


/* =========================================================
   5. 공통 플래너 카드
   ========================================================= */

.tableContainer,
.addContainer,
.mapContainer {
    min-width: 0;
    background-color: #ffffff;
    border: 1px solid #e2e8f0;
    border-radius: 15px;
    box-shadow: 0 4px 14px rgba(38, 50, 56, 0.04);
    overflow: hidden;
}


/* =========================================================
   6. 관광지 / 맛집 / 숙소 탭
   ========================================================= */

.wishList {
    display: flex;
    align-items: stretch;
    gap: 5px;
    padding: 7px;
    background-color: #ffffff;
    border-bottom: 1px solid #edf0f4;
}

.tableTitle {
    flex: 1;
    min-height: 40px;
    padding: 10px 3px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #64748b;
    background-color: #f5f7fa;
    border: none;
    border-radius: 8px;
    font-size: 12px;
    font-weight: 600;
    line-height: 1.4;
    text-align: center;
    cursor: pointer;
    transition: background-color 0.2s, color 0.2s;
}

.tableTitle + .tableTitle {
    border-left: none;
}

.tableTitle:hover {
    color: #0f766e;
    background-color: #e9f7f4;
}

.tableTitle.active {
    color: #ffffff;
    background-color: #0f766e;
}


/* =========================================================
   7. 찜 목록 검색창
   ========================================================= */

.wishSearch {
    padding: 14px 14px 6px;
}

.wishSearch input {
    width: 100%;
    height: 40px;
    padding: 0 12px;
    color: #263238;
    background-color: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 9px;
    outline: none;
    font-size: 12px;
    transition: border-color 0.2s, box-shadow 0.2s;
}

.wishSearch input:focus {
    border-color: #0f766e;
    box-shadow: 0 0 0 3px rgba(15, 118, 110, 0.08);
}

.wishSearch input::placeholder {
    color: #94a3b8;
}


/* =========================================================
   8. 찜 목록 카드
   ========================================================= */

.tablewishContainer {
    max-height: 560px;
    padding: 10px 14px 14px;
    overflow-y: auto;
    scrollbar-width: thin;
    scrollbar-color: #cbd5e1 transparent;
}

.wishItem {
    display: flex;
    align-items: center;
    gap: 9px;
    padding: 10px;
    margin-bottom: 10px;
    background-color: #ffffff;
    border: 1px solid #e5eaf0;
    border-radius: 11px;
    transition: border-color 0.2s, box-shadow 0.2s;
}

.wishItem:hover {
    border-color: #a7dcd5;
    box-shadow: 0 4px 12px rgba(15, 118, 110, 0.07);
}

.dragHandle {
    flex-shrink: 0;
    color: #94a3b8;
    font-size: 13px;
    cursor: grab;
}

.wishThumb {
    flex-shrink: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    background-color: #eef2f6;
    border-radius: 8px;
}

.wishThumb img {
    width: 60px;
    height: 60px;
    display: block;
    object-fit: cover;
}

.wishText {
    flex: 1;
    min-width: 0;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 4px;
    text-align: left;
}

.wishText p {
    margin: 0;
    color: #0f766e;
    font-size: 11px;
    font-weight: 600;
    line-height: 1.45;
}

.wishText span {
    display: block;
    overflow: hidden;
    color: #263238;
    font-size: 13px;
    font-weight: 700;
    line-height: 1.45;
    text-overflow: ellipsis;
    white-space: nowrap;
}


/* =========================================================
   9. 장소 추가 버튼
   ========================================================= */

.addBtn {
    width: 30px;
    height: 30px;
    flex-shrink: 0;
    padding: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #0f766e;
    background-color: #e9f7f4;
    border: none;
    border-radius: 8px;
    font-size: 19px;
    font-weight: 600;
    line-height: 1;
    transition: background-color 0.2s, color 0.2s;
}

.addBtn:hover:not(:disabled) {
    color: #ffffff;
    background-color: #0f766e;
}

.addBtn:disabled {
    color: #94a3b8;
    background-color: #e9edf2;
    cursor: not-allowed;
    opacity: 0.7;
}


/* =========================================================
   10. 가운데 일정표
   ========================================================= */

.addContainer {
    max-height: 700px;
    overflow-y: auto;
    scrollbar-width: thin;
    scrollbar-color: #cbd5e1 transparent;
}


/* Day 탭 */

.dayTabs {
    display: flex;
    flex-wrap: nowrap;
    gap: 6px;
    padding: 12px;
    overflow-x: auto;
    background-color: #ffffff;
    border-bottom: 1px solid #edf0f4;
    scrollbar-width: thin;
}

.dayTab {
    flex-shrink: 0;
    padding: 10px 16px;
    color: #64748b;
    background-color: #f1f5f9;
    border: 1px solid transparent;
    border-radius: 8px;
    font-size: 12px;
    font-weight: 700;
    text-align: center;
    cursor: pointer;
    transition: background-color 0.2s, color 0.2s;
}

.dayTab:hover {
    color: #0f766e;
    background-color: #e9f7f4;
}

.dayTab.active {
    color: #ffffff;
    background-color: #0f766e;
    border-color: #0f766e;
}


/* 날짜와 일정 본문 */

.dayBody {
    min-height: 320px;
    padding: 22px;
}

.dayDate {
    min-height: 24px;
    margin: 0 0 20px;
    display: flex;
    align-items: center;
    color: #263238;
    font-size: 15px;
    font-weight: 700;
    line-height: 1.5;
}


/* 일정 타임라인 */

.timelineItem {
    display: flex;
    align-items: flex-start;
    gap: 12px;
    margin-bottom: 16px;
}

.orderMark {
    width: 28px;
    height: 28px;
    flex-shrink: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #ffffff;
    background-color: #0f766e;
    border-radius: 50%;
    font-size: 12px;
    font-weight: 700;
}

.timelineCard {
    flex: 1;
    min-width: 0;
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 12px;
    background-color: #ffffff;
    border: 1px solid #e5eaf0;
    border-radius: 11px;
}

.timelineCard .wishThumb img {
    width: 50px;
    height: 50px;
}

.timelineCard .wishText {
    flex: 1;
    min-width: 0;
}

.timelineCard .wishText span {
    white-space: normal;
    overflow-wrap: anywhere;
}

.timeInput {
    width: 80px;
    min-width: 0;
    flex-shrink: 0;
    padding: 7px;
    color: #475569;
    background-color: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 7px;
    font-size: 11px;
    text-align: center;
}

.timelineCard button {
    width: 27px;
    height: 27px;
    flex-shrink: 0;
    padding: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #64748b;
    background-color: #f1f5f9;
    border: none;
    border-radius: 7px;
    line-height: 1;
    transition: color 0.2s, background-color 0.2s;
}

.timelineCard button:hover {
    color: #dc2626;
    background-color: #fee2e2;
}


/* 일정이 비어 있을 때 */

.dropEmpty {
    min-height: 95px;
    padding: 28px 18px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #64748b;
    background-color: #f8fafc;
    border: 1px dashed #cbd5e1;
    border-radius: 11px;
    font-size: 13px;
    line-height: 1.8;
    text-align: center;
}

.transport {
    margin: -4px 0 16px 40px;
    color: #64748b;
    font-size: 11px;
}


/* 일정 하단 요약 */

.dayFooter {
    padding: 14px 20px;
    color: #64748b;
    background-color: #f8fafc;
    border-top: 1px solid #edf0f4;
    font-size: 12px;
    line-height: 1.6;
}


/* =========================================================
   11. 오른쪽 지도
   ========================================================= */

.mapContainer {
    position: sticky;
    top: 20px;
}

.mapTitle {
    min-height: 50px;
    padding: 14px 16px;
    display: flex;
    align-items: center;
    color: #263238;
    background-color: #ffffff;
    border-bottom: 1px solid #edf0f4;
    font-size: 14px;
    font-weight: 700;
    line-height: 1.5;
}

.mapSlot {
    width: 100%;
    aspect-ratio: 3 / 4;
    min-height: 280px;
    background-color: #e9f0f3;
    border-bottom: 1px solid #edf0f4;
}

.mapSummary {
    padding: 16px;
    color: #64748b;
    background-color: #ffffff;
    font-size: 12px;
}

.mapSummary div {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 10px;
    margin-bottom: 10px;
    line-height: 1.6;
}

.mapSummary div:last-child {
    margin-bottom: 0;
}

.mapSummary span {
    text-align: left;
}

.mapSummary b {
    color: #0f766e;
    font-size: 13px;
    text-align: right;
}


/* =========================================================
   12. 하단 완료 바
   ========================================================= */

.finishBar {
    position: sticky;
    bottom: 0;
    z-index: 10;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 20px;
    padding: 16px 24px;
    color: #475569;
    background-color: rgba(255, 255, 255, 0.97);
    border-top: 1px solid #e2e8f0;
    box-shadow: 0 -4px 18px rgba(38, 50, 56, 0.04);
    font-size: 13px;
    backdrop-filter: blur(8px);
}

.finishBar > div:first-child {
    display: flex;
    align-items: center;
    line-height: 1.6;
}

.finishBar b {
    color: #0f766e;
    font-weight: 700;
}

.finishBtns {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
}

.finishBtns button {
    min-height: 38px;
    padding: 9px 14px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    color: #475569;
    background-color: #ffffff;
    border: 1px solid #dbe3ed;
    border-radius: 8px;
    font-size: 12px;
    font-weight: 600;
    line-height: 1.4;
    text-align: center;
    white-space: nowrap;
    transition: background-color 0.2s, color 0.2s, border-color 0.2s;
}

.finishBtns button:hover {
    color: #0f766e;
    background-color: #eef8f6;
    border-color: #a7dcd5;
}

.finishBtns button:last-child {
    color: #ffffff;
    background-color: #0f766e;
    border-color: #0f766e;
}

.finishBtns button:last-child:hover {
    background-color: #115e59;
}


/* =========================================================
   13. 작은 노트북 및 태블릿
   ========================================================= */

@media (max-width: 1200px) {
    .main {
        padding: 24px 20px 30px;
    }

    .barContainer form {
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 14px;
    }

    .barContainer form > div:first-child {
        grid-column: span 2;
    }

    .barContainer form > div:last-child {
        grid-column: auto;
    }

    #createPlaner {
        width: 100%;
    }

    .plannerLayout {
        grid-template-columns: minmax(0, 0.9fr) minmax(0, 1.5fr);
    }

    .mapContainer {
        position: static;
        grid-column: 1 / -1;
    }

    .mapSlot {
        aspect-ratio: 16 / 7;
        min-height: 250px;
    }

    .finishBar {
        padding: 15px 20px;
    }
}


/* =========================================================
   14. 모바일
   ========================================================= */

@media (max-width: 760px) {
    .title {
        min-height: 130px;
        padding: 24px 16px;
    }

    .title h1 {
        font-size: 24px;
    }

    .title p {
        font-size: 12px !important;
    }

    .main {
        padding: 16px 12px 24px;
        gap: 16px;
    }

    .barContainer {
        padding: 16px;
    }

    .barContainer form {
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 14px;
    }

    .barContainer form > div:first-child,
    .barContainer form > div:last-child {
        grid-column: 1 / -1;
    }

    #createPlaner {
        width: 100%;
    }

    .barContainer input[type="text"],
    .barContainer input[type="date"],
    .barContainer select {
        font-size: 12px;
    }

    .plannerLayout {
        grid-template-columns: minmax(0, 1fr);
        gap: 16px;
    }

    .tablewishContainer {
        max-height: 400px;
    }

    .addContainer {
        max-height: 650px;
    }

    .mapContainer {
        grid-column: auto;
    }

    .mapSlot {
        aspect-ratio: 4 / 3;
        min-height: 230px;
    }

    .dayBody {
        padding: 15px;
    }

    .timelineCard {
        flex-wrap: wrap;
    }

    .finishBar {
        position: static;
        flex-direction: column;
        align-items: stretch;
        padding: 15px;
        gap: 14px;
    }

    .finishBar > div:first-child {
        justify-content: center;
    }

    .finishBtns {
        display: grid;
        grid-template-columns: 1fr 1fr;
    }

    .finishBtns button {
        white-space: normal;
    }

    .finishBtns button:last-child {
        grid-column: 1 / -1;
    }
}

</style>

<div class="container">

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
                <div style="margin: 10px;">
                    <span style="font-size: 10px;">일정 제목</span><br>
                    <input type="text" name="title" placeholder="예: 제주도 3박 4일 힐링 여행">
                </div>

                <div style="margin: 10px;">
                    <span style="font-size: 10px;">여행 시작일</span><br>
                    <input type="date" name="startDate">
                </div>

                <div style="margin: 10px;">
                    <span style="font-size: 10px;">여행 종료일</span><br>
                    <input type="date" name="endDate">
                </div>

                <div style="margin: 10px;">
                    <span style="font-size: 10px;">인원</span><br>
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

                <div style="margin: 10px;">
                    <span style="font-size: 10px;">공개범위</span><br>
                    <select id="tf" name="tf">
                        <option value="true">전체 공개</option>
                        <option value="false">비공개</option>
                    </select>
                </div>

                <div>
                    <button type="button" id="createPlaner">일정 생성</button>
                </div>
            </form>
        </div>

        <div class="plannerLayout">

            <!-- 왼쪽: 찜 목록 -->
            <div class="tableContainer">
                <div class="wishList">
                    <div class="tableTitle active" data-type="SPOT"><span>관광지</span></div>
                    <div class="tableTitle" data-type="FOOD"><span>맛집</span></div>
                    <div class="tableTitle" data-type="STAY"><span>숙소</span></div>
                </div>

                <div class="wishSearch">
                    <input type="text" name="search" placeholder="찜 목록 내 검색">
                </div>

                <div class="tablewishContainer">
                    <c:forEach var="place" items="${wishList}">
                        <div class="wishItem" data-type="${place.place_type}" draggable="true">
                            <span class="dragHandle">⋮⋮</span>
                            <div class="wishThumb">
                                <img src="${place.image_name}" alt="${place.name}">
                            </div>
                            <div class="wishText">
                                <p>${place.region}</p>
                                <span>${place.name}</span>
                            </div>
                            <button type="button" class="addBtn" disabled
                                onclick="addPlace(${place.place_id}, ${place.latitude}, ${place.longitude}, '${place.name}', '${place.place_type}')">+</button>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- 가운데: 일정표 -->
            <div class="addContainer">
                <div class="dayTabs" id="dayTabs"></div>

                <div class="dayBody">
                    <p class="dayDate" id="dayDate"></p>
                    <div class="dropEmpty">＋ 버튼으로 나의 일정에 장소를 추가하세요</div>
                </div>

                <div class="dayFooter">Day ? · 방문지 ?곳 · 이동거리 약 ?km</div>
            </div>

            <!-- 오른쪽: 지도 + 요약 -->
            <div class="mapContainer">
                <div class="mapTitle">동선 미리보기</div>
                <div class="mapSlot" id="map"></div>
                <div class="mapSummary">
                    <div><span>총 일정 기간</span><b>?박 ?일</b></div>
                    <div><span>총 방문지 수</span><b>??곳</b></div>
                </div>
            </div>

        </div>
    </div>

    <!-- 하단 완료 바 -->
    <div class="finishBar">
        <div>총 <b>?일</b> 일정 · 방문지 <b>??곳</b> 등록됨</div>
        <div class="finishBtns">
            <button type="button">임시저장</button>
            <button type="button">미리보기</button>
            <button type="button">완성하고 링크 공유하기</button>
        </div>
    </div>

</div>

<script>

$(document).ready(function() {

    $("#createPlaner").on("click", function() {
        let title = $("input[name='title']").val().trim();
        let startDate = $("input[name='startDate']").val();
        let endDate = $("input[name='endDate']").val();

        if (title == "") {
            alert("제목을 입력해주세요");
            return;
        }

        if (startDate == "" || endDate == "") {
            alert("날짜 입력해주세요");
            return;
        }

        let start = new Date(startDate + "T00:00:00");
        let end = new Date(endDate + "T00:00:00");

        if (start > end) {
            alert("날짜 잘못 줴줴이~");
            return;
        }

        let dayTabs = $("#dayTabs");
        dayTabs.empty();

        let day = 1;
        let currentDate = new Date(start);
        let week = ["일", "월", "화", "수", "목", "금", "토"];

        while (currentDate <= end) {
            let year = currentDate.getFullYear();
            let month = String(currentDate.getMonth() + 1).padStart(2, "0");
            let date = String(currentDate.getDate()).padStart(2, "0");
            let dayOfWeek = week[currentDate.getDay()];

            let dayTab = $("<div>")
                .addClass("dayTab")
                .text("Day " + day);

            dayTab.data("year", year);
            dayTab.data("month", month);
            dayTab.data("date", date);
            dayTab.data("dayOfWeek", dayOfWeek);
            dayTab.data("day", day);

            if (day == 1) {
                dayTab.addClass("active");

                $("#dayDate").text(
                    year + "." + month + "." + date +
                    " (" + dayOfWeek + ") · " + day + "일차"
                );
            }

            dayTabs.append(dayTab);
            currentDate.setDate(currentDate.getDate() + 1);
            day++;
        }

        // 수정: 일정 생성이 성공한 뒤에만 + 버튼 활성화
        $(".addBtn").prop("disabled", false);

    });


    // 관광지, 맛집, 숙소 탭 필터링
    function filterWishList(type) {
        $(".wishItem").each(function() {
            if ($(this).data("type") == type) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    }

    $(".tableTitle").on("click", function() {
        $(".tableTitle").removeClass("active");
        $(this).addClass("active");

        let type = $(this).data("type");
        filterWishList(type);
    });

    // 플래너에 처음 들어오면 관광지만 표시
    filterWishList("SPOT");


    // 날짜별 Day 탭 클릭
    $(document).on("click", ".dayTab", function() {
        $(".dayTab").removeClass("active");
        $(this).addClass("active");

        let year = $(this).data("year");
        let month = $(this).data("month");
        let date = $(this).data("date");
        let dayOfWeek = $(this).data("dayOfWeek");
        let day = $(this).data("day");

        $("#dayDate").text(
            year + "." + month + "." + date +
            "(" + dayOfWeek + ")." + day + "일차"
        );
    });


    // 카카오 지도 API
    var container = document.getElementById("map");
    var options = {
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 8
    };

    var map = new kakao.maps.Map(container, options);

    var markers = [];

    var polyline = new kakao.maps.Polyline({
        path: [],
        strokeWeight: 5,
        strokeColor: "#FF0000",
        strokeOpacity: 0.7,
        strokeStyle: "solid"
    });

    polyline.setMap(map);


    // 수정: 일정 생성 전 장소 추가 차단
    window.addPlace = function(placeId, lat, lng, name, placeType) {
        if ($("#dayTabs .dayTab").length == 0) {
            alert("먼저 일정 제목과 여행 날짜를 입력하고 일정을 생성해주세요.");
            return;
        }

        // 기존 기능 유지
        addTimelineItem(placeId, name, placeType);
        addMarker(placeId, lat, lng, name);
    };


    // 마커 생성
    function addMarker(placeId, lat, lng, name) {
        var position = new kakao.maps.LatLng(lat, lng);

        var marker = new kakao.maps.Marker({
            position: position,
            map: map
        });

        markers.push({
            placeId: placeId,
            name: name,
            marker: marker,
            position: position
        });

        updatePolyline();
        map.setCenter(position);
    }


    // 경로 업데이트
    function updatePolyline() {
        var linePath = [];

        for (var i = 0; i < markers.length; i++) {
            linePath.push(markers[i].position);
        }

        polyline.setPath(linePath);
    }


    // 일정표에 장소 추가
    function addTimelineItem(placeId, name, placeType) {
        var count = $(".timelineItem").length + 1;

        var timelineItem = $("<div>")
            .addClass("timelineItem")
            .attr("data-place-id", placeId);

        var orderMark = $("<span>")
            .addClass("orderMark")
            .text(count);

        var timelineCard = $("<div>").addClass("timelineCard");

        var dragHandle = $("<span>")
            .addClass("dragHandle")
            .text("⋮⋮");

        var thumb = $("<div>")
            .addClass("wishThumb")
            .append(
                $("<img>")
                    .attr("src", "/images/logo.png")
                    .css({
                        width: "50px",
                        height: "50px"
                    })
            );

        var typeText;

        if (placeType == "SPOT") {
            typeText = "관광지";
        } else if (placeType == "FOOD") {
            typeText = "맛집";
        } else if (placeType == "STAY") {
            typeText = "숙박업소";
        } else {
            typeText = placeType;
        }

        var wishText = $("<div>")
            .addClass("wishText")
            .append($("<p>").text(typeText))
            .append($("<span>").text(name));

        var timeInput = $("<input>")
            .attr("type", "text")
            .addClass("timeInput")
            .attr("placeholder", "시간");

        var deleteButton = $("<button>")
            .attr("type", "button")
            .text("✕");

        timelineCard
            .append(dragHandle)
            .append(thumb)
            .append(wishText)
            .append(timeInput)
            .append(deleteButton);

        timelineItem
            .append(orderMark)
            .append(timelineCard);

        $(".dropEmpty").before(timelineItem);

        // 일정에서 장소 삭제
        deleteButton.on("click", function() {
            timelineItem.remove();
            removeMarker(placeId);
            updateOrder();
        });
    }


    // 지도에서 마커 삭제
    function removeMarker(placeId) {
        for (var i = 0; i < markers.length; i++) {
            if (markers[i].placeId == placeId) {
                markers[i].marker.setMap(null);
                markers.splice(i, 1);
                break;
            }
        }

        updatePolyline();
    }


    // 일정 순서 번호 갱신
    function updateOrder() {
        $(".timelineItem").each(function(index) {
            $(this).find(".orderMark").text(index + 1);
        });
    }

});

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
