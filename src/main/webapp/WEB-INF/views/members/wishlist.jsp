<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
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

.mypageContainer > h2,
.mypageContainer > h5 {
    text-align: center;
}

.mypageContainer a {
    color: inherit;
    text-decoration: none;
}

.mypageContainer button {
    border: 1px solid #ddd;
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

.sectionTitle > span {
    font-size: 16px;
    font-weight: bold;
    display: flex;
    align-items: center;
}

.sectionTitle > a {
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

.wishStatBar > div {
    width: 25%;
    height: 80px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    transition: background-color 0.2s ease;
}

.wishStatBar > div + div {
    border-left: 1px solid #e5e7eb;
}

.wishStatBar > div:hover {
    background-color: #f3f4f6;
}

.wishStatBar > div.active {
    background-color: #eff6ff;
}

.wishStatBar strong {
    font-size: 18px;
    font-weight: 700;
    color: #222;
}

.wishStatBar > div.active strong {
    color: #2563eb;
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

.wishCategorySection .sectionTitle > span {
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
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 20px;
}

.wishCard {
    min-width: 0;
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
    min-width: 0;
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

    .wishGrid {
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 14px;
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

    .wishStatBar > div {
        height: 70px;
    }

    .wishStatBar strong {
        font-size: 16px;
    }

    .wishStatBar span {
        font-size: 11px;
    }

    .wishGrid {
        grid-template-columns: 1fr 1fr;
        gap: 10px;
    }

    .wishCard .img {
        height: 130px;
    }

    .wishInfo {
        padding: 10px;
    }

    .wishInfo h3 {
        font-size: 14px;
    }

    .wishBtnRow {
        flex-direction: column;
        gap: 5px;
    }

    .wishCategorySection {
        margin-top: 32px;
    }
}
</style>
</head>
<body>
<c:choose>
    <c:when test="${loginId != null}">
        <jsp:include page="/WEB-INF/views/common/header.jsp"/>
        <div class="mypageContainer">
            <h2 style="margin:24px 0 4px;">찜한 목록</h2>
            <h5 style="font-size:13px;color:#7c7c7c;margin:0 0 16px;">관광지, 맛집, 숙소로 저장해 둔 곳을 한눈에 확인하세요.</h5>
            <hr style="border:1px solid rgb(248,246,246);margin:0 0 20px;">
            <div class="breadcrumb" style="font-size:12px;margin:0 0 20px;">홈 &gt; 마이페이지 &gt; 찜한 목록</div>
            <div class="sideBox">
                <div class="loginId">
                    <strong>${nickname}</strong><span>님</span><br>
                    <span>일반회원</span>
                    <span>등급</span>
                </div>
                <hr>
                <div class="sideTitle">
                    <span>예약/활동</span>
                    <ul>
                        <li><a href="/members/mypage">마이페이지 홈</a></li>
                        <li><a href="/members/reservationpage">예약 내역</a></li>
                        <li class="active"><a href="/members/wishlist">찜한 여행지 · 숙소</a></li>
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
                        <li><a href="/members/update">내 정보 수정</a></li>
                        <li><a href="/members/pwsearchpage">비밀번호 변경</a></li>
                        <li><a href="#">알림 설정</a></li>
                        <li><a href="#">1:1 문의</a></li>
                        <li><a href="/members/deleted">회원탈퇴</a></li>
                    </ul>
                </div>
            </div>
            <div class="mainContainer">
                <div class="wishStatBar">
                    <div class="active" data-type="ALL">
                        <strong>${wishTotalCount}</strong>
                        <span>전체</span>
                    </div>
                    <div data-type="SPOT">
                        <strong>${wishSpotCount}</strong>
                        <span>관광지</span>
                    </div>
                    <div data-type="FOOD">
                        <strong>${wishFoodCount}</strong>
                        <span>맛집</span>
                    </div>
                    <div data-type="STAY">
                        <strong>${wishStayCount}</strong>
                        <span>숙소</span>
                    </div>
                </div>
                
                <div class="wishCategorySection" data-section-type="SPOT">
                    <div class="sectionTitle"><span>관광지</span></div>
                    <div class="regionChips">
                        <button type="button" class="active">전체</button>
                    </div>
                    <div class="wishGrid">
                        <c:forEach var="wish" items="${wishList}">
                            <c:if test="${wish.place_type == 'SPOT'}">
                                <div class="wishCard" data-type="SPOT">
                                    <div class="img">
                                        <img src="${wish.image_name}" alt="${wish.name}">
                                        <span class="wishHeart">♥</span>
                                    </div>
                                    <div class="wishInfo">
                                        <h3>${wish.name}</h3>
                                        <p class="wishSub">${wish.region}</p>
                                        <div class="wishBtnRow">
                                            <button type="button" class="detailBtn" data-place-id="${wish.place_id}">상세 보기</button>
                                            <button type="button" class="unwishBtn" data-place-id="${wish.place_id}">찜 해제</button>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                <div class="wishCategorySection" data-section-type="FOOD">
                    <div class="sectionTitle"><span>맛집</span></div>
                    <div class="regionChips">
                        <button type="button" class="active">전체</button>
                    </div>
                    <div class="wishGrid">
                        <c:forEach var="wish" items="${wishList}">
                            <c:if test="${wish.place_type == 'FOOD'}">
                                <div class="wishCard" data-type="FOOD">
                                    <div class="img">
                                        <img src="${wish.image_name}" alt="${wish.name}">
                                        <span class="wishHeart">♥</span>
                                    </div>
                                    <div class="wishInfo">
                                        <h3>${wish.name}</h3>
                                        <p class="wishSub">${wish.region}</p>
                                        <div class="wishBtnRow">
                                            <button type="button" class="detailBtn" data-place-id="${wish.place_id}">상세 보기</button>
                                            <button type="button" class="unwishBtn" data-place-id="${wish.place_id}">찜 해제</button>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                <div class="wishCategorySection" data-section-type="STAY">
                    <div class="sectionTitle"><span>숙소</span></div>
                    <div class="regionChips">
                        <button type="button" class="active">전체</button>
                    </div>
                    <div class="wishGrid">
                        <c:forEach var="wish" items="${wishList}">
                            <c:if test="${wish.place_type == 'STAY'}">
                                <div class="wishCard" data-type="STAY">
                                    <div class="img">
                                        <img src="${wish.image_name}" alt="${wish.name}">
                                        <span class="wishHeart">♥</span>
                                    </div>
                                    <div class="wishInfo">
                                        <h3>${wish.name}</h3>
                                        <p class="wishSub">${wish.region}</p>
                                        <div class="wishBtnRow">
                                            <button type="button" class="detailBtn" data-place-id="${wish.place_id}">상세 보기</button>
                                            <button type="button" class="unwishBtn" data-place-id="${wish.place_id}">찜 해제</button>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </c:when>
    <c:otherwise>
        <script>
            alert("로그인이 필요합니다.");
            location.href="/members/loginpage";
        </script>
    </c:otherwise>
</c:choose>
<script>
$(document).on("click",".unwishBtn",function(){
    if(!confirm("찜을 해제할까요?")) return;
    let btn=$(this);
    let placeId=btn.data("place-id");
    $.ajax({
        url:"/wishlist/add",
        type:"POST",
        data:{placeId:placeId},
        success:function(result){
            if(result=="delete"){
                let card=btn.closest(".wishCard");
                let section=card.closest(".wishCategorySection");
                card.fadeOut(200,function(){
                    $(this).remove();
                    updateWishCounts();
                    if(section.find(".wishCard").length===0) section.hide();
                });
            }else{
                alert("찜 해제에 실패했습니다.");
            }
        },
        error:function(){
            alert("찜 해제 중 오류가 발생했습니다.");
        }
    });
});
$(document).on("click",".detailBtn",function(){
    let placeId=$(this).data("place-id");
    location.href="/place/detail?placeId="+encodeURIComponent(placeId);
});
$(".wishStatBar>div").on("click",function(){
    let type=$(this).data("type");
    $(".wishStatBar>div").removeClass("active");
    $(this).addClass("active");
    $(".wishCategorySection").each(function(){
        let section=$(this);
        if(type==="ALL"||section.data("section-type")===type){
            section.show();
        }else{
            section.hide();
        }
    });
});
function updateWishCounts(){
    let total=0,spot=0,food=0,stay=0;
    $(".wishCard").each(function(){
        let type=$(this).data("type");
        total++;
        if(type==="SPOT") spot++;
        else if(type==="FOOD") food++;
        else if(type==="STAY") stay++;
    });
    $(".wishStatBar>div").eq(0).find("strong").text(total);
    $(".wishStatBar>div").eq(1).find("strong").text(spot);
    $(".wishStatBar>div").eq(2).find("strong").text(food);
    $(".wishStatBar>div").eq(3).find("strong").text(stay);
}
$(".regionChips button").on("click",function(){
    $(this).siblings().removeClass("active");
    $(this).addClass("active");
});
</script>
</body>
</html>