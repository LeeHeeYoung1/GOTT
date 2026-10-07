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

<title>GOTT 메인화면</title>
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
            width: 1200px;
            height: 70px;
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
            width: 120px;
            height: 70px;
            margin-left: 0px;
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

        .icon {
            margin-left: 10px;
            font-size: 20px;
        }
        .icon:hover {
            cursor: pointer;
        }
        .icon:active {
            
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
            <a href="/"><img src="/images/logo.png" alt="GOTT 로고"></a>
        </div>
        <div class="navi flex-between">
            <div class="textzone"><a href=""></a>뭐 넣지?</div>
            <div class="textzone"><a href="">지역</a></div>
            <div class="textzone"><a href="">추천여행지</a></div>
            <div class="textzone"><a href="/reservation/list?cpage=1">숙박업소</a></div>
            <div class="textzone"><a href="/members/planner">여행플래너</a></div>
            <div class="textzone"><a href="/board/freeBoard">게시판</a></div>
            <div class="textzone"><a href="">문의사항</a></div>
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
		            <div class="icon"><i class="fa-solid fa-bars"></i></div>
		        </div>
	        </c:otherwise>
		</c:choose>
    </div>

</div>