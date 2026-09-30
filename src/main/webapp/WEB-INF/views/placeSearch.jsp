<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>추천 여행지</title>
<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: "Pretendard", "Noto Sans KR", "Malgun Gothic", sans-serif;
	color: #222;
	background: #fff;
}

button {
	font-family: inherit;
	font-size: 14px;
}

.wrap {
	width: 100%;
	max-width: 1040px;
	margin: 0 auto;
	padding: 0 16px;
}

.hero {
	text-align: center;
	padding: 48px 0 40px;
	border-bottom: 1px solid #eee;
}

.hero h1 {
	font-size: 28px;
}

.hero p {
	margin: 10px 0 0;
	color: #666;
	font-size: 14px;
}

.filters {
	display: flex;
	align-items: center;
	gap: 8px;
	flex-wrap: wrap;
	margin: 40px 0 16px;
}

.filters .label {
	font-size: 13px;
	color: #555;
	margin-right: 4px;
}

.chip {
	padding: 8px 16px;
	border: 1px solid #222;
	background: #fff;
	cursor: pointer;
}

.chip.active {
	background: #222;
	color: #fff;
}

.chip:focus-visible {
	outline: 2px solid #06c;
	outline-offset: 2px;
}

.count {
	font-size: 13px;
	color: #666;
	margin-bottom: 14px;
}

.grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 24px;
}

.card {
	border: 1px solid #222;
	display: flex;
	flex-direction: column;
}

.thumb {
	position: relative;
	aspect-ratio: 4/3;
	border-bottom: 1px solid #222;
	background: #f3f3f3;
	overflow: hidden;
}

.thumb img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

.thumb.empty {
	background: linear-gradient(to top right, transparent calc(50% - .5px),
		#bbb, transparent calc(50% + .5px)),
		linear-gradient(to top left, transparent calc(50% - .5px), #bbb,
		transparent calc(50% + .5px));
}

.tag {
	position: absolute;
	top: 10px;
	left: 10px;
	padding: 3px 8px;
	border: 1px solid #222;
	background: #fff;
	font-size: 12px;
}

.info {
	padding: 16px 16px 18px;
}

.info .region {
	font-size: 12px;
	color: #777;
}

.info h3 {
	font-size: 17px;
	margin-top: 6px;
}

.empty-msg {
	text-align: center;
	padding: 80px 0;
	color: #777;
}

.paging {
	display: flex;
	justify-content: center;
	gap: 6px;
	margin: 40px 0 60px;
}

.paging button {
	min-width: 32px;
	height: 32px;
	border: 1px solid #222;
	background: #fff;
	cursor: pointer;
}

.paging button.active {
	background: #222;
	color: #fff;
}

.paging button:disabled {
	opacity: .35;
	cursor: default;
}

@media ( max-width : 800px) {
	.grid {
		grid-template-columns: repeat(2, 1fr);
		gap: 16px;
	}
}

@media ( max-width : 520px) {
	.grid {
		grid-template-columns: 1fr;
	}
}
</style>
</head>
<body>

	<section class="hero">
		<div class="wrap">
			<h1>${keyword} 여행지</h1>
			<p>관광지, 맛집, 숙박업소를 모아봤어요.</p>
		</div>
	</section>

	<main class="wrap">
		<div class="filters">
			<span class="label">유형</span>
			<button type="button" class="chip active" data-type="전체">전체</button>
			<button type="button" class="chip" data-type="관광지">관광지</button>
			<button type="button" class="chip" data-type="맛집">맛집</button>
			<button type="button" class="chip" data-type="숙박업소">숙박업소</button>
		</div>

		<div class="count" id="count"></div>
		
		<div class="grid" id="grid">
			<c:forEach var="place" items="${list}">
				<article class="card" data-type="${place.place_Type}">
				<div class="thumb">
					<c:if test="${not empty place.imageName}">
					<img src="${place.imageName}" alt="${place.name}">
					</c:if>
					<span class="tag"></span>
				</div>
				<div class="info">
				<div class="region">
					${place.region} ${place.sigungu}
				</div>
					<h3>
						${place.name}
					</h3>
				</div>
				</article>
			</c:forEach>
		</div>
		
		<div class="empty-msg"
			id="emptyMsg"
			style="display: none;">
			
			검색 결과가 없어요.
			다른 지역명으로 검색하세요.
			
		</div>
		
		<div class="paging" id="paging">
		</div>
		<script>
	
		function getType(type) {
			if(type == "SPOT") {
				return "관광지";
			}
			
			if(type == "FOOD") {
				return "맛집";
			}
			
			if(type == "STAY") {
				return "숙박업소";
			}
			return type;
		}
		
		let chips = document.getElementsByClassName("chip");
		let cards = document.getElementsByClassName("card")
		let emptyMsg = document.getElementById("emptyMsg");
		
		for(let i = 0; i < chips.length; i++) {
			chips[i].onclick = function() {
				for(let j=0; j < chips.length; j++) {
					chips[j].classList.remove("active");
				}
				
				this.classList.add("active");
				
				let type = this.getAttribute("data-type");
				let count = 0;
				
				for(let j=0; j<cards.length; j++) {
					
					let cardType = getType(cards[j].getAttribute("data-type"));
					
					if(type == "전체" || type == cardType) {
						cards[j].style.display = "";
						count ++
					} else {
						cards[j].style.display = "none";
					}
				}
				if(count == 0) {
					emptyMsg.style.display = "block";
				} else {
					emptyMsg.style.display = "none";
				}
			} 
		
		}
		
		let recordTotalCount = ${recordTotalCount};
		let recordCountPerPage = ${recordCountPerPage};
		let naviCountPerPage = ${naviCountPerPage};
		let currentPage = ${cpage};
		
		let pageTotalCount = Math.ceil(recordTotalCount / recordCountPerPage);
		
		let startNavi = Math.floor((currentPage-1) / naviCountPerPage)
						* naviCountPerPage + 1;
		
		let endNavi = startNavi + naviCountPerPage - 1;
		
		if (endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}
		
		let needPrev = startNavi > 1;
		let needNext = endNavi < pageTotalCount;
		
		let navigation = document.getElementById("paging");
		
		if (needPrev) {
			let prev = document.createElement("a");
			
			prev.setAttribute("href", "/place/search?keyword=${keyword}&cpage=" + (startNavi -1));
			
			prev.innerHTML = "<";
			
			navigation.append(prev);
		}
		
		for (let i = startNavi; i <= endNavi; i++) {
			
			let num = document.createElement("a");
			
			num.setAttribute("href", "/place/search?keyword=${keyword}&cpage=" + i);
			
			num.innerHTML = i;
			
			navigation.append(num);
			
		}
		
		if (needNext) {
			
			let next = document.createElement("a");
			
			next.setAttribute("href", "/place/search?keyword=${keyword}&cpage=" + (endNavi + 1));
			
			next.innerHTML = ">";
			
			navigation.append(next);
		}
	</script>
</body>
</html>
