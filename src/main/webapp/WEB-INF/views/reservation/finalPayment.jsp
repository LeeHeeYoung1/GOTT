<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GOTT 최종결제</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
<style>
* {
    box-sizing: border-box;
}
body {
    margin: 0;
    padding: 40px 20px;
    font-family: "Noto Sans KR", sans-serif;
    background: #F1F5F9;
    color: #1E293B;
}
.box {
    width: 100%;
    max-width: 650px;
    margin: 0 auto;
    padding: 35px;
    background: #FFFFFF;
    border: 1px solid #E2E8F0;
    border-radius: 18px;
    box-shadow: 0 8px 30px rgba(15, 23, 42, 0.07);
}
.box > h2 {
    display: flex;
    justify-content: center;
    margin: 0 0 30px;
    padding-bottom: 22px;
    border-bottom: 2px solid #E2E8F0;
    color: #173B6C;
    font-size: 28px;
    font-weight: 800;
}
.box h4 {
    margin: 30px 0 14px;
    color: #173B6C;
    font-size: 19px;
    font-weight: 700;
}
.row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
    padding: 15px 12px;
    border-bottom: 1px solid #E8EEF5;
    font-size: 15px;
}
.row span:first-child {
    color: #64748B;
}
.row span:last-child {
    text-align: right;
    color: #1E293B;
    font-weight: 600;
    overflow-wrap: anywhere;
}
.mileageInputWrap {
    display: flex;
    gap: 8px;
    margin-top: 20px;
}
#mileageInput {
    width: 100%;
    min-width: 0;
    height: 48px;
    padding: 0 14px;
    border: 1px solid #CBD5E1;
    border-radius: 8px;
    outline: none;
    font-size: 15px;
}
#mileageInput:focus {
    border-color: #2563EB;
    box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.12);
}
#btnAll, #btnApply {
    flex-shrink: 0;
    height: 48px;
    padding: 0 18px;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 700;
    cursor: pointer;
}
#btnAll {
    color: #1D4ED8;
    background: #EFF6FF;
    border: 1px solid #BFDBFE;
}
#btnAll:hover {
    background: #DBEAFE;
}
#btnApply {
    color: #FFFFFF;
    background: #2563EB;
    border: 1px solid #2563EB;
}
#btnApply:hover {
    background: #1D4ED8;
}
#mileageHelp {
    min-height: 20px;
    margin-top: 10px;
    color: #DC2626;
    font-size: 13px;
}
.total {
    margin-top: 8px;
    padding: 20px 12px;
    background: #EFF6FF;
    border: none;
    border-radius: 10px;
    font-size: 18px;
    font-weight: 800;
}
.total span:first-child {
    color: #173B6C;
}
.total span:last-child {
    color: #2563EB;
    font-size: 22px;
}
.full {
    display: block;
    width: 100%;
    min-height: 50px;
    margin-top: 14px;
    border-radius: 9px;
    font-size: 16px;
    font-weight: 700;
    cursor: pointer;
    transition: background 0.2s, transform 0.2s;
}
.payment {
    color: #FFFFFF;
    background: #173B6C;
    border: 1px solid #173B6C;
}
.payment:hover {
    background: #102D52;
}
.payment:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}
.payment:active {
    transform: scale(0.99);
}
#cancelBtn {
    color: #475569;
    background: #FFFFFF;
    border: 1px solid #CBD5E1;
}
#cancelBtn:hover {
    background: #F8FAFC;
}
@media (max-width: 600px) {
    body {
        padding: 20px 12px;
    }
    .box {
        padding: 22px 16px;
        border-radius: 13px;
    }
    .box > h2 {
        font-size: 23px;
    }
    .box h4 {
        font-size: 17px;
    }
    .row {
        gap: 10px;
        padding: 13px 5px;
        font-size: 14px;
    }
    .mileageInputWrap {
        flex-wrap: wrap;
    }
    #mileageInput {
        flex: 1 1 100%;
    }
    #btnAll, #btnApply {
        flex: 1;
    }
    .total span:last-child {
        font-size: 19px;
    }
}


.couponSelectWrap{margin-top:15px}
#couponSelect{width:100%;height:48px;padding:0 14px;border:1px solid #CBD5E1;border-radius:8px;background:#fff;color:#1E293B;font-size:14px;outline:none}
#couponSelect:focus{border-color:#2563EB;box-shadow:0 0 0 3px rgba(37,99,235,.12)}
#couponHelp{min-height:20px;margin-top:8px;color:#DC2626;font-size:13px}

