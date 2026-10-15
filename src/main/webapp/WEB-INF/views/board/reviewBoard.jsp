<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<style>
/* 모든 요소의 크기에 padding과 border를 포함해서 계산 */
* {
	box-sizing: border-box;
}

/* 링크의 기본 글자색과 밑줄 설정 */
a {
	color: inherit;
	text-decoration: none;
}

/* 버튼 기본 모양 */
button {
	border: 1px solid #d5d5d5;
	background-color: white;
	cursor: pointer;
}

/* 버튼에 마우스를 올렸을 때 색상 변경 */
button:hover {
	background-color: #222;
	color: white;
	border-color: #222;
}

/* 제목 */
/* 페이지 제목 영역 */
.titleBox {
	text-align: center;
	padding: 35px 0 20px;
}

/* 큰 제목 스타일 */
.titleBox h2 {
	margin: 0 0 5px;
	font-size: 25px;
	color: #222;
}

/* 제목 아래 설명 문구 스타일 */
.titleBox h5 {
	margin: 0;
	font-size: 12px;
	font-weight: 400;
	color: #888;
}

/* 경로 */
/* 현재 페이지 위치를 보여주는 경로 영역 */
.breadcrumb {
	margin: 0 100px;
	padding: 10px 0;
	font-size: 10px;
	color: #999;
	border-top: 1px solid #eee;
}

/* 경로 중 현재 페이지 이름 강조 */
.breadcrumb span {
	color: #333;
	font-weight: 600;
}

/* 탭 */
/* 자유게시판과 리뷰게시판 탭 배치 */
.tabs {
	display: flex;
	margin: 10px 100px 0;
	border-bottom: 1px solid #222;
}

/* 각 탭의 기본 모양 */
.tabs a {
	min-width: 120px;
	padding: 9px 18px;
	text-align: center;
	border: 1px solid #ddd;
	border-bottom: 0;
	background: white;
	color: #777;
	font-size: 12px;
}

/* 현재 선택된 탭 강조 */
.tabs a.on {
	background: #222;
	border-color: #222;
	color: white;
}

/* 카테고리 — 체크박스 칩 */
/* 리뷰 카테고리 버튼들을 가운데에 여러 줄로 배치 */
.tag_list {
	width: 520px;
	max-width: 100%;
	margin: 25px auto;
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 4px;
}

/* 카테고리 버튼 기본 스타일 */
.tag_list label {
	padding: 4px 9px;
	border: 1px solid #ddd;
	border-radius: 14px;
	background: white;
	color: #666;
	font-size: 10px;
	cursor: pointer;
	user-select: none;
	transition: border-color .15s, background .15s, color .15s;
}

/* 카테고리 버튼에 마우스를 올렸을 때 */
.tag_list label:hover {
	border-color: #999;
	color: #333;
}

/* 선택한 카테고리 버튼 강조 */
.tag_list label:has(input:checked) {
	border-color: #222;
	background: #222;
	color: white;
	font-weight: 600;
}

/* 체크박스 자체는 숨기고 라벨을 버튼처럼 사용 */
.tag_list input {
	display: none;
}

/* 게시판 정보 */
/* 게시글 수, 정렬 메뉴, 글쓰기 버튼 영역 */
.searchOption {
	width: 900px;
	max-width: 100%;
	margin: 0 auto 12px;
	display: flex;
	align-items: center;
	font-size: 11px;
	color: #777;
}

/* 게시글 수를 왼쪽으로 배치 */
.totalCount {
	margin-right: auto;
}

/* 리뷰 정렬 선택 메뉴 */
.sort {
	height: 32px;
	padding: 0 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
	background: white;
	color: #555;
	font-size: 11px;
}

/* 리뷰 작성 버튼 */
.writeBtn {
	height: 32px;
	margin-left: 6px;
	padding: 0 15px;
	border: 1px solid #222;
	border-radius: 4px;
	background: #222;
	color: white;
	font-size: 11px;
}

