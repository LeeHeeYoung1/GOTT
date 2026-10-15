<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<style>
*{box-sizing:border-box}
.myReviewPage{width:1100px;max-width:calc(100% - 40px);margin:0 auto 80px;font-family:'Malgun Gothic','맑은 고딕',sans-serif;color:#222}
.reviewTitle{text-align:center;padding:42px 0 30px}
.reviewTitle h2{margin:0 0 12px;font-size:28px;font-weight:800;letter-spacing:-1px}
.reviewTitle p{margin:0;color:#888;font-size:13px;line-height:1.7}
.reviewBreadcrumb{padding:13px 0;border-top:1px solid #eee;font-size:12px;color:#999}
.reviewBreadcrumb span{color:#333;font-weight:700}
.reviewSummary{display:flex;align-items:center;justify-content:space-between;margin:24px 0 30px;padding:25px 28px;background:linear-gradient(120deg,#fff8f4,#fff);border:1px solid #ffe5d8;border-radius:14px}
.summaryLabel{font-size:14px;color:#777}
.summaryCount{margin-top:9px;font-size:26px;font-weight:800;letter-spacing:-.5px}
.summaryCount strong{color:#ff6b35}
.reviewWriteBtn{display:inline-flex;align-items:center;justify-content:center;gap:7px;padding:12px 19px;border:0;border-radius:8px;background:#ff6b35;color:#fff;text-decoration:none;font-size:13px;font-weight:700;transition:background .2s,transform .2s}
.reviewWriteBtn:hover{background:#e95a27;transform:translateY(-1px)}
.reviewListHeader{display:flex;justify-content:space-between;align-items:center;margin:0 0 15px}
.reviewListHeader h3{margin:0;font-size:18px;font-weight:800;letter-spacing:-.4px}
.reviewListHeader span{font-size:12px;color:#999}
.myReviewList{display:flex;flex-direction:column;gap:16px}
.myReviewCard{display:flex;align-items:stretch;gap:23px;padding:22px;background:#fff;border:1px solid #e9edf2;border-radius:14px;color:#222;transition:transform .2s,box-shadow .2s,border-color .2s}
.myReviewCard:hover{transform:translateY(-2px);border-color:#ffd0bd;box-shadow:0 8px 24px rgba(31,41,55,.06)}
.reviewPhoto{width:200px;height:165px;flex-shrink:0;overflow:hidden;border-radius:10px;background:#f4f5f7}
.reviewPhoto img{width:100%;height:100%;object-fit:cover;display:block}
.reviewNoPhoto{width:100%;height:100%;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:9px;color:#a0a5ad;font-size:12px}
.reviewNoPhoto .photoIcon{font-size:30px;color:#c2c7cf}
.reviewInfo{display:flex;flex:1;min-width:0;flex-direction:column;padding:3px 0}
.reviewMeta{display:flex;align-items:center;flex-wrap:wrap;gap:10px;margin-bottom:15px}
.reviewType{padding:5px 10px;border-radius:20px;background:#fff1eb;color:#f06432;font-size:11px;font-weight:700;letter-spacing:.3px}
.reviewRating{color:#f5a623;font-size:14px;font-weight:800}
.reviewDate{margin-left:auto;color:#999;font-size:12px}
.reviewPlace{margin:0 0 12px;font-size:17px;font-weight:800;letter-spacing:-.4px}
.reviewText{display:-webkit-box;overflow:hidden;-webkit-line-clamp:3;-webkit-box-orient:vertical;color:#626b78;font-size:13px;line-height:1.9;word-break:break-word}
.reviewText p{margin:0}
.reviewText img,.reviewText video,.reviewText iframe{display:none}
.reviewBottom{display:flex;justify-content:flex-end;align-items:center;gap:5px;margin-top:auto;padding-top:14px;color:#ff6b35;font-size:12px;font-weight:700}
.emptyReview{margin-top:10px;padding:75px 20px;text-align:center;background:#fafbfc;border:1px dashed #dfe3e8;border-radius:14px}
.emptyIcon{margin-bottom:17px;font-size:42px;color:#ff9a73}
.emptyReview h3{margin:0 0 10px;font-size:18px;font-weight:800}
.emptyReview p{margin:0 0 24px;color:#888;font-size:13px;line-height:1.7}
.reviewNavi{display:flex;justify-content:center;align-items:center;flex-wrap:wrap;gap:6px;margin-top:28px}
.reviewNavi a{min-width:34px;height:34px;display:inline-flex;align-items:center;justify-content:center;padding:0 10px;border:1px solid #e1e4e8;border-radius:7px;background:#fff;color:#777;text-decoration:none;font-size:12px;transition:all .2s}
.reviewNavi a.on,.reviewNavi a:hover{background:#222;border-color:#222;color:#fff}
@media(max-width:650px){
    .myReviewPage{max-width:calc(100% - 24px);margin-bottom:50px}
    .reviewTitle{padding:30px 0 23px}
    .reviewTitle h2{font-size:24px}
    .reviewSummary{gap:12px;margin:20px 0 25px;padding:18px 15px}
    .summaryLabel{font-size:12px}
    .summaryCount{font-size:23px}
    .reviewWriteBtn{padding:11px 12px;font-size:12px;white-space:nowrap}
    .reviewListHeader h3{font-size:16px}
    .reviewListHeader span{font-size:11px}
    .myReviewList{gap:12px}
    .myReviewCard{gap:13px;padding:13px;border-radius:11px}
    .reviewPhoto{width:105px;height:125px}
    .reviewNoPhoto{font-size:10px;text-align:center;padding:5px}
    .reviewNoPhoto .photoIcon{font-size:24px}
    .reviewMeta{gap:6px;margin-bottom:9px}
    .reviewType{padding:4px 7px;font-size:10px}
    .reviewRating{font-size:12px}
    .reviewDate{width:100%;margin-left:0;font-size:11px}
    .reviewPlace{margin-bottom:7px;font-size:14px}
    .reviewText{-webkit-line-clamp:2;font-size:12px;line-height:1.7}
    .reviewBottom{padding-top:8px;font-size:11px}
    .emptyReview{padding:55px 15px}
    .emptyReview h3{font-size:16px}
}
</style>
<div class="myReviewPage">
    <div class="reviewTitle">
        <h2>내가 쓴 리뷰</h2>
        <p>여행의 추억과 내가 남긴 소중한 후기를 확인해 보세요.</p>
    </div>
    <div class="reviewBreadcrumb">홈 &nbsp;&gt;&nbsp; 마이페이지 &nbsp;&gt;&nbsp; <span>내가 쓴 리뷰</span></div>
    <div class="reviewSummary">
        <div>
            <div class="summaryLabel">내가 작성한 리뷰</div>
            <div class="summaryCount">총 <strong><c:out value="${recordTotalCount}"/></strong>개</div>
        </div>
        <a href="${pageContext.request.contextPath}/review/review_write" class="reviewWriteBtn">리뷰 작성하기 <span>＋</span></a>
    </div>
    <div class="reviewListHeader">
        <h3>나의 리뷰 목록</h3>
        <span>최근 작성한 리뷰 순</span>
    </div>
    <c:choose>
        <c:when test="${not empty myReviewList}">
            <div class="myReviewList">
                <c:forEach var="review" items="${myReviewList}">
                    <div class="myReviewCard">
                        <div class="reviewPhoto">
                            <c:choose>
                                <c:when test="${not empty review.image1}">
                                    <img src="${pageContext.request.contextPath}${review.image1}" alt="리뷰 사진">
                                </c:when>
                                <c:otherwise>
                                    <div class="reviewNoPhoto">
                                        <span class="photoIcon">✎</span>
                                        <span>등록된 사진 없음</span>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="reviewInfo">
                            <div class="reviewMeta">
                                <span class="reviewType">MY REVIEW</span>
                                <span class="reviewRating">★ <c:out value="${review.rating}"/> / 5</span>
                                <span class="reviewDate"><fmt:formatDate value="${review.reg_date}" pattern="yyyy.MM.dd"/></span>
                            </div>
                            <div class="reviewPlace">${review.contents}</div>
                            <div class="reviewText"></div>
                            <div class="reviewBottom">나의 리뷰 <a href="/review/detail?seq=${review.seq}&place_id=${review.target_id}"><span>→</span></a></div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="reviewNavi" id="reviewNavi">${navi}</div>
        </c:when>
        <c:otherwise>
            <div class="emptyReview">
                <div class="emptyIcon">✎</div>
                <h3>아직 작성한 리뷰가 없어요.</h3>
                <p>여행한 장소의 솔직한 후기를 남겨 보세요.</p>
                <a href="${pageContext.request.contextPath}/review/review_write" class="reviewWriteBtn">첫 리뷰 작성하기</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>