</style>
</head>
<body>
<div class="box">
    <h2>GOTT 최종결제</h2>

    <h4>객실 정보</h4>
    <div class="row"><span>객실</span><span>${roomDto.roomName}</span></div>
    <div class="row"><span>체크인</span><span>${checkIn}</span></div>
    <div class="row"><span>체크아웃</span><span>${checkOut}</span></div>
   	<div class="row"><span>인원</span><span>${guest}명</span></div>
   	
   	
    <h4>쿠폰 할인</h4>
    <div class="row">
        <span>보유 쿠폰</span>
        <span>${empty couponList ? 0 : couponList.size()}장</span>
    </div>
    <div class="couponSelectWrap">
        <select id="couponSelect">
            <option value="">쿠폰을 선택해 주세요</option>
            <c:forEach var="coupon" items="${couponList}">
                <option value="${coupon.memberCouponId}"
                    data-type="${coupon.discountType}"
                    data-discount="${coupon.discountValue}"
                    data-min-price="${coupon.minOrderPrice}">
                    <c:out value="${coupon.couponName}"/>
                    (
                    <c:choose>
                        <c:when test="${coupon.discountType eq 'PERCENT'}">${coupon.discountValue}% 할인</c:when>
                        <c:otherwise>${coupon.discountValue}원 할인</c:otherwise>
                    </c:choose>
                    )
                </option>
            </c:forEach>
        </select>
    </div>
    <div id="couponHelp" role="alert"></div>
   	

    <h4>마일리지</h4>
    <div class="row">
        <span>보유 마일리지</span>
        <span id="myMileage" data-mileage="${mileage}"><c:out value="${mileage}"/>P</span>
    </div>

    <div class="mileageInputWrap">
        <input id="mileageInput" type="number" min="0" step="100" placeholder="사용할 마일리지 (100P 단위)">
        <button id="btnAll" type="button">전액</button>
        <button id="btnApply" type="button">적용</button>
    </div>
    <div id="mileageHelp" role="alert"></div>

    <h4>결제 금액</h4>
    <div class="row"><span>객실 금액</span><span id="roomPrice" data-price="${total_price}"></span></div>
    <div class="row"><span>마일리지 사용</span><span id="usedMileage">0P</span></div>
    <div class="row"><span>쿠폰 할인</span> <span id="couponDiscount">0원</span></div>
    <div class="row total"><span>최종 결제 금액</span><span id="finalPrice"></span></div>

	<button class="payment full" type="button">결제하기</button>
    <button id="cancelBtn" class="full" type="button">뒤로가기</button>
</div>

<script>


