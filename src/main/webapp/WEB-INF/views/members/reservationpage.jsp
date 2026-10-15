<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/public.css">
    <title>GOTT 예약내역</title>
    <style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    padding: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-size: 16px;
    color: #263238;
    background: #f8fafa;
    line-height: 1.5;
}

.mypageContainer {
    width: 1200px;
    max-width: calc(100% - 40px);
    margin: 0 auto;
}

.mypageContainer a {
    color: inherit;
    text-decoration: none;
}

.mypageContainer button {
    cursor: pointer;
}

.mypageContainer > h2,
.mypageContainer > h5 {
    text-align: center;
}

.sideBox {
    width: 17%;
    float: left;
    border: 1px solid #e5e7eb;
    border-radius: 10px;
    overflow: hidden;
    background: #fff;
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
}

.sideTitle li:hover {
    background: #f2f2f2;
}

.sideTitle li.active {
    background: #eff6ff;
}

.sideTitle li.active a {
    color: #2563eb;
    font-weight: 600;
}

.mainContainer {
    width: 83%;
    margin-left: 17%;
    padding-left: 20px;
}

.reservationStats {
    display: flex;
    width: 100%;
    border: 1px solid #e5e7eb;
    border-radius: 10px;
    overflow: hidden;
    background: #fff;
}

.reservationStats > div {
    width: 25%;
    height: 90px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    transition: background 0.2s;
}

.reservationStats > div + div {
    border-left: 1px solid #e5e7eb;
}

.reservationStats > div:hover,
.reservationStats > div.active {
    background: #eff6ff;
}

.reservationStats strong {
    font-size: 21px;
    color: #222;
}

.reservationStats > div.active strong {
    color: #2563eb;
}

.reservationStats span {
    margin-top: 4px;
    font-size: 12px;
    color: #797472;
}

.reservationToolbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 10px;
    flex-wrap: wrap;
    margin: 25px 0 14px;
}

.reservationTabs {
    display: flex;
    gap: 7px;
    flex-wrap: wrap;
}

.reservationTabs button {
    padding: 8px 15px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: #fff;
    font-size: 13px;
    color: #333;
}

.reservationTabs button.active {
    background: #222;
    color: #fff;
    border-color: #222;
    font-weight: 600;
}

.reservationTabs .count {
    margin-left: 4px;
    color: #999;
}

.reservationTabs button.active .count {
    color: #ddd;
}

.reservationSummary {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 15px 0;
    font-size: 13px;
    color: #777;
}

.reservationSummary strong {
    color: #222;
}

.reservationList {
    display: flex;
    flex-direction: column;
    gap: 16px;
}

.reservationCard {
    border: 1px solid #e5e7eb;
    border-radius: 10px;
    background: #fff;
    overflow: hidden;
}

.reservationCardTop {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 10px;
    padding: 14px 18px;
    background: #fafafa;
    border-bottom: 1px solid #eee;
    font-size: 12px;
    color: #777;
}

.reservationNumber {
    color: #555;
}

.statusBadge {
    display: inline-block;
    padding: 5px 10px;
    border-radius: 20px;
    background: #eff6ff;
    color: #2563eb;
    font-size: 12px;
    font-weight: 600;
    white-space: nowrap;
}

.statusBadge.completed {
    background: #f0fdf4;
    color: #15803d;
}

.statusBadge.cancelled {
    background: #fef2f2;
    color: #dc2626;
}

.statusBadge.pending {
    background: #fefce8;
    color: #a16207;
}

.reservationCardBody {
    display: flex;
    gap: 18px;
    padding: 20px;
}

.stayImage {
    width: 145px;
    height: 125px;
    flex-shrink: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    border-radius: 8px;
    background: #f1f1f1;
    color: #999;
    font-size: 12px;
}

.stayImage img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.reservationInfo {
    flex: 1;
    min-width: 0;
}

.reservationInfo h3 {
    margin: 0 0 5px;
    font-size: 17px;
    color: #222;
}

.roomName {
    margin: 0 0 14px;
    font-size: 13px;
    color: #777;
}

.reservationDetails {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 9px 18px;
}

.detailItem {
    min-width: 0;
    overflow-wrap: anywhere;
    font-size: 12px;
    color: #777;
}

.detailItem strong {
    display: block;
    margin-top: 3px;
    font-size: 13px;
    color: #333;
    font-weight: 500;
}

.reservationPrice {
    min-width: 130px;
    text-align: right;
    align-self: center;
}

.reservationPrice span {
    display: block;
    font-size: 12px;
    color: #777;
}

.reservationPrice strong {
    display: block;
    margin-top: 5px;
    font-size: 19px;
    color: #222;
}

.reservationCardBottom {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 10px;
    padding: 13px 18px;
    border-top: 1px solid #eee;
}

