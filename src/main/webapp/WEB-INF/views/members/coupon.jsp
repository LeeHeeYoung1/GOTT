
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GOTT 쿠폰함</title>
<style>
*{box-sizing:border-box}
body{margin:0;padding:0;background:#f5f7fa;font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;color:#263238;font-size:14px;line-height:1.6}
a{text-decoration:none;color:inherit}
.couponPage{width:calc(100% - 40px);max-width:1000px;margin:50px auto 80px}
.pageHeader{display:flex;justify-content:space-between;align-items:center;gap:15px;margin-bottom:25px}
.pageHeader h2{margin:0;font-size:26px;font-weight:700;color:#222}
.pageHeader p{margin:7px 0 0;color:#7b8490;font-size:13px}
.headerButtons{display:flex;gap:8px;flex-wrap:wrap}
.backBtn{display:inline-flex;align-items:center;justify-content:center;height:38px;padding:0 17px;border:1px solid #d9dee5;border-radius:7px;background:#fff;color:#394150;font-size:13px;transition:.2s;white-space:nowrap}
.backBtn:hover{background:#263238;color:#fff;border-color:#263238}
.couponSummary{display:grid;grid-template-columns:1fr 1fr;gap:18px;margin-bottom:25px}
.summaryCard{padding:24px 26px;background:#fff;border:1px solid #e8ebef;border-radius:12px;box-shadow:0 3px 12px rgba(20,35,50,.03)}
.summaryLabel{font-size:13px;color:#7b8490;margin-bottom:8px}
.summaryValue{font-size:27px;font-weight:700;color:#202b36}
.summaryValue span{font-size:14px;font-weight:500;margin-left:4px}
.summaryDesc{margin-top:7px;font-size:12px;color:#9aa2ac}
.couponSection{background:#fff;border:1px solid #e8ebef;border-radius:12px;overflow:hidden;box-shadow:0 3px 12px rgba(20,35,50,.03)}
.sectionHeader{display:flex;justify-content:space-between;align-items:center;padding:22px 25px;border-bottom:1px solid #edf0f3}
.sectionHeader h3{margin:0;font-size:17px;color:#263238}
.sectionHeader span{font-size:12px;color:#8b949e}
.couponList{display:grid;grid-template-columns:1fr 1fr;gap:16px;padding:22px}
.couponCard{display:flex;min-height:155px;border:1px solid #e5eaf0;border-radius:10px;overflow:hidden;background:#fff;transition:.2s}
.couponCard:hover{border-color:#b9d8f6;box-shadow:0 4px 12px rgba(20,35,50,.05)}
.couponDiscount{width:125px;flex-shrink:0;display:flex;flex-direction:column;align-items:center;justify-content:center;text-align:center;background:#eef5fc;padding:15px}
.discountValue{font-size:24px;font-weight:800;color:#2878bd;line-height:1.3;overflow-wrap:anywhere}
.discountLabel{margin-top:6px;font-size:12px;color:#697b8d}
.couponContent{min-width:0;flex:1;padding:17px 15px;display:flex;flex-direction:column;justify-content:center}
.couponName{font-size:16px;font-weight:700;color:#263238;margin-bottom:8px;overflow-wrap:anywhere}
.couponInfo{font-size:12px;line-height:1.9;color:#7b8490}
.statusBadge{display:inline-block;width:fit-content;margin-top:10px;padding:4px 10px;border-radius:20px;font-size:11px;font-weight:700;background:#eaf7ef;color:#25834a}
.statusUsed{background:#eef1f5;color:#657181}
.statusExpired{background:#fff0ee;color:#d65345}
.emptyState{padding:65px 15px;text-align:center}
.emptyIcon{display:block;margin-bottom:12px;font-size:32px;color:#9aa2ac}
.emptyTitle{font-size:16px;font-weight:700;color:#465463}
.emptyText{margin-top:6px;font-size:13px;color:#929ba6}
.bottomInfo{margin-top:18px;padding:17px 20px;border-radius:8px;background:#eef3f8;color:#6d7885;font-size:12px}
.bottomInfo strong{display:block;margin-bottom:5px;color:#465463;font-size:13px}
.bottomInfo p{margin:3px 0}
@media(max-width:750px){
.couponPage{width:calc(100% - 24px);margin:25px auto 45px}
.pageHeader{align-items:flex-start}
.pageHeader h2{font-size:22px}
.pageHeader p{font-size:12px}
.backBtn{height:34px;padding:0 11px;font-size:12px}
.couponList{grid-template-columns:1fr;padding:14px;gap:12px}
.couponDiscount{width:115px}
.summaryCard{padding:18px 15px}
.summaryValue{font-size:22px}
.sectionHeader{padding:18px 15px}
.sectionHeader h3{font-size:15px}
}
@media(max-width:420px){
.couponSummary{grid-template-columns:1fr;gap:10px}
.pageHeader{flex-direction:column}
.headerButtons{width:100%}
.couponCard{min-height:145px}
.couponDiscount{width:100px;padding:10px}
.discountValue{font-size:21px}
.couponContent{padding:12px}
.couponName{font-size:14px}
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="couponPage">
		<c:if test="${not empty autumn}">
			<script>
				alert("${autumn}");
			</script>
				<c:remove var="autumn"/>
		</c:if>
    <div class="pageHeader">
    
        <div>
            <h2>나의 쿠폰함</h2>
            <p>GOTT에서 제공하는 할인 쿠폰과 사용 상태를 확인하세요.</p>
        </div>
        <div class="headerButtons">
            <a class="backBtn" href="${pageContext.request.contextPath}/members/mileageHistory">마일리지 내역</a>
            <a class="backBtn" href="${pageContext.request.contextPath}/members/mypage">마이페이지</a>
        </div>
    </div>

    <div class="couponSummary">
        <div class="summaryCard">
            <div class="summaryLabel">보유 쿠폰</div>
            <div class="summaryValue"><fmt:formatNumber value="${couponList.size()}" pattern="#,##0"/><span>장</span></div>
            <div class="summaryDesc">발급받은 전체 쿠폰</div>
        </div>
        <div class="summaryCard">
            <div class="summaryLabel">사용 안내</div>
            <div class="summaryValue">COUPON<span>GOTT</span></div>
            <div class="summaryDesc">결제 단계에서 사용 가능한 쿠폰을 선택하세요.</div>
        </div>
    </div>

    <div class="couponSection">
        <div class="sectionHeader">
            <h3>보유 쿠폰 목록</h3>
            <span>발급일 최신순</span>
        </div>

        <c:choose>
            <c:when test="${not empty couponList}">
                <div class="couponList">
                    <c:forEach var="coupon" items="${couponList}">
                        <div class="couponCard">
                            <div class="couponDiscount">
                                <c:choose>
                                    <c:when test="${coupon.discountType eq 'PERCENT'}">
                                        <div class="discountValue"><fmt:formatNumber value="${coupon.discountValue}" pattern="#,##0"/>%</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="discountValue"><fmt:formatNumber value="${coupon.discountValue}" pattern="#,##0"/>원</div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="discountLabel">할인 쿠폰</div>
                            </div>

                            <div class="couponContent">
                                <div class="couponName"><c:out value="${coupon.couponName}"/></div>
                                <div class="couponInfo">
                                    최소 결제 금액<br>
                                    <strong><fmt:formatNumber value="${coupon.minOrderPrice}" pattern="#,##0"/>원</strong><br>
                                    유효기간<br>
                                    <fmt:formatDate value="${coupon.issueDate}" pattern="yyyy.MM.dd"/> ~
                                    <fmt:formatDate value="${coupon.expireDate}" pattern="yyyy.MM.dd"/>
                                </div>

                                <c:choose>
                                    <c:when test="${coupon.status eq 'USED'}">
                                        <span class="statusBadge statusUsed">사용 완료</span>
                                    </c:when>
                                    <c:when test="${coupon.status eq 'EXPIRED'}">
                                        <span class="statusBadge statusExpired">기간 만료</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="statusBadge">사용 가능</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="emptyState">
                    <span class="emptyIcon">♧</span>
                    <div class="emptyTitle">보유한 쿠폰이 없습니다.</div>
                    <div class="emptyText">쿠폰이 발급되면 이곳에서 확인할 수 있습니다.</div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="bottomInfo">
        <strong>쿠폰 이용 안내</strong>
        <p>· 쿠폰마다 최소 결제 금액과 사용 가능 기간이 다를 수 있습니다.</p>
        <p>· 사용 완료 또는 기간이 만료된 쿠폰은 결제에 사용할 수 없습니다.</p>
        <p>· 쿠폰의 실제 할인 금액은 결제 단계에서 서버가 검증한 뒤 적용해야 합니다.</p>
    </div>
 		<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>