<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<title>추천 여행지</title>

<style>
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    font-family: "Pretendard", "Noto Sans KR", "Malgun Gothic", sans-serif;
    color: #222;
    background: #fff;
}

button {
    font-family: inherit;
    font-size: 14px;
}

.wrap {
    width: 100%;
    max-width: 1040px;
    margin: 0 auto;
    padding: 0 16px;
}

.hero {
    text-align: center;
    padding: 48px 0 40px;
    border-bottom: 1px solid #eee;
}

.hero h1 {
    font-size: 28px;
}

.hero p {
    margin: 10px 0 0;
    color: #666;
    font-size: 14px;
}

.placeSearchForm {
    display: flex;
    gap: 8px;
    margin-top: 30px;
}

.placeSearchForm input[type="text"] {
    flex: 1;
    min-width: 0;
    height: 42px;
    padding: 0 12px;
    border: 1px solid #ccc;
    font-size: 14px;
}

.placeSearchForm button {
    width: 70px;
    border: 1px solid #222;
    background: #222;
    color: white;
    cursor: pointer;
}

.filters {
    display: flex;
    align-items: center;
    gap: 8px;
    flex-wrap: wrap;
    margin: 40px 0 16px;
}

.filters .label {
    font-size: 13px;
    color: #555;
    margin-right: 4px;
}

.chip {
    padding: 8px 16px;
    border: 1px solid #222;
    background: #fff;
    cursor: pointer;
}

.chip.active {
    background: #222;
    color: #fff;
}

.chip:focus-visible {
    outline: 2px solid #06c;
    outline-offset: 2px;
}

.count {
    font-size: 13px;
    color: #666;
    margin-bottom: 14px;
}

.grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 24px;
}

.card {
    border: 1px solid #222;
    display: flex;
    flex-direction: column;
}

.thumb {
    position: relative;
    aspect-ratio: 4/3;
    border-bottom: 1px solid #222;
    background: #f3f3f3;
    overflow: hidden;
}

.thumb img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
}

.wishBtn {
    position: absolute;
    top: 10px;
    right: 10px;
    border: none;
    background: none;
    padding: 0;
    color: white;
    font-size: 25px;
    line-height: 1;
    cursor: pointer;
    z-index: 2;
    -webkit-text-stroke: 1.5px #333;
    transition: transform 0.15s ease;
}

.wishBtn:hover {
    transform: scale(1.08);
}

.wishBtn.active {
    color: #ed4956;
    -webkit-text-stroke: 0;
    transform: scale(1.1);
}

.tag {
    position: absolute;
    top: 10px;
    left: 10px;
    padding: 3px 8px;
    border: 1px solid #222;
    background: #fff;
    font-size: 12px;
}

.info {
    padding: 16px 16px 18px;
}

.info .region {
    font-size: 12px;
    color: #777;
}

.info h3 {
    font-size: 17px;
    margin-top: 6px;
}

.empty-msg {
    text-align: center;
    padding: 80px 0;
    color: #777;
}

.paging {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
    margin: 40px 0 30px;
}

.paging a {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 36px;
    height: 36px;
    border: 1px solid #ddd;
    border-radius: 8px;
    color: #555;
    background-color: white;
    text-decoration: none;
    font-size: 14px;
}

.paging a:hover {
    background-color: #f5f5f5;
}

.paging a.active {
    color: white;
    background-color: #333;
    border-color: #333;
}

.home {
    display: flex;
    justify-content: flex-end;
    margin-top: 20px;
}

.home button {
    padding: 9px 20px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: white;
    color: #333;
    cursor: pointer;
    background-color:black;
    color:white;
    font-weight:bold;
}

.home button:hover {
    background: #333;
    color: white;
}

@media (max-width: 800px) {
    .grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 16px;
    }
}

@media (max-width: 520px) {
    .grid {
        grid-template-columns: 1fr;
    }
}
</style>
</head>

