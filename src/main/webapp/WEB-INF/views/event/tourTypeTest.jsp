<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.7.1.js"
  integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
  crossorigin="anonymous"></script>
   <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

  <style>
    * {
      box-sizing: border-box;
    }

    body {
      overflow-y: auto;
      margin: 0;
    }

    .container {
      width: 1200px;
      height: auto;
      margin: auto;
    }

    .testBox {
      width: 70%;
      height: 150px;
      margin: 20px auto;
      padding: 20px;
      border: 1px solid black;
    }
    
    h3 {
      text-align : center;
    }

    h4 {
      margin: 0 0 10px 0;
      font-size: 13px;
    }

    .question {
      display: block;
      font-size: 15px;
      font-weight: bold;
      line-height: 1.5;
      margin-left: 93px;
    }

    input {
      margin-top: 30px;
      margin-left: 40px;
    }

    .answers {
      text-align: center;
      margin-top: 1px;
    }

    .btnBox {
     width: 70%;
    height: 100px;
    margin: 0 auto;
    text-align: center;
    }

    #check {
    display: block;
    margin: 30px auto;
    padding: 12px 35px;

    border: none;
    border-radius: 25px;

    background-color: #4A90E2;
    color: white;

    font-size: 16px;
    font-weight: bold;

    cursor: pointer;

    transition: 0.2s;
}

#check:hover {
    background-color: #357ABD;
    transform: translateY(-2px);
}

    #result {
    width: 70%;
    margin: 50px auto;
    display: none;
}

#chartBox {
    width: 700px;
    height: 420px;
    margin: auto;
}
#result>h2{
  text-align: center;
}

#resultText {
    text-align: center;
    margin-top: 30px;
    font-size: 22px;
    font-weight: bold;
}
#saveResult {
    display: block;
    margin: 40px auto;
    padding: 12px 40px;

    border: none;
    border-radius: 25px;

    background-color: #6CC070;
    color: white;

    font-size: 16px;
    font-weight: bold;

    cursor: pointer;

    transition: 0.2s;
}

#saveResult:hover {
    background-color: #4FA653;
    transform: translateY(-2px);
}
p {
  text-align: center;
}
  </style>

</head>

