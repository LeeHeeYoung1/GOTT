<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/public.css">
<title>GOTT 로그인</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
        crossorigin="anonymous"></script>

<style>
    .title {
        width: 100%;
        height: 120px;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #f8fafc;
    }

    .title h1 {
        margin: 0;
        font-size: 32px;
        font-weight: 700;
    }

    .main {
        width: 100%;
        min-height: 400px;
        display: flex;
        padding: 40px 60px;
        gap: 50px;
        box-sizing: border-box;
    }

    .mainleft {
        width: 220px;
        flex-shrink: 0;
    }

    .linkbar {
        width: 100%;
        border: 1px solid #e5e7eb;
        border-radius: 10px;
        overflow: hidden;
        background-color: white;
        box-sizing: border-box;
    }

    .linkbartitle {
        width: 100%;
        height: 60px;
        display: flex;
        align-items: center;
        padding: 0 20px;
        font-size: 17px;
        font-weight: 700;
        background-color: #f1f5f9;
        border-bottom: 1px solid #e5e7eb;
        box-sizing: border-box;
    }

    .linkbarmain {
        width: 100%;
        min-height: 180px;
        padding: 15px;
        line-height: 2;
        box-sizing: border-box;
    }

    .linkbarmain a:hover {
        color: #2563eb;
    }

    .mainright {
        flex: 1;
        max-width: 600px;
        margin: 0 auto;
        padding: 35px 40px;
        border: 1px solid #e5e7eb;
        border-radius: 12px;
        background-color: white;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        box-sizing: border-box;
    }

    .mainright legend {
        padding: 0 10px;
        font-size: 20px;
        font-weight: 700;
    }

    .mainright input {
        width: 100%;
        height: 48px;
        margin-bottom: 12px;
        padding: 0 15px;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        font-size: 14px;
        outline: none;
        box-sizing: border-box;
    }

    .mainright input:focus {
        border-color: #1d97c0;
    }

    .mainright button {
        height: 45px;
        padding: 0 25px;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        background-color: #2563eb;
        color: white;
    }

    .mainright button:hover {
        background-color: #1d4ed8;
    }

    hr {
        margin: 0;
        border: none;
        border-top: 1px solid #e5e7eb;
    }

    @media (max-width: 768px) {
        .main {
            flex-direction: column;
            padding: 25px 20px;
            gap: 25px;
        }

        .mainleft {
            width: 100%;
        }

        .mainright {
            width: 100%;
            padding: 30px 20px;
        }
    }
</style>
</head>

<body>
<div class="container">
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="title">
        <h1>로그인</h1>
    </div>

    <div class="main">
        <div class="mainleft">
            <div class="linkbar">
                <div class="linkbartitle">메뉴</div>
                <div class="linkbarmain">
                    <a href="/">홈으로</a><br>
                    <a href="/members/loginpage">로그인</a><br>
                    <a href="/members/signuppage">회원가입</a><br>
                    <a href="/members/idsearchpage">아이디 찾기</a><br>
                    <a href="/members/pwsearchpage">비밀번호 찾기</a>
                </div>
            </div>
        </div>

        <form id="loginfrm" action="/members/login" method="post">
            <fieldset class="mainright">
                <legend>로그인</legend>
                <input id="id" name="id" type="text"
                       placeholder="ID를 입력하세요" autocomplete="username">
                <input id="pw" name="pw" type="password"
                       placeholder="Password를 입력하세요"
                       autocomplete="current-password">
                <button type="submit">로그인</button>
                <button id="signup" type="button">회원가입</button>
            </fieldset>
        </form>
    </div>

    <hr>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</div>

<script>
    $("#loginfrm").on("submit", function(e) {
        e.preventDefault();

        let id = $("#id").val().trim();
        let pw = $("#pw").val();

        if (id === "" || pw === "") {
            alert("아이디와 비밀번호를 입력해주세요.");
            return;
        }

        $.ajax({
            url: "/members/login",
            type: "post",
            data: {
                id: id,
                pw: pw
            }
        }).done(function(resp) {
            if (resp == 1) {
                location.href = "/";
            } else {
                alert("아이디 또는 비밀번호가 일치하지 않습니다.");
            }
        }).fail(function() {
            alert("로그인 요청 중 오류가 발생했습니다. 다시 시도해주세요.");
        });
    });

    $("#signup").on("click", function() {
        location.href = "/members/signuppage";
    });
</script>
</body>
</html>