.reservationCardBottom .paymentInfo {
    font-size: 12px;
    color: #777;
}

.reservationActions {
    display: flex;
    gap: 7px;
    flex-wrap: wrap;
}

.reservationActions a,
.reservationActions button {
    display: inline-flex;
    justify-content: center;
    align-items: center;
    min-height: 33px;
    padding: 0 13px;
    border: 1px solid #ddd;
    border-radius: 5px;
    background: #fff;
    font-size: 12px;
    color: #333;
}

.reservationActions a:hover,
.reservationActions button:hover {
    background: #222;
    color: #fff;
    border-color: #222;
}

.reservationActions .cancelBtn {
    color: #dc2626;
    border-color: #fecaca;
}

.emptyReservation {
    padding: 65px 20px;
    text-align: center;
    border: 1px solid #e5e7eb;
    border-radius: 10px;
    background: #fff;
    color: #888;
    font-size: 14px;
}

.emptyReservation strong {
    display: block;
    margin-bottom: 8px;
    font-size: 17px;
    color: #333;
}

.emptyReservation a {
    display: inline-block;
    margin-top: 18px;
    padding: 10px 18px;
    border-radius: 6px;
    background: #222;
    color: #fff;
}

@media (max-width: 1000px) {
    .mypageContainer {
        max-width: calc(100% - 24px);
    }

    .sideBox {
        width: 22%;
    }

    .mainContainer {
        width: 78%;
        margin-left: 22%;
        padding-left: 14px;
    }

    .reservationCardBody {
        flex-wrap: wrap;
    }

    .reservationPrice {
        width: 100%;
        padding-top: 12px;
        border-top: 1px solid #eee;
        text-align: left;
    }
}

@media (max-width: 650px) {
    .mypageContainer {
        max-width: calc(100% - 20px);
    }

    .sideBox {
        float: none;
        width: 100%;
        margin-bottom: 20px;
    }

    .mainContainer {
        width: 100%;
        margin-left: 0;
        padding-left: 0;
    }

    .reservationStats > div {
        height: 75px;
    }

    .reservationStats strong {
        font-size: 17px;
    }

    .reservationStats span {
        font-size: 11px;
    }

    .reservationToolbar {
        align-items: flex-start;
        flex-direction: column;
    }

    .reservationCardBody {
        gap: 12px;
        padding: 14px;
    }

    .stayImage {
        width: 100px;
        height: 100px;
    }

    .reservationInfo h3 {
        font-size: 15px;
    }

    .roomName {
        margin-bottom: 10px;
    }

    .reservationDetails {
        grid-template-columns: 1fr 1fr;
        gap: 8px;
    }

    .reservationCardTop,
    .reservationCardBottom {
        padding: 12px;
    }

    .reservationCardBottom {
        align-items: flex-start;
        flex-direction: column;
    }

    .reservationActions {
        width: 100%;
    }

    .reservationActions a,
    .reservationActions button {
        flex: 1;
        padding: 0 8px;
    }

    .reservationPrice strong {
        font-size: 17px;
    }
}
    </style>
