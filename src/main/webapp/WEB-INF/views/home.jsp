<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<!DOCTYPE html>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/public.css">
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.3.1/css/all.min.css"
   integrity="sha512-QeR2VH+lsBE5LSAe1Q5EnTBbe7XTBubt8dG93Y7gidSgdMCr8nVqKcfKAMyN96SV8KDbZVTDXChatu5G2KQGzg=="
   crossorigin="anonymous" referrerpolicy="no-referrer">
<script type="text/javascript"
   src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=ea87fc26ee3f75472cb75c454c18b302"></script>

<title>GOTT 메인화면</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"
   integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
   crossorigin="anonymous"></script>
<style>
.container {
   padding-top:3px;
}

.searchBox {
   width: 750px;
   height: 60px;
   margin: 40px auto;
   position: relative;
}

.searchBox input {
   width: 100%;
   height: 100%;
   box-sizing: border-box;
   padding: 0 70px 0 28px;
   border: 1px solid #e2ded9;
   border-radius: 30px;
   background-color: white;
   font-size: 17px;
   color: #444;
   outline: none;
   box-shadow: 0 4px 15px rgba(0, 0, 0, 0.07);
}

.searchBox input::placeholder {
   color: #aaa;
}

.searchBox input:focus {
   border-color: #c8b9aa;
   box-shadow: 0 5px 20px rgba(0, 0, 0, 0.10);
}
/* 검색 버튼 */
.searchBtn {
   width: 46px;
   height: 46px;
   position: absolute;
   right: 7px;
   top: 7px;
   border: none;
   border-radius: 50%;
   background-color: #f0ebe5;
   cursor: pointer;
   display: flex;
   justify-content: center;
   align-items: center;
}

.searchBtn:hover {
   background-color: #e5ddd5;
} /* 돋보기 */
.searchIcon {
   width: 14px;
   height: 14px;
   border: 2px solid #6f665f;
   border-radius: 50%;
   position: relative;
}

.searchIcon::after {
   content: "";
   width: 7px;
   height: 2px;
   background-color: #6f665f;
   position: absolute;
   right: -6px;
   bottom: -3px;
   transform: rotate(45deg);
   border-radius: 2px;
}

.title {
   width: 100%;
   height: 80px;
   display: flex;
   align-items: center;
   justify-content: center;
   background-color: #f8fafc;
   margin-top:30px;
}

.subtitle, .title-link {
   width: 100%;
   height: auto;
   display: flex;
   align-items: center;
   justify-content: center;
   background-color: #f8fafc;
}

.title h2 {
   font-size: 32px;
   font-weight: 700;
}

.subtitle h5 {
   color: #6B7280;
}

.notice {
   width: 80%;
   max-width: 1100px;
   margin: 28px auto 24px;
   border-collapse: collapse;
   border-top: 2px solid #1a1a1f;
   background: #fff;
   table-layout: fixed;
   border: 1px solid #dbdbdb;;
   position: relative;
}

/* ===== 중요 공지 ===== */
.important {
   max-width: 1100px;
   margin: auto;
}

.important_notice {
   width: 100%;
   border-collapse: collapse;
   border: 1px solid #ffd9c6;
   border-top: 2px solid #FF6B35;
   border-radius: 0 0 8px 8px;
   background: #fffaf7;
   overflow: hidden;
}

/* --- 머리글 바 --- */
.important_header th {
   padding: 13px 18px;
   border-bottom: 1px solid #ffd9c6;
   background: #fff3ec;
   font-size: 14px;
   font-weight: 800;
   color: #FF6B35;
   text-align: center;
   letter-spacing: -0.01em;
}

/* --- 본문 --- */
.important_body td {
   padding: 14px 10px;
   border-bottom: 1px solid #ffe7da;
   font-size: 14px;
   text-align: center;
   color: #45484f;
   vertical-align: middle;
}

.important_body:last-child td {
   border-bottom: 0;
}

.important_body:hover {
   background: #fff3ec;
}

/* 제목 */
.important_body td:nth-child(1) {
   width: 30%;
   max-width: 0;
   padding-left: 18px;
   text-align: left;
   overflow: hidden;
   text-overflow: ellipsis;
   white-space: nowrap;
}

.important_body td:nth-child(1) a {
   font-weight: 700;
   color: #1a1a1f;
   text-decoration: none;
}

.important_body td:nth-child(1) a:hover {
   color: #FF6B35;
   text-decoration: underline;
   text-underline-offset: 3px;
}

/* 내용 */
.important_body td:nth-child(2) {
   max-width: 0;
   text-align: left;
   color: #8a7066;
   overflow: hidden;
   text-overflow: ellipsis;
   white-space: nowrap;
}

/* 작성자 */
.important_body td:nth-child(3) {
   width: 110px;
}

