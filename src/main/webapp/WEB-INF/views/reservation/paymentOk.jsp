<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GOTT 결제 완료</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
<style>
    body {
        margin: 0;
        font-family: 'Segoe UI', 'Malgun Gothic', sans-serif;
        background-color: #f8fafa;
    }

    .box {
        width: 460px;
        margin: 80px auto;
        padding: 36px 32px;
        border: 1px solid #333;
        background-color: white;
        text-align: center;
    }

    .check {
        width: 56px;
        height: 56px;
        margin: 0 auto 16px;
        border-radius: 50%;
        background-color: #16a34a;
        color: white;
        font-size: 30px;
        line-height: 56px;
    }

    .box h2 {
        margin: 0 0 6px;
    }

    .box .sub {
        margin: 0 0 24px;
        font-size: 13px;
        color: #777;
    }

    /* 결제 정보 표 */
    .info {
        margin-bottom: 24px;
        border-top: 1px solid #333;
        text-align: left;
    }

    .info div {
        display: flex;
        justify-content: space-between;
        padding: 12px 4px;
        border-bottom: 1px solid #eee;
        font-size: 14px;
    }

    .info span {
        color: #777;
    }

    .info b {
        max-width: 260px;
        text-align: right;
        word-break: break-all;
    }

    .btns {
        display: flex;
        gap: 8px;
    }

    .btns button {
        flex: 1;
        height: 44px;
        border: 1px solid #333;
        background-color: white;
        font-size: 14px;
        cursor: pointer;
    }

    .btns .main {
        background-color: #222;
        color: white;
    }

    #msg {
        margin-top: 14px;
        min-height: 18px;
        font-size: 13px;
        color: red;
    }
</style>
</head>

<body>

<div class="box">

    <div class="check">✓</div>
    <h2>결제가 완료되었습니다</h2>
    <p class="sub">아래 내용으로 결제가 정상 처리되었어요.</p>

    <!-- 이 값들은 주소창이 아니라 서버가 포트원에서 확인한 값이에요 -->
    <div class="info">
        <div><span>상품명</span><b>${orderName}</b></div>
        <div><span>결제금액</span><b><fmt:formatNumber value="${total}" pattern="#,###"/>원</b></div>
        <div><span>결제번호</span><b>${paymentId}</b></div>
    </div>

    <div class="btns">
        <button type="button" id="cancelBtn">결제 취소</button>
        <button type="button" class="main" onclick="location.href='/members/mypage'">마이페이지로</button>
    </div>

    <div id="msg"></div>

</div>

<script>

$("#cancelBtn").on("click", async function () {

    if (!confirm("이 결제를 취소할까요?")) return;

    try {
        const res = await fetch("/reservation/cancel", {
            method: "POST",
            headers: { 
                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
            },
            body: "paymentId=" + encodeURIComponent("${paymentId}")
        });
        
        // ← charset 지정해서 읽기
        const text = await res.text();
        
        console.log("취소 응답:", text);
        console.log("응답 길이:", text.length);

        if (text.trim() === "OK") {
            alert("결제가 취소되었습니다.");
            location.href = "/reservation/list";
        } else {
            // 에러 메시지 표시
            document.getElementById("msg").textContent = text;
            console.error("취소 실패:", text);
        }
    } catch (error) {
        console.error("요청 실패:", error);
        alert("취소 요청 중 오류가 발생했습니다.");
    }
});
</script>

</body>
</html>