</head>
<body>
    <c:choose>
        <c:when test="${loginId != null}">
            <jsp:include page="/WEB-INF/views/common/header.jsp"/>
            <div class="mypageContainer">
                <h2 style="margin:24px 0 4px;">예약내역</h2>
                <h5 style="font-size:13px;color:#7c7c7c;margin:0 0 16px;">예약한 숙소와 이용 일정을 확인하고 관리하세요.</h5>
                <hr style="border:1px solid rgb(248,246,246);margin:0 0 20px;">
                <div class="breadcrumb" style="font-size:12px;margin:0 0 20px;">홈 &gt; 마이페이지 &gt; 예약내역</div>
                <div class="sideBox">
                    <div class="loginId">
                        <strong>${nickname}</strong><span>님</span><br>
                        <span>일반회원</span> <span>등급</span>
                    </div>
                    <hr>
                    <div class="sideTitle">
						<span>예약/활동</span>
						<ul>
							<li><a href="/members/mypage">마이페이지 홈</a></li>
							<li class="active"><a href="/members/reservationpage">예약 내역</a></li>
							<li><a href="/members/wishlist">찜한 목록</a></li>
							<li><a href="/members/planner">여행 일정 플래너</a></li>
							<li><a href="/review/reviewlist">내가 쓴 리뷰</a></li>
							<li><a href="/board/boardlist">내가 쓴 게시글</a></li>
							<li><a href="/bookmark/bookmarklist">북마크</a></li>

						</ul>
						<span>혜택</span>
						<ul>
							<li><a href="/members/mileage">마일리지 내역</a></li>
							<li><a href="/coupon/myCoupon">쿠폰함</a></li>
						</ul>
						<span>계정</span>
						<ul>
							<li><a href="/members/checkPassword">내 정보 수정</a></li>
							<li><a href="/members/pwsearchpage">비밀번호 변경</a></li>
							<li><a href="#">1:1 문의</a></li>
							<li><a href="/members/deleted">회원탈퇴</a></li>
						</ul>
					</div>
                </div>
                <div class="mainContainer">
                    <div class="reservationStats">
                        <div class="active" data-filter="ALL">
                            <strong id="totalCount">0</strong>
                            <span>전체 예약</span>
                        </div>
                        <div data-filter="UPCOMING">
                            <strong id="upcomingCount">0</strong>
                            <span>이용 예정</span>
                        </div>
                        <div data-filter="COMPLETED">
                            <strong id="completedCount">0</strong>
                            <span>이용 완료</span>
                        </div>
                        <div data-filter="CANCELLED">
                            <strong id="cancelledCount">0</strong>
                            <span>취소·환불</span>
                        </div>
                    </div>
                    <div class="reservationToolbar">
                        <div class="reservationTabs">
                            <button type="button" class="active" data-status="ALL">전체 <span class="count">0</span></button>
                            <button type="button" data-status="예약완료">예약 완료</button>
                            <button type="button" data-status="UPCOMING">이용 예정</button>
                            <button type="button" data-status="이용완료">이용 완료</button>
                            <button type="button" data-status="CANCELLED">취소·환불</button>
                        </div>
                        
                    </div>
                    <div class="reservationSummary">
                        <span>예약 내역 <strong id="visibleCount">0</strong>건</span>
                        <span>예약 정보를 확인해 주세요.</span>
                    </div>
                    <div class="reservationList" id="reservationList">
                        <c:forEach var="rs" items="${myRsList}">
                            <div class="reservationCard" data-status="${rs.status}" data-name="${rs.placeName} ${rs.roomName}" data-checkin="${rs.checkIn}" data-reserved="${rs.reserveDate}" data-price="${rs.price}">
                                <div class="reservationCardTop">
                                    <span class="reservationNumber">예약번호 : ${rs.paymentId}</span>
                                    <c:choose>
                                        <c:when test="${rs.status == '이용완료'}">
                                            <span class="statusBadge completed">이용 완료</span>
                                        </c:when>
                                        <c:when test="${rs.status == '예약취소' || rs.status == '취소완료' || rs.status == '환불완료' || rs.status == '취소·환불'}">
											<span class="statusBadge cancelled">${rs.status}</span>
										</c:when>
                                        <c:when test="${rs.status == '예약완료' && rs.checkOut lt today}">
										    <span class="statusBadge completed">이용 완료</span>
										</c:when>
										<c:when test="${rs.status == '예약완료'}">
										    <span class="statusBadge">예약 완료</span>
										</c:when>
                                        <c:otherwise>
                                            <span class="statusBadge pending">${rs.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="reservationCardBody">
                                    <div class="stayImage">
                                        <c:choose>
                                            <c:when test="${not empty rs.image1}">
											    <img src="${rs.image1}" alt="${rs.placeName}">
											</c:when>
                                            <c:otherwise>
                                                숙소 이미지
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="reservationInfo">
                                        <h3><c:out value="${rs.placeName}" default="예약 숙소"/></h3>
                                        <p class="roomName"><c:out value="${rs.roomName}" default="객실 정보"/></p>
                                        <div class="reservationDetails">
                                            <div class="detailItem">
                                                체크인
                                                <strong>${rs.checkIn}</strong>
                                            </div>
                                            <div class="detailItem">
                                                체크아웃
                                                <strong>${rs.checkOut}</strong>
                                            </div>
                                            <div class="detailItem">
                                                투숙 인원
                                                <strong>${rs.guestNum}명</strong>
                                            </div>
                                            <div class="detailItem">
                                                예약일
                                                <strong>${rs.reserveDate}</strong>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="reservationPrice">
                                        <span>결제 금액</span>
                                        <strong><fmt:formatNumber value="${rs.price}" pattern="#,##0"/>원</strong>
                                    </div>
                                </div>
                                <div class="reservationCardBottom">
									<span class="paymentInfo">예약 상태 :
									    <c:choose>
									        <c:when test="${rs.status == '예약완료' && rs.checkOut lt today}">
									            이용완료
									        </c:when>
									        <c:when test="${rs.status == '예약완료'}">
									            이용예정
									        </c:when>
									        <c:otherwise>
									            <c:out value="${rs.status}"/>
									        </c:otherwise>
									    </c:choose>
									</span>
                                    <div class="reservationActions">
									    <c:if test="${rs.status == '예약완료' && rs.checkIn gt today}">
									        <button type="button" class="update_btn" data-payment-id="${rs.paymentId}">예약 변경</button>
									        <button type="button" class="cancelBtn" data-payment-id="${rs.paymentId}">예약 취소</button>
									    </c:if>
									</div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="emptyReservation" id="emptyReservation" style="display:none;">
                        <strong>예약 내역이 없습니다.</strong>
                        조건에 맞는 예약을 찾을 수 없습니다.<br>
                        <a href="/reservation/list">숙소 둘러보기</a>
                    </div>
                </div>
                <div style="clear:both;"></div>
            </div>
            <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
        </c:when>
        <c:otherwise>
            <script>
                alert("로그인이 필요합니다.");
                location.href = "/members/loginpage";
            </script>
        </c:otherwise>
    </c:choose>
    <script>
$(function() {
    let activeFilter = "ALL";

    function getGroup(card) {
        let status = String(card.attr("data-status") || "").trim();

        if (["예약취소", "취소완료", "환불완료", "취소·환불"].includes(status)) {
            return "CANCELLED";
        }
        if (status === "이용완료") {
            return "COMPLETED";
        }
        if (status === "예약완료") {
            let checkIn = String(card.attr("data-checkin") || "").substring(0, 10).replaceAll("/", "-");
            let today = new Date();
            let todayString = today.getFullYear() + "-" + String(today.getMonth() + 1).padStart(2, "0") + "-" + String(today.getDate()).padStart(2, "0");
            let inDate = new Date(todayString);
            let checkInDate = new Date(checkIn);

            if (checkIn && !isNaN(checkInDate.getTime()) && checkInDate < inDate) {
                return "COMPLETED";
            }
            return "UPCOMING";
        }
        return "OTHER";
    }

    function updateCounts() {
        let cards = $(".reservationCard");
        let upcoming = 0;
        let completed = 0;
        let cancelled = 0;

        cards.each(function() {
            let group = getGroup($(this));

            if (group === "UPCOMING") {
                upcoming++;
            } else if (group === "COMPLETED") {
                completed++;
            } else if (group === "CANCELLED") {
                cancelled++;
            }
        });

        $("#totalCount").text(cards.length);
        $("#upcomingCount").text(upcoming);
        $("#completedCount").text(completed);
        $("#cancelledCount").text(cancelled);
        $(".reservationTabs button[data-status='ALL'] .count").text(cards.length);
    }

    function filterReservations() {
        let shown = 0;

        $(".reservationCard").each(function() {
            let card = $(this);
            let status = String(card.attr("data-status") || "").trim();
            let group = getGroup(card);
            let visible = activeFilter === "ALL"
                || activeFilter === status
                || activeFilter === group;

            card.toggle(visible);

            if (visible) {
                shown++;
            }
        });

        $("#visibleCount").text(shown);
        $("#emptyReservation").toggle(shown === 0);
    }

    function setActiveFilter(filter) {
        activeFilter = filter;

        $(".reservationStats > div").removeClass("active");
        $(".reservationStats > div[data-filter='" + filter + "']").addClass("active");

        $(".reservationTabs button").removeClass("active");

        let tabStatus = filter;
        if (filter === "COMPLETED") {
            tabStatus = "이용완료";
        } else if (filter === "UPCOMING") {
            tabStatus = "UPCOMING";
        } else if (filter === "CANCELLED") {
            tabStatus = "CANCELLED";
        }

        $(".reservationTabs button[data-status='" + tabStatus + "']").addClass("active");
        filterReservations();
    }
    
    $(document).on("click", ".update_btn", function() {
        let paymentId = $(this).attr("data-payment-id");

        if (!paymentId) {
            alert("예약 정보를 찾을 수 없습니다.");
            return;
        }

        location.href = "/reservation/reservationUpdate?paymentId=" + encodeURIComponent(paymentId);
   
    });

    $(".reservationStats > div").on("click", function() {
        setActiveFilter(String($(this).data("filter")));
    });

    $(".reservationTabs button").on("click", function() {
        setActiveFilter(String($(this).data("status")));
    });

    $(document).on("click", ".cancelBtn", function() {
        let button = $(this);
        let paymentId = button.attr("data-payment-id");

        if (!paymentId) {
            alert("결제 정보를 찾을 수 없습니다.");
            return;
        }

        if (!confirm("예약을 취소하시겠습니까?\n결제 취소도 함께 요청됩니다.")) {
            return;
        }

        button.prop("disabled", true).text("취소 처리 중...");

        $.ajax({
            url: "/reservation/cancelMyReservation",
            type: "POST",
            data: { paymentId: paymentId },
            success: function(result) {
                if (result === "success") {
                    alert("예약 및 결제가 취소되었습니다.");
                    location.reload();
                } else {
                    alert(result);
                    button.prop("disabled", false).text("예약 취소");
                }
            },
            error: function() {
                alert("예약 취소 요청에 실패했습니다. 결제 내역을 확인해 주세요.");
                button.prop("disabled", false).text("예약 취소");
            }
        });
    });
    
    updateCounts();
    filterReservations();
});
</script>
</body>
</html>