package com.kedu.controllers;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    // ★ 포트원 콘솔 > 결제연동 > 식별코드 · API Keys 에서 발급한 V2 API Secret
    //   주의: 이 값은 비밀번호예요. GitHub에 올리기 전에 반드시 지우거나 설정 파일로 빼세요.
    private static final String API_SECRET = "1eCHxu85LeGUbtZZ3YDLU1SfgU2aZVuA6qROvuuNFiSuzSWOiRdaqGcoVVoMfbKxxbtNaRPOM6qsxBHH";

    // 테스트용 고정 금액 (test.jsp의 AMOUNT와 같아야 함)
    // 실제 서비스에서는 DB에 저장된 예약 금액으로 비교해야 해요
    private static final int TEST_AMOUNT = 1000;

    private static final String PORTONE_URL = "https://api.portone.io/payments/";

    // 결제 테스트 화면
    @RequestMapping("/test")
    public String testPage() {
        return "payment/test";
    }

    // ---------------------------------------------------------
    // 1. 결제 검증: 포트원 서버에 결제 정보를 직접 물어봐서 확인
    // ---------------------------------------------------------
    @ResponseBody
    @RequestMapping(value = "/verify", method = RequestMethod.POST)
    public String verify(@RequestParam("paymentId") String paymentId) {

        try {
            // 1) 포트원 서버에 결제 단건 조회
            RestTemplate restTemplate = new RestTemplate();

            HttpHeaders headers = new HttpHeaders();
            headers.set("Authorization", "PortOne " + API_SECRET);

            ResponseEntity<Map> response = restTemplate.exchange(
                    PORTONE_URL + paymentId,
                    HttpMethod.GET,
                    new HttpEntity<>(headers),
                    Map.class);

            Map body = response.getBody();

            // 2) 결제 상태와 금액 꺼내기
            String status = (String) body.get("status");
            Map amount = (Map) body.get("amount");
            int total = ((Number) amount.get("total")).intValue();

            // 3) 결제 완료(PAID) + 금액 일치 → 성공
            if ("PAID".equals(status) && total == TEST_AMOUNT) {
                // TODO: 여기서 예약/주문을 DB에 저장
                return "OK";
            }

            // 4) 결제는 됐는데 금액이 다르면 → 자동으로 전액 취소
            if ("PAID".equals(status)) {
                cancelPayment(paymentId, "결제 금액 불일치");
                return "금액이 달라서 자동으로 취소했어요. (결제금액=" + total + ")";
            }

            return "상태=" + status + ", 금액=" + total;

        } catch (Exception e) {
            e.printStackTrace();
            return "서버 오류: " + e.getMessage();
        }
    }

    // ---------------------------------------------------------
    // 2. 결제 취소: 화면의 "결제 취소" 버튼이 호출
    //    주의: 테스트용이라 paymentId만 받아요.
    //    실제 서비스에서는 반드시 "로그인한 본인의 예약인지" DB에서 확인한 뒤 취소해야 해요.
    // ---------------------------------------------------------
    @ResponseBody
    @RequestMapping(value = "/cancel", method = RequestMethod.POST)
    public String cancel(@RequestParam("paymentId") String paymentId) {

        try {
            cancelPayment(paymentId, "고객 요청 (테스트 취소)");
            // TODO: 여기서 DB의 예약 상태를 '취소'로 변경
            return "OK";

        } catch (Exception e) {
            e.printStackTrace();
            return "취소 실패: " + e.getMessage();
        }
    }

    // ---------------------------------------------------------
    // 포트원 결제 취소 API 호출 (전액 취소)
    //   POST https://api.portone.io/payments/{paymentId}/cancel
    //   amount를 안 보내면 전액 취소돼요
    // ---------------------------------------------------------
    private void cancelPayment(String paymentId, String reason) {

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "PortOne " + API_SECRET);
        headers.setContentType(MediaType.APPLICATION_JSON);

        Map<String, String> requestBody = new HashMap<>();
        requestBody.put("reason", reason);

        restTemplate.exchange(
                PORTONE_URL + paymentId + "/cancel",
                HttpMethod.POST,
                new HttpEntity<>(requestBody, headers),
                Map.class);
    }
}