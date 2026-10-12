<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>여행 일정 상세</title>
<style>
.planDetail {
    max-width: 1000px;
    margin: 40px auto;
    padding: 0 24px;
    color: #263238;
}
.planHeader {
    padding: 28px;
    background: #f0fdfa;
    border-radius: 16px;
    margin-bottom: 30px;
}
.planHeader h2 {
    margin: 0 0 18px;
    font-size: 28px;
    overflow-wrap: anywhere;
}
.planInfo {
    display: flex;
    flex-wrap: wrap;
    gap: 12px 24px;
    color: #475569;
    font-size: 14px;
}
.daySection {
    margin-bottom: 28px;
}
.dayTitle {
    padding: 14px 18px;
    background: #f1f5f9;
    border-radius: 10px;
    font-size: 18px;
    font-weight: 700;
}
.placeCard {
    display: flex;
    gap: 16px;
    padding: 20px;
    margin-top: 12px;
    border: 1px solid #e2e8f0;
    border-radius: 12px;
}
.placeNumber {
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    width: 36px;
    height: 36px;
    background: #0f766e;
    color: white;
    border-radius: 50%;
    font-weight: 700;
}
.placeInfo {
    min-width: 0;
}
.placeInfo h4 {
    margin: 4px 0 10px;
    font-size: 17px;
    overflow-wrap: anywhere;
}
.placeInfo p {
    margin: 6px 0;
    color: #64748b;
    font-size: 14px;
    overflow-wrap: anywhere;
}
.emptyDay {
    padding: 20px;
    color: #64748b;
    text-align: center;
}
.backButton {
    display: inline-block;
    margin: 10px 0 40px;
    padding: 12px 20px;
    background: #0f766e;
    color: white;
    text-decoration: none;
    border-radius: 8px;
}
@media (max-width: 600px) {
    .planDetail {
        padding: 0 14px;
    }
    .planHeader h2 {
        font-size: 23px;
    }
    .placeCard {
        padding: 14px;
    }
}
</style>
</head>
<body>
<div class="planDetail">
    <div class="planHeader">
        <h2><c:out value="${plan.plan_title}"/></h2>
        <div class="planInfo">
            <span>시작일: <c:out value="${plan.start_date}"/></span>
            <span>종료일: <c:out value="${plan.end_date}"/></span>
            <span>여행 인원: <c:out value="${plan.person_count}"/>명</span>
            <span>공개 여부: <c:choose><c:when test="${plan.is_public eq 'Y'}">전체 공개</c:when><c:otherwise>비공개</c:otherwise></c:choose></span>
        </div>
    </div>

    <h3>여행 일정</h3>

    <c:forEach var="dayNo" items="${dayNumbers}">
        <div class="daySection">
            <div class="dayTitle">Day <c:out value="${dayNo}"/></div>
            <c:set var="placeCount" value="0"/>
            <c:forEach var="place" items="${detailList}">
                <c:if test="${place.DAY_NO eq dayNo}">
                    <c:set var="placeCount" value="${placeCount + 1}"/>
                    <div class="placeCard">
                        <div class="placeNumber"><c:out value="${place.VISIT_ORDER}"/></div>
                        <div class="placeInfo">
                            <h4><c:out value="${place.PLACE_NAME}"/></h4>
                            <c:if test="${not empty place.VISIT_TIME}">
                                <p>방문 시간: <c:out value="${place.VISIT_TIME}"/></p>
                            </c:if>
                            <c:if test="${not empty place.PLACE_TYPE}">
                                <p>장소 유형: <c:out value="${place.PLACE_TYPE}"/></p>
                            </c:if>
                            <c:if test="${not empty place.REGION}">
                                <p>지역: <c:out value="${place.REGION}"/></p>
                            </c:if>
                            <c:if test="${not empty place.ADDRESS}">
                                <p>주소: <c:out value="${place.ADDRESS}"/></p>
                            </c:if>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
            <c:if test="${placeCount eq 0}">
                <div class="emptyDay">아직 추가된 장소가 없습니다.</div>
            </c:if>
        </div>
    </c:forEach>

    <a href="${pageContext.request.contextPath}/travelPlan/list" class="backButton">목록으로 돌아가기</a>
    <a href="${pageContext.request.contextPath}/members/mypage" class="backButton">마이페이지로 돌아가기</a>
</div>
</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>