/* 조회수 */
.important_body td:nth-child(4) {
   width: 90px;
   color: #b09287;
}

/* 작성일 */
.important_body td:nth-child(5) {
   width: 160px;
   padding-right: 18px;
   font-size: 13px;
   color: #b09287;
   white-space: nowrap;
}

/* 중요 공지가 없으면 머리글만 남으므로 통째로 숨김 */
.important_notice:not(:has(.important_body)) {
   display: none;
}


.eventbannerzone {
   position: relative;
   width: 90%;
   max-width: 1200px;
   margin: 0 auto;
   padding-top: 30px;
}

.event-viewport {
   width: 100%;
   overflow: hidden;
}

.event-track {
   display: flex;
   gap: 10px;
   transform: translateX(0);
   transition: transform 0.5s ease;
   will-change: transform;
}

.event-track .eventbox {
   flex: 0 0 calc(( 100% - 20px)/3);
   min-width: 0;
   height: auto;
   aspect-ratio: 1.65/1;
   margin: 0;
   overflow: hidden;
   border-radius: 14px;
}

.event-track .eventbox img {
   display: block;
   width: 100%;
   height: 100%;
   object-fit: contain;
   transition: transform 0.3s ease;
}

.event-arrow {
   position: absolute;
   top: 55%;
   z-index: 5;
   width: 38px;
   height: 38px;
   border: none;
   border-radius: 50%;
   background: #fff;
   color: #263238;
   box-shadow: 0 3px 12px rgba(0, 0, 0, 0.15);
   cursor: pointer;
   transform: translateY(-50%);
}

.event-prev {
   left: -20px;
}

.event-next {
   right: -20px;
}

.event-arrow:hover {
   background: #e2e8f0;
}

.event-arrow:disabled {
   opacity: 0.4;
   cursor: default;
}

.ourtext {
   border: 1px solid black;
}

.mapzone {
   width: 700px;
   height: 700px;
   border: 2px solid black;
   margin: auto;
   position: relative;
}

.mapMoreView {
   position: absolute;
   top: 10px;
   right: 10px;
   z-index: 10;
   background-color: white;
   padding: 8px 12px;
   border-radius: 6px;
}

.moreview {
   position: absolute;
   top: 5px;
   right: 20px;
   margin-bottom: 15px;
   font-size: 14px;
   cursor: pointer;
}

.mapMoreView a {
   text-decoration: none;
   color: #263238;
   font-size: 14px;
}

.mapMoreView a:hover {
   color: #2563eb;
}

.travelPlan, .hotelsuggest {
   width: 80%;
   height: auto;
   padding: 0px 30px;
   margin: auto;
}

.travelPlan .planzone, .hotelsuggest .hotelzone {
   width: 90%;
   max-width: 1400px;
   margin: 10px auto;
   display: grid;
   grid-template-columns: repeat(3, minmax(0, 1fr));
   gap: 20px;
   align-items: start;
   position: relative;
   padding-top: 25px;
}

.ourpromisebox img {
   width: 270px;
   height: 200px;
}

.planbox, .hotelbox {
   height: 280px;
   position: relative;
   overflow: hidden;
   border-radius: 14px;
   background-color: #eee;
   cursor: pointer;
   box-shadow: 0 5px 18px rgba(0, 0, 0, 0.10);
   margin-top: 10px;
}

.planbox .planphoto, .hotelbox .hotelphoto {
   width: 100%;
   height: 100%;
   overflow: hidden;
   border-radius: 14px;
}

.planbox img, .hotelbox img {
   width: 100%;
   height: 100%;
   display: block;
   object-fit: cover;
   transition: transform 0.4s ease;
}

.planbox::after, .hotelbox::after {
   content: "";
   position: absolute;
   inset: 0;
   background: linear-gradient(to top, rgba(0, 0, 0, 0.75),
      rgba(0, 0, 0, 0.05));
   z-index: 1;
   pointer-events: none;
}

.planbox .plantext, .planbox .sharedPlanCondition, .hotelbox .hoteltext
   {
   position: absolute;
   z-index: 2;
   color: white;
}

.planbox .plantext {
   left: 10px;
   right: 10px;
   bottom: 45px;
}

.hotelbox .hoteltext {
   left: 10px;
   right: 10px;
   bottom: 10px;
}

.planbox .plantext h3, .hotelbox .hoteltext h3 {
   margin: 0;
   font-size: 20px;
   color: white;
}

.planbox:hover img, .hotelbox:hover img {
   transform: scale(1.05);
}

.sharedPlanCondition {
   left: 10px;
   right: 10px;
   bottom: 8px;
   display: flex;
   align-items: center;
   justify-content: space-between;
   gap: 10px;
   padding: 0;
}

