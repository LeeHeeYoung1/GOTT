<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/public.css">
<title>GOTT 찜한 목록</title>
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
    background-color: #f8fafa;
    line-height: 1.5;
}
.mypageContainer a {
    color: inherit;
    text-decoration: none;
}
.mypageContainer button {
    border: 1px solid black;
    background-color: white;
}
.mypageContainer button:hover {
    background-color: #222;
    color: white;
    border-color: #222;
}
.sectionTitle {
    display: flex;
    justify-content: space-between;
    align-items: stretch;
}
.sectionTitle>span {
    font-size: 16px;
    font-weight: bold;
    display: flex;
    align-items: center;
}
.sectionTitle>a {
    font-size: 12px;
    color: #777;
    display: flex;
    align-items: center;
}
.mypageContainer {
    width: 1200px;
    max-width: calc(100% - 40px);
    margin: 0 auto;
}
.sideBox {
    width: 17%;
    float: left;
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
.sideTitle>span {
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
.mainContainer {
    width: 83%;
    margin-left: 17%;
    padding-left: 20px;
}
.wishStatBar {
    width: 100%;
    display: flex;
    border: 1px solid #e5e7eb;
    border-radius: 10px;
    overflow: hidden;
    background-color: white;
}
.wishStatBar>div {
    width: 25%;
    height: 80px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}
.wishStatBar>div+div {
    border-left: 1px solid #e5e7eb;
}
.wishStatBar strong {
    font-size: 18px;
    font-weight: 700;
    color: #222;
}
.wishStatBar span {
    margin-top: 4px;
    font-size: 12px;
    color: #797472;
}
.wishFilterTabs {
    display: flex;
    gap: 8px;
    margin-top: 20px;
}
.wishFilterTabs button {
    padding: 8px 18px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background-color: white;
    font-size: 13px;
    color: #333;
    cursor: pointer;
}
.wishFilterTabs button .count {
    margin-left: 4px;
    color: #999;
}
.wishFilterTabs button.active {
    background-color: #222;
    color: white;
    border-color: #222;
    font-weight: 600;
}
.wishFilterTabs button.active .count {
    color: #ccc;
}
.wishFilterTabs button:not(.active):hover {
    background-color: #f2f2f2;
}
.wishToolbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 14px;
    flex-wrap: wrap;
    gap: 10px;
}
.wishToolbar .leftGroup,
.wishToolbar .rightGroup {
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 13px;
    color: #555;
}
.wishToolbar label {
    display: flex;
    align-items: center;
    gap: 5px;
    cursor: pointer;
}
.wishToolbar select,
.wishToolbar .plainBtn {
    height: 32px;
    padding: 0 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    background-color: white;
    font-size: 12px;
    color: #333;
    cursor: pointer;
}
.wishToolbar .plainBtn:hover {
    background-color: #222;
    color: white;
    border-color: #222;
}
.wishCategorySection {
    margin-top: 48px;
}
.wishCategorySection .sectionTitle>span {
    font-size: 17px;
}
.regionChips {
    display: flex;
    gap: 8px;
    margin: 14px 0 16px;
}
.regionChips button {
    padding: 7px 16px;
    border: 1px solid #ddd;
    border-radius: 20px;
    background-color: white;
    font-size: 12px;
    color: #555;
    cursor: pointer;
}
.regionChips button.active {
    background-color: #222;
    color: white;
    border-color: #222;
    font-weight: 600;
}
.regionChips button:not(.active):hover {
    background-color: #f2f2f2;
}
.wishGrid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
}
.wishCard {
    border: 1px solid #e5e7eb;
    border-radius: 10px;
    overflow: hidden;
    background-color: white;
    transition: box-shadow 0.2s ease;
}
.wishCard:hover {
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}
.wishCard .img {
    position: relative;
    width: 100%;
    height: 170px;
    background-color: #f1f1f1;
    overflow: hidden;
}
.wishCard .img img {
    display: block;
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.wishHeart {
    position: absolute;
    top: 10px;
    right: 10px;
    width: 30px;
    height: 30px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: rgba(255, 255, 255, 0.9);
    color: #e74c3c;
    font-size: 15px;
    cursor: pointer;
}
.wishInfo {
    padding: 14px 16px;
}
.wishInfo h3 {
    margin: 0 0 4px;
    font-size: 15px;
    font-weight: 700;
    color: #222;
}
.wishInfo .wishSub {
    margin: 0 0 12px;
    font-size: 12px;
    color: #777;
}
.wishBtnRow {
    display: flex;
    gap: 8px;
}
.wishBtnRow button {
    flex: 1;
    height: 34px;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: white;
    font-size: 12px;
    color: #333;
    cursor: pointer;
}
.wishBtnRow button:hover {
    background-color: #222;
    color: white;
    border-color: #222;
}
.wishBtnRow .unwishBtn {
    border-color: #e5e7eb;
    color: #999;
}
</style>
</head>
<body>
<c:choose>
    <c:when test="${loginId != null}">
        <jsp:include page="/WEB-INF/views/common/header.jsp" />
        <div class="mypageContainer">
            <h2 style="margin: 24px 0 4px;">찜한 목록</h2>
            <h5 style="font-size: 13px; color: #7c7c7c; margin: 0 0 16px;">관광지, 맛집, 숙소로 저장해 둔 곳을 한눈에 확인하세요.</h5>
            <hr style="border: 1px solid rgb(248, 246, 246); margin: 0 0 20px;">
            <div class="breadcrumb" style="font-size: 12px; margin: 0 0 20px;">홈 &gt; 마이페이지 &gt; 찜한 목록</div>
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
                        <li class="active"><a href="/member/wishlist">찜한 목록</a></li>
                        <li><a href="/members/planner">여행 일정 플래너</a></li>
                        <li><a href="#">내가 쓴 리뷰</a></li>
                        <li><a href="#">내가 쓴 게시글</a></li>
                    </ul>
                    <span>혜택</span>
                    <ul>
                        <li><a href="#">포인트 내역</a></li>
                        <li><a href="#">쿠폰함</a></li>
                    </ul>
                    <span>계정</span>
                    <ul>
                        <li><a href="/members/update">내 정보 수정</a></li>
                        <li><a href="#">알림 설정</a></li>
                        <li><a href="#">1:1 문의</a></li>
                    </ul>
                </div>
            </div>
            <div class="mainContainer">
                <div class="wishStatBar">
                    <div>
                        <strong>${wishTotalCount}</strong>
                        <span>전체</span>
                    </div>
                    <div>
                        <strong>${wishSpotCount}</strong>
                        <span>관광지</span>
                    </div>
                    <div>
                        <strong>${wishFoodCount}</strong>
                        <span>맛집</span>
                    </div>
                    <div>
                        <strong>${wishStayCount}</strong>
                        <span>숙소</span>
                    </div>
                </div>
                <div class="wishFilterTabs">
                    <button type="button" class="active" data-type="all">전체 <span class="count">${wishTotalCount}</span></button>
                    <button type="button" data-type="spot">관광지 <span class="count">${wishSpotCount}</span></button>
                    <button type="button" data-type="food">맛집 <span class="count">${wishFoodCount}</span></button>
                    <button type="button" data-type="stay">숙소 <span class="count">${wishStayCount}</span></button>
                </div>
                <div class="wishToolbar">
                    <div class="leftGroup">
                        <label><input type="checkbox" id="selectAll">전체 선택</label>
                        <button type="button" class="plainBtn">선택 삭제</button>
                        <button type="button" class="plainBtn">폴더에 담기</button>
                    </div>
                    <div class="rightGroup">
                        <select>
                            <option>지역 전체</option>
                            <option>제주</option>
                            <option>부산</option>
                            <option>강릉</option>
                            <option>경주</option>
                        </select>
                        <select>
                            <option>최근 저장순</option>
                            <option>이름순</option>
                            <option>평점순</option>
                        </select>
                    </div>
                </div>
                <div class="wishCategorySection">
                    <div class="sectionTitle">
                        <span>관광지 ${wishSpotCount}곳</span>
                        <a href="#">관광지 전체 보기 &gt;</a>
                    </div>
                    <div class="regionChips">
                        <button type="button" class="active">전체</button>
                        <button type="button">제주</button>
                        <button type="button">부산</button>
                        <button type="button">강릉</button>
                        <button type="button">경주</button>
                    </div>
                    <div class="wishGrid">
                        <c:forEach var="wishList" items="${wishList}">
                            <c:if test="${wishList.place_type == 'SPOT'}">
                                <div class="wishCard">
                                    <div class="img">
                                        <img src="${wishList.image_name}" alt="${wishList.name}">
                                        <span class="wishHeart">♥</span>
                                    </div>
                                    <div class="wishInfo">
                                        <h3>${wishList.name}</h3>
                                        <p class="wishSub">${wishList.region}</p>
                                        <div class="wishBtnRow">
                                            <button type="button" class="detailBtn" data-place-id="${wishList.place_id}">상세 보기</button>
                                            <button type="button" class="unwishBtn" data-place-id="${wishList.place_id}">찜 해제</button>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                <div class="wishCategorySection">
                    <div class="sectionTitle">
                        <span>맛집 ${wishFoodCount}곳</span>
                        <a href="#">맛집 전체 보기 &gt;</a>
                    </div>
                    <div class="regionChips">
                        <button type="button" class="active">전체</button>
                        <button type="button">제주</button>
                        <button type="button">부산</button>
                        <button type="button">강릉</button>
                        <button type="button">경주</button>
                    </div>
                    <div class="wishGrid">
                        <c:forEach var="wishList" items="${wishList}">
                            <c:if test="${wishList.place_type == 'FOOD'}">
                                <div class="wishCard">
                                    <div class="img">
                                        <img src="${wishList.image_name}" alt="${wishList.name}">
                                        <span class="wishHeart">♥</span>
                                    </div>
                                    <div class="wishInfo">
                                        <h3>${wishList.name}</h3>
                                        <p class="wishSub">${wishList.region}</p>
                                        <div class="wishBtnRow">
                                            <button type="button" class="detailBtn" data-place-id="${wishList.place_id}">상세 보기</button>
                                            <button type="button" class="unwishBtn" data-place-id="${wishList.place_id}">찜 해제</button>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                <div class="wishCategorySection">
                    <div class="sectionTitle">
                        <span>숙소 ${wishStayCount}곳</span>
                        <a href="#">숙소 전체 보기 &gt;</a>
                    </div>
                    <div class="regionChips">
                        <button type="button" class="active">전체</button>
                        <button type="button">제주</button>
                        <button type="button">부산</button>
                        <button type="button">강릉</button>
                        <button type="button">경주</button>
                    </div>
                    <div class="wishGrid">
                        <c:forEach var="wishList" items="${wishList}">
                            <c:if test="${wishList.place_type == 'STAY'}">
                                <div class="wishCard">
                                    <div class="img">
                                        <img src="${wishList.image_name}" alt="${wishList.name}">
                                        <span class="wishHeart">♥</span>
                                    </div>
                                    <div class="wishInfo">
                                        <h3>${wishList.name}</h3>
                                        <p class="wishSub">${wishList.region}</p>
                                        <div class="wishBtnRow">
                                            <button type="button" class="detailBtn" data-place-id="${wishList.place_id}">상세 보기</button>
                                            <button type="button" class="unwishBtn" data-place-id="${wishList.place_id}">찜 해제</button>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    </c:when>
</c:choose>
<script>
$(".unwishBtn").on("click", function() {
    if (!confirm("찜을 해제할까요?")) {
        return;
    }
    let btn = $(this);
    let placeId = btn.data("place-id");
    $.ajax({
        url: "/wishlist/add",
        type: "POST",
        data: {
            placeId: placeId
        },
        success: function(result) {
            if (result == "delete") {
                btn.closest(".wishCard").fadeOut(200, function() {
                    $(this).remove();
                });
            }
        },
        error: function() {
            alert("찜 해제 중 오류가 발생했습니다.");
        }
    });
});
$(".wishFilterTabs button").on("click", function() {
    $(".wishFilterTabs button").removeClass("active");
    $(this).addClass("active");
});
$(".regionChips button").on("click", function() {
    $(this).siblings().removeClass("active");
    $(this).addClass("active");
});
$(document).on("click", ".detailBtn", function() {
    let placeId = $(this).data("place-id");
    location.href = "/place/detail?placeId=" + placeId;
});
</script>
</body>
</html>