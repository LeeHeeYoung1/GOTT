<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>예약 변경</title>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    background-color: #F5F5F5;
    font-family: "Malgun Gothic", "맑은 고딕", sans-serif;
    color: #1a1a1f;
}

.container {
    max-width: 1000px;
    margin: 0 auto;
    background: #fff;
    padding: 30px 24px;
}

.header {
    padding-bottom: 18px;
    margin-bottom: 20px;
    border-bottom: 1px solid #e3e6ea;
    font-size: 13px;
    color: #9a9aa0;
}


/* =========================
   숙소 정보
========================= */

.place_info {
    padding-bottom: 24px;
    margin-bottom: 24px;
    border-bottom: 1px solid #e3e6ea;
}

.place_info img {
    width: 100%;
    height: 320px;
    object-fit: cover;
    border-radius: 8px;
    display: block;
    background: #eef1f5;
}

.place_name {
    margin-top: 16px;
    font-size: 24px;
    font-weight: 800;
}

.place_address {
    margin-top: 6px;
    font-size: 14px;
    color: #6b6f76;
}


/* =========================
   현재 예약 정보
========================= */

.current_reservation {
    padding: 18px;
    margin-bottom: 30px;
    border: 1px solid #e3e6ea;
    border-radius: 8px;
    background: #fafafa;
}

.current_reservation h3 {
    margin: 0 0 14px;
}

.current_reservation p {
    margin: 6px 0;
    font-size: 14px;
}


/* =========================
   객실 목록
========================= */

.room_list {
    display: flex;
    flex-direction: column;
    gap: 16px;
}

.room_card_div {
    border: 1px solid #e3e6ea;
    border-radius: 8px;
    background: #fff;
    overflow: hidden;
    cursor: pointer;
    transition: .2s;
}

.room_card_div:hover {
    border-color: #b9bec5;
    box-shadow: 0 2px 10px rgba(0, 0, 0, .05);
}


/* 선택된 객실 */

.room_card_div.selected {
    border: 2px solid #222;
    background: #fafafa;
}


/* 현재 예약된 객실 */

.room_card_div.current {
    border-color: #777;
}


.room_card {
    display: grid;
    grid-template-columns: 1fr auto;
    gap: 14px 18px;
    padding: 16px;
}


/* 이미지 */

.room_img {
    grid-column: 1 / -1;
    display: flex;
    gap: 6px;
    overflow-x: auto;
    padding-bottom: 6px;
}

.room_img img {
    width: 200px;
    height: 150px;
    object-fit: cover;
    flex-shrink: 0;
    border-radius: 6px;
    display: block;
    background: #eef1f5;
}

.no_img {
    width: 200px;
    height: 150px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #eef1f5;
    border-radius: 6px;
    font-size: 12px;
    color: #9a9aa0;
}


/* 객실 정보 */

.room_info {
    min-width: 0;
}

.room_info p {
    margin: 0;
}

.roomName {
    font-size: 17px;
    font-weight: 700;
}

.roomCount {
    margin-top: 4px !important;
    font-size: 13px;
    color: #9a9aa0;
}

.roomAmenity {
    display: flex;
    flex-wrap: wrap;
    gap: 5px;
    margin-top: 10px;
}

.roomAmenity span {
    padding: 3px 9px;
    border: 1px solid #e8eaed;
    border-radius: 3px;
    font-size: 11px;
    color: #6b6f76;
}


/* 가격 */

.room_price {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    justify-content: flex-end;
    min-width: 160px;
    font-size: 16px;
    font-weight: 700;
    text-align: right;
    line-height: 1.5;
}


/* =========================
   날짜 / 인원
========================= */

.change_info {
    margin-top: 30px;
    padding: 20px;
    border-top: 1px solid #e3e6ea;
}

.change_info h3 {
    margin-top: 0;
}

.form_row {
    display: flex;
    align-items: center;
    margin: 14px 0;
}

.form_row label {
    width: 100px;
    font-weight: 700;
}

.form_row input {
    width: 220px;
    height: 40px;
    padding: 0 10px;
    border: 1px solid #d5d9de;
    border-radius: 5px;
}


/* 인원 */

.guest_box {
    display: flex;
    align-items: center;
    gap: 10px;
}

.guest_box button {
    width: 32px;
    height: 32px;
    border: 1px solid #d5d9de;
    background: #fff;
    border-radius: 4px;
    cursor: pointer;
}

.guest_box span {
    min-width: 30px;
    text-align: center;
    font-weight: 700;
}


/* =========================
   하단
========================= */

.bottom_area {
    margin-top: 30px;
    padding-top: 20px;
    border-top: 1px solid #e3e6ea;
    text-align: right;
}

.price_text {
    font-size: 18px;
    font-weight: 700;
    margin-bottom: 15px;
}

.update_btn {
    width: 180px;
    height: 45px;
    border: none;
    border-radius: 6px;
    background: #222;
    color: white;
    font-size: 15px;
    cursor: pointer;
}

.update_btn:hover {
    background: #000;
}

</style>

</head>

<body>

