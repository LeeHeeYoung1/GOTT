<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
<style>
* {
	box-sizing: border-box;
}

body {
	margin: 0;
	padding: 0;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	font-size: 16px;
	color: #263238;
	background-color: #f8fafa;
	line-height: 1.5;
}

.dashContainer {
	width: 1200px;
	max-width: calc(100% - 40px);
	margin: 40px auto 80px;
}

/* ===== 머리말 ===== */
.dashHeader {
	margin-bottom: 32px;
	text-align: center;
}

.dashHeader h2 {
	margin: 0 0 10px;
	font-size: 27px;
	font-weight: 700;
	letter-spacing: -0.4px;
	color: #263238;
}

.dashHeader .description {
	margin: 0;
	color: #64748b;
	font-size: 14px;
}

/* ===== 상단 요약 카드 ===== */
.dataBox {
	display: grid;
	grid-template-columns: repeat(4, minmax(0, 1fr));
	gap: 16px;
	margin-bottom: 24px;
}

.dataCard {
	display: flex;
	flex-direction: column;
	justify-content: center;
	gap: 6px;
	min-height: 110px;
	padding: 22px 20px;
	background: #fff;
	border: 1px solid #e2e8f0;
	border-radius: 14px;
	box-shadow: 0 4px 14px rgba(38, 50, 56, .04);
	transition: transform .2s, box-shadow .2s;
}

.dataCard:hover {
	transform: translateY(-3px);
	box-shadow: 0 8px 22px rgba(38, 50, 56, .1);
}

.dataCard p {
	margin: 0;
	color: #0f766e;
	font-size: 16px;
	font-weight: 700;
	text-align: center;
}

.dataCard p+p {
	margin-top: 2px;
	color: #64748b;
	font-size: 13px;
	font-weight: 500;
}

/* ===== 차트 ===== */
.chartBox {
	display: grid;
	grid-template-columns: 1.6fr 1fr;
	gap: 20px;
	margin-bottom: 20px;
}

.panel {
	padding: 22px 24px;
	background: #fff;
	border: 1px solid #e2e8f0;
	border-radius: 14px;
	box-shadow: 0 4px 14px rgba(38, 50, 56, .04);
}

.panel h3 {
	margin: 0 0 18px;
	padding-bottom: 12px;
	border-bottom: 1px solid #f1f5f9;
	font-size: 16px;
	font-weight: 700;
	color: #263238;
}

.panel canvas {
	width: 100% !important;
	height: 320px !important;
}

/* ===== TOP 5 ===== */
.rankBox {
	display: grid;
	grid-template-columns: repeat(2, minmax(0, 1fr));
	gap: 20px;
}

.popularStay, .popularPlan {
	min-height: 240px;
	padding: 22px 24px;
	background: #fff;
	border: 1px solid #e2e8f0;
	border-radius: 14px;
	box-shadow: 0 4px 14px rgba(38, 50, 56, .04);
}

.popularStay h3, .popularPlan h3 {
	margin: 0 0 6px;
	padding-bottom: 12px;
	border-bottom: 1px solid #f1f5f9;
	font-size: 16px;
	font-weight: 700;
	color: #263238;
}

/* 인기 숙소 한 줄: 순위 | 사진 | 이름 */
/*                              | 주소 */
.topFiveStay {
	display: grid;
	grid-template-columns: 34px 64px minmax(0, 1fr);
	grid-template-rows: auto auto;
	align-items: center;
	column-gap: 12px;
	padding: 12px 2px;
	border-bottom: 1px solid #f1f5f9;
}

.topFiveStay:last-child {
	border-bottom: none;
}

.stayRank {
	grid-column: 1;
	grid-row: 1 / 3;
	margin: 0;
	color: #0f766e;
	font-size: 13px;
	font-weight: 700;
	text-align: center;
	white-space: nowrap;
}

.topFiveStay img {
	grid-column: 2;
	grid-row: 1 / 3;
	width: 64px;
	height: 64px;
	object-fit: cover;
	border-radius: 10px;
	background: #f1f5f9;
}

.topFiveStay p:not(.stayRank) {
	grid-column: 3;
	margin: 0;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}

.topFiveStay p:nth-of-type(2) {
	grid-row: 1;
	align-self: end;
	color: #263238;
	font-size: 14px;
	font-weight: 700;
}

.topFiveStay p:nth-of-type(3) {
	grid-row: 2;
	align-self: start;
	color: #94a3b8;
	font-size: 12px;
	font-weight: 400;
}

.popularStay ul, .popularPlan ul {
	list-style: none;
	margin: 0;
	padding: 0;
}

.popularStay li, .popularPlan li {
	display: flex;
	align-items: center;
	gap: 12px;
	padding: 11px 2px;
	border-bottom: 1px solid #f1f5f9;
	font-size: 14px;
	color: #334155;
}

.popularStay li:last-child, .popularPlan li:last-child {
	border-bottom: none;
}

.rankNo {
	flex: 0 0 24px;
	width: 24px;
	height: 24px;
	display: flex;
	align-items: center;
	justify-content: center;
	border-radius: 50%;
	background: #e9f7f4;
	color: #0f766e;
	font-size: 12px;
	font-weight: 700;
}

.rankName {
	flex: 1;
	min-width: 0;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}

.rankCount {
	flex-shrink: 0;
	color: #0f766e;
	font-size: 13px;
	font-weight: 700;
}