$(function() {
    const roomPrice = Number($("#roomPrice").data("price")) || 0;
    const myMileage = Number($("#myMileage").data("mileage")) || 0;
    let usedMileage = 0;
    let couponDiscount = 0;

    function formatPrice(price) {
        return price.toLocaleString("ko-KR") + "원";
    }

    function getCouponDiscount() {
        const selected = $("#couponSelect option:selected");

        if (!selected.val()) {
            return 0;
        }

        const type = selected.data("type");
        const discount = Number(selected.data("discount")) || 0;
        const minPrice = Number(selected.data("min-price")) || 0;

        if (roomPrice < minPrice) {
            $("#couponHelp").text(
                "최소 결제 금액 " + formatPrice(minPrice) + " 이상부터 사용할 수 있습니다."
            );
            return 0;
        }

        $("#couponHelp").text("");

        let amount = 0;

        if (type === "PERCENT") {
            amount = Math.floor(roomPrice * discount / 100);
        } else if (type === "FIXED") {
            amount = discount;
        }

        // PortOne 결제 금액이 0원이 되지 않도록 제한
        return Math.max(0, Math.min(amount, Math.max(0, roomPrice - 1)));
    }

    function updatePrice() {
        couponDiscount = getCouponDiscount();

        const priceAfterCoupon = roomPrice - couponDiscount;
        const maxMileage = Math.floor(
            Math.max(0, priceAfterCoupon - 1) / 100
        ) * 100;

        // 쿠폰 변경으로 사용 가능 마일리지를 초과하면 자동 조정
        if (usedMileage > maxMileage) {
            usedMileage = Math.min(
                Math.floor(myMileage / 100) * 100,
                maxMileage
            );
            $("#mileageInput").val(usedMileage);
            $("#mileageHelp").text(
                "쿠폰 적용 금액에 맞춰 마일리지 사용액을 조정했습니다."
            );
        }

        const finalAmount = priceAfterCoupon - usedMileage;

        $("#roomPrice").text(formatPrice(roomPrice));
        $("#couponDiscount").text(formatPrice(couponDiscount));
        $("#usedMileage").text(usedMileage.toLocaleString("ko-KR") + "P");
        $("#finalPrice").text(formatPrice(finalAmount));
    }

    $("#couponSelect").on("change", function() {
        $("#couponHelp").text("");
        updatePrice();
    });

    $("#btnAll").on("click", function() {
        const couponAmount = getCouponDiscount();
        const maxMileage = Math.floor(
            Math.max(0, roomPrice - couponAmount - 1) / 100
        ) * 100;

        const availableMileage = Math.floor(myMileage / 100) * 100;
        const amount = Math.min(availableMileage, maxMileage);

        $("#mileageInput").val(amount);
        $("#mileageHelp").text("");
    });

    $("#btnApply").on("click", function() {
        const inputMileage = Number($("#mileageInput").val());
        const couponAmount = getCouponDiscount();
        const priceAfterCoupon = roomPrice - couponAmount;

        if (!Number.isFinite(inputMileage) || inputMileage < 0) {
            $("#mileageHelp").text("사용할 마일리지를 올바르게 입력해 주세요.");
            return;
        }

        if (!Number.isInteger(inputMileage) || inputMileage % 100 !== 0) {
            $("#mileageHelp").text("마일리지는 100P 단위로 입력해 주세요.");
            return;
        }

        if (inputMileage > myMileage) {
            $("#mileageHelp").text("보유 마일리지를 초과했습니다.");
            return;
        }

        if (inputMileage >= priceAfterCoupon) {
            $("#mileageHelp").text("최종 결제 금액은 0원보다 커야 합니다.");
            return;
        }

        usedMileage = inputMileage;
        $("#mileageHelp").text("");
        updatePrice();
    });

    $(".payment").on("click", async function() {
        updatePrice();

        const finalAmount = roomPrice - couponDiscount - usedMileage;

        if (finalAmount <= 0) {
            $("#mileageHelp").text("최종 결제 금액은 0원보다 커야 합니다.");
            return;
        }

        const paymentButton = this;
        paymentButton.disabled = true;

        try {
        	const paymentId = "GOTT_" + Date.now() + "_"
            + Math.random().toString(36).substring(2, 10);

            const response = await PortOne.requestPayment({
                storeId: "store-d4a75cb3-13cc-4226-b7fc-33d40089bf40",
                channelKey: "channel-key-6b882be9-c6c2-4429-a3ba-2a04d40b1f0a",
                paymentId: paymentId,
                orderName: "${placeOne.name} ${roomDto.roomName}",
                totalAmount: finalAmount,
                currency: "CURRENCY_KRW",
                payMethod: "CARD",
                customer: {
                    fullName: "${name}",
                    phoneNumber: "${phone}",
                    email: "${email}"
                }
            });

            if (response.code != null) {
                alert("결제 실패: " + response.message);
                return;
            }

            const contextPath = "${pageContext.request.contextPath}";
            const selectedCouponId = $("#couponSelect").val();

            let url = contextPath + "/reservation/paymentComplete"
                + "?paymentId=" + encodeURIComponent(paymentId)
                + "&roomId=" + encodeURIComponent("${roomDto.roomId}")
                + "&checkIn=" + encodeURIComponent("${checkIn}")
                + "&checkOut=" + encodeURIComponent("${checkOut}")
                + "&guest=" + encodeURIComponent("${guest}")
                + "&mileage=" + encodeURIComponent(usedMileage);

            if (selectedCouponId) {
                url += "&memberCouponId=" + encodeURIComponent(selectedCouponId);
            }

            location.href = url;
        } catch (error) {
            console.error(error);
            alert("결제 중 오류가 발생했습니다.");
        } finally {
            paymentButton.disabled = false;
        }
    });

    $("#cancelBtn").on("click", function() {
        history.back();
    });

    updatePrice();
});

</script>
</body>
</html>