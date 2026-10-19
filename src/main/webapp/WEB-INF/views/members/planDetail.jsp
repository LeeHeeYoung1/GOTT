<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<meta charset="UTF-8">
<title>여행 일정 상세</title>
<style>
.planDetail {
	max-width: 1000px;
	margin: 40px auto;
	padding: 0 24px;
	color: #263238;
}

/* ===== 상단 요약 ===== */
.planHeader {
	position: relative;
	padding: 30px 32px;
	background: linear-gradient(135deg, #f0fdfa 0%, #e8fbf6 55%, #f4fbff 100%);
	border: 1px solid #cbeee7;
	border-radius: 16px;
	margin-bottom: 34px;
}

.planHeader h2 {
	margin: 0 0 18px;
	font-size: 28px;
	font-weight: 700;
	letter-spacing: -0.4px;
	overflow-wrap: anywhere;
}

.planInfo {
	display: flex;
	flex-wrap: wrap;
	gap: 9px;
	color: #475569;
	font-size: 14px;
}

.planInfo span {
	display: inline-flex;
	align-items: center;
	padding: 7px 14px;
	background: #fff;
	border: 1px solid #d8e7e4;
	border-radius: 999px;
	font-size: 13px;
	color: #415854;
}

/* ===== 섹션 제목 ===== */
.planDetail>h3 {
	display: flex;
	align-items: center;
	gap: 9px;
	margin: 0 0 18px;
	font-size: 19px;
	font-weight: 700;
}

.planDetail>h3::before {
	content: "";
	width: 4px;
	height: 17px;
	background: #0f766e;
	border-radius: 2px;
}

/* ===== 하루 ===== */
.daySection {
	margin-bottom: 30px;
}

.dayTitle {
	display: flex;
	align-items: center;
	gap: 10px;
	padding: 13px 18px;
	background: #f1f5f9;
	border-radius: 10px;
	font-size: 17px;
	font-weight: 700;
	color: #1f3a36;
}

.dayTitle::before {
	content: "";
	width: 8px;
	height: 8px;
	background: #0f766e;
	border-radius: 50%;
}

/* ===== 장소 카드 ===== */
.placeCard {
	display: flex;
	align-items: center;
	gap: 12px;
	padding: 12px 16px;
	margin-top: 8px;
	background: #fff;
	border: 1px solid #e2e8f0;
	border-radius: 12px;
	transition: border-color .18s, box-shadow .18s, transform .18s;
}

.placeCard:hover {
	border-color: #9ddfd5;
	box-shadow: 0 6px 18px rgba(15, 118, 110, .10);
	transform: translateY(-2px);
}

.placeNumber {
	order: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-shrink: 0;
	width: 26px;
	height: 26px;
	background: #0f766e;
	color: #fff;
	border-radius: 50%;
	font-size: 13px;
	font-weight: 700;
}

.placeCard>img {
	order: 2;
	flex-shrink: 0;
	width: 56px;
	height: 56px;
	object-fit: cover;
	display: block;
	background: #eef2f5;
	border-radius: 8px;
}

.placeInfo {
	order: 3;
	flex: 1;
	min-width: 0;
	display: flex;
	align-items: center;
	gap: 14px;
}

.placeInfo h4 {
	flex-shrink: 0;
	margin: 0;
	font-size: 15px;
	font-weight: 700;
	white-space: nowrap;
}

.placeInfo p {
	margin: 0;
	color: #64748b;
	font-size: 12.5px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	min-width: 0;
}

.placeInfo p+p {
	padding-left: 14px;
	border-left: 1px solid #e9eef3;
}

.placeInfo p:last-of-type {
	flex: 1;
}

.emptyDay {
	margin-top: 12px;
	padding: 26px 20px;
	color: #8a99a8;
	text-align: center;
	font-size: 14px;
	border: 1px dashed #d7dee6;
	border-radius: 12px;
}

/* ===== 스크랩 · 돌아가기 ===== */
.scrapBtnBox {
	display: flex;
	flex-direction: column;
	align-items: center;
	gap: 14px;
	margin: 24px 0 36px;
}

.scrapBtn {
	display: inline-flex;
	align-items: center;
	gap: 7px;
	padding: 8px 16px;
	background: #fff;
	border: 1px solid #e0e3e7;
	border-radius: 8px;
	font-size: 13px;
	font-family: inherit;
	font-weight: 600;
	color: #8b8f96;
	cursor: pointer;
	transition: border-color .15s, color .15s;
}

.scrapBtn:hover {
	border-color: #9ddfd5;
	color: #0f766e;
}

.scrapBtn i {
	font-size: 15px;
}

.scrapBtn.on {
	border-color: #0f766e;
	color: #0f766e;
}

.scrapBtn.on i {
	animation: pop .3s ease;
}

.backBtnBox {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 10px;
}

.backButton {
	display: inline-block;
	margin: 0;
	padding: 12px 22px;
	background: #0f766e;
	color: #fff;
	text-decoration: none;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 600;
	transition: background .18s, box-shadow .18s, transform .18s;
}

.backButton:hover {
	background: #0b5d56;
	box-shadow: 0 5px 14px rgba(15, 118, 110, .25);
	transform: translateY(-1px);
}

.backBtnBox .backButton:last-of-type {
	background: #fff;
	color: #0f766e;
	border: 1px solid #0f766e;
}

.backBtnBox .backButton:last-of-type:hover {
	background: #f0fdfa;
	box-shadow: 0 5px 14px rgba(15, 118, 110, .12);
}

/* ===== 댓글 ===== */
.replyBox {
	margin-top: 10px;
	padding-top: 28px;
	padding-bottom: 50px;
	border-top: 1px solid #e3e9ee;
}

.replyBox form {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 8px;
}

.replyBox form>p {
	width: 100%;
	display: flex;
	align-items: center;
	gap: 8px;
	margin: 0 0 3px;
	font-size: 14px;
	font-weight: 700;
	color: #1f3a36;
}

.replyBox form>p::before {
	content: "";
	width: 4px;
	height: 15px;
	background: #0f766e;
	border-radius: 2px;
}

#replyInput {
	flex: 1;
	min-width: 0;
	padding: 13px 16px;
	background: #fff;
	border: 1px solid #d8e7e4;
	border-radius: 10px;
	box-sizing: border-box;
	font-size: 14px;
	font-family: inherit;
	color: #263238;
	transition: border-color .18s, box-shadow .18s;
}