/* ===== 인스타그램 스타일 리뷰 카드 ===== */
/* 리뷰 카드를 3열 그리드로 배치 */
.reviewList {
    width: 100%;
    max-width: 1000px;
    margin: 0 auto;
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 20px;
    align-items: start;
}

/* 리뷰 사진 영역만 상세 페이지로 이동하도록 링크 설정 */
.reviewImageLink {
    display: block;
    color: inherit;
    text-decoration: none;
}

.reviewHeart {
    cursor: pointer;
    color: #999;
    font-size: 20px;
}

.reviewHeart.liked {
    color: #ff4d6d;
}

/* 인스타그램 게시물처럼 보이는 카드 바깥 영역 */
.reviewCard {
    min-width: 0;
    overflow: hidden;
    border: 1px solid #dbdbdb;
    border-radius: 12px;
    background: #fff;
    color: #262626;
    transition: transform .25s, box-shadow .25s;
}

/* 카드에 마우스를 올리면 살짝 올라오고 그림자 표시 */
.reviewCard:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 24px rgba(0, 0, 0, .08);
}

/* 카드 위쪽의 작성자 프로필과 이름 영역 */
.reviewUser {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 13px 14px;
}

/* 인스타그램 느낌의 원형 프로필 테두리 */
.reviewProfile {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 38px;
    height: 38px;
    flex-shrink: 0;
    border-radius: 50%;
    padding: 2px;
    background: linear-gradient(135deg, #feda75, #fa7e1e, #d62976, #962fbf, #4f5bd5);
}

/* 원형 프로필 안의 글자 */
.reviewProfile span {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 100%;
    border: 2px solid #fff;
    border-radius: 50%;
    background: #fff;
    color: #d62976;
    font-size: 14px;
    font-weight: 800;
}

/* 작성자 이름과 리뷰 종류를 세로로 배치 */
.reviewUserInfo {
    display: flex;
    flex-direction: column;
    gap: 3px;
    min-width: 0;
}

/* 작성자 이름이 길면 한 줄로 줄여서 표시 */
.reviewUserInfo strong {
    overflow: hidden;
    color: #262626;
    font-size: 13px;
    text-overflow: ellipsis;
    white-space: nowrap;
}

/* 리뷰 종류 설명 문구 */
.reviewUserInfo span {
    color: #8e8e8e;
    font-size: 11px;
}

/* 카드 오른쪽 위의 더보기 표시 */
.reviewMore {
    margin-left: auto;
    color: #262626;
    font-size: 17px;
    letter-spacing: 2px;
}

/* 리뷰 이미지를 정사각형 영역으로 표시 */
.reviewImage {
    width: 100%;
    aspect-ratio: 1 / 1;
    overflow: hidden;
    background: #fafafa;
}

/* 이미지가 영역을 채우도록 크기와 잘림 방식 설정 */
.reviewImage img {
    display: block;
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform .35s;
}

/* 카드에 마우스를 올리면 이미지가 살짝 확대 */
.reviewCard:hover .reviewImage img {
    transform: scale(1.03);
}

/* 이미지가 없는 리뷰에 보여줄 대체 영역 */
.reviewNoImage {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 100%;
    color: #c13584;
    background: linear-gradient(135deg, #fff0f6, #f3e8ff, #e8f4ff);
}

/* 대체 영역의 아이콘 크기 */
.reviewNoImage span {
    font-size: 45px;
}

/* 대체 영역의 안내 문구 */
.reviewNoImage p {
    margin: 12px 0 0;
    color: #777;
    font-size: 12px;
}

/* 이미지 아래의 좋아요, 내용, 태그, 날짜 영역 */
.reviewInfo {
    padding: 13px 14px 15px;
}

/* 좋아요와 댓글, 공유 아이콘을 가로로 배치 */
.reviewIcons {
    display: flex;
    align-items: center;
    gap: 15px;
    margin-bottom: 10px;
    font-size: 24px;
}

/* 하트 아이콘 색상과 크기 */
.reviewHeart {
    color: #ed4956;
    font-size: 29px;
}

/* 공유 아이콘을 카드 오른쪽으로 배치 */
.reviewShareIcon {
    margin-left: auto;
    font-size: 25px;
}

/* 좋아요 수 표시 문구 */
.reviewLike {
    margin: 0 0 10px;
    color: #262626;
    font-size: 13px;
}

/* 좋아요 수 강조 */
.reviewLike strong {
    color: #c13584;
    font-size: 15px;
}

/* 리뷰 내용을 최대 3줄까지만 표시 */
.reviewDescription {
    display: -webkit-box;
    overflow: hidden;
    margin: 0 0 9px;
    color: #262626;
    font-size: 13px;
    line-height: 1.7;
    overflow-wrap: anywhere;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 3;
}

/* 리뷰 내용 안쪽 문단의 기본 여백 제거 */
.reviewDescription p {
    margin: 0;
}

/* 리뷰 본문 안의 이미지나 영상이 카드 배치를 깨지 않도록 숨김 */
.reviewDescription img, .reviewDescription video, .reviewDescription iframe {
    display: none;
}

/* 리뷰 태그 표시 */
.reviewTag {
    margin: 0 0 10px;
    color: #00376b;
    font-size: 12px;
}

/* 리뷰 작성 날짜 표시 */
.reviewDate {
    margin: 10px 0 0;
    color: #a8a8a8;
    font-size: 10px;
}

/* 리뷰가 없을 때 안내 문구를 보여주는 영역 */
.emptyReview {
    grid-column: 1 / -1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    min-height: 200px;
    padding: 30px 15px;
    border: 1px dashed #dbdbdb;
    border-radius: 12px;
    background: #fff;
    text-align: center;
}

/* 리뷰 없음 아이콘 */
.emptyReview span {
    margin-bottom: 12px;
    color: #c13584;
    font-size: 42px;
}

/* 리뷰 없음 제목 */
.emptyReview strong {
    color: #262626;
    font-size: 16px;
}

/* 리뷰 없음 안내 문구 */
.emptyReview p {
    margin: 8px 0 0;
    color: #8e8e8e;
    font-size: 13px;
}
.reviewShareIcon:hover {
	cursor: pointer;
}
/* 화면 너비가 900px 이하이면 카드 2열로 변경 */
@media (max-width: 900px) {
    .reviewList {
        grid-template-columns: repeat(2, minmax(0, 1fr));
    }
}

/* 휴대폰처럼 화면이 좁으면 카드 1열로 변경 */
@media (max-width: 600px) {
    .reviewList {
        grid-template-columns: 1fr;
        max-width: 420px;
    }
}

/* ===== 페이지네이션 ===== */
/* 페이지 이동 버튼 전체 영역 */
#navi {
	width: 900px;
	max-width: 100%;
	margin: 28px auto 0;
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	align-items: center;
	gap: 6px;
}

/* 페이지 번호 버튼 기본 모양 */
#navi a {
	min-width: 34px;
	height: 34px;
	padding: 0 10px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	border: 1px solid #ddd;
	border-radius: 6px;
	background: white;
	font-size: 12px;
	font-weight: 600;
	color: #777;
	text-decoration: none;
	transition: background .15s, border-color .15s, color .15s;
}

