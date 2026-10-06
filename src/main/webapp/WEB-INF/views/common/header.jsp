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
  
        body{
            position: relative;
            padding-top: 70px;
        }
        .header {
            width: 100%;
            height: 70px;
            padding: 0 30px;
            position : fixed;
            top: 0;
            right: 0;
            left: 0;
            z-index: 100;
            
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
            <a href="/"><img src="/images/logo.png" alt="GOTT 로고"></a>
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
		       	 	<div class="textbox">${nickname}님이요</div>
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
</div>