.sharedPlanCondition button {
   position: relative;
   z-index: 3;
   padding: 6px 12px;
   border: none;
   border-radius: 6px;
   background-color: white;
   color: #263238;
   cursor: pointer;
}

.sharedPlanCondition button:hover {
   background-color: #222;
   color: white;
   border-color: #222;
}

.popularboard {
   width: 80%;
   height: auto;
   padding: 20px 10px 15px 10px;
   margin: auto;
   display: flex;
   align-items: center;
   justify-content: center;
   position: relative;
   border-radius: 10px;
}

.boardwriter {
   width: 100%;
   height: 20px;
   font-weight: 900;
   margin-bottom: 10px;
}

.linkbar {
   width: auto;
   border: 1px solid #e5e7eb;
   border-radius: 10px;
   overflow: hidden;
   background-color: white;
   position: fixed;
   left: 80px;
   top: 150px;
   z-index: 3;
}

.linkbar nav {
   display: flex;
   flex-direction: column;
   align-items: center;
}

.linkbar nav a {
   margin: 2em;
   color: #263238;
}

#vertical-underline {
   position: absolute;
   width: 0px;
   background-color: #318de4;
   height: 4px;
   transition: 0.5s;
}

#vertical-underline a {
   transition: 0.5s;
}

.linkbarmain {
   width: 100%;
   min-height: 180px;
   padding: 15px;
   line-height: 2;
}

.linkbarmain a:hover {
   cursor: pointer;
   color: #2563eb;
}

.searchBox {
   width: 750px;
   height: 60px;
   margin: 40px auto;
   position: relative;
}

.searchBox input {
   width: 100%;
   height: 100%;
   box-sizing: border-box;
   padding: 0 70px 0 28px;
   border: 1px solid #e2ded9;
   border-radius: 30px;
   background-color: white;
   font-size: 17px;
   color: #444;
   outline: none;
   box-shadow: 0 4px 15px rgba(0, 0, 0, 0.07);
}

.searchBox input::placeholder {
   color: #aaa;
}

.searchBox input:focus {
   border-color: #c8b9aa;
   box-shadow: 0 5px 20px rgba(0, 0, 0, 0.10);
}

.searchBtn {
   width: 46px;
   height: 46px;
   position: absolute;
   right: 7px;
   top: 7px;
   border: none;
   border-radius: 50%;
   background-color: #f0ebe5;
   cursor: pointer;
   display: flex;
   justify-content: center;
   align-items: center;
}

.searchBtn:hover {
   background-color: #e5ddd5;
}

.searchIcon {
   width: 14px;
   height: 14px;
   border: 2px solid #6f665f;
   border-radius: 50%;
   position: relative;
}

.searchIcon::after {
   content: "";
   width: 7px;
   height: 2px;
   background-color: #6f665f;
   position: absolute;
   right: -6px;
   bottom: -3px;
   transform: rotate(45deg);
   border-radius: 2px;
}

#searchResult {
   position: absolute;
   top: 68px;
   left: 0;
   width: 100%;
   background-color: white;
   border-radius: 18px;
   box-shadow: 0 8px 25px rgba(60, 50, 40, 0.12);
   overflow: hidden;
   z-index: 1000;
   max-height: 480px;
   overflow-y: auto;
}

.searchItem {
   height: 48px;
   padding: 0 25px;
   display: flex;
   align-items: center;
   box-sizing: border-box;
   font-size: 15px;
   color: #555;
   background-color: white;
   cursor: pointer;
   transition: background-color 0.15s;
}

.searchItem+.searchItem {
   border-top: 1px solid #f1ede8;
}

.searchItem:hover {
   background-color: #faf7f3;
   color: #333;
}

.searchItem::before {
   content: "⌕";
   margin-right: 12px;
   font-size: 18px;
   color: #a69a8e;
}

#searchResult::-webkit-scrollbar {
   width: 6px;
}

#searchResult::-webkit-scrollbar-track {
   background: #faf8f5;
}

#searchResult::-webkit-scrollbar-thumb {
   background: #d8cec4;
   border-radius: 10px;
}

#searchResult::-webkit-scrollbar-thumb:hover {
   background: #bdb0a4;
}
/* 인스타그램 스타일 리뷰 영역 */
.reviewContainer {
   width: 100%;
   margin: 30px 0;
   color: #262626;
   font-family: 'Segoe UI', Arial, sans-serif;
}

.reviewContainer .reviewList {
   display: grid;
   grid-template-columns: repeat(3, minmax(0, 1fr));
   gap: 20px;
   align-items: start;
}

.reviewContainer .reviewCard {
   min-width: 0;
   height: 600px;
   overflow: hidden;
   background: #fff;
   border: 1px solid #dbdbdb;
   border-radius: 12px;
   transition: transform .25s, box-shadow .25s;
}

