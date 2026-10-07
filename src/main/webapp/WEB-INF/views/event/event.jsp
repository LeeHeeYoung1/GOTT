<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
<!DOCTYPE html>

<meta charset="UTF-8">
<title>GOTT 이벤트</title>
<link rel="stylesheet" href="/css/public.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.3.1/css/all.min.css" integrity="sha512-QeR2VH+lsBE5LSAe1Q5EnTBbe7XTBubt8dG93Y7gidSgdMCr8nVqKcfKAMyN96SV8KDbZVTDXChatu5G2KQGzg==" crossorigin="anonymous" referrerpolicy="no-referrer">

<style>
  
        .eventcontainer {
            margin-top: 80px;
            width: 100%;
            height: auto;
            padding-top: 30px;
            padding-bottom: 60px;
            border: 1px solid black;
        }
        .title {
            width: 100%;
            height: 80px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8fafc;
            padding-top: 40px;
        }
        .subtitle {
            width: 100%;
            height: auto;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8fafc;
        }

        .title h2 {
            font-size: 32px;
            font-weight: 700;
        }
        .subtitle h5 {
            color: #6B7280;
        }
        
        .maineventbox {
            width: 90%;
            max-width: 1200px;
            border: 1px solid blue;
            margin: 0 auto;
            height: 450px;
            position: relative;
            overflow: hidden;
            border-radius: 18px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }
        .maineventbox img {
            width: 100%;
    		height: 100%;
    		display: block;
    		object-fit: cover;
        }
        .maineventbox::after {
		    content: "";
		    position: absolute;
		    inset: 0;
		    background: linear-gradient(
		        to top,
		        rgba(0, 0, 0, 0.7),
		        rgba(0, 0, 0, 0.1)
		    );
		}	
		.maineventbox .eventText {
		    position: absolute;
		    left: 50px;
		    bottom: 45px;
		    z-index: 2;
		    color: white;
		}
		.maineventbox .eventText h1 {
		    margin: 0 0 12px;
		    font-size: 42px;
		    font-weight: 700;
		}
		
		.maineventbox .eventText h3 {
		    margin: 0 0 8px;
		    font-size: 22px;
		    font-weight: 500;
		}
		
		.maineventbox .eventText h5 {
		    margin: 0;
		    font-size: 14px;
		    font-weight: 400;
		    opacity: 0.7;
		}
		
        .eventzone {
            width: 90%;
            max-width: 1200px;
            margin: 25px auto 0;
            height: auto;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
        }
        .eventbox {
            height: 280px;
            position: relative;
    		overflow: hidden;
    		border-radius: 14px;
    		background-color: #eee;
    		cursor: pointer;
    		box-shadow: 0 5px 18px rgba(0, 0, 0, 0.10);	
            border: 1px solid red;
        }

        .eventbox img {
            width: 100%;
		    height: 100%;
		    display: block;
		    object-fit: cover;
		    transition: transform 0.4s ease;
        }
		.eventbox::after {
		    content: "";
		    position: absolute;
		    inset: 0;
		    background: linear-gradient
		    ( to top,
		    rgba(0, 0, 0, 0.75),
		    rgba(0, 0, 0, 0.05)
		    );
		}
		.eventbox:hover img {
		    transform: scale(1.05);
		}
		.eventbox .eventText {
		    position: absolute;
		    left: 20px;
		    right: 20px;
		    bottom: 20px;
		    z-index: 2;
		    color: white;
		}
		
		.eventbox .eventText h3 {
		    margin: 0 0 6px;
		    font-size: 20px;
		    font-weight: 600;
		}
		
		.eventbox .eventText p {
		    margin: 0 0 12px;
		    font-size: 12px;
		    opacity: 0.8;
		}
		.eventbox button {
		    padding: 8px 14px;
		    border: none;
		    border-radius: 6px;
		    background-color: white;
		    color: black;
		    font-size: 12px;
		    font-weight: 600;
		    cursor: pointer;
		    transition: 0.2s;
		}
		
		.eventbox button:hover {
		    background-color: #2563eb;
		    color: white;
		}
		
    </style>


<div class="container">

	<div class="title">
        <h2>GOTT 특별 이벤트</h2>
    </div>
    <br>
    <div class="subtitle">
        <h5>여행의 즐거움을 더해줄 GOTT만의 특별한 혜택을 만나보세요.</h5>
    </div>
    
    <div class="eventcontainer">
        <div class="maineventbox">
            <img src="/images/mainbackground1.png" alt="mianbanner">
            <div class="eventText">
                <h1>국내여행</h1>
                <h3>특별한 순간을 만나보세요!</h3>
                <h5>아름다운 우리나라, 여행할 땐 GOTT와 함께</h5>
            </div>
        </div>
        <div class="eventzone">
            <c:forEach var="i" items="${banner}">
               	<div class="eventbox">
                    <img src="$/images/{i.imageName}" alt="${i.title}">
                    <div class="eventText">
                        <h3>${i.title}</h3>
                        <p>${i.contents}</p>
                        <button>${i.title} 여행 바로가기</button>
                	</div>
                </div>
            </c:forEach>
            
            <!-- db에 값 넣으면 삭제 할 코드 -->
            	<div class="eventbox">
                    <img src="$/images/{i.imageName}" alt="경주">
                    <div class="eventText">
                        <h3>경주</h3>
                        <p>천년의 고도 경주로 떠나보세요</p>
                        <button>경주 여행 바로가기</button>
                    </div>
            	</div>
            	
        </div>
    </div>
    
</div>

<script>


</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>