<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
<!DOCTYPE html>

<meta charset="UTF-8">
<title>GOTT 이벤트</title>
<link rel="stylesheet" href="/css/public.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.3.1/css/all.min.css" integrity="sha512-QeR2VH+lsBE5LSAe1Q5EnTBbe7XTBubt8dG93Y7gidSgdMCr8nVqKcfKAMyN96SV8KDbZVTDXChatu5G2KQGzg==" crossorigin="anonymous" referrerpolicy="no-referrer">
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=ea87fc26ee3f75472cb75c454c18b302"></script>

<style>
  
        body{
            position: relative;
        }
        .header {
            width: 80%;
            height: 70px;
            padding: 0 30px;
            position : fixed;
            top: 0;
            right: 0;
            left: 0;
            margin-bottom: 70px;
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

        .eventcontainer {
            margin-top: 150px;
            width: 100%;
            height: auto;
            border: 1px solid black;
        }
        .maineventbox {
            width: 90%;
            border: 1px solid #2563eb;
            margin: auto;
            height: auto;
            position: relative;
        }
        .maineventbox img {
            width: 100%;
            z-index: 1;
            position: absolute;
        }
        .eventText{
            position: absolute;
            z-index: 2;
        }
        .eventzone {
            width: 90%;
            border: 1px solid #2563eb;
            margin: auto;
            height: auto;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 8px;
        }
        .eventbox {
            width: 100%;
            height: auto;
            border: 1px solid red;
        }

        .eventbox img {
            width: 100%;
            height: 100%;
            z-index: 0;
            display: block;
            border-radius: 8px;
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

    <div class="eventcontainer">
        <div class="maineventbox">
            <img src="background.jpg" alt="mianbanner">
            <div class="eventText">
                <h1>국내여행</h1>
                <h3>특별한 순간을 만나보세요!</h3>
                <h5>아름다운 우리나라, 여행할 땐 GOTT와 함께</h5>
            </div>
        </div>
        <div class="eventzone">
            <c:forEach var="i" items="${banner}">
                <div class="eventbox">
                    <img src="${i.imageName}" alt="${i.title}">
                    <div class="eventText">
                        <h3>${i.title}</h3>
                        <p>${i.contents}</p>
                        <button>${i.title} 여행 바로가기</button>
                    </div>
                </div>
            </c:forEach>
        </div>
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

    


</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>