<body>

  <h2 style="text-align: center;">&lt;&lt;여행성향 테스트&gt;&gt;</h2>

  <div class="container">

    <!-- Q1 -->
    <div class="testBox">
      <h4>Q1</h4>
      <span class="question">1. 여행 전 일정을 미리 계획하는 편인가요?</span>
      <div class="answers">
        <input name="answer1" type="radio" value="4">매우그렇다
        <input name="answer1" type="radio" value="3">그렇다
        <input name="answer1" type="radio" value="2">보통이다
        <input name="answer1" type="radio" value="1">그렇지않다
        <input name="answer1" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <!-- Q2 -->
    <div class="testBox">
      <h4>Q2</h4>
      <span class="question">2. 여행지역의 유명관광지를 필수로 방문하는 것을 선호하나요?</span>
      <div class="answers">
        <input name="answer2" type="radio" value="4">매우그렇다
        <input name="answer2" type="radio" value="3">그렇다
        <input name="answer2" type="radio" value="2">보통이다
        <input name="answer2" type="radio" value="1">그렇지않다
        <input name="answer2" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <!-- Q3 -->
    <div class="testBox">
      <h4>Q3</h4>
      <span class="question">3. 유명관광지보다는 새로운 장소나 잘 알려지지 않은 장소를 방문하는 것을 선호하나요?</span>
      <div class="answers">
        <input name="answer3" type="radio" value="4">매우그렇다
        <input name="answer3" type="radio" value="3">그렇다
        <input name="answer3" type="radio" value="2">보통이다
        <input name="answer3" type="radio" value="1">그렇지않다
        <input name="answer3" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <!-- Q4 -->
    <div class="testBox">
      <h4>Q4</h4>
      <span class="question">4. 여행 중 관광보다 충분한 휴식을 더 중요하게 생각하나요?</span>
      <div class="answers">
        <input name="answer4" type="radio" value="4">매우그렇다
        <input name="answer4" type="radio" value="3">그렇다
        <input name="answer4" type="radio" value="2">보통이다
        <input name="answer4" type="radio" value="1">그렇지않다
        <input name="answer4" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <!-- Q5 -->
    <div class="testBox">
      <h4>Q5</h4>
      <span class="question">5. 여행 중 숙소의 편의시설과 인테리어, 분위기를 중요하게 생각하나요?</span>
      <div class="answers">
        <input name="answer5" type="radio" value="4">매우그렇다
        <input name="answer5" type="radio" value="3">그렇다
        <input name="answer5" type="radio" value="2">보통이다
        <input name="answer5" type="radio" value="1">그렇지않다
        <input name="answer5" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <!-- Q6 -->
    <div class="testBox">
      <h4>Q6</h4>
      <span class="question">6. 여행 중 여행지의 맛집을 필수로 방문하나요?</span>
      <div class="answers">
        <input name="answer6" type="radio" value="4">매우그렇다
        <input name="answer6" type="radio" value="3">그렇다
        <input name="answer6" type="radio" value="2">보통이다
        <input name="answer6" type="radio" value="1">그렇지않다
        <input name="answer6" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <!-- Q7 -->
    <div class="testBox">
      <h4>Q7</h4>
      <span class="question">7. 여행지의 현지음식을 먹어보는 것을 좋아하나요?</span>
      <div class="answers">
        <input name="answer7" type="radio" value="4">매우그렇다
        <input name="answer7" type="radio" value="3">그렇다
        <input name="answer7" type="radio" value="2">보통이다
        <input name="answer7" type="radio" value="1">그렇지않다
        <input name="answer7" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <!-- Q8 -->
    <div class="testBox">
      <h4>Q8</h4>
      <span class="question">8. 여행지 맛집의 웨이팅이 길더라도 참고 기다리는 편이신가요?</span>
      <div class="answers">
        <input name="answer8" type="radio" value="4">매우그렇다
        <input name="answer8" type="radio" value="3">그렇다
        <input name="answer8" type="radio" value="2">보통이다
        <input name="answer8" type="radio" value="1">그렇지않다
        <input name="answer8" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <!-- Q9 -->
    <div class="testBox">
      <h4>Q9</h4>
      <span class="question">9. 여행지에서 사진이나 영상을 많이 남기는 편인가요?</span>
      <div class="answers">
        <input name="answer9" type="radio" value="4">매우그렇다
        <input name="answer9" type="radio" value="3">그렇다
        <input name="answer9" type="radio" value="2">보통이다
        <input name="answer9" type="radio" value="1">그렇지않다
        <input name="answer9" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <!-- Q10 -->
    <div class="testBox">
      <h4>Q10</h4>
      <span class="question">10. 자연이나 분위기 좋은 장소를 찾아가는 것을 좋아하나요?</span>
      <div class="answers">
        <input name="answer10" type="radio" value="4">매우그렇다
        <input name="answer10" type="radio" value="3">그렇다
        <input name="answer10" type="radio" value="2">보통이다
        <input name="answer10" type="radio" value="1">그렇지않다
        <input name="answer10" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <div class="testBox">
      <h4>Q11</h4>
      <span class="question">11. 여행 중 계획이 바뀌는 것을 별로 선호하지 않나요?</span>
      <div class="answers">
        <input name="answer11" type="radio" value="4">매우그렇다
        <input name="answer11" type="radio" value="3">그렇다
        <input name="answer11" type="radio" value="2">보통이다
        <input name="answer11" type="radio" value="1">그렇지않다
        <input name="answer11" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <div class="testBox">
      <h4>Q12</h4>
      <span class="question">12. 여행 시 관광보다는 액티비티 활동을 더 즐기는 편인가요?</span>
      <div class="answers">
        <input name="answer12" type="radio" value="4">매우그렇다
        <input name="answer12" type="radio" value="3">그렇다
        <input name="answer12" type="radio" value="2">보통이다
        <input name="answer12" type="radio" value="1">그렇지않다
        <input name="answer12" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <div class="testBox">
      <h4>Q13</h4>
      <span class="question">13. 여행 시 쉬지않고 늦은 시간까지 돌아다니는 편인가요?</span>
      <div class="answers">
        <input name="answer13" type="radio" value="4">매우그렇다
        <input name="answer13" type="radio" value="3">그렇다
        <input name="answer13" type="radio" value="2">보통이다
        <input name="answer13" type="radio" value="1">그렇지않다
        <input name="answer13" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <div class="testBox">
      <h4>Q14</h4>
      <span class="question">14. 여행 중 우연히 발견한 호기심있는 장소를 계획이 무너지더라도 가보는 편인가요?</span>
      <div class="answers">
        <input name="answer14" type="radio" value="4">매우그렇다
        <input name="answer14" type="radio" value="3">그렇다
        <input name="answer14" type="radio" value="2">보통이다
        <input name="answer14" type="radio" value="1">그렇지않다
        <input name="answer14" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <div class="testBox">
      <h4>Q15</h4>
      <span class="question">15. 여행지에서 처음 해보는 체험이나 활동에도 적극적으로 참여하는 편인가요?</span>
      <div class="answers">
        <input name="answer15" type="radio" value="4">매우그렇다
        <input name="answer15" type="radio" value="3">그렇다
        <input name="answer15" type="radio" value="2">보통이다
        <input name="answer15" type="radio" value="1">그렇지않다
        <input name="answer15" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <div class="testBox">
      <h4>Q16</h4>
      <span class="question">16. 여행 중 예상하지 못한 문제가 생겼을 때 직접 해결 방법을 찾아보는 편인가요?</span>
      <div class="answers">
        <input name="answer16" type="radio" value="4">매우그렇다
        <input name="answer16" type="radio" value="3">그렇다
        <input name="answer16" type="radio" value="2">보통이다
        <input name="answer16" type="radio" value="1">그렇지않다
        <input name="answer16" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <div class="testBox">
      <h4>Q17</h4>
      <span class="question">17. 여행 전에 여행지의 날씨나 계절별 특징을 확인하는 편인가요?</span>
      <div class="answers">
        <input name="answer17" type="radio" value="4">매우그렇다
        <input name="answer17" type="radio" value="3">그렇다
        <input name="answer17" type="radio" value="2">보통이다
        <input name="answer17" type="radio" value="1">그렇지않다
        <input name="answer17" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <div class="testBox">
      <h4>Q18</h4>
      <span class="question">18. 여행 중 현지 사람들과 대화하거나 교류하는 것을 좋아하나요?</span>
      <div class="answers">
        <input name="answer18" type="radio" value="4">매우그렇다
        <input name="answer18" type="radio" value="3">그렇다
        <input name="answer18" type="radio" value="2">보통이다
        <input name="answer18" type="radio" value="1">그렇지않다
        <input name="answer18" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <div class="testBox">
      <h4>Q19</h4>
      <span class="question">19. 여행 중 혼자만의 시간을 보내는 것도 즐거운 편인가요?</span>
      <div class="answers">
        <input name="answer19" type="radio" value="4">매우그렇다
        <input name="answer19" type="radio" value="3">그렇다
        <input name="answer19" type="radio" value="2">보통이다
        <input name="answer19" type="radio" value="1">그렇지않다
        <input name="answer19" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <div class="testBox">
      <h4>Q20</h4>
      <span class="question">20. 여행 중 스파, 온천, 마사지처럼 몸과 마음을 편안하게 해주는 활동을 즐기나요?</span>
      <div class="answers">
        <input name="answer20" type="radio" value="4">매우그렇다
        <input name="answer20" type="radio" value="3">그렇다
        <input name="answer20" type="radio" value="2">보통이다
        <input name="answer20" type="radio" value="1">그렇지않다
        <input name="answer20" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <div class="testBox">
      <h4>Q21</h4>
      <span class="question">21. 여행지에서 특별한 순간을 기념하기 위해 사진 외에 기념품이나 소품을 남기는 편인가요?</span>
      <div class="answers">
        <input name="answer21" type="radio" value="4">매우그렇다
        <input name="answer21" type="radio" value="3">그렇다
        <input name="answer21" type="radio" value="2">보통이다
        <input name="answer21" type="radio" value="1">그렇지않다
        <input name="answer21" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <div class="testBox">
      <h4>Q22</h4>
      <span class="question">22. 여행지에서 음악이나 소리를 들으며 여행 분위기를 즐기는 것을 좋아하나요?</span>
      <div class="answers">
        <input name="answer22" type="radio" value="4">매우그렇다
        <input name="answer22" type="radio" value="3">그렇다
        <input name="answer22" type="radio" value="2">보통이다
        <input name="answer22" type="radio" value="1">그렇지않다
        <input name="answer22" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <div class="testBox">
      <h4>Q23</h4>
      <span class="question">23. 여행을 가면 하루에 여러 종류의 음식을 맛보는 것을 좋아하나요?</span>
      <div class="answers">
        <input name="answer23" type="radio" value="4">매우그렇다
        <input name="answer23" type="radio" value="3">그렇다
        <input name="answer23" type="radio" value="2">보통이다
        <input name="answer23" type="radio" value="1">그렇지않다
        <input name="answer23" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <div class="testBox">
      <h4>Q24</h4>
      <span class="question">24. 여행 중 체력적으로 힘들더라도 새로운 활동을 끝까지 해보고 싶은 편인가요?</span>
      <div class="answers">
        <input name="answer24" type="radio" value="4">매우그렇다
        <input name="answer24" type="radio" value="3">그렇다
        <input name="answer24" type="radio" value="2">보통이다
        <input name="answer24" type="radio" value="1">그렇지않다
        <input name="answer24" type="radio" value="0">전혀 그렇지않다
      </div>
    </div>

    <div class="btnBox">
      <button id="check">내 결과 확인하기</button>
    </div>
    
    <div id="result">
    <h2>나의 여행 성향</h2>

    <div id="chartBox">
        <canvas id="resultChart"></canvas>
    </div>
    <div id="resultText"></div>
    <div id="typeDescription"></div>
    
    <form id="saveForm" action="/members/tourTypeTestResult" method="post">

    <input type="hidden" id="typeCode" name="type_code">

    <input type="hidden" id="planScore" name="plan_score">
    <input type="hidden" id="exploreScore" name="explore_score">
    <input type="hidden" id="healingScore" name="healing_score">
    <input type="hidden" id="emotionScore" name="emotion_score">
    <input type="hidden" id="foodScore" name="food_score">
    <input type="hidden" id="activityScore" name="activity_score">

    <button type="button" id="saveResult">
        결과 저장하기
    </button>

