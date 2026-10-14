<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GOTT | 회사소개</title>

<style>
.aboutPage {
    color: #25352f;
    font-family: 'Noto Sans KR', sans-serif;
    padding-bottom: 80px;
}

.aboutPage * {
    box-sizing: border-box;
}

.aboutHero {
    background: linear-gradient(135deg, #183f32, #34765d);
    color: white;
    padding: 100px 20px 95px;
    text-align: center;
}

.heroLabel {
    display: inline-block;
    font-size: 12px;
    letter-spacing: 4px;
    color: #c5e4d2;
    margin-bottom: 25px;
}

.aboutHero h1 {
    font-size: 43px;
    line-height: 1.5;
    font-weight: 700;
    margin: 0 0 20px;
}

.aboutHero p {
    font-size: 16px;
    line-height: 1.9;
    color: #e0eee6;
    margin: 0;
}

.heroLine {
    width: 48px;
    height: 3px;
    background: #b8d9c4;
    margin: 30px auto 0;
}

.aboutInner {
    width: 86%;
    max-width: 1150px;
    margin: 0 auto;
}

.aboutSection {
    padding: 85px 0;
}

.sectionLabel {
    color: #4a876b;
    font-size: 12px;
    font-weight: 700;
    letter-spacing: 3px;
    margin-bottom: 15px;
}

.sectionHeading {
    font-size: 32px;
    line-height: 1.5;
    margin: 0 0 18px;
    color: #25352f;
}

.sectionDescription {
    font-size: 15px;
    color: #777f79;
    line-height: 1.9;
    margin: 0;
}

.promiseSection {
    text-align: center;
}

.promiseCards {
    display: flex;
    gap: 25px;
    margin-top: 45px;
    text-align: left;
}

.promiseCard {
    flex: 1;
    background: #fff;
    border: 1px solid #e8eee9;
    border-radius: 18px;
    padding: 35px 28px;
    box-shadow: 0 8px 25px rgba(33, 67, 50, 0.05);
    transition: transform 0.25s, box-shadow 0.25s;
}

.promiseCard:hover {
    transform: translateY(-6px);
    box-shadow: 0 15px 30px rgba(33, 67, 50, 0.1);
}

.promiseNumber {
    color: #8ab49a;
    font-size: 13px;
    font-weight: 700;
    letter-spacing: 2px;
}

.promiseCard h3 {
    font-size: 19px;
    margin: 23px 0 14px;
    color: #294b3b;
}

.promiseCard p {
    font-size: 14px;
    color: #7a817c;
    line-height: 1.9;
    margin: 0;
    word-break: keep-all;
}

.storySection {
    background: #f3f6f1;
    padding: 75px 0;
}

.storyContent {
    max-width: 780px;
    margin: 0 auto;
    text-align: center;
}

.storyContent h2 {
    font-size: 30px;
    line-height: 1.6;
    margin: 0 0 20px;
}

.storyContent p {
    font-size: 15px;
    line-height: 2;
    color: #6f7972;
    margin: 0;
    word-break: keep-all;
}

.serviceSection {
    text-align: center;
}

.serviceGrid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 18px;
    margin-top: 40px;
}

.serviceItem {
    padding: 28px 15px;
    background: #f7f8f5;
    border-radius: 14px;
}

.serviceItem span {
    display: block;
    color: #659579;
    font-size: 12px;
    letter-spacing: 2px;
    margin-bottom: 15px;
}

.serviceItem h3 {
    font-size: 16px;
    margin: 0 0 10px;
}

.serviceItem p {
    font-size: 13px;
    color: #858b86;
    line-height: 1.8;
    margin: 0;
    word-break: keep-all;
}

.aboutCta {
    background: #234d3b;
    border-radius: 22px;
    padding: 50px 20px;
    text-align: center;
    color: white;
    margin-top: 25px;
}

.aboutCta h2 {
    font-size: 27px;
    margin: 0 0 14px;
}

.aboutCta p {
    color: #d4e4d9;
    font-size: 14px;
    margin: 0 0 28px;
}

.aboutCta a {
    display: inline-block;
    background: #fff;
    color: #28543f;
    padding: 14px 28px;
    border-radius: 30px;
    text-decoration: none;
    font-size: 14px;
    font-weight: 700;
    transition: background 0.2s;
}

.aboutCta a:hover {
    background: #e0eee5;
}

