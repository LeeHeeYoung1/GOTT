<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>GOTT 여행 일정 구경하기</title>
<style>
.a1,.description{
	display:flex;
	justify-content:center;
	text-align: center;
}

.sharedPlanner {
    max-width: 1200px;
    margin: 40px auto;
    padding: 0 24px;
}
.sharedPlanner h2 {
    margin-bottom: 10px;
    color: #263238;
}
.sharedPlanner .description {
    margin-bottom: 28px;
    color: #64748b;
    font-size: 14px;
}
.planList {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 20px;
}
.planCard {
    padding: 24px;
    background: #fff;
    border: 1px solid #e2e8f0;
    border-radius: 14px;
    box-shadow: 0 4px 14px rgba(38, 50, 56, .04);
}
.planCard h3 {
    margin: 0 0 16px;
    color: #0f766e;
    font-size: 19px;
    overflow-wrap: anywhere;
}
.planCard p {
    margin: 8px 0;
    color: #475569;
    font-size: 14px;
}
.planCard .publicLabel {
    display: inline-block;
    margin-bottom: 12px;
    padding: 5px 9px;
    color: #0f766e;
    background: #e9f7f4;
    border-radius: 6px;
    font-size: 12px;
}
.emptyPlans {
    grid-column: 1 / -1;
    padding: 50px 20px;
    text-align: center;
    color: #64748b;
    background: #f8fafc;
    border-radius: 12px;
}
@media (max-width: 800px) {
    .planList {
        grid-template-columns: repeat(2, minmax(0, 1fr));
    }
}
@media (max-width: 550px) {
    .sharedPlanner {
        padding: 0 14px;
    }
    .planList {
        grid-template-columns: 1fr;
    }
}
.planCardLink {
    display: block;
    text-decoration: none;
    color: inherit;
}
.planCardLink .planCard {
    height: 100%;
    cursor: pointer;
    transition: transform .2s, box-shadow .2s;
}
.planCardLink:hover .planCard {
    transform: translateY(-4px);
    box-shadow: 0 8px 22px rgba(38, 50, 56, .12);
}
.detailLink {
    display: inline-block;
    margin-top: 12px;
    color: #0f766e;
    font-size: 14px;
    font-weight: 600;
}
</style>
</head>
<body>
<div class="sharedPlanner">
    <h2 class="a1">여행 일정 구경하기</h2>
    <p class="description">다른 여행자들이 공유한 여행 계획을 확인해 보세요.</p>
    <div class="planList">
        <c:choose>
            <c:when test="${not empty planList}">
                <c:forEach var="plan" items="${planList}">
				    <a href="${pageContext.request.contextPath}/travelPlan/detail?planId=${plan.plan_id}" class="planCardLink">
				        <div class="planCard">
				            <span class="publicLabel">공개 일정</span>
				            <h3><c:out value="${plan.plan_title}"/></h3>
				            <p>여행 시작일: <fmt:formatDate value="${plan.start_date}" pattern="yyyy-MM-dd"/></p>
							<p>여행 종료일: <fmt:formatDate value="${plan.end_date}" pattern="yyyy-MM-dd"/></p>
					        <p>여행 인원: <c:out value="${plan.person_count}"/>명</p>
				            <span class="detailLink">일정 자세히 보기 →</span>
				        </div>
				    </a>
				</c:forEach>
            </c:when>
            <c:otherwise>
                <div class="emptyPlans">아직 공유된 여행 일정이 없습니다.</div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