</form>
    
</div>

  </div>

  <script>
  let chart;

    let type = [
      "계획형",
      "탐험형",
      "탐험형",
      "힐링형",
      "힐링형",
      "미식형",
      "미식형",
      "미식형",
      "감성형",
      "감성형",
      "계획형",
      "액티비티형",
      "액티비티형",
      "탐험형",
      "액티비티형",
      "계획형",
      "계획형",
      "탐험형",
      "힐링형",
      "힐링형",
      "감성형",
      "감성형",
      "미식형",
      "액티비티형"
    ];

    $("#check").on("click", function () {
      let score = {
        "계획형": 0,
        "탐험형": 0,
        "힐링형": 0,
        "감성형": 0,
        "미식형": 0,
        "액티비티형": 0
      };

      let testBox = $(".testBox");
      for (let i = 0; i < testBox.length; i++) {
        let value = $(testBox[i]).find("input:checked").val();

        if (value == undefined) {

          alert((i + 1) + "번 문제를 선택해주세요.");

          return;
        }
        score[type[i]] += Number(value);
      }
     
    $("#result").show();
    
    $("html, body").animate({
    scrollTop: $("#result").offset().top
    }, 500);

   
    if(chart != null) {
        chart.destroy();
    }

    let ctx = document.getElementById("resultChart");

     chart = new Chart(ctx, {

        type: "bar",

        data: {

            labels: [
                "계획형",
                "탐험형",
                "힐링형",
                "감성형",
                "미식형",
                "액티비티형"
            ],

            datasets: [{

                label: "여행 성향 점수",

                data: [
                    score["계획형"],
                    score["탐험형"],
                    score["힐링형"],
                    score["감성형"],
                    score["미식형"],
                    score["액티비티형"]
                ]

            }]

        },

        options: {

            responsive: true,

            maintainAspectRatio: false,

            scales: {

                y: {

                    beginAtZero: true,

                    max: 16,

                    ticks: {
                        stepSize: 2
                    }

                }

            }

        }

    });
    
     let result = [];

     for(let typeName in score) {

         result.push({
             name : typeName,
             score : score[typeName]
         });

     }

     result.sort(function(a,b) {
         return b.score - a.score;
     });

     let first = result[0].score;

     let resultText = "";

     for(let i = 0; i < result.length; i++) {

         if(result[i].score == first) {

             if(resultText != "") {
                 resultText += ", ";
             }

             resultText += result[i].name;
         }
     }

    $("#resultText").html("당신의 여행성향은 " + resultText + "입니다.<br><br>");
	
    $("#typeCode").val(resultText);

    $("#planScore").val(score["계획형"]);
    $("#exploreScore").val(score["탐험형"]);
    $("#healingScore").val(score["힐링형"]);
    $("#emotionScore").val(score["감성형"]);
    $("#foodScore").val(score["미식형"]);
    $("#activityScore").val(score["액티비티형"]);
    
   let description = "";

if(resultText.includes("계획형")) {
    description += 
        "<h3>계획형 여행자</h3>" +
        "<p>여행을 떠나기 전부터 전체 일정을 꼼꼼하게 준비하는 당신!</p>" +
        "<p>여행지에서 어디를 방문할지, 어떤 음식을 먹을지 미리 찾아보는 것을 좋아합니다.</p>" +
        "<p>숙소와 교통편도 미리 확인해두어 여행 중 예상하지 못한 상황을 줄이려고 하는 편입니다.</p>" +
        "<p>정해진 일정에 맞춰 하나씩 계획을 실천해 나갈 때 여행의 만족도가 높아집니다.</p>" +
        "<p>시간을 효율적으로 사용하는 것을 중요하게 생각하기 때문에 여행 전에 동선을 확인하는 것도 좋아합니다.</p>" +
        "<p>물론 여행 중 갑작스러운 일정 변경이 생기면 조금 당황할 수도 있습니다.</p>" +
        "<p>하지만 꼼꼼한 준비 덕분에 안정적이고 만족스러운 여행을 만들어가는 타입입니다.</p><br>"; 
}

if(resultText.includes("탐험형")) {
    description += 
        "<h3>탐험형 여행자</h3>" +
        "<p>새로운 장소와 특별한 경험을 찾아 떠나는 것을 좋아하는 당신!</p>" +
        "<p>이미 알고 있는 관광지를 방문하는 것보다 처음 가보는 장소를 발견하는 과정에서 즐거움을 느낍니다.</p>" +
        "<p>유명한 관광지뿐만 아니라 사람들이 잘 모르는 숨은 명소를 찾아다니는 것도 좋아합니다.</p>" +
        "<p>여행 중 우연히 발견한 골목이나 새로운 장소도 흥미로운 여행의 일부라고 생각합니다.</p>" +
        "<p>계획에 없던 장소라도 재미있어 보인다면 과감하게 일정을 바꿀 수 있는 편입니다.</p>" +
        "<p>새로운 문화와 풍경을 직접 경험하면서 여행지에 대해 알아가는 것을 좋아합니다.</p>" +
        "<p>매번 다른 장소를 방문하며 새로운 추억을 만들어가는 것이 당신에게는 여행의 큰 즐거움입니다.</p><br>"; 
}

if(resultText.includes("힐링형")) {
    description += 
        "<h3>힐링형 여행자</h3>" +
        "<p>바쁜 일상에서 벗어나 몸과 마음을 편안하게 쉬게 하는 여행을 좋아하는 당신!</p>" +
        "<p>짧은 시간 동안 많은 장소를 방문하기보다는 한곳에서 여유롭게 시간을 보내는 것을 선호합니다.</p>" +
        "<p>조용한 숙소나 자연 속에서 휴식을 취하며 여행의 여유를 느끼는 편입니다.</p>" +
        "<p>아침에 천천히 일어나 맛있는 식사를 하고 주변을 산책하는 여행도 잘 어울립니다.</p>" +
        "<p>여행 일정이 너무 빡빡하면 오히려 피곤함을 느낄 수 있기 때문에 적당한 여유를 중요하게 생각합니다.</p>" +
        "<p>아름다운 자연이나 편안한 카페처럼 마음이 편안해지는 장소를 찾아가는 것을 좋아합니다.</p>" +
        "<p>여행을 통해 새로운 자극을 받기보다는 일상에서 쌓인 피로를 내려놓고 재충전하는 타입입니다.</p><br>"; 
}

if(resultText.includes("감성형")) {
    description += 
        "<h3>감성형 여행자</h3>" +
        "<p>여행지에서 특별한 분위기와 순간을 기억하는 것을 중요하게 생각하는 당신!</p>" +
        "<p>유명한 관광지를 방문하는 것뿐만 아니라 그 장소만의 분위기와 감성을 느끼는 것을 좋아합니다.</p>" +
        "<p>아름다운 풍경이나 노을, 조명, 음악처럼 여행의 분위기를 만들어주는 요소에도 관심이 많습니다.</p>" +
        "<p>마음에 드는 장소를 발견하면 사진을 찍거나 기록으로 남겨두는 것도 좋아하는 편입니다.</p>" +
        "<p>조용하고 분위기 좋은 카페나 감성적인 거리를 찾아다니는 여행도 잘 어울립니다.</p>" +
        "<p>여행에서 무엇을 얼마나 많이 했는지보다 그 순간 어떤 기분을 느꼈는지를 중요하게 생각합니다.</p>" +
        "<p>시간이 지난 뒤에도 다시 떠올릴 수 있는 특별한 장면과 추억을 만들어가는 타입입니다.</p><br>"; 
}

if(resultText.includes("미식형")) {
    description += 
        "<h3>미식형 여행자</h3>" +
        "<p>여행에서 빠질 수 없는 즐거움은 바로 맛있는 음식이라고 생각하는 당신!</p>" +
        "<p>여행지를 정할 때 맛집이나 대표 음식이 무엇인지 먼저 찾아보는 경우가 많습니다.</p>" +
        "<p>유명한 맛집뿐만 아니라 현지에서만 맛볼 수 있는 특별한 음식에도 관심이 많습니다.</p>" +
        "<p>새로운 음식을 발견하고 직접 맛보는 과정 자체를 여행의 중요한 즐거움으로 생각합니다.</p>" +
        "<p>하루 일정에 여러 맛집이나 카페를 찾아가는 것도 마다하지 않는 편입니다.</p>" +
        "<p>음식의 맛뿐만 아니라 그 지역의 음식 문화와 특색을 경험하는 것도 좋아합니다.</p>" +
        "<p>맛있는 음식과 함께 즐거운 추억을 쌓으며 여행지를 기억하는 미식 중심의 여행자입니다.</p><br>"; 
}

if(resultText.includes("액티비티형")) {
    description += 
        "<h3>액티비티형 여행자</h3>" +
        "<p>가만히 쉬기보다는 직접 움직이며 다양한 경험을 하는 것을 좋아하는 당신!</p>" +
        "<p>여행을 떠나면 새로운 체험이나 액티비티를 하나쯤 꼭 해보고 싶어 합니다.</p>" +
        "<p>등산, 수상 스포츠, 자전거, 테마파크 등 몸을 움직이는 활동을 즐기는 편입니다.</p>" +
        "<p>평소에 해보지 않았던 새로운 활동이라도 재미있어 보인다면 적극적으로 도전합니다.</p>" +
        "<p>여행 중 조금 힘들더라도 직접 경험하고 나면 오히려 뿌듯함을 느낄 수 있습니다.</p>" +
        "<p>친구나 가족과 함께 다양한 활동을 하면서 특별한 추억을 만드는 것도 좋아합니다.</p>" +
        "<p>새로운 도전과 짜릿한 경험을 통해 여행의 즐거움을 찾는 활동적인 여행자입니다.</p><br>"; 
}

$("#typeDescription").html(description);

});
    
    $("#saveResult").on("click", function() {

        $("#saveForm").submit();

    });

</script>

</body>
</html>