#replyInput::placeholder {
	color: #9aa7b2;
}

#replyInput:focus {
	outline: none;
	border-color: #0f766e;
	box-shadow: 0 0 0 3px rgba(15, 118, 110, .12);
}

#register {
	flex-shrink: 0;
	padding: 13px 26px;
	background: #0f766e;
	color: #fff;
	border: 0;
	border-radius: 10px;
	font-size: 14px;
	font-family: inherit;
	font-weight: 600;
	cursor: pointer;
	transition: background .18s, box-shadow .18s;
}

#register:hover {
	background: #0b5d56;
	box-shadow: 0 5px 14px rgba(15, 118, 110, .25);
}

/* ===== 댓글 한 건 ===== */
.replyList {
	position: relative;
	padding: 16px 2px;
	border-bottom: 1px solid #f0f3f6;
}

.replyList:first-of-type {
	margin-top: 24px;
	border-top: 1px solid #f0f3f6;
}

.replyList .info {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 10px;
	margin-bottom: 7px;
	padding-right: 120px;
}

.replyList .info p {
	margin: 0;
	font-size: 12.5px;
	color: #8a99a8;
}

.replyList .info p:first-child {
	font-size: 13px;
	font-weight: 700;
	color: #1f3a36;
}

.replyList .info p+p {
	padding-left: 10px;
	border-left: 1px solid #e9eef3;
}

.replyContents input {
	width: 100%;
	padding: 0;
	background: transparent;
	border: 0;
	box-sizing: border-box;
	font-size: 14px;
	font-family: inherit;
	color: #37474f;
	line-height: 1.6;
	cursor: default;
	transition: padding .15s, border-color .15s, box-shadow .15s;
}

.replyContents input:focus {
	outline: none;
}