<body>

    <section class="hero">
        <div class="wrap">
            <h1>여행지</h1>
            <p>관광지, 맛집, 숙박업소를 모아봤어요.</p>
        </div>
    </section>

    <main class="wrap">

        <form action="${pageContext.request.contextPath}/place/search"
              method="get" class="placeSearchForm">

            <input type="text" name="keyword" value="${keyword}"
                   placeholder="지역명이나 여행지를 검색하세요.">

            <input type="hidden" name="type" value="${type}">

            <button type="submit">검색</button>
        </form>

        <div class="filters">
            <span class="label">유형</span>

            <button type="button"
                    class="chip ${type == '전체' ? 'active' : ''}"
                    data-type="전체">전체</button>

            <button type="button"
                    class="chip ${type == '관광지' ? 'active' : ''}"
                    data-type="관광지">관광지</button>

            <button type="button"
                    class="chip ${type == '맛집' ? 'active' : ''}"
                    data-type="맛집">맛집</button>

            <button type="button"
                    class="chip ${type == '숙박업소' ? 'active' : ''}"
                    data-type="숙박업소">숙박업소</button>
        </div>

        <div class="count" id="count"></div>

        <div class="grid" id="grid">
            <c:forEach var="place" items="${list}">
                <article class="card" data-type="${place.place_type}">

                    <div class="thumb">
                        <c:if test="${not empty place.image_name}">
                            <img src="${place.image_name}" alt="${place.name}">
                        </c:if>

                        <button type="button"
                                class="wishBtn ${place.wish ? 'active' : ''}"
                                data-place-id="${place.place_id}">${place.wish ? '♥' : '♡'}</button>

                        <span class="tag">
                            <c:choose>
                                <c:when test="${place.place_type == 'SPOT'}">관광지</c:when>
                                <c:when test="${place.place_type == 'FOOD'}">맛집</c:when>
                                <c:when test="${place.place_type == 'STAY'}">숙박업소</c:when>
                                <c:otherwise>${place.place_type}</c:otherwise>
                            </c:choose>
                        </span>
                    </div>

                    <div class="info">
                        <div class="region">
                            ${place.region} ${place.sigungu}
                        </div>

                        <h3>${place.name}</h3>
                    </div>

                </article>
            </c:forEach>
        </div>

        <div class="empty-msg" id="emptyMsg" style="display: none;">
            검색 결과가 없어요. 다른 지역명으로 검색하세요.
        </div>
	
		<div class="home">
			<button onclick="location.href='/'">Home</button>
		</div>
		
        <div class="paging" id="paging"></div>

    </main>

    <script>
        let chips = document.getElementsByClassName("chip");

        for(let i = 0; i < chips.length; i++) {

            chips[i].onclick = function() {

                let type = this.getAttribute("data-type");

                location.href = "${pageContext.request.contextPath}/place/search?keyword=${keyword}&type="
                        + type + "&cpage=1";
            }
        }

        let recordTotalCount = ${recordTotalCount};
        let recordCountPerPage = ${recordCountPerPage};
        let naviCountPerPage = ${naviCountPerPage};
        let currentPage = ${cpage};

        let pageTotalCount = Math.ceil(recordTotalCount / recordCountPerPage);

        let startNavi = Math.floor((currentPage - 1) / naviCountPerPage)
                * naviCountPerPage + 1;

        let endNavi = startNavi + naviCountPerPage - 1;

        if(endNavi > pageTotalCount) {
            endNavi = pageTotalCount;
        }

        let needPrev = startNavi > 1;
        let needNext = endNavi < pageTotalCount;

        let navigation = document.getElementById("paging");

        if(needPrev) {
            let prev = document.createElement("a");

            prev.setAttribute("href",
                "${pageContext.request.contextPath}/place/search?keyword=${keyword}&type=${type}&cpage=" + (startNavi - 1));

            prev.innerHTML = "<";
            navigation.append(prev);
        }

        for(let i = startNavi; i <= endNavi; i++) {
            let num = document.createElement("a");

            num.setAttribute("href",
                "${pageContext.request.contextPath}/place/search?keyword=${keyword}&type=${type}&cpage=" + i);

            num.innerHTML = i;

            if(i == currentPage) {
                num.className = "active";
            }

            navigation.append(num);
        }

        if(needNext) {
            let next = document.createElement("a");

            next.setAttribute("href",
                "${pageContext.request.contextPath}/place/search?keyword=${keyword}&type=${type}&cpage=" + (endNavi + 1));

            next.innerHTML = ">";
            navigation.append(next);
        }

        $(document).on("click", ".wishBtn", function() {

            let btn = $(this);
            let placeId = btn.data("place-id");

            $.ajax({
                url: "${pageContext.request.contextPath}/wishlist/add",
                type: "POST",
                data: {
                    placeId: placeId
                },
                success: function(result) {

                    if(result == "add") {
                        btn.addClass("active");
                        btn.text("♥");
                    } else if(result == "delete") {
                        btn.removeClass("active");
                        btn.text("♡");
                    }
                },
                error: function() {
                    alert("찜 처리 중 오류가 발생했습니다.");
                }
            });
        });
    </script>

</body>
</html>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>