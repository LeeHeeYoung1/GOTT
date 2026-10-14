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
        /* 관리자 버튼 영역 */
		.adminzone {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    gap: 12px;
		    margin: 35px auto 25px;
		}
		.adminzone button {
		    min-width: 125px;
		    padding: 13px 22px;
		    border: none;
		    border-radius: 10px;
		    font-size: 14px;
		    font-weight: 600;
		    letter-spacing: -0.3px;
		    cursor: pointer;
		    transition: all 0.25s ease;
		}
		
		/* 이벤트 추가 버튼 */
		#addEvent {
		    background-color: #263746;
		    color: #fff;
		    box-shadow: 0 4px 12px rgba(38, 55, 70, 0.15);
		}
		
		#addEvent:hover {
		    background-color: #344b60;
		    transform: translateY(-2px);
		    box-shadow: 0 7px 16px rgba(38, 55, 70, 0.22);
		}
		
		/* 이벤트 삭제 버튼 */
		#delEvent {
		    background-color: #fff;
		    color: #e05252;
		    border: 1px solid #e5bcbc;
		}
		
		#delEvent:hover {
		    background-color: #fff3f3;
		    border-color: #e05252;
		    transform: translateY(-2px);
		}
		
		/* 이벤트 삭제 모드의 X 버튼 */
		.eventDeleteX {
		    display: none;
		    position: absolute;
		    top: 10px;
		    right: 10px;
		    width: 32px;
		    height: 32px;
		    border: none;
		    border-radius: 50%;
		    background-color: #e53935;
		    color: white;
		    font-size: 20px;
		    font-weight: bold;
		    cursor: pointer;
		    z-index: 10;
		    align-items: center;
		    justify-content: center;
		    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
		}
		
		/* 삭제 모드일 때만 X 표시 */
		.eventbox.deleteMode .eventDeleteX {
		    display: flex;
		}
		
		/* 삭제 모드에서 이벤트 카드 강조 */
		.eventbox.deleteMode {
		    outline: 2px solid #e53935;
		    outline-offset: -2px;
		}
		
		/* 이벤트 등록 카드 */
		#eventForm {
		    width: 90%;
		    max-width: 520px;
		    box-sizing: border-box;
		    margin: 30px auto 20px;
		    padding: 32px;
		    background-color: #fff;
		    border: 1px solid #e5eaf0;
		    border-radius: 18px;
		    box-shadow: 0 10px 35px rgba(31, 45, 61, 0.08);
		    animation: eventFormAppear 0.3s ease;
		}
		
		/* 등록 폼 제목 */
		#eventForm h3 {
		    margin: 0 0 26px;
		    padding-bottom: 18px;
		    border-bottom: 1px solid #edf0f4;
		    color: #263746;
		    font-size: 22px;
		    font-weight: 700;
		}
		
		/* 입력 항목을 세로로 배치 */
		#eventForm label {
		    display: block;
		    margin: 18px 0 8px;
		    color: #374151;
		    font-size: 14px;
		    font-weight: 600;
		}
		
		/* 입력창 */
		#eventForm input {
		    display: block;
		    width: 100%;
		    height: 46px;
		    box-sizing: border-box;
		    padding: 0 13px;
		    border: 1px solid #dce2e9;
		    border-radius: 9px;
		    background-color: #f9fafb;
		    color: #263238;
		    font-size: 14px;
		    outline: none;
		    transition: all 0.2s ease;
		}
		
		/* 입력창 클릭 시 */
		#eventForm input:focus {
		    border-color: #526b82;
		    background-color: #fff;
		    box-shadow: 0 0 0 3px rgba(82, 107, 130, 0.12);
		}
		
		/* 입력창 안내 문구 */
		#eventForm input::placeholder {
		    color: #9ca3af;
		    font-size: 13px;
		}
		
		/* 폼 하단 버튼 영역 */
		#eventForm form {
		    display: flex;
		    flex-wrap: wrap;
		    gap: 10px;
		}
		
		#eventForm form label {
		    width: 100%;
		}
		
		/* 등록 / 취소 버튼 공통 */
		#eventForm form button {
		    flex: 1;
		    min-width: 100px;
		    height: 45px;
		    margin-top: 24px;
		    border: none;
		    border-radius: 9px;
		    font-size: 14px;
		    font-weight: 600;
		    cursor: pointer;
		    transition: all 0.2s ease;
		}
		
		/* 등록 버튼 */
		#eventForm form button[type="submit"] {
		    background-color: #263746;
		    color: #fff;
		}
		
		#eventForm form button[type="submit"]:hover {
		    background-color: #344b60;
		    transform: translateY(-1px);
		}
		
		/* 취소 버튼 */
		#eventForm form button[type="button"] {
		    background-color: #f1f3f5;
		    color: #4b5563;
		}
		
		#eventForm form button[type="button"]:hover {
		    background-color: #e5e7eb;
		}
		
		/* 폼 등장 애니메이션 */
		@keyframes eventFormAppear {
		    from {
		        opacity: 0;
		        transform: translateY(10px);
		    }
		
		    to {
		        opacity: 1;
		        transform: translateY(0);
		    }
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
				<a href="/reservation/list?cpage=1"> 
					<img src="/images/First_reservation.png"alt="First_reservation">
				</a>
        </div>
        
        
        <div class="eventzone">
		    <c:forEach var="i" items="${banner}">
		        <div class="eventbox">
		
		            <a href="<c:out value='${i.link_url}'/>">
		                <img src="/images/<c:out value='${i.image_name}'/>"
		                     alt="<c:out value='${i.title}'/>">
		            </a>
		
		            <c:if test="${loginId == 'admin0001'}">
		                <button type="button" class="eventDeleteX" data-banner-id="${i.banner_id}" title="이벤트 삭제">X</button>
		            </c:if>
		
		        </div>
		    </c:forEach>
		</div>
        
        <c:if test="${loginId == 'admin0001'}">
			<div class="adminzone">
				<button type="button" id="addEvent">이벤트 추가</button>
				<button type="button" id="delEvent">이벤트 삭제</button>
			</div>
			
		    <div id="eventForm" style="display: none;">
		        <h3>이벤트 추가</h3>
		
		        <form action="/event/insert" method="post">
		            <label for="title">이벤트 제목</label>
		            <input type="text" id="title" name="title" required>
		
		            <label for="imageName">이미지 파일명</label>
		            <input type="text" id="imageName" name="image_name" placeholder="예: Coupon2.png" required>
		
		            <label for="linkUrl">클릭 시 이동할 URL</label>
		            <input type="text" id="linkUrl" name="link_url" placeholder="/reservation/list?cpage=1" required>
		
		            <button type="submit">등록</button>
		            <button type="button" id="cancelEvent">취소</button>
		        </form>
		    </div>
    
		</c:if>
		
    </div>
    
</div>

<script>

		const addEvent = document.getElementById("addEvent");
		const eventForm = document.getElementById("eventForm");
		const cancelEvent = document.getElementById("cancelEvent");
		const delEvent = document.getElementById("delEvent");
		
		// 이벤트 등록 폼 열기
		if (addEvent && eventForm) {
		    addEvent.addEventListener("click", function() {
		        eventForm.style.display = "block";
		    });
		}
		
		// 이벤트 등록 폼 닫기
		if (cancelEvent && eventForm) {
		    cancelEvent.addEventListener("click", function() {
		        eventForm.style.display = "none";
		    });
		}
		
		// 삭제 모드 켜기 / 끄기
		if (delEvent) {
		    delEvent.addEventListener("click", function() {
		        const eventBoxes = document.querySelectorAll(
		            ".eventzone .eventbox"
		        );
		
		        const isDeleteMode = delEvent.dataset.mode !== "delete";
		
		        eventBoxes.forEach(function(box) {
		            box.classList.toggle("deleteMode", isDeleteMode);
		        });
		
		        delEvent.dataset.mode = isDeleteMode ? "delete" : "normal";
		        delEvent.textContent = isDeleteMode
		            ? "삭제 모드 종료"
		            : "이벤트 삭제";
		    });
		}
		
		// 개별 이벤트의 X 버튼 클릭
		document.querySelectorAll(".eventDeleteX").forEach(function(button) {
		    button.addEventListener("click", function() {
		        const bannerId = this.dataset.bannerId;
		
		        if (!confirm("이 이벤트를 삭제하시겠습니까?")) {
		            return;
		        }
		
		        const form = document.createElement("form");
		        form.method = "post";
		        form.action =
		            "${pageContext.request.contextPath}/event/delete";
		
		        const input = document.createElement("input");
		        input.type = "hidden";
		        input.name = "bannerId";
		        input.value = bannerId;
		
		        form.appendChild(input);
		        document.body.appendChild(form);
		        form.submit();
		    });
		});


</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>