<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<title>GOTT 마이페이지</title>
</head>
<body>
	<c:if test="${not empty tourTypeMessage}">
		<script>
        alert("${tourTypeMessage}");
    </script>
		<c:remove var="tourTypeMessage" />
	</c:if>

	<c:choose>
		<c:when test="${loginId != null}">
			<jsp:include page="/WEB-INF/views/common/header.jsp" />
			<div class="mypageContainer">
				<h2 style="margin: 24px 0 4px;">마이페이지</h2>
				<h5 style="font-size: 13px; color: #7c7c7c; margin: 0 0 16px;">예약
					내역과 찜한 여행지, 내가 남긴 기록을 한 곳에서 관리</h5>
				<c:if test="${not empty reservationUpdateMessage}">
					<script>
		        alert("${reservationUpdateMessage}");
		    </script>
				</c:if>
				<hr style="border: 1px solid rgb(248, 246, 246); margin: 0 0 20px;">
				<div class="breadcrumb" style="font-size: 12px; margin: 20px;">홈
					&gt; 마이페이지 &gt; 대시보드</div>
				<div class="sideBox">
					<div class="loginId">
						<strong>${nickname}</strong><span>님</span><br> <span>일반회원</span><span>등급</span>
					</div>
					<hr>
					<div class="sideTitle">
						<span>예약/활동</span>
						<ul>
							<li class="active"><a href="/members/mypage">마이페이지 홈</a></li>
							<li><a href="/members/reservationpage">예약 내역</a></li>
							<li><a href="/members/wishlist">찜한 목록</a></li>
							<li><a href="/members/planner">여행 일정 플래너</a></li>
							<li><a href="/review/reviewlist">내가 쓴 리뷰</a></li>
							<li><a href="/board/boardlist">내가 쓴 게시글</a></li>

						</ul>
						<span>혜택</span>
						<ul>
							<li><a href="/members/mileage">마일리지 내역</a></li>
							<li><a href="/coupon/myCoupon">쿠폰함</a></li>
						</ul>
						<span>계정</span>
						<ul>
							<li><a href="/members/checkPassword">내 정보 수정</a></li>
							<li><a href="/members/pwsearchpage">비밀번호 변경</a></li>
							<li><a href="/notice/qna">1:1 문의</a></li>
							<li><a href="/members/deleted">회원탈퇴</a></li>
						</ul>
					</div>
				</div>
				<div class="mainContainer">
					<nav class="mybarBox">
						<a class="a1"><strong>${upcomingCount}</strong><span>다가오는
								예약</span></a> <a class="a2"><strong>${myWishTotalCount}</strong><span>찜한
								목록</span></a> <a class="a3"><strong>${reviewTotalCount}</strong><span>작성한
								리뷰</span></a> <a class="a4"><strong><fmt:formatNumber
									value="${mileage}" pattern="#,##0" />M</strong><span>보유마일리지</span></a> <a
							class="a5"><strong><fmt:formatDate
									value="${regdate}" pattern="yyyy-MM-dd" /></strong><span>가입일자</span></a>
					</nav>

					<div class="tourType">
						<div class="sectionTtitle">
							<strong>나의 여행 성향</strong>
						</div>

						<div class="tourTypeBox">
							<div class="tourTypeText">
								<c:choose>
									<c:when test="${not empty tourType}">
										<strong>나의 여행 성향은 <span>${tourType}</span>입니다.
										</strong>
										<p>나에게 맞는 여행을 더 알아보세요.</p>
									</c:when>
									<c:otherwise>
										<strong>아직 여행 성향 테스트 결과가 없습니다.</strong>
										<p>테스트를 통해 나에게 맞는 여행 스타일을 찾아보세요.</p>
									</c:otherwise>
								</c:choose>
							</div>

							<button type="button"
								onclick="location.href='/members/tourTypeTest'">테스트
								하러가기 →</button>
						</div>
					</div>

					<div class="plannerContainer">
						<div class="sectionTitle">
							<span>여행 일정 플래너</span>
						</div>
						<div class="plannerBox">
							<div class="plannerText">
								<strong>찜해둔 장소를 일차별 일정으로 정리해보세요.</strong>
								<p>관광지·맛집·숙소를 드래그해 일정에 추가하고 완성한 여행을 게시판에 공유할 수 있습니다.</p>
							</div>
							<div class="plannerBtns">
								<button type="button" class="newScheduleBtn"
									onclick="location.href='/members/planner'">새 일정 만들기</button>
								<button type="button" class="viewShareBtn"
									onclick="location.href='/travelPlan/list?cpage=1'">공유일정
									전부 보기</button>
							</div>
						</div>
					</div>
					<div class="sharedPlanContainer">
						<div class="sectionTitle">
							<span>내가 공유한 여행 일정</span>
						</div>
						<c:choose>
							<c:when test="${not empty myPlannerList}">
								<c:forEach var="plan" items="${myPlannerList}">
									<div class="sharedPlanCard">
										<div class="img">
											<c:choose>
												<c:when test="${not empty plan.IMAGE_NAME}">
													<img src="<c:out value='${plan.IMAGE_NAME}'/>"
														alt="<c:out value='${plan.PLAN_TITLE}'/>">
												</c:when>
												<c:otherwise>
													<div
														style="width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; color: #999; font-size: 12px;">이미지
														준비 중</div>
												</c:otherwise>
											</c:choose>
										</div>
										<div class="sharedPlanInfo">
											<h3>
												<c:out value="${plan.PLAN_TITLE}" />
											</h3>
											<p>
												<c:out value="${plan.START_DATE}" />
												~
												<c:out value="${plan.END_DATE}" />
												· 방문지
												<c:out value="${plan.SPOT_COUNT}" />
												곳
											</p>
											<p>
												공유일
												<fmt:formatDate value="${plan.CREATED_AT}"
													pattern="yyyy-MM-dd" />
											</p>
										</div>
										<div class="sharedPlanCondition">
										    <c:choose>
										        <c:when test="${plan.IS_PUBLIC eq 'Y'}">
										            <span class="shareBadge">전체 공개</span>
										        </c:when>
										        <c:otherwise>
										            <span class="shareBadge">비공개</span>
										        </c:otherwise>
										    </c:choose>
										
										    <div class="btnGroup">
										        <form
										            action="${pageContext.request.contextPath}/travelPlan/delete"
										            method="post"
										            onsubmit="return confirm('이 여행 일정을 삭제하시겠습니까? 삭제하면 복구할 수 없습니다.');">
										
										            <input type="hidden" name="planId" value="${plan.PLAN_ID}">
										
										            <button type="button" class="deleteBtn"
										                style="background-color: #eef5ff;"
										                onclick="if(confirm('삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/travelPlan/delete?planId=${plan.PLAN_ID}'">
										                삭제
										            </button>
										        </form>
										
										        <button type="button" class="boardViewBtn"
										            onclick="location.href='${pageContext.request.contextPath}/travelPlan/detail?planId=${plan.PLAN_ID}'">
										            일정 보기
										        </button>
										    </div>
										</div>
									</div>
								</c:forEach>
								<c:if test="${plannerTotalPage > 1}">
									<div class="plannerPagination">
										<c:if test="${plannerCpage > 1}">
											<a
												href="${pageContext.request.contextPath}/members/mypage?cpage=${cpage}&wishCpage=${wishCpage}&mileageCpage=${mileageCpage}&plannerCpage=${plannerCpage - 1}">&lt;</a>
										</c:if>

										<c:forEach var="i" begin="1" end="${plannerTotalPage}">
											<a
												href="${pageContext.request.contextPath}/members/mypage?cpage=${cpage}&wishCpage=${wishCpage}&mileageCpage=${mileageCpage}&plannerCpage=${i}"
												class="${plannerCpage == i ? 'active' : ''}">${i}</a>
										</c:forEach>
									</div>
								</c:if>
							</c:when>
							<c:otherwise>
								<p class="emptyPlanner">아직 공유한 여행 일정이 없습니다.</p>
							</c:otherwise>
						</c:choose>
					</div>

					<div class="scrapPlanContainer">
						<div class="scrapPlanHeader">
							<span>내가 스크랩한 여행 일정</span>
						</div>
						<c:choose>
							<c:when test="${not empty scrapPlanList}">
								<c:forEach var="i" items="${scrapPlanList}">
									<div class="scrapPlanCard">
										<div class="img">
											<img src="${i.image_name}">
										</div>
										<div class="scrapPlanInfo">
											<p>${i.plan_title}</p>
											<p>${i.start_date}~${i.end_date} · 방문지 ${i.spot_count} 곳</p>
											<p>작성자 ${i.nickname}</p>
										</div>
										<div class="btnBox">
											<button type="button" class="scrapDeleteBtn"
												id="scrapDeleteBtn${i.plan_id}">스크랩 취소</button>
											<button type="button" class="scrapDetailBtn"
												id="scrapDetailBtn${i.plan_id}">일정 보기</button>
										</div>
									</div>

									<script>
									$("#scrapDeleteBtn${i.plan_id}").on("click", function() {
										if (confirm("스크랩을 취소하시겠습니까?")) {
											location.href = "${pageContext.request.contextPath}/travelPlan/mypageScrapDown?seq=${i.plan_id}";
										}
									});

									$("#scrapDetailBtn${i.plan_id}").on("click", function() {
										location.href = "${pageContext.request.contextPath}/travelPlan/detail?planId=${i.plan_id}";
									});
									</script>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<p class="emptyScrapPlan">아직 스크랩한 여행 일정이 없습니다.</p>
							</c:otherwise>
						</c:choose>
					</div>

					<div class="reservationContainer" id="reservationSection">
						<div class="sectionTitle">
							<span>예약내역</span> <a
								href="${pageContext.request.contextPath}/members/reservationpage">예약내역
								열기</a>
						</div>
						<div class="reservationVar">
							<span class="tab ${reservationTab eq 'all' ? 'active' : ''}"
								data-tab="all">전체</span> <span
								class="tab ${reservationTab eq 'upcoming' ? 'active' : ''}"
								data-tab="upcoming">이용 예정</span> <span
								class="tab ${reservationTab eq 'completed' ? 'active' : ''}"
								data-tab="completed">이용 완료</span> <span
								class="tab ${reservationTab eq 'cancelled' ? 'active' : ''}"
								data-tab="cancelled">취소 / 환불</span>
						</div>
						<div class="reservationList" id="reservationList">
							<c:choose>
								<c:when test="${not empty myRsList}">
									<c:forEach var="rs" items="${myRsList}">
										<div class="flipCard" data-tab="${reservationType}">
											<div class="flipCardInner">
												<div class="flipCardFront">
													<div class="img">
														<img src="${rs.image1}" alt="호텔 이미지">
													</div>
													<div class="reservationInfo">
														<h3>${rs.roomName}</h3>
														<p>· 체크인 ${rs.checkIn} / 체크아웃 ${rs.checkOut}</p>
														<p>
															· 성인 ${rs.guestNum}명<br>· 예약번호 ${rs.paymentId}<br>
															<c:choose>
																<c:when test="${rs.status eq '예약취소'}">
																	<strong>· 회수 마일리지 - ${rs.mileage}M</strong>
																</c:when>
																<c:otherwise>
																	<strong>적립예정 마일리지 + <fmt:formatNumber
																			value="${pendingMileage}" pattern="#,##0" />M
																	</strong>
																</c:otherwise>
															</c:choose>
														</p>
														<p>결제금액 ${rs.price}원</p>
													</div>

													<div class="reservationCondition">
													    <button type="button" disabled>
													        <c:choose>
													            <c:when test="${rs.status eq '예약취소'}">
													                예약취소
													            </c:when>
													            <c:when test="${rs.status eq '이용완료'}">
													                이용 완료
													            </c:when>
													            <c:otherwise>
													                예약완료
													            </c:otherwise>
													        </c:choose>
													    </button>
													
													    <button type="button" class="detailBtn">예약 상세</button>
													
													    <c:if test="${rs.reservationType eq 'upcoming'}">
													        <button type="button" class="updateBtn"
													            data-payment-id="${rs.paymentId}"
													            data-checkin="${rs.checkIn}">예약 변경</button>
													
													        <button type="button" class="cancelBtn"
													            data-payment-id="${rs.paymentId}">예약 취소</button>
													    </c:if>
													</div>

												</div>
												<div class="flipCardBack">
													<div class="reservationInfo">
														<h3>${rs.roomName}상세정보</h3>
														<p>· 체크인: ${rs.checkIn}</p>
														<p>· 체크아웃: ${rs.checkOut}</p>
														<p>· 성인: ${rs.guestNum}명</p>
														<p>· 예약번호: ${rs.paymentId}</p>
														<p>· 결제금액: ${rs.price}원</p>
														<p>
															· 예약일:
															<fmt:formatDate value="${rs.reserveDate}"
																pattern="yyyy-MM-dd HH:mm" />
														</p>
													</div>
													<div class="reservationCondition">
														<button type="button" class="backBtn">돌아가기</button>
														<c:if test="${reservationType eq 'upcoming'}">
															<button type="button" class="updateBtn"
																data-payment-id="${rs.paymentId}"
																data-checkin="${rs.checkIn}">예약 변경</button>
															<button type="button" class="cancelBtn"
																data-payment-id="${rs.paymentId}">예약 취소</button>
														</c:if>
													</div>
												</div>
											</div>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<div class="emptyReservation">
										<span>🏨</span> <strong>예약 내역이 없어요</strong>
										<p>
											<c:choose>
												<c:when test="${reservationTab eq 'upcoming'}">이용 예정인 예약이 없습니다.</c:when>
												<c:when test="${reservationTab eq 'completed'}">이용 완료된 예약이 없습니다.</c:when>
												<c:when test="${reservationTab eq 'cancelled'}">취소 / 환불 내역이 없습니다.</c:when>
												<c:otherwise>아직 예약한 내역이 없습니다.</c:otherwise>
											</c:choose>
										</p>
									</div>
								</c:otherwise>
							</c:choose>
						</div>


						<div class="reservationPaging">
							<c:forEach var="i" begin="1" end="${totalPage}">
								<a
									href="${pageContext.request.contextPath}/members/mypage?cpage=${i}&wishCpage=${wishCpage}&mileageCpage=${mileageCpage}&plannerCpage=${plannerCpage}&reviewCpage=${reviewCpage}&reservationTab=${reservationTab}#reservationSection"
									class="${cpage == i ? 'active' : ''}">${i}</a>
							</c:forEach>
						</div>


					</div>

					<div class="wishlistContainer" id="wishlistSection">
						<div class="sectionTitle">
							<span>찜한 관광지 맛집 숙소</span> <a href="/members/wishlist">더
								보기&gt;</a>
						</div>
						<div class="wishlistTab">
							<div class="wishlistTab">
								<button type="button"
									class="${wishType == 'all' ? 'active' : ''}" data-type="all">전체</button>
								<button type="button"
									class="${wishType == 'spot' ? 'active' : ''}" data-type="spot">관광지</button>
								<button type="button"
									class="${wishType == 'food' ? 'active' : ''}" data-type="food">맛집</button>
								<button type="button"
									class="${wishType == 'stay' ? 'active' : ''}" data-type="stay">숙박</button>
							</div>
						</div>
						<div class="wishlistGrid">
							<c:choose>
								<c:when test="${not empty wishList}">
									<c:forEach var="wishList" items="${wishList}">
										<div class="wishlistCard">
											<div class="img">
												<img src="${wishList.image_name}" alt="${wishList.name}">
											</div>
											<div class="wishlistInfo">
												<h3>${wishList.name}</h3>
												<p>${wishList.region}</p>
												
											</div>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<div class="emptyWishlist">
										<span>🤍</span> <strong>아직 찜한 항목이 없어요</strong>
										<p>마음에 드는 관광지, 맛집, 숙소를 찜해보세요.</p>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="wishlistPagination">
						<c:if test="${wishTotalPage > 0}">
							<c:forEach var="page" begin="1" end="${wishTotalPage}">
								<a
									href="/members/mypage?cpage=${cpage}&wishCpage=${page}&wishType=${wishType}#wishlistSection"
									class="${wishCpage == page ? 'active' : ''}">${page}</a>
							</c:forEach>
						</c:if>
					</div>



					<div class="reviewContainer" id="reviewSection">
						<div class="sectionTitle">
							<span>내가 쓴 리뷰</span> <a
								href="${pageContext.request.contextPath}/review/reviewBoard?cpage=1">더
								보기 <span>→</span>
							</a>
						</div>
						<div class="reviewList">
							<c:forEach var="rv" items="${reviewList}">
								<div class="reviewCard">
									<div class="reviewUser">
										<div class="reviewProfile">
											<span>G</span>
										</div>
										<div class="reviewUserInfo">
											<strong>${rv.member_id}</strong> <span>${rv.target_type}
												리뷰</span>
										</div>
										<button type="button" class="reviewMore">•••</button>
									</div>
									<div class="reviewImage">
										<c:choose>
											<c:when test="${not empty rv.image1}">
												<img src="${rv.image1}" alt="리뷰 이미지">
											</c:when>
											<c:otherwise>
												<div class="reviewNoImage">
													<span>✈</span>
													<p>여행의 순간을 기록해 보세요</p>
												</div>
											</c:otherwise>
										</c:choose>
									</div>
									<div class="reviewInfo">
										<div class="reviewIcons">
											<span class="reviewHeart ${rv.liked ? 'liked' : ''}"
												onclick="toggleRecommend(${rv.seq}, this)">${rv.liked ? '♥' : '♡'}</span>

											<span class="likeCount" id="likeCount${rv.seq}">${rv.recommendCount}</span>

											<span class="reviewShareIcon"
												onclick="shareReview(${rv.seq}, ${rv.target_id})"
												title="리뷰 링크 복사"> <i class="fa-solid fa-link"></i>
											</span>
										</div>
										<p class="reviewLike">
											좋아요 <strong>${rv.rating}</strong>
										</p>
										<p class="reviewDescription">${rv.contents}</p>
										<c:if test="${not empty rv.tag}">
											<p class="reviewTag">${rv.tag}</p>
										</c:if>
										<p class="reviewDate">${rv.reg_date}</p>
										<div class="reviewActions">
										<a href="${pageContext.request.contextPath}/review/detail?seq=${rv.seq}&place_id=${rv.target_id}">수정</a>
											<a
												href="${pageContext.request.contextPath}/review/delete?seq=${rv.seq}"
												onclick="return confirm('리뷰를 삭제하시겠습니까?')">삭제</a>
										</div>
									</div>
								</div>
							</c:forEach>
							<c:if test="${empty reviewList}">
								<div class="emptyReview">
									<span>♡</span> <strong>아직 작성한 리뷰가 없어요</strong>
									<p>여행의 소중한 순간을 리뷰로 남겨보세요.</p>
								</div>
							</c:if>
						</div>
						<c:if test="${not empty reviewList and reviewTotalPage > 0}">
							<div class="reviewNavi">
								<c:if test="${reviewCpage > 1}">
									<a
										href="${pageContext.request.contextPath}/members/mypage?cpage=${cpage}&wishCpage=${wishCpage}&mileageCpage=${mileageCpage}&plannerCpage=${plannerCpage}&reviewCpage=${reviewCpage - 1}#reviewSection">&lt;</a>
								</c:if>
								<c:forEach var="page" begin="1" end="${reviewTotalPage}">
									<a
										href="${pageContext.request.contextPath}/members/mypage?cpage=${cpage}&wishCpage=${wishCpage}&mileageCpage=${mileageCpage}&plannerCpage=${plannerCpage}&reviewCpage=${page}#reviewSection"
										class="${page == reviewCpage ? 'active' : ''}">${page}</a>
								</c:forEach>

							</div>
						</c:if>
					</div>


					<div class="couponContainer" id="mileageSection">
						<div class="couponSectionTitle">
							<span>마일리지 · 쿠폰</span> <a href="/members/mileage">더 보기 &gt;</a>
						</div>
						<div class="coupon_point" style="padding: 20px 20px 12px">
							<table align="center">
								<thead>
									<tr>
										<th>날짜</th>
										<th>내용</th>
										<th>구분</th>
										<th>포인트</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach var="mh" items="${mileageHistory}">
										<tr>
											<td><fmt:formatDate value="${mh.regDate}" pattern="yyyy-MM-dd" /></td>
											<td>${mh.reason}</td>
											<td>
												<c:choose>
													<c:when test="${mh.type eq 'EARN'}">적립</c:when>
													<c:when test="${mh.type eq 'USE'}">사용</c:when>
													<c:when test="${mh.type eq 'RESTORE'}">
													    <span style="color: green; font-weight: bold;">복구</span>
													</c:when>
													<c:when test="${mh.type eq 'REVOKE'}">
														<span style="color: red; font-weight: bold;">회수</span>
													</c:when>
													<c:otherwise>${mh.type}</c:otherwise>
												</c:choose>
											</td>
											<td>
												<c:choose>
													<c:when test="${mh.type eq 'EARN' or mh.type eq 'RETURN'}">+<fmt:formatNumber
															value="${mh.amount}" pattern="#,##0" />M</c:when>
													<c:when test="${mh.type eq 'USE' or mh.type eq 'REVOKE'}">- <fmt:formatNumber
															value="${mh.amount}" pattern="#,##0" />M</c:when>
													<c:otherwise><fmt:formatNumber value="${mh.amount}" pattern="#,##0" />M</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>

							<div class="pagination">
								<c:if test="${mileageCpage > 1}">
									<a
										href="${pageContext.request.contextPath}/members/mypage?cpage=${cpage}&wishCpage=${wishCpage}&mileageCpage=${mileageCpage - 1}#mileageSection">&lt;</a>
								</c:if>

								<c:forEach var="i" begin="1" end="${mileageTotalPage}">
									<a
										href="${pageContext.request.contextPath}/members/mypage?cpage=${cpage}&wishCpage=${wishCpage}&mileageCpage=${i}#mileageSection"
										class="${mileageCpage == i ? 'active' : ''}">${i}</a>
								</c:forEach>
							</div>

						</div>



						<div class="couponList">
							<c:choose>
								<c:when test="${not empty myCoupons}">
									<c:forEach var="coupon" items="${myCoupons}" begin="0" end="1">
										<div class="couponBox">
											<strong><c:out value="${coupon.couponName}" /></strong>
											<p>
												<fmt:formatDate value="${coupon.expireDate}"
													pattern="yyyy-MM-dd" />
												까지
												<fmt:formatNumber value="${coupon.minOrderPrice}"
													pattern="#,##0" />
												원 이상 결제 시
											</p>
											<button type="button"
												onclick="location.href='${pageContext.request.contextPath}/reservation/list?cpage=1'">사용하기</button>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<div class="couponBox">
										<strong>보유 중인 쿠폰이 없습니다.</strong>
										<p>사용할 수 있는 쿠폰이 없습니다.</p>
										<button type="button"
											onclick="location.href='${pageContext.request.contextPath}/coupon/myCoupon'">쿠폰함
											보기</button>
									</div>
								</c:otherwise>
							</c:choose>
						</div>

					</div>
				</div>
				<jsp:include page="/WEB-INF/views/common/footer.jsp" />
			</div>
		</c:when>

		<c:otherwise>
			<script>location.href="${pageContext.request.contextPath}/members/loginpage";</script>
		</c:otherwise>

	</c:choose>

	<script>
	
	document.querySelectorAll(".wishlistTab button").forEach(function(button) {
	    button.addEventListener("click", function() {
	        const url = new URL(window.location.href);
	        url.searchParams.set("wishType", this.dataset.type);
	        url.searchParams.set("wishCpage", "1");
	        url.hash = "wishlistSection";
	        window.location.href = url.toString();
	    });
	});
	
		$(document).ready(function() {
		
		    // 예약 탭 클릭
		    $(".reservationVar .tab").on("click", function() {
		        const selectedTab = $(this).attr("data-tab");
		        const url = new URL(window.location.href);
		        url.searchParams.set("reservationTab", selectedTab);
		        url.searchParams.set("cpage", "1");
		        window.location.href = url.pathname + url.search + "#reservationSection";
		    });
		
		    // 예약 취소 버튼
		    $(".cancelBtn").on("click", async function() {
		        if (!confirm("이 결제를 취소할까요?")) return;
		        let paymentId = $(this).data("payment-id");
		        try {
		            const res = await fetch("${pageContext.request.contextPath}/reservation/cancelMyReservation", {
		                method: "POST",
		                headers: {
		                    "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
		                    "Accept": "text/plain; charset=UTF-8"
		                },
		                body: "paymentId=" + encodeURIComponent(paymentId)
		            });
		            const text = await res.text();
		            console.log("취소 응답:", text);
		            if (res.ok && text.trim() === "success") {
		                alert("결제와 예약이 취소되었으며, 사용 마일리지를 복구했습니다.");
		                location.reload();
		            } else {
		                alert("취소 처리 결과: " + text);
		            }
		        } catch (error) {
		            console.error("요청 실패:", error);
		            alert("취소 요청 중 오류가 발생했습니다.");
		        }
		    });
		
		    // 예약 변경 버튼
		    $(".updateBtn").on("click", function() {
		        let paymentId = $(this).data("payment-id");
		        let checkIn = $(this).data("checkin");
		
		        if (!paymentId) {
		            alert("예약 정보를 찾을 수 없습니다.");
		            return;
		        }
		
		        const today = new Date().toISOString().slice(0, 10);
		        if (checkIn === today) {
		            alert("바로결제 후 취소 아니면, 체크인 당일에는 예약 변경이 불가합니다.");
		            return;
		        }
		
		        location.href = "${pageContext.request.contextPath}/reservation/reservationUpdate?paymentId=" + encodeURIComponent(paymentId);
		    });
		
		    // 카드 앞면 (상세 보기)
		    $(".detailBtn").on("click", function() {
		        $(this).closest(".flipCard").addClass("flipped");
		    });
		
		    // 카드 뒷면 (뒤로)
		    $(".backBtn").on("click", function() {
		        $(this).closest(".flipCard").removeClass("flipped");
		    });
		
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
		        url: "${pageContext.request.contextPath}/review/toggleRecommend",
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
		                count.innerHTML = Number(count.innerHTML) + 1;

		            } else if (result == "unliked") {
		                heart.innerHTML = "♡";
		                heart.classList.remove("liked");

		                let count = document.getElementById("likeCount" + seq);
		                count.innerHTML = Number(count.innerHTML) - 1;
		            }
		        }
		    });
		}
		
</script>
</body>
</html>