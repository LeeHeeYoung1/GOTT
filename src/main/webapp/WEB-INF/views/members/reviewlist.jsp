<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<style>
*{box-sizing:border-box}
.myReviewPage{
    width:1100px;
    max-width:calc(100% - 40px);
    margin:0 auto 80px;
    font-family:'Malgun Gothic','맑은 고딕',sans-serif;
    color:#222;
}
.reviewTitle{
    text-align:center;
    padding:38px 0 25px;
}
.reviewTitle h2{
    margin:0 0 10px;
    font-size:27px;
    font-weight:800;
}
.reviewTitle p{
    margin:0;
    color:#888;
    font-size:13px;
}
.reviewBreadcrumb{
    padding:12px 0;
    border-top:1px solid #eee;
    font-size:12px;
    color:#999;
}
.reviewBreadcrumb span{
    color:#333;
    font-weight:700;
}
.reviewSummary{
    display:flex;
    align-items:center;
    justify-content:space-between;
    margin:24px 0 15px;
    padding:22px 25px;
    background:#fff;
    border:1px solid #e8e8e8;
    border-radius:12px;
}
.summaryLabel{
    font-size:14px;
    color:#666;
}
.summaryCount{
    margin-top:7px;
    font-size:25px;
    font-weight:800;
}
.summaryCount strong{
    color:#ff6b35;
}
.reviewWriteBtn{
    display:inline-flex;
    align-items:center;
    justify-content:center;
    padding:11px 18px;
    border:0;
    border-radius:7px;
    background:#ff6b35;
    color:#fff;
    text-decoration:none;
    font-size:13px;
    font-weight:700;
}
.reviewWriteBtn:hover{
    background:#e95a27;
}
.reviewListHeader{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin:28px 0 13px;
}
.reviewListHeader h3{
    margin:0;
    font-size:17px;
}
.reviewListHeader span{
    font-size:12px;
    color:#888;
}
.myReviewList{
    display:flex;
    flex-direction:column;
    gap:14px;
}
.myReviewCard{
    display:flex;
    gap:22px;
    padding:20px;
    background:#fff;
    border:1px solid #e8e8e8;
    border-radius:12px;
    text-decoration:none;
    color:inherit;
    transition:transform .18s,box-shadow .18s,border-color .18s;
}
.myReviewCard:hover{
    transform:translateY(-2px);
    border-color:#ffd0bd;
    box-shadow:0 6px 18px rgba(0,0,0,.06);
}
.reviewPhoto{
    width:190px;
    height:155px;
    flex-shrink:0;
    overflow:hidden;
    border-radius:9px;
    background:#f3f4f6;
}
.reviewPhoto img{
    width:100%;
    height:100%;
    object-fit:cover;
    display:block;
}
.reviewNoPhoto{
    width:100%;
    height:100%;
    display:flex;
    align-items:center;
    justify-content:center;
    color:#aaa;
    font-size:13px;
}
.reviewInfo{
    display:flex;
    flex:1;
    min-width:0;
    flex-direction:column;
    padding:3px 0;
}
.reviewMeta{
    display:flex;
    align-items:center;
    flex-wrap:wrap;
    gap:8px;
    margin-bottom:12px;
}
.reviewType{
    padding:5px 10px;
    border-radius:15px;
    background:#fff1eb;
    color:#ff6b35;
    font-size:11px;
    font-weight:700;
}
.reviewRating{
    font-size:14px;
    font-weight:700;
    color:#ffb400;
}
.reviewDate{
    margin-left:auto;
    color:#999;
    font-size:12px;
}
.reviewPlace{
    margin:0 0 10px;
    font-size:17px;
    font-weight:800;
}
.reviewText{
    display:-webkit-box;
    overflow:hidden;
    -webkit-line-clamp:3;
    -webkit-box-orient:vertical;
    font-size:13px;
    line-height:1.8;
    color:#666;
    word-break:break-word;
}
.reviewText p{
    margin:0;
}
.reviewText img,.reviewText video,.reviewText iframe{
    display:none;
}
.reviewBottom{
    display:flex;
    justify-content:flex-end;
    margin-top:auto;
    padding-top:12px;
    color:#ff6b35;
    font-size:12px;
    font-weight:700;
}
.emptyReview{
    padding:70px 20px;
    text-align:center;
    background:#fff;
    border:1px solid #eee;
    border-radius:12px;
}
.emptyIcon{
    margin-bottom:15px;
    font-size:42px;
}
.emptyReview h3{
    margin:0 0 9px;
    font-size:18px;
}
.emptyReview p{
    margin:0 0 22px;
    color:#888;
    font-size:13px;
}
.reviewNavi{
    display:flex;
    justify-content:center;
    align-items:center;
    gap:6px;
    margin-top:28px;
}
.reviewNavi a{
    min-width:34px;
    height:34px;
    display:inline-flex;
    align-items:center;
    justify-content:center;
    padding:0 10px;
    border:1px solid #ddd;
    border-radius:6px;
    color:#777;
    text-decoration:none;
    font-size:12px;
}
.reviewNavi a.on,.reviewNavi a:hover{
    background:#222;
    border-color:#222;
    color:#fff;
}
@media(max-width:650px){
    .myReviewPage{
        max-width:calc(100% - 24px);
    }
    .reviewTitle{
        padding:28px 0 20px;
    }
    .reviewSummary{
        padding:17px;
    }
    .myReviewCard{
        gap:13px;
        padding:13px;
    }
    .reviewPhoto{
        width:110px;
        height:125px;
    }
    .reviewPlace{
        font-size:14px;
    }
    .reviewMeta{
        gap:5px;
        margin-bottom:8px;
    }
    .reviewDate{
        width:100%;
        margin-left:0;
    }
    .reviewText{
        -webkit-line-clamp:2;
        font-size:12px;
    }
    .reviewBottom{
        font-size:11px;
    }

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
			<div class="summaryCount">총 <strong>${recordTotalCount}</strong>개</div>
		</div>
		<a href="/review/review_write" class="reviewWriteBtn">리뷰 작성하기 +</a>
	</div>
	<div class="reviewListHeader">
		<h3>나의 리뷰 목록</h3>
		<span>최근 작성한 리뷰 순</span>
	</div>
	<c:choose>
		<c:when test="${not empty myReviewList}">
			<div class="myReviewList">
				<c:forEach var="review" items="${myReviewList}">
					<a class="myReviewCard" href="/review/detail?seq=${review.seq}&place_id=${review.target_id}">
						<div class="reviewPhoto">
							<c:choose>
								<c:when test="${not empty review.image1}">
									<img src="${review.image1}" alt="리뷰 사진">
								</c:when>
								<c:otherwise>
									<div class="reviewNoPhoto">등록된 사진이 없습니다</div>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="reviewInfo">
							<div class="reviewMeta">
								<span class="reviewType">
									<c:choose>
										<c:when test="${review.target_type eq 'STAY'}">숙소</c:when>
										<c:when test="${review.target_type eq 'FOOD'}">맛집</c:when>
										<c:when test="${review.target_type eq 'SPOT'}">관광지</c:when>
										<c:otherwise>여행 리뷰</c:otherwise>
									</c:choose>
								</span>
								<span class="reviewRating">★ ${review.rating}/5</span>
								<span class="reviewDate"><fmt:formatDate value="${review.reg_date}" pattern="yyyy.MM.dd"/></span>
							</div>
							<h4 class="reviewPlace">
								<c:out value="${review.target_id}"/>번 장소 리뷰
							</h4>
							<div class="reviewText">${review.contents}</div>
							<div class="reviewBottom">리뷰 상세보기 &nbsp;→</div>
						</div>
					</a>
				</c:forEach>
			</div>
			<div class="reviewNavi" id="reviewNavi">${navi}</div>
		</c:when>
		<c:otherwise>
			<div class="emptyReview">
				<div class="emptyIcon">✎</div>
				<h3>아직 작성한 리뷰가 없어요.</h3>
				<p>여행한 장소의 솔직한 후기를 남겨 보세요.</p>
				<a href="/review/review_write" class="reviewWriteBtn">첫 리뷰 작성하기</a>
			</div>
		</c:otherwise>
	</c:choose>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
