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
            height: auto;
            position: relative;
            overflow: hidden;
            border-radius: 18px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }
        .maineventbox img {
            width: 100%;
    		height: 100%;
    		display: block;
    		object-fit: contain;
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
            height: auto;
            position: relative;
    		overflow: hidden;
    		border-radius: 14px;
    		background-color: #eee;
    		cursor: pointer;
    		box-shadow: 0 5px 18px rgba(0, 0, 0, 0.10);	
        }

        .eventbox img {
            width: 100%;
		    height: 100%;
		    display: block;
		    object-fit: contain;
		    transition: transform 0.4s ease;
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
				<a href="/"> 
					<img src="/images/First_reservation.png"alt="First_reservation">
				</a>
        </div>
        <div class="eventzone">
            
	            <div class="eventbox">
	           		<a href="/reservation/list?cpage=1">
	                  	<img src="/images/Coupon1.png" alt="Coupon1">
	                </a>
	           </div>
	           <div class="eventbox">
	           		<a href="/reservation/list?cpage=1">
	                  	<img src="/images/Coupon2.png" alt="Coupon2">
	                </a>
	           </div>
	           <div class="eventbox">
	           		<a href="/board/freeBoard?cpage=1">
	                  	<img src="/images/Review_coupon.png" alt="Review_coupon">
	                </a>
	           </div>
	           <div class="eventbox">
	           		<a href="/members/tourTypeTest">
	                  	<img src="/images/Travel_type_test.png" alt="Travel_type_test">
	                </a>
	           </div>
	           <div class="eventbox">
	           		<a href="/members/signuppage">
	                  	<img src="/images/Welcome_coupon.jpg" alt="Welcome_coupon">
	                </a>
	           </div>
         
             
        </div>
    </div>
    
</div>

<script>


</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>