/* 페이지 번호에 마우스를 올렸을 때 */
#navi a:hover {
	border-color: #222;
	color: #222;
}

/* 현재 페이지 번호 강조 */
#navi a.on {
	background: #222;
	border-color: #222;
	color: white;
}
</style>

<!-- 메인 -->

<div class="container">

	<div class="titleBox">
		<h2>리뷰게시판</h2>
		<h5>여행후기, 맛집, 관광지, 액티비티, 꿀팁까지 자유롭게 나눠보세요.</h5>
	</div>

	<div class="breadcrumb">
		홈 &nbsp;>&nbsp; <span>리뷰게시판</span>
	</div>

	<nav class="tabs">
		<a href="/board/freeBoard?cpage=1">자유게시판</a> <a
			href="/review/reviewBoard?cpage=1" class="on">리뷰게시판</a>
	</nav>

	<!-- 카테고리 -->

	<div class="tag_list">
		<label><input type="checkbox" name="tag" value="관광지">관광지</label>
		<label><input type="checkbox" name="tag" value="맛집">맛집</label>
		<label><input type="checkbox" name="tag" value="카페">카페</label>
		<label><input type="checkbox" name="tag" value="액티비티">액티비티</label>
		<label><input type="checkbox" name="tag" value="숙소">숙소</label>
		<label><input type="checkbox" name="tag" value="청결">청결</label>
		<label><input type="checkbox" name="tag" value="가성비">가성비</label>
		<label><input type="checkbox" name="tag" value="뷰맛집">뷰맛집</label>
		<label><input type="checkbox" name="tag" value="조용함">조용함</label>
		<label><input type="checkbox" name="tag" value="친절">친절</label>
		<label><input type="checkbox" name="tag" value="주차편함">주차편함</label>
		<label><input type="checkbox" name="tag" value="재방문의사">재방문의사</label>
		<label><input type="checkbox" name="tag" value="사진맛집">사진맛집</label>
		<label><input type="checkbox" name="tag" value="교통편리">교통편리</label>
		<label><input type="checkbox" name="tag" value="아이동반">아이동반</label>
	</div>

	<!-- 게시판 정보 -->

	<div class="searchOption">

		<div class="totalCount">
			총 <strong>${recordTotalCount}</strong>건
		</div>

		<select class="sort" id="sort">
			<option value="new">최신순</option>
			<option value="view">조회순</option>
			<option value="recommend">추천순</option>
			<option value="reply">댓글순</option>
		</select>

		<button class="writeBtn" id="writeBtn">글쓰기</button>

	</div>

	<!-- 카드 -->

	<div class="reviewList">

		<c:forEach var="i" items="${rList}">
			<div class="reviewCard">
					<div class="reviewUser">
						<div class="reviewProfile"><span>G</span></div>
						<div class="reviewUserInfo">
							<strong>${i.member_id}</strong>
							<span>${i.target_type} 리뷰</span>
						</div>
						<div class="reviewMore">•••</div>
					</div>

					<a class="reviewImageLink" href="/review/detail?seq=${i.seq}&place_id=${i.target_id}">
						<div class="reviewImage">
							<c:choose>
							<c:when test="${not empty i.image1}">
								<img src="${i.image1}" alt="리뷰 이미지">
							</c:when>
							<c:otherwise>
								<div class="reviewNoImage">
									<span>✈</span>
									<p>여행의 순간을 기록해 보세요</p>
								</div>
							</c:otherwise>
							</c:choose>
						</div>
					</a>

					<div class="reviewInfo">
						<div class="reviewIcons">
							<span class="reviewHeart ${i.liked ? 'liked' : ''}"
							 onclick="toggleRecommend(${i.seq}, this)"> ${i.liked ? '♥' : '♡'}</span>
							<span class="reviewShareIcon" onclick="shareReview(${i.seq}, ${i.target_id})"
						      title="리뷰 링크 복사">
						    	<i class="fa-solid fa-link"></i>   
						    </span>
						</div>
						<p class="reviewLike">평점 <strong>${i.rating}</strong></p>
						<div class="reviewDescription">${i.contents}</div>
						<c:if test="${not empty i.tag}">
							<p class="reviewTag">${i.tag}</p>
						</c:if>
						<p class="reviewDate"><fmt:formatDate value="${i.reg_date}" pattern="yyyy.MM.dd" /></p>
					</div>
			</div>
		</c:forEach>

		<c:if test="${empty rList}">
			<div class="emptyReview">
				<span>♡</span>
				<strong>아직 작성한 리뷰가 없어요</strong>
				<p>여행의 소중한 순간을 리뷰로 남겨보세요.</p>
			</div>
		</c:if>
	</div>

	<div class="reviewNavi" id="navi">${navi}</div>
