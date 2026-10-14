<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<meta charset="UTF-8">
<title>GOTT 여행 일정 구경하기</title>
<style>
.sharedPlanner {
	max-width: 1200px;
	margin: 40px auto;
	padding: 0 24px;
}

.a1, .description {
	text-align: center;
}

.sharedPlanner h2 {
	margin: 0 0 10px;
	font-size: 27px;
	font-weight: 700;
	letter-spacing: -0.4px;
	color: #263238;
}

.sharedPlanner .description {
	margin: 0 0 26px;
	color: #64748b;
	font-size: 14px;
}

/* ===== 필터 ===== */
.filter {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 10px;
	margin-bottom: 30px;
}

.filter select {
	padding: 9px 16px;
	background: #fff;
	border: 1px solid #d8e7e4;
	border-radius: 999px;
	font-size: 13px;
	font-family: inherit;
	color: #415854;
	cursor: pointer;
	transition: border-color .15s, box-shadow .15s;
}

.filter select:hover {
	border-color: #9ddfd5;
}

.filter select:focus {
	outline: none;
	border-color: #0f766e;
	box-shadow: 0 0 0 3px rgba(15, 118, 110, .12);
}

/* ===== 카드 목록 ===== */
.planList {
	display: grid;
	grid-template-columns: repeat(3, minmax(0, 1fr));
	gap: 20px;
}

.planCardLink {
	display: block;
	text-decoration: none;
	color: inherit;
}

.planCard {
	display: flex;
	flex-direction: column;
	height: 100%;
	padding: 24px;
	background: #fff;
	border: 1px solid #e2e8f0;
	border-radius: 14px;
	box-shadow: 0 4px 14px rgba(38, 50, 56, .04);
	cursor: pointer;
	transition: transform .2s, box-shadow .2s, border-color .2s;
}

.planCardLink:hover .planCard {
	transform: translateY(-4px);
	border-color: #9ddfd5;
	box-shadow: 0 8px 22px rgba(38, 50, 56, .12);
}

.planCard .publicLabel {
	align-self: flex-start;
	margin-bottom: 12px;
	padding: 5px 10px;
	color: #0f766e;
	background: #e9f7f4;
	border-radius: 999px;
	font-size: 12px;
	font-weight: 600;
}

.planCard h3 {
	margin: 0 0 14px;
	color: #0f766e;
	font-size: 19px;
	font-weight: 700;
	line-height: 1.4;
	overflow-wrap: anywhere;
}

.planCard p {
	margin: 6px 0;
	color: #64748b;
	font-size: 13.5px;
}

.detailLink {
	margin-top: auto;
	padding-top: 14px;
	color: #0f766e;
	font-size: 14px;
	font-weight: 600;
}

.planCardLink:hover .detailLink {
	text-decoration: underline;
}

.emptyPlans {
	grid-column: 1/-1;
	padding: 50px 20px;
	text-align: center;
	color: #8a99a8;
	font-size: 14px;
	background: #f8fafc;
	border: 1px dashed #d7dee6;
	border-radius: 12px;
}

/* ===== 페이지 번호 ===== */
.reviewNavi {
	display: flex;
	justify-content: center;
	flex-wrap: wrap;
	gap: 6px;
	margin: 36px 0 20px;
}

.reviewNavi a {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	min-width: 34px;
	height: 34px;
	padding: 0 10px;
	background: #fff;
	border: 1px solid #e2e8f0;
	border-radius: 8px;
	color: #64748b;
	text-decoration: none;
	font-size: 13px;
	transition: border-color .15s, color .15s, background .15s;
}

.reviewNavi a:hover {
	border-color: #9ddfd5;
	color: #0f766e;
}

.reviewNavi a.on {
	background: #0f766e;
	border-color: #0f766e;
	color: #fff;
	font-weight: 700;
}
</style>

<div class="sharedPlanner">
	<h2 class="a1">여행 일정 구경하기</h2>
	<p class="description">다른 여행자들이 공유한 여행 계획을 확인해 보세요.</p>

	<div class="filter" id="filter">
		<select name="region" id="region">
			<option value="">지역 전체</option>
			<option value="서울특별시">서울</option>
			<option value="부산광역시">부산</option>
			<option value="대구광역시">대구</option>
			<option value="인천광역시">인천</option>
			<option value="대전광역시">대전</option>
			<option value="울산광역시">울산</option>
			<option value="세종특별자치시">세종</option>
			<option value="경기도">경기</option>
			<option value="강원특별자치도">강원</option>
			<option value="충청북도">충북</option>
			<option value="충청남도">충남</option>
			<option value="전북특별자치도">전북</option>
			<option value="전남광주통합특별시">전남·광주</option>
			<option value="경상북도">경북</option>
			<option value="경상남도">경남</option>
			<option value="제주특별자치도">제주</option>
		</select> <select name="nights" id="nights">
			<option value="">기간 전체</option>
			<option value="0">당일치기</option>
			<option value="1">1박 2일</option>
			<option value="2">2박 3일</option>
			<option value="3">3박 4일</option>
			<option value="4">4박 5일 이상</option>
		</select> <select name="sort" id="sort">
			<option value="new">최신순</option>
			<option value="scrap">스크랩순</option>
		</select>
	</div>

	<div class="planList">
		<c:choose>
			<c:when test="${not empty planList}">
				<c:forEach var="plan" items="${planList}">
					<a
						href="${pageContext.request.contextPath}/travelPlan/detail?planId=${plan.plan_id}"
						class="planCardLink">
						<div class="planCard">
							<span class="publicLabel">공개 일정</span>
							<h3>
								<c:out value="${plan.plan_title}" />
							</h3>
							<p>
								여행 시작일:
								<fmt:formatDate value="${plan.start_date}" pattern="yyyy-MM-dd" />
							</p>
							<p>
								여행 종료일:
								<fmt:formatDate value="${plan.end_date}" pattern="yyyy-MM-dd" />
							</p>
							<p>
								여행 인원:
								<c:out value="${plan.person_count}" />
								명
							</p>
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
	<div class="reviewNavi" id="navi">${navi}</div>
</div>

<script>
let region = "${region}";
let nights = "${nights}";
let sort = "${sort}";

$("#region").val(region);
$("#nights").val(nights);
$("#sort").val(sort);


$("#filter select").on("change", function() {
	location.href = "$/travelPlan/list?cpage=1&region=" + $("#region").val()) + "&nights=" + $("#nights").val() + "&sort=" + $("#sort").val();
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
	prev.setAttribute("href", "/travelPlan/list?cpage="
			+ (startNavi - 1) + "&region=" + $("#region").val()) + "&nights=" + $("#nights").val() + "&sort=" + $("#sort").val());
	prev.innerHTML = "<";
	navi.append(prev);
}
for (let i = startNavi; i <= endNavi; i++) {
	let num = document.createElement("a");
	num.setAttribute("href", "/travelPlan/list?cpage=" + i + "&region=" + $("#region").val()) + "&nights=" + $("#nights").val() + "&sort=" + $("#sort").val());
	if (i == currentPage) {
		num.setAttribute("class", "on");
	}
	num.innerHTML = i;
	navi.append(num);
}
if (needNext) {
	let next = document.createElement("a");
	next.setAttribute("href", "/travelPlan/list?cpage=" + (endNavi + 1) + "&region=" + $("#region").val()) + "&nights=" + $("#nights").val() + "&sort=" + $("#sort").val());
	next.innerHTML = ">";
	navi.append(next);
}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