.reviewContainer .reviewCard:hover {
   transform: translateY(-4px);
   box-shadow: 0 8px 24px rgba(0, 0, 0, .08);
}

.reviewContainer .reviewUser {
   display: flex;
   align-items: center;
   gap: 10px;
   padding: 13px 14px;
}

.reviewContainer .reviewProfile {
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

.reviewContainer .reviewProfile span {
   display: flex;
   justify-content: center;
   align-items: center;
   width: 100%;
   height: 100%;
   border: 2px solid #fff;
   border-radius: 50%;
   background: #fff;
   color: #d62976;
   font-size: 17px;
   font-weight: 800;
}

.reviewContainer .reviewUserInfo {
   display: flex;
   flex-direction: column;
   gap: 3px;
   min-width: 0;
}

.reviewContainer .reviewUserInfo strong {
   overflow: hidden;
   color: #262626;
   font-size: 13px;
   text-overflow: ellipsis;
   white-space: nowrap;
}

.reviewContainer .reviewUserInfo>span {
   color: #8e8e8e;
   font-size: 11px;
}

.reviewContainer .reviewMore {
   margin-left: auto;
   padding: 5px;
   border: 0;
   background: transparent;
   color: #262626;
   font-size: 17px;
   cursor: pointer;
}

.reviewContainer .reviewImage {
    width: 100%;
    height: 300px;
    overflow: hidden;
    background: #fafafa;
}

.reviewContainer .reviewImage img {
    display: block;
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.reviewContainer .reviewCard:hover .reviewImage img {
   transform: scale(1.03);
}

.reviewContainer .reviewNoImage {
   display: flex;
   flex-direction: column;
   justify-content: center;
   align-items: center;
   width: 100%;
   height: 100%;
   color: #c13584;
   background: linear-gradient(135deg, #fff0f6, #f3e8ff, #e8f4ff);
}

.reviewContainer .reviewNoImage>span {
   font-size: 45px;
}

.reviewContainer .reviewNoImage p {
   margin: 12px 0 0;
   color: #777;
   font-size: 12px;
}

.reviewContainer .reviewInfo {
    padding: 13px 14px 15px;
    text-align: left;
}

.reviewContainer .reviewIcons {
   display: flex;
   align-items: center;
   gap: 15px;
   margin-bottom: 10px;
}

.reviewContainer .reviewIcons span {
   display: inline-flex;
   align-items: center;
   justify-content: center;
   color: #262626;
   font-size: 25px;
   line-height: 1;
}

.reviewContainer .reviewIcons .reviewHeart {
   color: #ed4956;
   font-size: 29px;
}

.reviewContainer .reviewIcons .reviewShareIcon {
   margin-left: auto;
   color: #262626;
   font-size: 25px;
}

.reviewContainer .reviewLike {
   margin: 0 0 10px;
   color: #262626;
   font-size: 13px;
}

.reviewContainer .reviewLike strong {
   color: #c13584;
   font-size: 15px;
}

.reviewContainer .reviewDescription {
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

.reviewContainer .reviewTag {
   margin: 0 0 10px;
   color: #00376b;
   font-size: 12px;
}

.reviewContainer .reviewDate {
   margin: 10px 0 0;
   color: #a8a8a8;
   font-size: 10px;
}

.reviewContainer .reviewActions {
   display: flex;
   justify-content: flex-end;
   gap: 12px;
   margin-top: 12px;
   padding-top: 10px;
   border-top: 1px solid #efefef;
}

.reviewContainer .reviewActions a {
   color: #8e8e8e;
   font-size: 11px;
   text-decoration: none;
}

.reviewContainer .reviewActions a:hover {
   color: #c13584;
}

.reviewContainer .emptyReview {
   grid-column: 1/-1;
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

.reviewHeart {
   cursor : pointer;
}

.reviewContainer .reviewIcons .likeCount {
    font-size: 15px;
    font-weight: normal;
}

.reviewContainer .emptyReview>span {
   margin-bottom: 12px;
   color: #c13584;
   font-size: 42px;
}

.reviewContainer .emptyReview strong {
   color: #262626;
   font-size: 16px;
}

.reviewContainer .emptyReview p {
   margin: 8px 0 0;
   color: #8e8e8e;
   font-size: 13px;
}

.reviewShareIcon:hover {
   cursor: pointer;
}

.reviewContainer .reviewHeart {
   cursor: pointer;
   color: #999;
}

.reviewContainer .reviewHeart.liked {
   color: #ff4d6d;
}
/* ===== 우리의 약속 영역 ===== */
		.ourpromise {
		    width: 90%;
		    max-width: 1200px;
		    box-sizing: border-box;
		    height: auto;
		    padding: 45px 20px 30px;
		    margin: 0 auto;
		    display: grid;
		    grid-template-columns: repeat(3, minmax(0, 1fr));
		    gap: 25px;
		    position: relative;
		}
		
		/* 개별 카드 */
		.ourpromisebox {
		    min-width: 0;
		    margin: 0;
		    overflow: hidden;
		    position: relative;
		    background-color: #fff;
		    border: 1px solid #e5e7eb;
		    border-radius: 16px;
		    box-shadow: 0 4px 14px rgba(38, 50, 56, 0.06);
		    transition: transform 0.3s ease, box-shadow 0.3s ease;
		}
		
		/* 카드에 마우스를 올렸을 때 */
		.ourpromisebox:hover {
		    transform: translateY(-6px);
		    box-shadow: 0 12px 28px rgba(38, 50, 56, 0.12);
		}
		
		/* 카드 이미지 */
		.ourpromisebox img {
		    display: block;
		    width: 100%;
		    height: 210px;
		    object-fit: cover;
		    transition: transform 0.4s ease;
		}
		
		/* 이미지 확대 효과 */
		.ourpromisebox:hover img {
		    transform: scale(1.04);
		}
		
		/* 카드 설명 영역 */
		.ourtext {
		    box-sizing: border-box;
		    min-height: 145px;
		    padding: 20px 18px !important;
		    border: none;
		    background-color: #fff;
		}
		
		/* 카드 제목 */
		.ourtext p:first-child {
		    margin: 0 0 12px;
		    color: #263746;
		    font-size: 19px;
		    font-weight: 700;
		    letter-spacing: -0.5px;
		}
		
		/* 카드 설명 */
		.ourtext p:last-child {
		    margin: 0;
		    color: #6b7280;
		    font-size: 14px;
		    line-height: 1.9;
		    word-break: keep-all;
		}
		
		/* 더 보기 */
		.ourpromise > .moreview {
		    top: 8px;
		    right: 20px;
		}
		
		.ourpromise > .moreview a {
		    color: #64748b;
		    font-size: 14px;
		    text-decoration: none;
		    transition: color 0.2s ease;
		}
		
		.ourpromise > .moreview a:hover {
		    color: #2563eb;
		}

</style>

<div class="container">

   <div id="eventbannerzone" class="title">
      <h1>대한민국 구석구석, 당신의 여행을 찾아보세요</h1>
   </div>
   <form action="/place/search" method="get">
      <div class="searchBox">
         <input type="text" id="searchInput" name="keyword"
            placeholder="어디로 떠나고 싶으신가요?">
         <button type="submit" class="searchBtn">
            <span class="searchIcon"></span>
         </button>
         <div id="searchResult"></div>
      </div>
   </form>

   <div class="title">
      <h2>진행 중인 이벤트</h2>

   </div>
   <div class="eventbannerzone">
      <div class="moreview">
         <a href="/event/eventpage">더 보기</a>
      </div>

      <button type="button" class="event-arrow event-prev"
         aria-label="이전 이벤트">&#10094;</button>

      <div class="event-viewport" id="eventViewport">
         <div class="event-track" id="eventTrack">

            <c:forEach var="i" items="${banner}">
               <div class="eventbox">
                  <a href="<c:out value='${i.link_url}'/>"> <img
                     src="/images/${i.image_name}" alt="${i.title}">
                  </a>
               </div>
            </c:forEach>

         </div>
      </div>

      <button type="button" class="event-arrow event-next"
         aria-label="다음 이벤트">&#10095;</button>

      <div id="ourpromise"></div>
   </div>

   <hr>
   <div class="title">
      <h2>우리의 약속</h2>
   </div>
   <div class="subtitle">
      <h5>GOTT가 제공하는 특별한 가치를 경험해보세요.</h5>
   </div>
   <br>
   <div class="ourpromise">
    	<div class="moreview"><a href="/event/company">더 보기</a></div>
        <div class="ourpromisebox">
            <img src="/images/systeam.jpg">
            <div class="ourtext" style="padding: 5px;">
                <p style="font-weight: bold;">체계적인 시스템</p>
                <p>효율적인 예약 관리와 편리한 여행 일정 구성으로 더욱 스마트한 여행 준비를 도와드립니다.</p>
            </div>
        </div>
        <div class="ourpromisebox">
            <img src="/images/24hoursCare.png">
            <div class="ourtext" style="padding: 5px;">
                <p style="font-weight: bold;">24시간 고객 케어</p>
                <p>언제든 궁금한 점이나 불편한 사항을 확인하고 해결할 수 있도록 고객의 편의를 생각합니다.</p>
            </div>
        </div>
        <div class="ourpromisebox">
            <img src="/images/trust.png">
            <div class="ourtext" style="padding: 5px;">
                <p style="font-weight: bold;">신뢰할 수 있는 정보</p>
                <p>여행지와 맛집, 숙소에 대한 유용하고 정확한 정보를 제공하여 만족스러운 여행을 지원합니다.</p>
            </div>
        </div>
    </div>
   <div id="mapzone"></div>
   <hr>

   <div class="title">
      <h2>여행지도</h2>
   </div>
   <div class="subtitle">
      <h5>대한민국 지도를 이용해 여행지를 탐색해보세요</h5>
   </div>

   <br>
   <div class="mapzone">
      <div class="mapMoreView">
         <a href="/place/mappage">자세히 보기</a>
      </div>
      <div id="map" style="width: 100%; height: 100%;"></div>
   </div>

   <div id="travelPlan"></div>
   <hr>
   <hr>

   <div class="title">
      <h2>최신 여행 일정</h2>
   </div>
   <div class="subtitle">
      <h5>지금 회원들이 직접 만든 최신 여행 일정들을 만나보세요</h5>
   </div>
   <div class="title-link" style="font-size: 10px; color: #2563eb">
      <a href="/members/planner">찜한 장소로 나만의 여행 일정 만들기</a>
   </div>

   <div class="travelPlan">
      <div class="planzone">
         <div class="moreview">
            <a href="/travelPlan/list?cpage=1">더 보기</a>
         </div>

         <c:choose>
            <c:when test="${not empty planList}">
               <c:forEach var="plan" items="${planList}" end="2">
                  <div class="planbox">
                     <div class="planphoto">
                        <c:choose>
                           <c:when test="${not empty plan.IMAGE_NAME}">
                              <img src="<c:out value='${plan.IMAGE_NAME}'/>"
                                 alt="<c:out value='${plan.PLAN_TITLE}'/>">
                           </c:when>
                           <c:otherwise>
                              <div class="noImage">이미지 준비 중</div>
                           </c:otherwise>
                        </c:choose>
                     </div>
                     <div class="plantext">
                        <h3>
                           <c:out value="${plan.PLAN_TITLE}" />
                        </h3>
                     </div>
                     <div class="sharedPlanCondition">
                        <span class="shareBadge">전체 공개</span>
                        <div class="btnGroup">
                           <button type="button" class="boardViewBtn"
                              onclick="location.href='/travelPlan/detail?planId=${plan.PLAN_ID}&cpage=1'">일정
                              보기</button>
                        </div>
                     </div>
                  </div>
               </c:forEach>
            </c:when>
            <c:otherwise>
               <div class="emptyPlans">아직 공유된 여행 일정이 없습니다.</div>
            </c:otherwise>
         </c:choose>

      </div>
   </div>
   <div id="hotelsuggest"></div>
   <hr>
   <hr>
   <div class="title">
      <h2>숙박업소 추천</h2>
   </div>
   <div class="subtitle">
      <h5>지금 가장인기 있는 숙박업소를 만나보세요</h5>
   </div>

   <div class="hotelsuggest">
      <div class="hotelzone">
         <div class="moreview">
            <a href="/reservation/list?cpage=1">더 보기</a>
         </div>
         <div class="hotelbox">
            <div class="hotelphoto">
               <img src="${stayImgs[0]}">
            </div>
            <div class="hoteltext">
               <p style="font-weight: 900;">호텔</p>
               <p>편안한 휴식과 품격 있는 서비스를 누려보세요.</p>
            </div>
         </div>
         <div class="hotelbox">
            <div class="hotelphoto">
               <img src="${stayImgs[1]}">
            </div>
            <div class="hoteltext">
               <p style="font-weight: 900;">모텔</p>
               <p>합리적인 가격으로 편안한 하루를 보내세요.</p>
            </div>
         </div>
         <div class="hotelbox">
            <div class="hotelphoto">
               <img src="${stayImgs[2]}">
            </div>
            <div class="hoteltext">
               <p style="font-weight: 900;">민박</p>
               <p>아늑하고 따뜻한 분위기에서 특별한 추억을 만들어보세요.</p>
            </div>
         </div>
      </div>

   </div>
   <div id="popularboard"></div>
   <hr>
   <hr>

   <div class="title">
      <h2>인기 리뷰글</h2>
   </div>
   <div class="subtitle">
      <h5>다른 여행자들이 공유하는 생생한 여행 후기를 확인해보세요</h5>
   </div>

   
<div class="popularboard">
    <div class="reviewContainer">
        <div class="moreview">
            <a href="/review/reviewBoard?cpage=1">더 보기</a>
        </div>

        <div class="reviewList">
            <c:forEach var="rv" items="${reviewList}" end="2">
                <div class="reviewCard">

                    <div class="reviewUser">
                        <div class="reviewProfile">
                            <span>G</span>
                        </div>

                        <div class="reviewUserInfo">
                            <strong>${rv.member_id}</strong>
                            <span>${rv.target_type} 리뷰</span>
                        </div>

                        <button type="button" class="reviewMore">•••</button>
                    </div>

                    <a href="/review/detail?seq=${rv.seq}&amp;place_id=${rv.target_id}">
                        <div class="reviewImage">
                            <c:choose>
                                <c:when test="${not empty rv.image1}">
                                    <img src="<c:out value='${rv.image1}'/>"
                                         alt="리뷰 이미지">
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
                            <span class="reviewHeart ${rv.liked ? 'liked' : ''}"
                                  onclick="toggleRecommend(${rv.seq}, this)">${rv.liked ? '♥' : '♡'}</span>

                            <span class="likeCount" id="likeCount${rv.seq}">${rv.recommendCount}</span>

                            <span class="reviewShareIcon"
                                  onclick="shareReview(${rv.seq}, ${rv.target_id})"
                                  title="리뷰 링크 복사">
                                <i class="fa-solid fa-link"></i>
                            </span>
                        </div>

                        <div class="reviewtext">
                            <p class="reviewLike">
                                ⭐ <strong>${rv.rating}</strong>
                            </p>

                            <p class="reviewDescription">${rv.contents}</p>

                            <c:if test="${not empty rv.tag}">
                                <p class="reviewTag">#${rv.tag}</p>
                            </c:if>

                            <p class="reviewDate">${rv.reg_date}</p>
                        </div>
                    </div>

                </div>
            </c:forEach>

            <c:if test="${empty reviewList}">
                <div class="emptyReview">
                    <span>♡</span>
                    <strong>아직 작성한 리뷰가 없어요</strong>
                    <p>여행의 소중한 순간을 리뷰로 남겨보세요.</p>
                </div>
            </c:if>
        </div>
    </div>
</div>

<div id="notice"></div>
<hr>


<div class="title">
   <h2>공지사항</h2>
</div>

<div class="notice">
   <div class="moreview">
      <a href="/notice/notice_list">더 보기</a>
   </div>

   <div class="important">
      <table class="important_notice">
         <tr class="important_header">
            <th colspan="5">중요 공지사항</th>
         </tr>

         <c:forEach var="i" items="${ilist}">
            <tr class="important_body">
               <td><a href="/notice/detail?notice_id=${i.notice_id}">${i.title}</a></td>
               <td>${i.contents}</td>
               <td>${i.nickname}</td>
               <td>${i.view_count}</td>
               <td><fmt:formatDate value="${i.write_date}"
                     pattern="yyyy.MM.dd HH:mm" /></td>
            </tr>
         </c:forEach>
      </table>
   </div>

</div>


<div class="linkbar">
   <nav>
      <div id="vertical-underline"></div>
      <h3 style="margin-top: 10px; border-bottom: 2px solid #318de4;">QUICK
         MENU</h3>
      <a href="#eventbannerzone">이벤트</a> <a href="#ourpromise">우리의 약속</a> <a
         href="#mapzone">여행지도</a> <a href="#travelPlan">최신 여행일정</a> <a
         href="#hotelsuggest">숙박업소 추천</a> <a href="#popularboard">인기 게시글</a> <a
         href="#notice">공지사항</a>
   </nav>
</div>


</div>

<script>

   var container = document.getElementById('map');
   var options = {
      center: new kakao.maps.LatLng(36.35, 127.85),
      level: 13
   };
   
   var map = new kakao.maps.Map(container, options);

    let verticalunderline = document.getElementById("vertical-underline");
    let verticalmenus = document.querySelectorAll("nav:first-child a");
    
    verticalmenus.forEach(menu=>menu.addEventListener("click", (e)=>createunderline(e)))
    function createunderline(e) {
        verticalunderline.style.left = e.currentTarget.offsetLeft + "px";
        verticalunderline.style.width = e.currentTarget.offsetWidth + "px";
        verticalunderline.style.top = e.currentTarget.offsetTop + 
                                        e.currentTarget.offsetHeight + "px";

    }

$("#searchInput").on("keyup", function () {

        let keyword = $(this).val();

        if(keyword == "") {
            $("#searchResult").empty();
            return;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/place/keyword",
            type: "get",
            data: {
                keyword: keyword
            },

            success: function(result) {
   
                console.log(result);
                   console.log(result.length);
               
                $("#searchResult").empty();

                for(let i = 0; i < result.length && i <10; i++) {

                    let div = $("<div>");

                    div.addClass("searchItem");

                    div.text(result[i]);

                    div.on("click", function() {

                        $("#searchInput").val(result[i]);
                        $("#searchResult").empty();});

                    $("#searchResult").append(div);}},

            error: function() {
                console.log("연관검색어 검색 실패");
            }
        });
    });

document.addEventListener("DOMContentLoaded", function () {
    const track = document.getElementById("eventTrack");
    const viewport = document.getElementById("eventViewport");
    const prevButton = document.querySelector(".event-prev");
    const nextButton = document.querySelector(".event-next");

    if (!track || !viewport || !prevButton || !nextButton) {
        return;
    }

    const originalCards = Array.from(track.children);
    const originalCount = originalCards.length;

    if (originalCount === 0) {
        prevButton.hidden = true;
        nextButton.hidden = true;
        return;
    }

    let visibleCount = getVisibleCount();
    let index = 0;
    let timer = null;
    let isAnimating = false;

    function getVisibleCount() {
        if (window.innerWidth <= 560) return 1;
        if (window.innerWidth <= 900) return 2;
        return 3;
    }

    // 이벤트가 화면에 꽉 차면 슬라이드하지 않음
    function canSlide() {
        return originalCount > visibleCount;
    }

    // 무한 슬라이드를 위해 앞뒤에 배너 복제
    function setupClones() {
        track.innerHTML = "";

        const count = Math.min(visibleCount, originalCount);

        // 앞쪽에는 마지막 배너들을 배치
        originalCards.slice(-count).forEach(function (card) {
            const clone = card.cloneNode(true);
            clone.setAttribute("aria-hidden", "true");
            track.appendChild(clone);
        });

        // 원래 DB 배너
        originalCards.forEach(function (card) {
            track.appendChild(card);
        });

        // 뒤쪽에는 처음 배너들을 배치
        originalCards.slice(0, count).forEach(function (card) {
            const clone = card.cloneNode(true);
            clone.setAttribute("aria-hidden", "true");
            track.appendChild(clone);
        });

        index = count;
        moveTo(index, false);
    }

    function getStep() {
        const card = track.querySelector(".eventbox");

        if (!card) return 0;

        const gap = parseFloat(getComputedStyle(track).gap) || 0;

        return card.getBoundingClientRect().width + gap;
    }

    function moveTo(position, animate) {
        track.style.transition = animate
            ? "transform 0.5s ease"
            : "none";

        track.style.transform =
            "translateX(-" + (getStep() * position) + "px)";
    }

    function nextSlide() {
        if (!canSlide() || isAnimating) return;

        isAnimating = true;
        index++;
        moveTo(index, true);
    }

    function prevSlide() {
        if (!canSlide() || isAnimating) return;

        isAnimating = true;
        index--;
        moveTo(index, true);
    }

    // 복제 배너에 도착하면 원래 배너 위치로 순간 이동
    track.addEventListener("transitionend", function (event) {
        if (event.target !== track ||
            event.propertyName !== "transform") {
            return;
        }

        const cloneCount = Math.min(visibleCount, originalCount);

        if (index >= originalCount + cloneCount) {
            index = cloneCount;
            moveTo(index, false);
        } else if (index < cloneCount) {
            index = originalCount + cloneCount - 1;
            moveTo(index, false);
        }

        isAnimating = false;
    });

    function stopAutoSlide() {
        clearInterval(timer);
        timer = null;
    }

    function startAutoSlide() {
        stopAutoSlide();

        if (canSlide()) {
            timer = setInterval(nextSlide, 4000);
        }
    }

    nextButton.addEventListener("click", function () {
        nextSlide();
        startAutoSlide();
    });

    prevButton.addEventListener("click", function () {
        prevSlide();
        startAutoSlide();
    });

    // 마우스를 올리면 잠시 정지
    viewport.addEventListener("mouseenter", stopAutoSlide);
    viewport.addEventListener("mouseleave", startAutoSlide);

    // 화면 크기가 바뀌면 복제 및 위치 재설정
    let resizeTimer;

    window.addEventListener("resize", function () {
        clearTimeout(resizeTimer);

        resizeTimer = setTimeout(function () {
            stopAutoSlide();

            visibleCount = getVisibleCount();
            setupClones();

            isAnimating = false;
            startAutoSlide();
        }, 150);
    });

    setupClones();
    startAutoSlide();
});

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

      function toggleRecommend(seq, heart) {
          $.ajax({
              url: "/review/toggleRecommend",
              type: "post",
              data: {
                  seq: seq
              },
              success: function(result) {
                  result = result.trim();

                  if (result == "login") {
                      alert("로그인이 필요합니다.");
                      location.href = "/members/loginpage";
                  } else if (result == "liked") {
                      heart.innerHTML = "♥";
                      heart.classList.add("liked");

                      let count = document.getElementById("likeCount" + seq);

                      if (count != null) {
                          count.innerHTML = Number(count.innerHTML) + 1;
                      }
                  } else if (result == "unliked") {
                      heart.innerHTML = "♡";
                      heart.classList.remove("liked");

                      let count = document.getElementById("likeCount" + seq);

                      if (count != null) {
                          count.innerHTML = Number(count.innerHTML) - 1;
                      }
                  }
              }
          });
      }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
