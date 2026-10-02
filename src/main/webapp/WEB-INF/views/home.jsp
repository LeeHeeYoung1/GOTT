<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/public.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.3.1/css/all.min.css" integrity="sha512-QeR2VH+lsBE5LSAe1Q5EnTBbe7XTBubt8dG93Y7gidSgdMCr8nVqKcfKAMyN96SV8KDbZVTDXChatu5G2KQGzg==" crossorigin="anonymous" referrerpolicy="no-referrer">
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=ea87fc26ee3f75472cb75c454c18b302"></script>

<title>GOTT 메인화면</title>
<script
  src="https://code.jquery.com/jquery-3.7.1.js"
  integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
  crossorigin="anonymous"></script>
  <style>
  
        body{
            position: relative;
        }
        .header {
            width: 100%;
            height: 70px;
            padding: 0 30px;
        }
        
        .searchBox {
			width: 750px;
			height: 60px;
			margin: 40px auto;
			position: relative;
		}
		
		.searchBox input {
			width: 100%;
			height: 100%;
			box-sizing: border-box;
			padding: 0 70px 0 28px;
			border: 1px solid #e2ded9;
			border-radius: 30px;
			background-color: white;
			font-size: 17px;
			color: #444;
			outline: none;
			box-shadow: 0 4px 15px rgba(0, 0, 0, 0.07);
		}
		
		.searchBox input::placeholder {
			color: #aaa;
		}
		
		.searchBox input:focus {
			border-color: #c8b9aa;
			box-shadow: 0 5px 20px rgba(0, 0, 0, 0.10);
		}
		/* 검색 버튼 */
		.searchBtn {
			width: 46px;
			height: 46px;
			position: absolute;
			right: 7px;
			top: 7px;
			border: none;
			border-radius: 50%;
			background-color: #f0ebe5;
			cursor: pointer;
			display: flex;
			justify-content: center;
			align-items: center;
		}
		
		.searchBtn:hover {
			background-color: #e5ddd5;
		} /* 돋보기 */
		.searchIcon {
			width: 14px;
			height: 14px;
			border: 2px solid #6f665f;
			border-radius: 50%;
			position: relative;
		}
		
		.searchIcon::after {
			content: "";
			width: 7px;
			height: 2px;
			background-color: #6f665f;
			position: absolute;
			right: -6px;
			bottom: -3px;
			transform: rotate(45deg);
			border-radius: 2px;
		}

        .logobox {
            width: 120px;
            height: 70px;
            margin-left: 50px;
        }

        .logobox img {
            width: 100%;
            height: 100%;
        }

        .navi {
            width: 50%;
            margin: 0 auto;
        }

        .textzone {
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
        }

        .textzone:hover {
            color: #2563eb;
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .textbox {
            padding: 7px 12px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 13px;
            cursor: pointer;
        }
        .textbox:hover {
            background-color: #f3f4f6;
        }

        .icon {
            margin-left: 10px;
            font-size: 20px;
        }
        .icon:hover {
            cursor: pointer;
        }
        .icon:active {
            
        }
        .title {
            width: 100%;
            height: 80px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8fafc;
        }
        .subtitle,
        .title-link {
            width: 100%;
            height: auto;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8fafc;
        }

        .title h1 {
            font-size: 32px;
            font-weight: 700;
        }
        .subtitle h5 {
            color: #6B7280;
        }
        .eventbannerzone,
        .ourpromise {
            width: 80%;
            height: auto;
            padding: 20px 30px;
            border: 1px solid black;
            margin: auto;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }
        .notice {
            width: 80%;
            height: auto;
            padding: 20px 30px;
            border: 1px solid black;
            margin: auto;
            position: relative;
        }
        .noticetitle {
            width: 80%;
            height: auto;
        }
        .noticewritedate {
            width: 20%;
            height: auto;
        }
        .noticebox {
            width: 100%;
            height: 24px;
        }
        .eventbannerbox,
        .ourpromisebox {
            float: left;
            width: auto;
            height: auto;
            margin: 20px;
        }
        .ourtext {
            border: 1px solid black;
        }

        .mapzone {
            width: 800px;
            height: 800px;
            border: 2px solid black;
            margin: auto;
        }
        .placesuggest,
        .hotelsuggest {
            width: 80%;
            height: auto;
            padding: 20px 30px;
            margin: auto;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .placesuggest .placezone,
        .hotelsuggest .hotelzone {
            width: 90%;
            height: auto;
            padding: 20px 10px 15px 10px;
            margin: auto;
            border: 1px solid black;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            position: relative;
        }
        .moreview {
            position: absolute;
            top: 5px;
            right: 20px;

            font-size: 14px;
            cursor: pointer;
        }

        .placebox,
        .hotelbox {
            float: left;
            width: auto;
            height: auto;
            margin: 10px;
            border: 1px solid black;
        }
        .popularboard {
            width: 80%;
            height: auto;
            padding: 20px 10px 15px 10px;
            border: 1px solid black;
            margin: auto;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }
        
        .popularzone {
            float: left;
            width: auto;
            height: auto;
            margin: 10px;
        }
        .boardwriter {
            width: 100%;
            height: 20px;
            font-weight: 900;
            margin-bottom: 10px;
        }

        .linkbar {
            width: auto;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            overflow: hidden;
            background-color: white;
            position: fixed;
            left: 80px;
            top: 150px;
        }
        .linkbar nav {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .linkbar nav a {
            margin: 2em;
            color: #263238;
        }

        #vertical-underline {
            position: absolute;
            width: 0px;
            background-color: #318de4;
            height: 4px;
            transition: 0.5s;
        }

        .linkbarmain {
            width: 100%;
            min-height: 180px;
            padding: 15px;
            line-height: 2;
        }
        .linkbarmain a:hover {
            cursor: pointer;
            color: #2563eb;
        }

        hr {
            margin: 25px 0px;
            border: none;
            border-top: 1px solid #e5e7eb;
        }

        .footer {
            min-height: 180px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 8px;
            color: #777;
            background-color: #f8fafc;
            font-size: 13px;
        }

        .footer p {
            margin: 0;
        }
        .footer .textbox {
            margin-top: 10px;
            color: #6B7280;
            background-color: #F8FAFA;
        }

    </style>
</head>

<body>

<div class="container">
    <div class="header flex-between">
        <div class="logobox">
            <a href="/"><img src="images/logo.png" alt="GOTT 로고"></a>
        </div>
        <div class="navi flex-between">
            <div class="textzone"><a href="">이벤트</a></div>
            <div class="textzone"><a href="">지역</a></div>
            <div class="textzone"><a href="">추천여행지</a></div>
            <div class="textzone"><a href="/reservation/list">숙박업소</a></div>
            <div class="textzone"><a href="">리뷰</a></div>
            <div class="textzone"><a href="">여행플래너</a></div>
            <div class="textzone"><a href="/board/freeBoard">게시판</a></div>
        </div>
        <c:choose>
	        <c:when test="${loginId != null}">
		        <div class="user-menu">
		       	 	<div class="textbox">${nickname}님</div>
		            <div class="textbox"><a href="/members/logout">로그아웃</a></div>
		            <div class="textbox"><a href="members/mypage">마이페이지</a></div>
		            <div class="icon"><i class="fa-solid fa-bars"></i></div>
		        </div>
	        </c:when>
	        <c:otherwise>
	        	<div class="user-menu">
	        		<div class="textbox"><a href="/members/loginpage">로그인</a></div>
		            <div class="textbox"><a href="/members/signuppage">회원가입</a></div>
		            <div class="icon"><i class="fa-solid fa-bars"></i></div>
		        </div>
	        </c:otherwise>
		</c:choose>
    </div>

    <div id="eventbannerzone" class="title">
        <h1>대한민국 구석구석, 당신의 여행을 찾아보세요</h1>
    </div>
    <form action="/place/search" method="get">
		<div class="searchBox">
			<input type="text" name="keyword" placeholder="어디로 떠나고 싶으신가요?">
			<button type="submit" class="searchBtn">
				<span class="searchIcon"></span>
			</button>
		<div id="searchResult"></div>
		</div>
	</form>
	
    
    <div class="title">
        <h2>진행 중인 이벤트</h2>
    </div>
    <div class="eventbannerzone">
        <div class="moreview"><a href="">더 보기</a></div>
        <div class="eventbannerbox">
            <img src="https://picsum.photos/270/200?random=1">
            <div class="eventtext"></div>
        </div>
        <div class="eventbannerbox">
            <img src="https://picsum.photos/270/200?random=2">
            <div class="eventtext"></div>
        </div>
        <div class="eventbannerbox">
            <img src="https://picsum.photos/270/200?random=3">
            <div class="eventtext"></div>
        </div>
    </div>

    <hr>
    <div id="ourpromise" class="title">
        <h2>우리의 약속</h2>
    </div>
    <div class="subtitle">
        <h5>GOTT가 제공하는 특별한 가치를 경험해보세요.</h5>
    </div>
    <br>
    <div class="ourpromise">
        <div class="moreview"><a href="">더 보기</a></div>
        <div class="ourpromisebox">
            <img src="https://picsum.photos/270/200?random=1">
            <div class="ourtext" style="padding: 5px;">
                <p style="font-weight: bold;">체계적인 시스템</p>
                <p>효율적인 예약 및 정보 관리로 편의성을 제공합니다.</p>
                <button>자세히 보기</button>
            </div>
        </div>
        <div class="ourpromisebox">
            <img src="https://picsum.photos/270/200?random=2">
            <div class="ourtext" style="padding: 5px;">
                <p style="font-weight: bold;">24시간 고객 케어</p>
                <p>24시간 언제든 궁금한 점을 해결해 드립니다.</p>
                <button>자세히 보기</button>
            </div>
        </div>
        <div class="ourpromisebox">
            <img src="https://picsum.photos/270/200?random=3">
            <div class="ourtext" style="padding: 5px;">
                <p style="font-weight: bold;">신뢰할 수 있는 정보</p>
                <p>정확하고 검증된 여행 정보를 제공합니다.</p>
                <button>자세히 보기</button>
            </div>
        </div>
    </div>

    <hr>
    
	<div id="mapzone" class="title">
        <h2>여행지도</h2>
    </div>
    <div class="subtitle">
        <h5>대한민국 지도를 이용해 여행지를 탐색해보세요</h5>
    </div>
    <br>
    <div class="mapzone">
        <div id="map" style="width:100%; height:100%;"></div>
        
    </div>

    <hr>

    <div id="placesuggest" class="title">
        <h2>추천 여행지</h2>
    </div>
    <div class="subtitle">
        <h5>지금 가장인기 있는 국내 여행지를 만나보세요</h5>
    </div>
    <div class="title-link" style="font-size: 10px; color:#2563eb">
        <a href="">찜한 장소로 나만의 여행 일정 만들기</a>
    </div>
   
    <div class="placesuggest">
        <i class="fa-solid fa-circle-chevron-left"></i>
        <div class="placezone">
            <div class="moreview"><a href="">더 보기</a></div>
            <div class="placebox">
                <div class="placephoto"><img src="https://picsum.photos/240/240?random=4"></div>
                <div class="placetext" style="padding: 5px;">
                    <p style="font-weight: bold;">ex 제주도</p>
                    <p>ex 에메랄드 빛 바다</p>
                    <button>자세히 보기</button>
                </div>
            </div>
            <div class="placebox">
                <div class="placephoto"><img src="https://picsum.photos/240/240?random=5"></div>
                <div class="placetext" style="padding: 5px;">
                    <p style="font-weight: bold;">ex 부산</p>
                    <p>ex 도시와 바다</p>
                    <button>자세히 보기</button>
                </div>
            </div>
            <div class="placebox">
                <div class="placephoto"><img src="https://picsum.photos/240/240?random=6"></div>
                <div class="placetext" style="padding: 5px;">
                    <p style="font-weight: bold;">ex 경주</p>
                    <p>ex 천년 고도의 역사</p>
                    <button>자세히 보기</button>
                </div>
            </div>
        </div>
        <i class="fa-solid fa-circle-chevron-right"></i>
    </div>

    <hr>
    
    <div id="hotelsuggest" class="title">
        <h2>숙박업소 추천</h2>
    </div>
    <div class="subtitle">
        <h5>지금 가장인기 있는 숙박업소를 만나보세요</h5>
    </div>
    
    <div class="hotelsuggest">
        <i class="fa-solid fa-circle-chevron-left"></i>
        <div class="hotelzone">
            <div class="moreview"><a href="">더 보기</a></div>
            <div class="hotelbox">
                <div class="hotelphoto"><img src="https://picsum.photos/240/240?random=7"></div>
                <div class="hoteltext" style="padding: 5px;">
                    <p style="font-weight: bold;">ex 호텔</p>
                    <p>ex 편안한 호텔</p>
                    <button>자세히 보기</button>
                </div>
            </div>
            <div class="hotelbox">
                <div class="hotelphoto"><img src="https://picsum.photos/240/240?random=8"></div>
                <div class="hoteltext" style="padding: 5px;">
                    <p style="font-weight: bold;">ex 모텔</p>
                    <p>ex 가성비 모텔</p>
                    <button>자세히 보기</button>
                </div>
            </div>
            <div class="hotelbox">
                <div class="hotelphoto"><img src="https://picsum.photos/240/240?random=9"></div>
                <div class="hoteltext" style="padding: 5px;">
                    <p style="font-weight: bold;">ex 민박</p>
                    <p>ex 감성의 민박</p>
                    <button>자세히 보기</button>
                </div>
            </div>
        </div>
        <i class="fa-solid fa-circle-chevron-right"></i>
    </div>

    <hr>

    <div id="popularboard" class="title">
        <h2>인기 게시글</h2>
    </div>
    <div class="subtitle">
        <h5>다른 여행자들이 공유하는 생생한 여행 후기를 확인해보세요</h5>
    </div>

    <div class="popularboard">
        <div class="moreview"><a href="">더 보기</a></div>
        <div class="popularzone">
            <div class="boardwriter">writer</div>
            <div class="popularphoto"><img src="https://picsum.photos/290/360?random=11"></div>
            <div class="boardtext" style="padding: 5px;">
                <p style="font-weight: bold;">writer</p>
                <p>contents</p>
            </div>
        </div>
        <div class="popularzone">
            <div class="boardwriter">writer</div>
            <div class="popularphoto"><img src="https://picsum.photos/290/360?random=12"></div>
            <div class="boardtext" style="padding: 5px;">
                <p style="font-weight: bold;">writer</p>
                <p>contents</p>
            </div>
        </div>
        <div class="popularzone">
            <div class="boardwriter">writer</div>
            <div class="popularphoto"><img src="https://picsum.photos/290/360?random=13"></div>
            <div class="boardtext" style="padding: 5px;">
                <p style="font-weight: bold;">writer</p>
                <p>contents</p>
            </div>
        </div>
    </div>

    <hr>

    <div id="notice" class="title">
        <h2>공지사항</h2>
    </div>
    
    <div class="notice">
        <div class="moreview"><a href="">더 보기</a></div>
        <%-- 
                <div class="noticebox">
                    <div class="noticetitle" style="float: left;">사이트 점검 안내</div>
                    <div class="noticewritedate" style="float: left;">날짜</div>
                </div>
 --%>
    </div>


    <div class="linkbar">
        <nav>
            <div id="vertical-underline"></div>
            <h2 style="margin-top: 10px;">MENU</h2>
            <a href="#eventbannerzone">이벤트</a>
            <a href="#ourpromise">우리의 약속</a>
            <a href="#mapzone">여행지도</a>
            <a href="#placesuggest">여행지 추천</a>
            <a href="#hotelsuggest">숙박업소 추천</a>
            <a href="#popularboard">인기 게시글</a>
            <a href="#notice">공지사항</a>
        </nav>
    </div>
    

    <hr>
    <div class="footer">
        <p>AAAAAAAAAAAAAAAAAAAAAAAAAAAAA</p>
        <p>회사명 : GOTT | 대표 : ??? | 사업자등록번호 : 123-45-67890</p>
        <p>이용약관 | 개인정보처리방침 | 고객센터</p>
        <div class="textbox">사이트로고</div>
    </div>
</div>

<script>

	var container = document.getElementById('map');
	var options = {
		center: new kakao.maps.LatLng(33.450701, 126.570667),
		level: 3
	};
	
	var map = new kakao.maps.Map(container, options);

    let verticalunderline = document.getElementById("vertical-underline");
    let verticalmenus = document.querySelectorAll("nav:first-child a");
    
    verticalmenus.forEach(menu=>menu.addEventListener("click", (e)=>createunderline(e)))
    function createunderline(e) {
        verticalunderline.style.left = e.currentTarget.offsetLeft + "px";
        verticalunderline.style.width = e.currentTarget.offsetWidth + "px";
        verticalunderline.style.top = e.currentTarget.offsetTop + 
                                        e.currentTarget.offsetHeight + "px";

    }

$("#searchInput").on("keyup", function () {

        let keyword = $(this).val();

        if(keyword == "") {
            $("#searchResult").empty();
            return;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/place/keyword",
            type: "get",
            data: {
                keyword: keyword
            },

            success: function(result) {
	
            	 console.log(result);
            	    console.log(result.length);
            	
                $("#searchResult").empty();

                for(let i = 0; i < result.length && i <10; i++) {

                    let div = $("<div>");

                    div.addClass("searchItem");

                    div.text(result[i]);

                    div.on("click", function() {

                        $("#searchInput").val(result[i]);

                        $("#searchResult").empty();
                    });

                    $("#searchResult").append(div);
                }
            },

            error: function() {
                console.log("연관검색어 검색 실패");
            }
        });
    });

</script>

</body>
</html>