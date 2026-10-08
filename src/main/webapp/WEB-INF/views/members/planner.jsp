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
    flex-direction: column;   /* 위에서 아래로 쌓기 */
    padding: 40px 60px;
    gap: 50px;
}


/* ---------- 4-1. 일정 입력 바 ---------- */

.barContainer {
    width: 100%;
    display: flex;
    border: 1px solid black;
}

/* 폼 안의 칸들을 가로 한 줄로, 아래 기준 정렬 */
.barContainer form {
    display: flex;
    align-items: flex-end;
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
.tableContainer {
    border: 1px solid #333;
    background-color: white;
}

/* 탭 줄: 3칸을 똑같은 너비로 */
.wishList {
    display: flex;
}

.tableTitle {
    flex: 1;
    padding: 12px 0;
    text-align: center;
    border-bottom: 1px solid #333;
    cursor: pointer;
}

.tableTitle + .tableTitle {
    border-left: 1px solid #333;
}

/* 선택된 탭 */
.tableTitle.active {
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
    max-height: 700px;
    overflow-y: auto;
}

/* Day 탭 */
.dayTabs {
    display: flex;
    flex-wrap: nowrap;
    overflow-x: auto;
    border-bottom: 1px solid #333;
}

.dayTab {
    flex-shrink: 0;
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
    position: sticky;     /* 스크롤해도 따라오게 */
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
                        <div class="tableTitle active"><span>관광지</span></div>
                        <div class="tableTitle"><span>맛집</span></div>
                        <div class="tableTitle"><span>숙소</span></div>
                    </div>

                    <div class="wishSearch">
                        <input type="text" name="search" placeholder="찜 목록 내 검색">
                    </div>

                    <div class="tablewishContainer">
						<c:forEach var="place" items="${wishList}">
	                        <div class="wishItem" draggable="true">
	                            <span class="dragHandle">⋮⋮</span>
	                            <div class="wishThumb">
	                                <img src="/images/logo.png" style="width: 50px; height: 50px;">
	                            </div>
	
	                            <div class="wishText">
	                                <p>${place.region}</p>
                					<span>${place.name}</span>
	                            </div>
	
	                            <button type="button" class="addBtn"
							        onclick="addPlace(${place.place_id}, ${place.latitude}, 
							        ${place.longitude},'${place.name}','${place.place_type}')">
							    +</button>
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
                <button type="button">임시저장</button>
                <button type="button">미리보기</button>
                <button type="button">완성하고 링크 공유하기</button>
            </div>
        </div>

    </div>
    
<script>

   $("#createPlaner").on("click",function(){
      let title = $("input[name='title']").val();
      let startDate = $("input[name='startDate']").val();
      let endDate = $("input[name='endDate']").val();
      
      if(title == ""){
         alert("히히 바보 다잉~");
         return;
      }
      
      if(startDate == "" || endDate == ""){
         alert("히히 너 바보다잉~");
         return;
      }
      
      let start = new Date(startDate);
      let end = new Date(endDate);
      
      if(start > end){
         alert("히히 나 바보 아니다~");
         return;
      }
      
      let dayTabs = $("#dayTabs");
      dayTabs.empty();
      
      let day = 1;
      let currentDate = new Date(start);
      let week = ["일", "월", "화", "수", "목", "금", "토"];

      while(currentDate <= end){
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

          if(day == 1){
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
      
   });
   
   
   $(document).on("click", ".dayTab", function(){
      $(".dayTab").removeClass("active");
      $(this).addClass("active");
      
      let year = $(this).data("year");
      let month = $(this).data("month");
      let date = $(this).data("date");
      let dayOfWeek = $(this).data("dayOfWeek");
      let day = $(this).data("day");
      
      $("#dayDate").text(year+"."+month+"."+date+"("+dayOfWeek+")."+day+"일차");
   });
   
	// 카카오 맵 API요~
	var container = document.getElementById('map');
	var options = {
		center: new kakao.maps.LatLng(33.450701, 126.570667),
		level: 8
	};

	var map = new kakao.maps.Map(container, options);
	
	var markers = [];
	var polyline = new kakao.maps.Polyline({
		path: [],
		strokeWeight: 5,
		strokeColor: '#FF0000',
		strokeOpacity: 0.7,
		strokeStyle: 'solid'
	});
	
	polyline.setMap(map);
	
	// + 버튼 기능이요~
	function addPlace(placeId, lat, lng, name, placeType) {

	    // 1. 일정표에 장소 추가
	    addTimelineItem(placeId, name, placeType);
	    // 2. 지도에 마커 추가
	    addMarker(placeId, lat, lng, name);

	}
	
	// 마커 생성이요~
	function addMarker(placeId, lat, lng, name) {
		
	    var position = new kakao.maps.LatLng(lat, lng);

	    // 새로운 마커 생성
	    var marker = new kakao.maps.Marker({
	        position: position,
	        map: map
	    });
	    // 생성된 마커 정보를 배열에 저장
	    markers.push({
	        placeId: placeId,
	        name: name,
	        marker: marker,
	        position: position
	    });
	    // 경로 업데이트
	    updatePolyline();
	    
	    // 지도 중심을 새 장소로 이동
	    map.setCenter(position);
	    
	}
	
	function updatePolyline() {
		
		linePath = [];
		
		for (var i=0; i<markers.length; i++) {
			linePath.push(markers[i].position);
		}
		
		polyline.setPath(linePath);
		
	}
	
	function addTimelineItem(placeId, name, placeType) {

	    // 현재 일정표에 있는 장소 개수
	    var count = $(".timelineItem").length + 1;
	    // timelineItem
	    var timelineItem = $("<div>").addClass("timelineItem");
	    // 순서 번호
	    var orderMark = $("<span>").addClass("orderMark").text(count);
	    // 카드
	    var timelineCard = $("<div>").addClass("timelineCard");
	    // 드래그 아이콘
	    var dragHandle = $("<span>").addClass("dragHandle").text("⋮⋮");
	    // 이미지
	    var thumb = $("<div>").addClass("wishThumb").append(
	           $("<img>").attr("src", "/images/logo.png").css({width: "50px", height: "50px"}));
	 	
	    var typeText;
	    
	    if(placeType == "SPOT") {
	    	typeText = "관광지";
	    } else if (placeType == "FOOD") {
	    	typeText = "맛집";
	    } else if (placeType == "STAY") {
	    	typeText = "숙박업소";
	    } else {
	    	typeText = placeType;
	    }
	    
	    // 장소 이름
	    var wishText = $("<div>").addClass("wishText").append($("<p>").text(typeText))
	    				.append($("<span>").text(name));
	    // 시간 입력
	    var timeInput = $("<input>").attr("type", "text").addClass("timeInput").attr("placeholder", "시간");
	    // 삭제 버튼
	    var deleteButton = $("<button>").attr("type", "button").text("✕");
	    // 카드 안에 요소 넣기
	    timelineCard.append(dragHandle).append(thumb).append(wishText)
	        			.append(timeInput).append(deleteButton);
	    // timelineItem에 번호와 카드 넣기
	    timelineItem.append(orderMark).append(timelineCard);
	    // 안내 문구가 있으면 그 위에 추가
	    $(".dropEmpty").before(timelineItem);
	    
	    // 삭제 버튼
	    deleteButton.on("click", function() {

	        timelineItem.remove();
	        removeMarker(placeId);
	        updateOrder();

	    });
	}
	
	function removeMarker(placeId) {
	    // markers 배열에서 해당 placeId를 가진 마커 찾기
	    for (var i = 0; i < markers.length; i++) {
	        if (markers[i].placeId == placeId) {
	            // 카카오 지도에서 마커 제거
	            markers[i].marker.setMap(null);
	            // 배열에서도 제거
	            markers.splice(i, 1);
	            break;
	        }
	    }
	    updatePolyline();
	}
	
	function updateOrder() {

	    $(".timelineItem").each(function(index) {
	        $(this).find(".orderMark").text(index + 1);
	    });

	}
	
	
	
	
   
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>