</div>



<script>
	let sort = "${sort}";
	$("#sort").val(sort);

	let tags = "";

	if ("${tag_list}" !== "") {
		tags = "&tag_list=" + encodeURIComponent("${tag_list}");

		let checkedList = "${tag_list}".split(",");
		for (let i = 0; i < checkedList.length; i++) {
			$("input[name=tag][value=" + checkedList[i] + "]").prop("checked", true);
		}
	}
	
	$("input[name=tag]").on("click", function(){
		let checked = $("input[name=tag]:checked");
		let tag_list = [];

		for(let i = 0; i<checked.length; i++){
			tag_list.push(checked[i].value);
		}
		
		if(tag_list.length>0){
			location.href = "/review/reviewBoard?cpage=1&sort=" + sort + "&tag_list=" + encodeURIComponent(tag_list.join(",")); 
		}else{
			location.href = "/review/reviewBoard?cpage=1&sort=" + sort; 
		}
	})

	$("#sort").on("change", function() {
		location.href = "/review/reviewBoard?cpage=1&sort=" + $(this).val() + tags;
	})

	$("#writeBtn").on("click", function() {
		location.href = "/review/review_write";
	})

	let recordTotalCount = ${recordTotalCount};
	let recordCountPerPage = ${recordCountPerPage};
	let naviCountPerPage = ${naviCountPerPage};
	let currentPage = ${cpage};

	let pageTotalCount = Math.ceil(recordTotalCount / recordCountPerPage);

	let startNavi = Math.floor((currentPage - 1) / naviCountPerPage)
			* naviCountPerPage + 1;
	let endNavi = startNavi + naviCountPerPage - 1;

	if (endNavi > pageTotalCount) {
		endNavi = pageTotalCount;
	}

	let needPrev = startNavi > 1;
	let needNext = endNavi < pageTotalCount;

	let navi = document.getElementById("navi");

	if (needPrev) {
		let prev = document.createElement("a");
		prev.setAttribute("href", "/review/reviewBoard?cpage="
				+ (startNavi - 1) + "&sort=" + sort + tags);
		prev.innerHTML = "<";
		navi.append(prev);
	}
	for (let i = startNavi; i <= endNavi; i++) {
		let num = document.createElement("a");
		num.setAttribute("href", "/review/reviewBoard?cpage=" + i + "&sort="
				+ sort + tags);
		if (i == currentPage) {
			num.setAttribute("class", "on");
		}
		num.innerHTML = i;
		navi.append(num);
	}
	if (needNext) {
		let next = document.createElement("a");
		next.setAttribute("href", "/review/reviewBoard?cpage=" + (endNavi + 1)
				+ "&sort=" + sort + tags);
		next.innerHTML = ">";
		navi.append(next);
	}
	
