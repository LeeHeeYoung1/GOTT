
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GOTT 마일리지 내역</title>
<style>
*{box-sizing:border-box}
body{margin:0;padding:0;background:#f5f7fa;font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;color:#263238;font-size:14px;line-height:1.6}
a{text-decoration:none;color:inherit}
button{font-family:inherit;cursor:pointer}
.mileagePage{width:calc(100% - 40px);max-width:1000px;margin:50px auto 80px}
.pageHeader{display:flex;justify-content:space-between;align-items:center;margin-bottom:25px}
.pageHeader h2{margin:0;font-size:26px;font-weight:700;color:#222}
.pageHeader p{margin:7px 0 0;color:#7b8490;font-size:13px}
.backBtn{display:inline-flex;align-items:center;justify-content:center;height:38px;padding:0 17px;border:1px solid #d9dee5;border-radius:7px;background:#fff;color:#394150;font-size:13px;transition:.2s}
.backBtn:hover{background:#263238;color:#fff;border-color:#263238}
.mileageSummary{display:grid;grid-template-columns:1fr 1fr;gap:18px;margin-bottom:25px}
.summaryCard{padding:24px 26px;background:#fff;border:1px solid #e8ebef;border-radius:12px;box-shadow:0 3px 12px rgba(20,35,50,.03)}
.summaryLabel{font-size:13px;color:#7b8490;margin-bottom:8px}
.summaryValue{font-size:27px;font-weight:700;color:#202b36}
.summaryValue span{font-size:14px;font-weight:500;margin-left:4px}
.summaryDesc{margin-top:7px;font-size:12px;color:#9aa2ac}
.historyCard{background:#fff;border:1px solid #e8ebef;border-radius:12px;overflow:hidden;box-shadow:0 3px 12px rgba(20,35,50,.03)}
.historyHeader{display:flex;justify-content:space-between;align-items:center;padding:22px 25px;border-bottom:1px solid #edf0f3}
.historyHeader h3{margin:0;font-size:17px;color:#263238}
.historyHeader span{font-size:12px;color:#8b949e}
.tableWrap{width:100%;overflow-x:auto}
.mileageTable{width:100%;border-collapse:collapse;table-layout:fixed}
.mileageTable thead{background:#f8fafc}
.mileageTable th{height:48px;padding:10px 16px;border-bottom:1px solid #e8ebef;color:#697481;font-size:12px;font-weight:600;text-align:center;white-space:nowrap}
.mileageTable td{height:58px;padding:12px 16px;border-bottom:1px solid #f0f2f5;color:#4a5562;font-size:13px;text-align:center;overflow-wrap:anywhere}
.mileageTable tbody tr:last-child td{border-bottom:none}
.mileageTable tbody tr:hover{background:#fbfcfe}
.mileageTable th:nth-child(1),.mileageTable td:nth-child(1){width:20%}
.mileageTable th:nth-child(2),.mileageTable td:nth-child(2){width:40%;text-align:left}
.mileageTable th:nth-child(3),.mileageTable td:nth-child(3){width:18%}
.mileageTable th:nth-child(4),.mileageTable td:nth-child(4){width:22%;text-align:right}
.typeBadge{display:inline-block;min-width:45px;padding:4px 10px;border-radius:20px;font-size:11px;font-weight:600}
.typeEarn,.typeReturn{background:#eaf7ef;color:#25834a}
.typeUse,.typeRevoke{background:#fff0ee;color:#d65345}
.typeEtc{background:#eef1f5;color:#657181}
.amountPlus{color:#25834a;font-weight:700;white-space:nowrap}
.amountMinus{color:#d65345;font-weight:700;white-space:nowrap}
.amountNormal{color:#485463;font-weight:600;white-space:nowrap}
.emptyRow{padding:65px 15px!important;text-align:center!important;color:#929ba6!important}
.emptyIcon{display:block;margin-bottom:12px;font-size:28px}
.emptyText{font-size:14px;color:#7c8794}
.bottomInfo{margin-top:18px;padding:17px 20px;border-radius:8px;background:#eef3f8;color:#6d7885;font-size:12px}
.bottomInfo strong{display:block;margin-bottom:5px;color:#465463;font-size:13px}
.bottomInfo p{margin:3px 0}
@media(max-width:650px){
.mileagePage{width:calc(100% - 24px);margin:25px auto 45px}
.pageHeader{align-items:flex-start;gap:12px}
.pageHeader h2{font-size:22px}
.pageHeader p{font-size:12px}
.backBtn{height:34px;padding:0 11px;font-size:12px;white-space:nowrap}
.mileageSummary{gap:10px}
.summaryCard{padding:18px 15px}
.summaryLabel{font-size:12px}
.summaryValue{font-size:22px}
.summaryValue span{font-size:12px}
.historyHeader{padding:18px 15px}
.historyHeader h3{font-size:15px}
.historyHeader span{font-size:11px}
.mileageTable{min-width:570px}
.mileageTable th,.mileageTable td{padding:10px 12px}
.bottomInfo{padding:14px}
}
@media(max-width:400px){
.mileageSummary{grid-template-columns:1fr}
.summaryCard{padding:16px 18px}
.summaryValue{font-size:24px}
}

.pagination{display:flex;justify-content:center;align-items:center;gap:7px;margin:25px 0}
.pagination a{display:flex;justify-content:center;align-items:center;min-width:34px;height:34px;padding:0 10px;border:1px solid #e0e5eb;border-radius:6px;background:#fff;color:#596574;font-size:13px;transition:.2s}
.pagination a:hover,.pagination a.active{background:#263238;border-color:#263238;color:#fff}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="mileagePage">
    <div class="pageHeader">
        <div>
            <h2>마일리지 내역</h2>
            <p>GOTT에서 적립하고 사용한 마일리지를 확인하세요.</p>
        </div>
        <a class="backBtn" href="${pageContext.request.contextPath}/members/mypage">마이페이지</a>
    </div>
    <div class="mileageSummary">
        <div class="summaryCard">
            <div class="summaryLabel">마일리지 이용 내역</div>
            <div class="summaryValue"><fmt:formatNumber value="${mileageTotalCount}" pattern="#,##0"/><span>건</span></div>
            <div class="summaryDesc">적립 및 사용 기록</div>
        </div>
        <div class="summaryCard">
            <div class="summaryLabel">내역 안내</div>
            <div class="summaryValue"><fmt:formatNumber value="${mileage}" pattern="#,##0"/>M<span>Mileage</span></div>
            <div class="summaryDesc">적립 · 사용 · 복구 · 회수 내역</div>
        </div>
    </div>
    <div class="historyCard">
        <div class="historyHeader">
            <h3>마일리지 이용 내역</h3>
            <span>최신 내역 순</span>
        </div>
        <div class="tableWrap">
            <table class="mileageTable">
                <thead>
                    <tr>
                        <th>날짜</th>
                        <th>내용</th>
                        <th>구분</th>
                        <th>마일리지</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty mileageHistory}">
                            <c:forEach var="mh" items="${mileageHistory}">
                                <tr>
                                    <td><fmt:formatDate value="${mh.regDate}" pattern="yyyy-MM-dd"/></td>
                                    <td>${mh.reason}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${mh.type eq 'EARN'}"><span class="typeBadge typeEarn">적립</span></c:when>
                                            <c:when test="${mh.type eq 'RETURN'}"><span class="typeBadge typeReturn">복구</span></c:when>
                                            <c:when test="${mh.type eq 'USE'}"><span class="typeBadge typeUse">사용</span></c:when>
                                            <c:when test="${mh.type eq 'REVOKE'}"><span class="typeBadge typeRevoke">회수</span></c:when>
                                            <c:otherwise><span class="typeBadge typeEtc">${mh.type}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${mh.type eq 'EARN' or mh.type eq 'RETURN'}">
                                                <span class="amountPlus">+<fmt:formatNumber value="${mh.amount}" pattern="#,##0"/>M</span>
                                            </c:when>
                                            <c:when test="${mh.type eq 'USE' or mh.type eq 'REVOKE'}">
                                                <span class="amountMinus">-<fmt:formatNumber value="${mh.amount}" pattern="#,##0"/>M</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="amountNormal"><fmt:formatNumber value="${mh.amount}" pattern="#,##0"/>M</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        
                        <c:otherwise>
                            <tr>
                                <td colspan="4" class="emptyRow">
                                    <span class="emptyIcon">◷</span>
                                    <div class="emptyText">아직 마일리지 이용 내역이 없습니다.</div>
                                </td>
                            </tr>
                        </c:otherwise>
                        
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
    
    <c:if test="${mileageTotalPage > 1}">
        <div class="pagination">
            <c:forEach var="i" begin="1" end="${mileageTotalPage}">
                <a href="${pageContext.request.contextPath}/members/mileage?mileageCpage=${i}"
                   class="${mileageCpage == i ? 'active' : ''}">${i}</a>
            </c:forEach>
        </div>
    </c:if>
    
    <div class="bottomInfo">
        <strong>마일리지 안내</strong>
        <p>· 적립은 초록색, 사용 및 회수는 빨간색으로 표시됩니다.</p>
        <p>· 결제 취소 등으로 인해 마일리지 내역이 복구 또는 회수될 수 있습니다.</p>
        <p>· 현재 보유 마일리지와 상세 적립 내역은 각각의 기준에 따라 표시됩니다.</p>
    </div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>