/* 수정 모드 — readonly가 풀리면 입력창처럼 보이게 */
.replyContents input:not([readonly]) {
	padding: 9px 12px;
	background: #fff;
	border: 1px solid #0f766e;
	border-radius: 8px;
	box-shadow: 0 0 0 3px rgba(15, 118, 110, .12);
	cursor: text;
}

/* ===== 댓글 버튼 ===== */
.reply_btn_box {
	position: absolute;
	top: 14px;
	right: 2px;
	display: flex;
	gap: 6px;
}

.reply_btn_box button {
	padding: 4px 11px;
	background: #fff;
	border: 1px solid #e0e3e7;
	border-radius: 6px;
	font-size: 12px;
	font-family: inherit;
	color: #8b8f96;
	cursor: pointer;
	transition: border-color .15s, color .15s, background .15s;
}

.reply_btn_box button:hover {
	border-color: #9ddfd5;
	color: #0f766e;
}

.replySaveBtn {
	background: #0f766e !important;
	border-color: #0f766e !important;
	color: #fff !important;
}

.replySaveBtn:hover {
	background: #0b5d56 !important;
	border-color: #0b5d56 !important;
	color: #fff !important;
}
</style>

<div class="planDetail">
	<div class="planHeader">
		<h2>
			<c:out value="${plan.plan_title}" />
		</h2>
		<div class="planInfo">
			<span>시작일: <c:out value="${plan.start_date}" /></span> <span>종료일:
				<c:out value="${plan.end_date}" />
			</span> <span>여행 인원: <c:out value="${plan.person_count}" />명
			</span> <span>공개 여부: <c:choose>
					<c:when test="${plan.is_public eq 'Y'}">전체 공개</c:when>
					<c:otherwise>비공개</c:otherwise>
				</c:choose></span>
		</div>
	</div>

	<h3>여행 일정</h3>

	<c:forEach var="dayNo" items="${dayNumbers}">
		<div class="daySection">
			<div class="dayTitle">
				Day
				<c:out value="${dayNo}" />
			</div>
			<c:set var="placeCount" value="0" />
			<c:forEach var="place" items="${detailList}">
				<c:if test="${place.DAY_NO eq dayNo}">
					<c:set var="placeCount" value="${placeCount + 1}" />
					<div class="placeCard">
						<c:forEach var="i" items="${idAndImg}">
							<c:if test="${i.place_id == place.place_id}">
								<img src="${i.image_name}">
							</c:if>
						</c:forEach>
						<div class="placeNumber">
							<c:out value="${place.VISIT_ORDER}" />
						</div>
						<div class="placeInfo">
							<h4>
								<c:out value="${place.PLACE_NAME}" />
							</h4>
							<c:if test="${not empty place.VISIT_TIME}">
								<p>
									방문 시간:
									<c:out value="${place.VISIT_TIME}" />
								</p>
							</c:if>
							<c:if test="${not empty place.PLACE_TYPE}">
								<c:choose>
									<c:when test="${place.PLACE_TYPE == 'STAY'}">
										<p>장소유형 : 숙박업소</p>
									</c:when>
									<c:when test="${place.PLACE_TYPE == 'FOOD'}">
										<p>장소유형 : 식당</p>
									</c:when>
									<c:otherwise>
										<p>장소유형 : 관광지</p>
									</c:otherwise>
								</c:choose>
							</c:if>
							<c:if test="${not empty place.REGION}">
								<p>
									지역:
									<c:out value="${place.REGION}" />
								</p>
							</c:if>
							<c:if test="${not empty place.ADDRESS}">
								<p>
									주소:
									<c:out value="${place.ADDRESS}" />
								</p>
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

	<div class="scrapBtnBox">
		<button type="button" class="scrapBtn" id="scrapBtn">
			<i class="fa-regular fa-bookmark"></i> <span>스크랩</span>
		</button>

		<div class="backBtnBox">
		    <a href="/travelPlan/list?cpage=${cpage}&region=${region}&night=${night}&sort=${sort}"
		       class="backButton" id="backToList">목록으로 돌아가기</a>
		
		    <a href="${pageContext.request.contextPath}/members/mypage"
		       class="backButton" id="backToMypage">마이페이지로 돌아가기</a>
		
		    <c:if test="${sessionScope.loginId eq plan.member_id}">
		        <a href="${pageContext.request.contextPath}/travelPlan/delete?planId=${plan.plan_id}"
		           class="backButton"
		           onclick="return confirm('정말 이 여행 일정을 삭제하시겠습니까?');"
		           style="background: #dc2626; color: #fff; border-color: #dc2626;">
		            일정 삭제하기
		        </a>
		    </c:if>
		</div>
	</div>
	<div class="replyBox">
		<form action="/travelPlanReply/insert" method="post">
			<p>${sessionScope.nickname}</p>
			<input type="hidden" id="nickname" name="nickname"
				value="${sessionScope.nickname}"> <input type="hidden"
				id="member_id" name="member_id" value="${sessionScope.loginId}">
			<input type="hidden" id="plan_id" name="plan_id"
				value="${plan.plan_id}"> <input type="text" id="replyInput"
				name="contents">
			<button id="register">등록</button>
		</form>
		<c:forEach var="i" items="${tprList}">
			<div class="replyList">
				<div class="info">
					<p>작성자 : ${i.nickname}</p>
					<p>
						등록일 :
						<fmt:formatDate value="${i.reg_date}" pattern="yyyy-MM-dd HH:mm" />
					</p>
				</div>
				<div class="replyContents">
					<input type="text" id="reply_contents${i.seq}"
						value="${i.contents}" readonly>
				</div>
				<div class="reply_btn_box" id="reply_btn_box${i.seq}">
					<c:if test="${sessionScope.loginId == i.member_id}">
						<button type="button" class="replyUpdateBtn"
							id="replyUpdateBtn${i.seq}">수정</button>
					</c:if>
					<c:if
						test="${sessionScope.loginId == i.member_id or sessionScope.role == 'admin'}">
						<button type="button" class="replyDeleteBtn"
							id="replyDeleteBtn${i.seq}">삭제</button>
					</c:if>
				</div>
			</div>
			<script>
				$("#replyDeleteBtn${i.seq}").on("click", function() {
						location.href = "/travelPlanReply/delete?seq=${i.seq}&plan_id=${plan.plan_id}";
						
					})

				$("#replyUpdateBtn${i.seq}").on("click", function() {

					let input = $("#reply_contents${i.seq}");
					let before = input.val();

					input.prop("readonly", false).focus();

					$("#replyUpdateBtn${i.seq}").hide();
					$("#replyDeleteBtn${i.seq}").hide();

					let saveBtn = $("<button>").attr("type", "button").addClass("replySaveBtn").text("저장");
					let cancelBtn = $("<button>").attr("type", "button").addClass("replyCancelBtn").text("취소");

					$("#reply_btn_box${i.seq}").append(saveBtn).append(cancelBtn);

					saveBtn.on("click", function() {

						let contents = input.val().trim();

						$.ajax({
							url : "/travelPlanReply/update",
							type : "post",
							data : {
								seq : ${i.seq},
								contents : contents},
								success : function() {
									input.prop("readonly", true);
									saveBtn.remove();
									cancelBtn.remove();
									$("#replyUpdateBtn${i.seq}").show();
									$("#replyDeleteBtn${i.seq}").show();
								}
							})
						})

						cancelBtn.on("click", function() {
							input.val(before).prop("readonly", true);
							saveBtn.remove();
							cancelBtn.remove();
							$("#replyUpdateBtn${i.seq}").show();
							$("#replyDeleteBtn${i.seq}").show();
						})
					})
				</script>
		</c:forEach>
	</div>
</div>
<script>

let isScrap = ${isScrap};

if (isScrap) {
	$("#scrapBtn").css({
		"color" : "#ff4757",
		"border-color" : "#ff4757"
	});
	$("#scrapBtn i").removeClass("fa-regular").addClass("fa-solid");
}

$("#scrapBtn").on("click", function() {
	if (isScrap) {
		location.href = "/travelPlan/scrapDown?seq=${plan.plan_id}";
	} else {
		location.href = "/travelPlan/scrapUp?seq=${plan.plan_id}";
	}
})
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>