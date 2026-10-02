<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GOTT 결제 테스트</title>

<!-- 포트원 V2 브라우저 SDK -->
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>

<style>
    body {
        margin: 0;
        font-family: 'Segoe UI', 'Malgun Gothic', sans-serif;
        background-color: #f8fafa;
    }

    .box {
        width: 420px;
        margin: 80px auto;
        padding: 32px;
        border: 1px solid #333;
        background-color: white;
        text-align: center;
    }

    .box h2 {
        margin: 0 0 8px;
    }

    .box p {
        margin: 4px 0;
        font-size: 14px;
        color: #555;
    }

    .price {
        margin: 20px 0;
        font-size: 28px;
        font-weight: 700;
    }

    #payBtn,
    #cancelBtn {
        width: 100%;
        height: 48px;
        border: none;
        color: white;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
    }

    #payBtn {
        background-color: #222;
    }

    /* 결제가 끝난 뒤에만 보이는 취소 버튼 */
    #cancelBtn {
        display: none;
        margin-top: 10px;
        background-color: #dc2626;
    }

    #payBtn:disabled,
    #cancelBtn:disabled {
        background-color: #999;
        cursor: default;
    }

    #result {
        margin-top: 20px;
        min-height: 20px;
        font-size: 14px;
        word-break: break-all;
    }
</style>
</head>

<body>

<div class="box">
    <h2>결제 테스트</h2>
    <p>제주 오션뷰 호텔 1박</p>
    <div class="price">1,000원</div>

    <button id="payBtn" type="button">결제하기</button>
    <button id="cancelBtn" type="button">결제 취소</button>

    <div id="result"></div>
</div>

<script>

    // ★ 여기 두 개만 본인 값으로 바꾸세요 (포트원 콘솔에서 확인)
    const STORE_ID    = "store-d4a75cb3-13cc-4226-b7fc-33d40089bf40";
    const CHANNEL_KEY = "channel-key-6b882be9-c6c2-4429-a3ba-2a04d40b1f0a";

    // 서버(PaymentController)에도 같은 금액이 들어 있어야 검증이 통과해요
    const AMOUNT = 1000;

    const payBtn    = document.getElementById("payBtn");
    const cancelBtn = document.getElementById("cancelBtn");
    const result    = document.getElementById("result");

    // 방금 결제한 결제번호 (취소할 때 사용)
    let lastPaymentId = null;

    // 서버에 POST로 요청하고 글자 응답을 돌려받는 함수
    async function postToServer(url, paymentId) {
        const res = await fetch(url, {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "paymentId=" + encodeURIComponent(paymentId)
        });
        return await res.text();
    }

    // ---------------- 결제하기 ----------------
    payBtn.addEventListener("click", async function () {

        payBtn.disabled = true;
        cancelBtn.style.display = "none";
        result.style.color = "#222";
        result.textContent = "결제창을 여는 중...";

        // 주문마다 겹치지 않는 결제 번호
        const paymentId = "pay-" + Date.now() + "-" + Math.floor(Math.random() * 100000);

        // 1. 결제창 열기
        const response = await PortOne.requestPayment({
            storeId: STORE_ID,
            channelKey: CHANNEL_KEY,
            paymentId: paymentId,
            orderName: "제주 오션뷰 호텔 1박",
            totalAmount: AMOUNT,
            currency: "KRW",
            payMethod: "CARD"
        });

        // 2. 실패하거나 사용자가 창을 닫은 경우
        if (response.code != null) {
            result.style.color = "red";
            result.textContent = "결제 실패: " + response.message;
            payBtn.disabled = false;
            return;
        }

        // 3. 성공하면 서버에 검증 요청
        result.textContent = "결제 확인 중...";
        const text = await postToServer("/payment/verify", response.paymentId);

        if (text === "OK") {
            lastPaymentId = response.paymentId;
            result.style.color = "green";
            result.textContent = "결제 완료! (결제번호: " + lastPaymentId + ")";
            cancelBtn.style.display = "block";    // 취소 버튼 보이기
        } else {
            result.style.color = "red";
            result.textContent = "검증 실패: " + text;
            payBtn.disabled = false;
        }
    });

    // ---------------- 결제 취소 ----------------
    cancelBtn.addEventListener("click", async function () {

        if (!lastPaymentId) return;
        if (!confirm("방금 한 결제를 취소할까요?")) return;

        cancelBtn.disabled = true;
        result.style.color = "#222";
        result.textContent = "취소 처리 중...";

        const text = await postToServer("/payment/cancel", lastPaymentId);

        if (text === "OK") {
            result.style.color = "green";
            result.textContent = "결제가 취소되었습니다. (결제번호: " + lastPaymentId + ")";
            lastPaymentId = null;
            cancelBtn.style.display = "none";
            payBtn.disabled = false;             // 다시 결제 테스트 가능
        } else {
            result.style.color = "red";
            result.textContent = text;
        }

        cancelBtn.disabled = false;
    });

</script>

</body>
</html>