<div class="container">

    <div class="header">
        예약 변경
    </div>


    <!-- =========================
         숙소 정보
    ========================== -->

    <div class="place_info">

        <img src="${reservation.image1}" alt="호텔 이미지">

        <p class="place_name">
            ${placeOne.name}
        </p>

        <p class="place_address">
            ${placeOne.address}
        </p>

    </div>


    <!-- =========================
         현재 예약
    ========================== -->

    <div class="current_reservation">

        <h3>현재 예약</h3>

        <p>
            객실 : ${reservation.roomName}
        </p>

        <p>
            체크인 : ${reservation.checkIn}
        </p>

        <p>
            체크아웃 : ${reservation.checkOut}
        </p>

        <p>
            인원 : ${reservation.guestNum}명
        </p>

        <p>
            결제금액 :
            <fmt:formatNumber value="${reservation.price}" pattern="#,###"/>원
        </p>

    </div>


    <!-- =========================
         객실 변경
    ========================== -->

    <h2>객실 변경</h2>

    <div class="room_list">

        <c:forEach var="i" items="${detailList}">

            <div class="room_card_div
                <c:if test="${i.roomId == reservation.roomId}">
                    selected current
                </c:if>"
                data-room-id="${i.roomId}">

                <div class="room_card">

                    <!-- 이미지 -->

                    <div class="room_img">

                        <c:if test="${not empty i.image1}">
                            <img src="${i.image1}">
                        </c:if>

                        <c:if test="${not empty i.image2}">
                            <img src="${i.image2}">
                        </c:if>

                        <c:if test="${not empty i.image3}">
                            <img src="${i.image3}">
                        </c:if>

                        <c:if test="${not empty i.image4}">
                            <img src="${i.image4}">
                        </c:if>

                        <c:if test="${not empty i.image5}">
                            <img src="${i.image5}">
                        </c:if>

                        <c:if test="${empty i.image1}">
                            <div class="no_img">
                                사진 준비중
                            </div>
                        </c:if>

                    </div>


                    <!-- 객실 정보 -->

                    <div class="room_info">

                        <p class="roomName">
                            ${i.roomName}
                        </p>

                        <p class="roomCount">
                            잔여 객실 수 : ${i.roomCount}
                        </p>

                        <div class="roomAmenity">

                            <c:forEach var="j" items="${i.amenities}">
                                <span>${j}</span>
                            </c:forEach>

                        </div>

                    </div>


                    <!-- 가격 -->

                    <div class="room_price">

                        <c:choose>

                            <c:when test="${i.priceWeekday != null}">

                                <fmt:formatNumber
                                    value="${i.priceWeekday}"
                                    pattern="#,###"/>원 ~

                                <fmt:formatNumber
                                    value="${i.priceWeekend}"
                                    pattern="#,###"/>원

                            </c:when>

                            <c:otherwise>

                                가격은 해당 숙소에 문의하여 주시기 바랍니다.

                            </c:otherwise>

                        </c:choose>

                    </div>

                </div>

            </div>

        </c:forEach>

    </div>


    <!-- =========================
         날짜 / 인원 변경
    ========================== -->

    <div class="change_info">

        <h2>예약 정보 변경</h2>


        <div class="form_row">

            <label>체크인</label>

            <input
                type="date"
                id="checkIn"
                value="${reservation.checkIn}">

        </div>


        <div class="form_row">

            <label>체크아웃</label>

            <input
                type="date"
                id="checkOut"
                value="${reservation.checkOut}">

        </div>


        <div class="form_row">

            <label>인원</label>

            <div class="guest_box">

                <button type="button" id="minusGuest">
                    -
                </button>

                <span id="guestCount">
                    ${reservation.guestNum}
                </span>

                <button type="button" id="plusGuest">
                    +
                </button>

            </div>

        </div>

    </div>


    <!-- =========================
         변경
    ========================== -->

    <div class="bottom_area">

        <div class="price_text">

            현재 결제금액 :
            <fmt:formatNumber
                value="${reservation.price}"
                pattern="#,###"/>원

        </div>

        <button type="button" class="update_btn">
            예약 변경
        </button>

    </div>

</div>


<script>

/* =========================
   선택된 객실
========================= */

$(".room_card_div").on("click", function() {

    $(".room_card_div").removeClass("selected");

    $(this).addClass("selected");

    let roomId = $(this).data("room-id");

    console.log("선택한 roomId : " + roomId);

});


/* =========================
   인원 감소
========================= */

$("#minusGuest").on("click", function() {

    let guest = Number($("#guestCount").text());

    if (guest > 1) {

        guest--;

        $("#guestCount").text(guest);

    }

});


/* =========================
   인원 증가
========================= */

$("#plusGuest").on("click", function() {

    let guest = Number($("#guestCount").text());

    guest++;

    $("#guestCount").text(guest);

});


/* =========================
   예약 변경
========================= */

$(".update_btn").on("click", function() {

    let roomId = $(".room_card_div.selected").data("room-id");

    let checkIn = $("#checkIn").val();

    let checkOut = $("#checkOut").val();

    let guest = Number($("#guestCount").text());

    console.log("roomId : " + roomId);
    console.log("checkIn : " + checkIn);
    console.log("checkOut : " + checkOut);
    console.log("guest : " + guest);

});


</script>

</body>
</html>