.emptyRank {
	padding: 40px 10px;
	color: #94a3b8;
	font-size: 13px;
	text-align: center;
}
</style>
</head>
<body>
	<div class="dashContainer">
		<div class="dashHeader">
			<h2>GOTT 통계 대시보드</h2>
			<p class="description">예약, 매출, 인기 콘텐츠 현황을 한눈에 확인하세요.</p>
		</div>
		<div class="dataBox">
			<div class="dataCard">
				<p>총 회원 수 : ${totalMembers}명</p>
			</div>
			<div class="dataCard">
				<p>총 예약 건수 : ${totalReservation} 건</p>
				<p>예약 취소 : ${cancelReservation} 건</p>
				<p>
					취소율 :
					<fmt:formatNumber value="${cancelRatio}" pattern="0.0" />
					%
				</p>
			</div>
			<div class="dataCard">
				<p>
					총 매출 :
					<fmt:formatNumber value="${totalSales}" pattern="#,##0" />
					원
				</p>
			</div>
			<div class="dataCard">
				<p>작성된 리뷰</p>
				<p>자유게시판 : ${boardCount}개</p>
				<p>리뷰게시판 : ${reviewCount}개</p>
			</div>
		</div>

		<div class="chartBox">
			<div class="panel">
				<h3>월별 매출 추이</h3>
				<canvas id="salesChart" height="110"></canvas>
			</div>
			<div class="panel">
				<h3>지역별 예약 분포</h3>
				<canvas id="regionChart" height="190"></canvas>
			</div>
		</div>

		<div class="rankBox">
			<div class="popularStay">
				<h3>인기 숙소 TOP 5</h3>
				<c:forEach var="i" items="${topFiveStay}" varStatus="st">
					<div class="topFiveStay">
						<p class="stayRank">${st.count} 위</p>
						<img src="${i.image_name}">
						<p>${i.name}
						<p>${i.address}</p>
					</div>
				</c:forEach>
			</div>
			<div class="popularPlan">
				<h3>인기 여행 일정 TOP 5</h3>

			</div>
		</div>
	</div>

</body>

<script>
let monthlySales = [];
<c:forEach var="i" items="${monthlySales}">
monthlySales.push(${i});
</c:forEach>

// labels 배열 길이만큼 막대를 그린다
let salesLabels = [];
let now = new Date();
for (let k = 2; k >= 0; k--) {
	let d = new Date(now.getFullYear(), now.getMonth() - k, 1);
	salesLabels.push((d.getMonth() + 1) + "월");
}

// 막대 위에 금액을 찍어주는 기능
const valueLabel = {
	id : "valueLabel",
	afterDatasetsDraw : function(chart) {
		const ctx = chart.ctx;
		chart.data.datasets[0].data.forEach(function(v, idx) {
			const bar = chart.getDatasetMeta(0).data[idx];
			ctx.fillStyle = "#0f766e";
			ctx.font = "bold 12px 'Segoe UI'";
			ctx.textAlign = "center";
			ctx.fillText(v.toLocaleString() + "원", bar.x, bar.y - 10);
		});
	}
};

new Chart(document.getElementById("salesChart"), {
	type : "bar",
	data : {
		labels : salesLabels,
		datasets : [ {
			label : "매출",
			data : monthlySales,
			backgroundColor : "#0f766e",
			hoverBackgroundColor : "#0b5d57",
			borderRadius : 8,
			maxBarThickness : 60
		} ]
	},
	options : {
		maintainAspectRatio : false,
		layout : {
			padding : {
				top : 20
			}
		},
		plugins : {
			legend : {
				display : false
			},
			tooltip : {
				backgroundColor : "#263238",
				padding : 10,
				displayColors : false,
				callbacks : {
					label : function(ctx) {
						return ctx.parsed.y.toLocaleString() + "원";
					}
				}
			}
		},
		scales : {
			x : {
				grid : {
					display : false
				},
				ticks : {
					color : "#64748b",
					font : {
						size : 13,
						weight : "600"
					}
				},
				border : {
					color : "#e2e8f0"
				}
			},
			y : {
				beginAtZero : true,
				grid : {
					color : "#f1f5f9"
				},
				border : {
					display : false
				},
				ticks : {
					color : "#94a3b8",
					font : {
						size : 11
					},
					callback : function(v) {
						return (v / 10000) + "만";
					}
				}
			}
		}
	},
	plugins : [ valueLabel ]
});

let regions = [];
<c:forEach var="i" items="${regions}">
regions.push("${i}");
</c:forEach>

let regionLabels = [];
let regionCounts = [];

for(let i = 0; i < regions.length; i++){
	let region = regions[i];
	let position = regionLabels.indexOf(region);
	
	if(position === -1){
		regionLabels.push(region);
		regionCounts.push(1);
	}else{
		regionCounts[position] = regionCounts[position] + 1;
	}
}
new Chart(document.getElementById("regionChart"), {
	type : "doughnut",
	data : {
		labels : regionLabels,
		datasets : [ {
			data : regionCounts,
			backgroundColor : [ "#0f766e", "#2563eb", "#f59e0b", "#ef4444",
					"#8b5cf6", "#14b8a6", "#64748b" ],
			borderWidth : 0
		} ]
	},
	options : {
		maintainAspectRatio : false,
		plugins : {
			legend : {
				position : "bottom",
				labels : {
					boxWidth : 12,
					padding : 14
				}
			}
		}
	}
});
</script>
</html>