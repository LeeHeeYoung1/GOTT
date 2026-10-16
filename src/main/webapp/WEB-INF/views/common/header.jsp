<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/public.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.3.1/css/all.min.css" integrity="sha512-QeR2VH+lsBE5LSAe1Q5EnTBbe7XTBubt8dG93Y7gidSgdMCr8nVqKcfKAMyN96SV8KDbZVTDXChatu5G2KQGzg==" crossorigin="anonymous" referrerpolicy="no-referrer">

<title>GOTT</title>
<script
  src="https://code.jquery.com/jquery-3.7.1.js"
  integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
  crossorigin="anonymous"></script>
  <style>
  
  		html {
		    scroll-behavior: smooth;
		}
  
        body{
            position: relative;
            padding-top: 70px;
        }
        .header {
            width: 100%;
            height: 100px;
            background-color: rgba(255, 255, 255, 0.95);
            position : fixed;
            top: 0;
		    left: 50%;
		    transform: translateX(-50%);
   			box-shadow: 0 2px 12px rgba(15, 23, 42, 0.08);
		    backdrop-filter: blur(8px);	
            z-index: 100;
        }
        
        .logobox {
        	position : fixed;
            width: 220px;
            height: 110px;
            margin-left: 0px;
            top:-5px;
            z-index:150;
            left:70px;
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
            font-size: 20px;
            font-weight: bold;
            cursor: pointer;
        }

        .textzone:hover {
            color: #2563eb;
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 8px;
            padding-right: 10px;
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

        i {
            margin-left: 10px;
            font-size: 20px;
        }
        i:hover {
            cursor: pointer;
        }
        i:active {
        	transform: scale(0.9);
        }
        
        .sidemenu {
            width: 200px;
            height: 400px;
            position: fixed;
            right:80px;
            top: 150px;
            background-color: rgba(255, 255, 255, 0.7);
            
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            
            box-shadow: -5px 0 20px rgba(0, 0, 0, 0.2);
            z-index: 50;
            opacity: 0;
            visibility: hidden;
    		transition: opacity 0.3s ease, visibility 0.3s ease;
        }
        
        .sidemenu.open {
		    opacity: 1;
    		visibility: visible;
		}
        
        .sidemenu-title {
            width: 100%;
            height: 15%;
            display: flex;
		    justify-content: center;
		    align-items: center;
		    border-bottom: 1px solid #e5e7eb;
        }
        
        .sidemenu-main {
            width: 100%;
		    height: 75%;
		    box-sizing: border-box;
		    display: flex;
		    flex-direction: column;
		    justify-content: center;
		    gap: 8px;
		    padding: 0 15px;
        }
        .sidemenu-main p {
		    width: 100%;
		    margin: 0;
		}
		.sidemenu-main p a {
		    display: flex;
		    align-items: center;
		    justify-content: flex-start;
		    width: 100%;
		    box-sizing: border-box;
		    padding: 12px 10px;
		    border-radius: 7px;
		    color: #374151;
		    text-decoration: none;
		    font-size: 14px;
		    transition: background-color 0.2s, color 0.2s;
		}
        .sidemenu-main p a{
            display: flex;
		    justify-content: center;
		    align-items: center;
        }
        .sidemenu-main p a:hover {
            background-color: #f1f5f9;
            color: #2563eb;
        }
        .sidemenu-footer {
		    width: 100%;
		    height: 10%;
		    box-sizing: border-box;
		    display: flex;
		    align-items: center;
		    justify-content: space-between;
		    gap: 8px;
		    padding: 0 15px;
		    border-top: 1px solid #e5e7eb;
		}
		.sidemenu-footer span a {
		    color: #6b7280;
		    font-size: 12px;
		    text-decoration: none;
		    white-space: nowrap;
		}
        .sidemenu-footer span a:hover {
            color: #2563eb;
        }
        
        
        hr {
            margin: 25px 0px;
            border: none;
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
<div class="logobox">
            <a href="/"><img src="/images/logo.png" alt="GOTT 로고"></a>
        </div>
<div class="container">
   <div class="header flex-between">
	 <div class="navi flex-between">
            <div class="textzone" style="margin-left:140px;"><a href="/members/tourTypeTest">여행성향 테스트</a></div>
            <div class="textzone"><a href="/place/mappage">지역</a></div>
            <div class="textzone"><a href="${pageContext.request.contextPath}/place/search?keyword=&type=전체&cpage=1">여행지</a></div>
            <div class="textzone"><a href="/reservation/list?cpage=1">숙박업소</a></div>
            <div class="textzone"><a href="/members/planner">여행플래너</a></div>
            <div class="textzone"><a href="/board/freeBoard?cpage=1">게시판</a></div>
            <div class="textzone"><a href="/notice/qna?cpage=1">문의사항</a></div>
            <c:if test="${loginId == 'admin0001'}"><div class="textzone"><a href="/dashBoard/dashHome">대시보드</a></div></c:if>
        </div>
        <c:choose>
	        <c:when test="${loginId != null}">
		        <div class="user-menu">

		       	 	<div class="textbox">${nickname}님</div>
		            <div class="menubtn"><i class="fa-solid fa-bars"></i></div>
		        </div>
		        <div class="sidemenu" id="sidemenu">
		            <div class="sidemenu-title flex-center">
		                <h2>메뉴</h2>
		            </div>
		            <div class="sidemenu-main">
		            	<p><a href="/">메인 화면</a></p>
		                <p><a href="/members/mypage">마이페이지</a></p>
		                <p><a href="/members/wishlist">내 찜 목록</a></p>
		                <p><a href="/review/reviewlist">내 리뷰 목록</a></p>
		                <p><a href="/board/boardlist">내 게시글 목록</a></p>
		                
		            </div>
		            <div class="sidemenu-footer flex-between">
		                <span><a href="/members/logout">로그아웃</a></span>
		                <span><a href="/members/deleted">회원탈퇴</a></span>
		            </div>
		        </div>
	        </c:when>
	        <c:otherwise>
	        	<div class="user-menu">
	        		<div class="textbox"><a href="/members/loginpage">로그인</a></div>
		        </div>
		        
	        </c:otherwise>
		</c:choose>
		
		
        
    </div>
    	
</div>