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
* { box-sizing: border-box; }
    body { margin: 0; font-family: 'Segoe UI', 'Malgun Gothic', sans-serif; color: #1f2937; background: #f5f7fa; }
    .box { width: min(520px, calc(100% - 32px)); margin: 64px auto; padding: 40px 36px 32px; border: 1px solid #e5eaf0; border-radius: 20px; background: #fff; box-shadow: 0 12px 36px rgba(15, 23, 42, 0.07); text-align: center; }
    .check { display: flex; align-items: center; justify-content: center; width: 68px; height: 68px; margin: 0 auto 22px; border-radius: 50%; background: #e8f7ef; color: #16a34a; font-size: 36px; font-weight: 700; }
    .box h2 { margin: 0 0 10px; color: #111827; font-size: 25px; font-weight: 750; letter-spacing: -0.8px; }
    .box .sub { margin: 0 0 30px; color: #6b7280; font-size: 14px; line-height: 1.6; }
    .info { margin-bottom: 28px; padding: 8px 18px; border: 1px solid #e8edf3; border-radius: 14px; background: #f9fafb; text-align: left; }
    .info div { display: flex; align-items: flex-start; justify-content: space-between; gap: 18px; padding: 15px 0; border-bottom: 1px solid #e8edf3; font-size: 14px; line-height: 1.5; }
    .info div:last-child { border-bottom: 0; }
    .info span { flex-shrink: 0; color: #6b7280; }
    .info b { max-width: 68%; color: #1f2937; font-weight: 650; text-align: right; overflow-wrap: anywhere; }
    .info div:nth-child(2) b { color: #2563eb; font-size: 17px; font-weight: 750; }
    .btns { display: flex; gap: 10px; }
    .btns button { flex: 1; min-width: 0; min-height: 48px; padding: 12px 10px; border: 1px solid #d8dee8; border-radius: 10px; background: #fff; color: #374151; font-family: inherit; font-size: 14px; font-weight: 650; cursor: pointer; transition: background .2s ease, border-color .2s ease, transform .2s ease; }
    .btns button:hover { background: #f3f6fa; border-color: #aeb9c9; }
    .btns button:active { transform: translateY(1px); }
    .btns .main { border-color: #2563eb; background: #2563eb; color: #fff; }
    .btns .main:hover { border-color: #1d4ed8; background: #1d4ed8; }
    #msg { margin-top: 14px; min-height: 18px; color: #dc2626; font-size: 13px; line-height: 1.5; overflow-wrap: anywhere; }
    @media (max-width: 480px) {
        .box { margin: 24px auto; padding: 30px 20px 24px; border-radius: 16px; }
        .box h2 { font-size: 22px; }
        .info { padding: 6px 14px; }
        .btns { flex-direction: column; }
        .btns button { width: 100%; }
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