<<<<<<< HEAD
	function shareReview(seq, placeId) {
	    // 현재 사이트 주소와 리뷰 상세 페이지 주소를 결합
	    const url = window.location.origin
	        + "/review/detail?seq=" + seq
	        + "&place_id=" + encodeURIComponent(placeId);

	    // 리뷰 링크를 클립보드에 복사
	    navigator.clipboard.writeText(url)
	        .then(function() {
	            alert("리뷰 링크가 복사되었습니다!");
	        })
	        .catch(function() {
	            // 클립보드 복사가 안 될 경우 링크를 직접 보여줌
	            prompt("아래 링크를 복사해주세요.", url);
	        });
	}
	
</script>
=======
	function toggleRecommend(seq, heart) {
	    $.ajax({
	        url: "/review/toggleRecommend",
	        type: "post",
	        data: {
	            seq: seq
	        },
	        success: function(result) {
	            if (result == "login") {
	                alert("로그인이 필요합니다.");
	                location.href = "/members/loginpage";
	            } else if (result == "liked") {
	                heart.innerHTML = "♥";
	                heart.classList.add("liked");
	            } else if (result == "unliked") {
	                heart.innerHTML = "♡";
	                heart.classList.remove("liked");
	            }
	        }
	    });
	}
	</script>
>>>>>>> 870aadd30a0b33bb17ff9af8771a0e683cf17012
<%@ include file="/WEB-INF/views/common/footer.jsp"%>