@media (max-width: 768px) {
    .aboutHero {
        padding: 75px 20px;
    }

    .aboutHero h1 {
        font-size: 30px;
    }

    .aboutHero p {
        font-size: 14px;
    }

    .aboutInner {
        width: 90%;
    }

    .aboutSection {
        padding: 60px 0;
    }

    .sectionHeading {
        font-size: 25px;
    }

    .promiseCards {
        flex-direction: column;
    }

    .promiseCard {
        padding: 28px;
    }

    .storyContent h2 {
        font-size: 24px;
    }

    .serviceGrid {
        grid-template-columns: repeat(2, 1fr);
    }

    .aboutCta h2 {
        font-size: 22px;
    }
}
</style>
</head>

<body>

<div class="aboutPage">

    <section class="aboutHero">
        <span class="heroLabel">GO TO TRAVEL</span>
        <h1>여행의 모든 순간을,<br>GOTT와 함께</h1>
        <p>
            일상에서 벗어나 새로운 풍경을 만나는 순간부터<br>
            여행을 추억으로 간직하는 순간까지.
        </p>
        <div class="heroLine"></div>
    </section>

    <section class="aboutSection promiseSection">
        <div class="aboutInner">

            <div class="sectionLabel">OUR PROMISE</div>
            <h2 class="sectionHeading">우리가 여행을 대하는 마음</h2>
            <p class="sectionDescription">
                더 편안하고 즐거운 여행을 위해 GOTT가 지켜나갈 약속입니다.
            </p>

            <div class="promiseCards">
                <div class="promiseCard">
                    <span class="promiseNumber">PROMISE 01</span>
                    <h3>체계적인 여행 준비</h3>
                    <p>
                        여행지 탐색부터 일정 계획과 숙소 예약까지,
                        여행에 필요한 정보를 한곳에서 편리하게 살펴볼 수 있도록 노력합니다.
                    </p>
                </div>

                <div class="promiseCard">
                    <span class="promiseNumber">PROMISE 02</span>
                    <h3>여행자를 위한 배려</h3>
                    <p>
                        누구나 자신만의 여행을 계획하고 즐길 수 있도록
                        쉽고 편리한 서비스를 만들어갑니다.
                    </p>
                </div>

                <div class="promiseCard">
                    <span class="promiseNumber">PROMISE 03</span>
                    <h3>믿을 수 있는 여행 정보</h3>
                    <p>
                        여행을 준비하는 데 도움이 되는 정보를 제공하고,
                        여행자들의 소중한 경험을 나눌 수 있는 공간을 만듭니다.
                    </p>
                </div>
            </div>

        </div>
    </section>

    <section class="storySection">
        <div class="aboutInner">
            <div class="storyContent">
                <div class="sectionLabel">OUR STORY</div>
                <h2>여행은 목적지가 아니라,<br>새로운 발견의 과정입니다.</h2>
                <p>
                    낯선 골목에서 발견한 작은 가게, 우연히 마주한 아름다운 풍경,
                    소중한 사람과 함께한 시간까지.<br>
                    여행은 우리에게 일상과 다른 특별한 순간을 선물합니다.<br>
                    GOTT는 더 많은 사람이 자신만의 여행을 발견하고,
                    그 순간을 오래 기억할 수 있도록 함께하겠습니다.
                </p>
            </div>
        </div>
    </section>

    <section class="aboutSection serviceSection">
        <div class="aboutInner">

            <div class="sectionLabel">WHAT WE OFFER</div>
            <h2 class="sectionHeading">여행의 시작부터 기록까지</h2>
            <p class="sectionDescription">
                GOTT에서 나만의 여행을 준비해 보세요.
            </p>

            <div class="serviceGrid">
                <div class="serviceItem">
                    <span>01 / DISCOVER</span>
                    <h3>여행지 탐색</h3>
                    <p>새로운 장소와<br>숨겨진 여행지를 발견해요.</p>
                </div>

                <div class="serviceItem">
                    <span>02 / PLAN</span>
                    <h3>여행 일정</h3>
                    <p>나만의 취향을 담아<br>여행을 계획해요.</p>
                </div>

                <div class="serviceItem">
                    <span>03 / STAY</span>
                    <h3>숙소 예약</h3>
                    <p>여행에 어울리는<br>숙소를 찾아봐요.</p>
                </div>

                <div class="serviceItem">
                    <span>04 / SHARE</span>
                    <h3>여행 기록</h3>
                    <p>나의 경험을 기록하고<br>다른 여행자와 나눠요.</p>
                </div>
            </div>

        </div>
    </section>

    <div class="aboutInner">
        <section class="aboutCta">
            <h2>다음 여행을 떠날 준비가 되었나요?</h2>
            <p>지금 GOTT에서 새로운 여행을 발견해 보세요.</p>
            <a href="${pageContext.request.contextPath}/place/mappage">
                여행지 둘러보기 →
            </a>
        </section>
    </div>

</div>

</body>
</html>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>