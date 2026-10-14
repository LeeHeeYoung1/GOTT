<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <title>GOTT 마이페이지</title>
<style>
*{box-sizing:border-box;}
body{
    margin:0;
    padding:0;
    font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;
    font-size:16px;
    color:#263238;
    background-color:#f8fafa;
    line-height:1.5;
}
.mypageContainer>h2,.mypageContainer>h5{text-align:center;}
.mypageContainer a{color:inherit;text-decoration:none;}
.mypageContainer button{
    border:1px solid black;
    background-color:white;
}
.mypageContainer button:hover{
    background-color:#222;
    color:white;
    border-color:#222;
}
.sectionTitle{
    display:flex;
    justify-content:space-between;
    align-items:center;
}
.sectionTitle>span{
    font-size:16px;
    font-weight:bold;
    line-height:1;
}
.sectionTitle>a{
    font-size:12px;
    color:#777;
    line-height:1;
    align-self:center;
}
.mypageContainer{
    width:1200px;
    max-width:calc(100% - 40px);
    margin:0 auto;
}
.sideBox{
    width:17%;
    float:left;
    border:1px solid #e5e7eb;
    border-radius:10px;
    overflow:hidden;
    background-color:white;
}
.loginId{
    padding:20px;
    text-align:center;
}
.loginId strong{font-size:14px;}
.loginId span{
    font-size:12px;
    color:#797472;
}
.sideBox hr{
    margin:0;
    border:0;
    border-top:1px solid #e5e7eb;
}
.sideTitle{padding-bottom:10px;}
.sideTitle>span{
    display:block;
    margin:12px 20px 5px;
    font-size:12px;
    color:#797472;
}
.sideTitle ul{
    list-style:none;
    padding:0;
    margin:0;
}
.sideTitle li{
    padding:6px 20px;
    font-size:14px;
}
.sideTitle li a{
    display:block;
    color:#222;
    text-decoration:none;
}
.sideTitle li:hover{background-color:#f2f2f2;}
.sideTitle li.active{background-color:#eff6ff;}
.sideTitle li.active a{
    color:#2563eb;
    font-weight:600;
}
.mainContainer{
    width:83%;
    margin-left:17%;
    padding-left:20px;
}
.mybarBox{
    width:100%;
    display:flex;
    border:1px solid #e5e7eb;
    border-radius:10px;
    overflow:hidden;
    background-color:white;
}
.a1,.a2,.a3,.a4,.a5{
    width:20%;
    height:80px;
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
    cursor:pointer;
    transition:background-color .2s ease;
}
.a2,.a3,.a4,.a5{border-left:1px solid #e5e7eb;}
.a1 strong,.a2 strong,.a3 strong,.a4 strong,.a5 strong{
    margin:0;
    font-size:15px;
    font-weight:700;
    color:#222;
}
.a1 span,.a2 span,.a3 span,.a4 span,.a5 span{
    margin-top:4px;
    font-size:12px;
    color:#797472;
}
.a1:hover,.a2:hover,.a3:hover,.a4:hover,.a5:hover{
    background-color:#f8fafa;
}
.plannerContainer{margin-top:80px;}
.plannerBox{
    display:flex;
    justify-content:space-between;
    align-items:center;
    gap:20px;
    width:100%;
    padding:20px 24px;
    border:1px solid #e5e7eb;
    border-radius:10px;
    background-color:white;
}
.plannerBox .plannerText strong{
    display:block;
    margin-bottom:6px;
    font-size:15px;
    font-weight:700;
    color:#222;
}
.plannerBox .plannerText p{
    margin:0;
    font-size:13px;
    color:#777;
    line-height:1.5;
}
.plannerBox .plannerBtns{
    display:flex;
    gap:8px;
    flex-shrink:0;
}
.plannerBox .plannerBtns button{
    height:34px;
    padding:0 16px;
    border-radius:5px;
    font-size:12px;
    white-space:nowrap;
    cursor:pointer;
}
.plannerBox .plannerBtns .newScheduleBtn{
    border:none;
    background-color:#222;
    color:white;
    font-weight:600;
}
.plannerBox .plannerBtns .newScheduleBtn:hover{background-color:#000;}
.plannerBox .plannerBtns .viewShareBtn{
    border:1px solid #d9d9d9;
    background-color:white;
    color:#333;
}
.plannerBox .plannerBtns .viewShareBtn:hover{
    background-color:#222;
    color:white;
    border-color:#222;
}
.sharedPlanContainer{margin-top:80px;}
.sharedPlanCard{
    display:flex;
    align-items:stretch;
    gap:0;
    width:100%;
    min-height:140px;
    margin-top:12px;
    padding:18px;
    border:1px solid #e5e7eb;
    border-radius:10px;
    background-color:white;
    transition:box-shadow .2s ease;
}
.sharedPlanCard:hover{box-shadow:0 4px 12px rgba(0,0,0,.08);}
.sharedPlanCard>.img{
    width:150px;
    height:100px;
    flex:0 0 150px;
    overflow:hidden;
    border-radius:8px;
    background-color:#f1f1f1;
}
.sharedPlanCard>.img img{
    display:block;
    width:100%;
    height:100%;
    object-fit:cover;
}
.sharedPlanInfo{
    flex:1;
    min-width:0;
    padding:2px 25px;
}
.sharedPlanInfo h3{
    margin:0 0 10px;
    font-size:16px;
    font-weight:700;
    color:#222;
    overflow-wrap:anywhere;
}
.sharedPlanInfo p{
    margin:4px 0;
    font-size:13px;
    color:#666;
}
.sharedPlanCondition{
    width:130px;
    flex:0 0 130px;
    display:flex;
    flex-direction:column;
    align-items:flex-end;
    justify-content:space-between;
}
.sharedPlanCondition .shareBadge{
    padding:4px 10px;
    border-radius:5px;
    background-color:#eff6ff;
    color:#2563eb;
    font-size:12px;
    font-weight:600;
}
.sharedPlanCondition .shareBadge.linkShare{
    background-color:#fff7ed;
    color:#c2410c;
}
.sharedPlanCondition .btnGroup{
    width:100%;
    display:flex;
    flex-direction:column;
    gap:8px;
}
.sharedPlanCondition .btnGroup button{
    width:100%;
    height:32px;
    border:1px solid #d9d9d9;
    border-radius:5px;
    background-color:white;
    font-size:12px;
    color:#333;
    cursor:pointer;
}
.sharedPlanCondition .btnGroup button:hover{
    background-color:#222;
    color:white;
    border-color:#222;
}
.reservationContainer{margin-top:80px;}
.reservationVar{
    display:flex;
    align-items:center;
    margin-top:20px;
    border-bottom:1px solid #222;
}
.tab{
    width:110px;
    height:42px;
    display:flex;
    justify-content:center;
    align-items:center;
    border:1px solid #ddd;
    border-bottom:none;
    border-radius:7px 7px 0 0;
    background-color:#f8f8f8;
    font-size:13px;
    color:#777;
    cursor:pointer;
    box-sizing:border-box;
}
.tab+.tab{margin-left:3px;}
.tab:hover{
    background-color:#222;
    color:white;
    border-color:#222;
}
.tab.active{
    background-color:#222;
    color:white;
    border-color:#222;
    font-weight:600;
}
.reservationPaging{
    display:flex;
    justify-content:center;
    gap:10px;
    margin:30px 0;
}
.reservationPaging a{
    display:flex;
    align-items:center;
    justify-content:center;
    width:35px;
    height:35px;
    border:1px solid #ddd;
    border-radius:5px;
    color:#333;
    text-decoration:none;
}
.reservationPaging a.active{
    background-color:#333;
    color:white;
    border-color:#333;
}
.wishlistContainer{
    width:100%;
    margin-top:80px;
}
.wishlistTab{
    display:flex;
    gap:8px;
    margin:14px 0 16px;
}
.wishlistTab button{
    padding:8px 16px;
    border:1px solid #ddd;
    border-radius:6px;
    background-color:white;
    font-size:13px;
    color:#333;
    cursor:pointer;
}
.wishlistTab button.active{
    background-color:#222;
    color:white;
    border-color:#222;
    font-weight:600;
}
.wishlistTab button:not(.active):hover{background-color:#f2f2f2;}
.wishlistGrid{
    display:grid;
    grid-template-columns:repeat(3,minmax(0,1fr));
    gap:20px;
}
.wishlistCard{
    border:1px solid #e5e7eb;
    border-radius:10px;
    overflow:hidden;
    background-color:white;
}
.wishlistCard .img{
    width:100%;
    height:200px;
    background-color:#f1f1f1;
    overflow:hidden;
}
.wishlistCard .img img{
    display:block;
    width:100%;
    height:100%;
    object-fit:cover;
}
.wishlistInfo{padding:14px 16px;}
.wishlistInfo h3{
    margin:0 0 6px;
    font-size:15px;
    font-weight:700;
    color:#222;
}
.wishlistInfo p{
    margin:0 0 12px;
    font-size:12px;
    color:#777;
    line-height:1.4;
}
.wishlistInfo button{
    width:100%;
    height:34px;
    border:1px solid #ccc;
    border-radius:5px;
    background-color:white;
    font-size:12px;
    color:#333;
    cursor:pointer;
}
.wishlistInfo button:hover{
    background-color:#222;
    color:white;
    border-color:#222;
}
.wishlistPagination{
    display:flex;
    justify-content:center;
    gap:10px;
    margin:30px 0;
}
.wishlistPagination a{
    display:flex;
    align-items:center;
    justify-content:center;
    width:35px;
    height:35px;
    border:1px solid #ddd;
    border-radius:5px;
    color:#333;
    text-decoration:none;
    font-size:14px;
    background-color:white;
    transition:all .2s ease;
}
.wishlistPagination a:hover{
    background-color:#f2f2f2;
    border-color:#999;
}
.wishlistPagination a.active{
    background-color:#333;
    color:white;
    border-color:#333;
    font-weight:600;
}
.flipCard{
    width:100%;
    height:200px;
    margin-top:12px;
    perspective:1000px;
}
.flipCardInner{
    position:relative;
    width:100%;
    height:100%;
    transition:transform .6s ease;
    transform-style:preserve-3d;
}
.flipCard.flipped .flipCardInner{transform:rotateY(180deg);}
.flipCardFront,.flipCardBack{
    position:absolute;
    width:100%;
    height:100%;
    padding:18px;
    border:1px solid #e5e7eb;
    border-radius:10px;
    background-color:white;
    display:flex;
    flex-direction:row;
    align-items:stretch;
    backface-visibility:hidden;
}
.flipCard:hover .flipCardFront,.flipCard:hover .flipCardBack{
    box-shadow:0 4px 12px rgba(0,0,0,.08);
}
.flipCardFront{transform:rotateY(0deg);}
.flipCardBack{
    transform:rotateY(180deg);
    background-color:#f8faff;
}
.flipCard .img{
    width:210px;
    height:145px;
    flex-shrink:0;
    overflow:hidden;
    border-radius:8px;
    background-color:#f1f1f1;
}
.flipCard .img img{
    display:block;
    width:100%;
    height:100%;
    object-fit:cover;
}
.flipCard .reservationInfo{
    flex:1;
    min-width:0;
    padding:5px 25px;
}
.flipCard .reservationInfo h3{
    margin:0 0 12px;
    font-size:18px;
    font-weight:600;
    color:#222;
}
.flipCard .reservationInfo p{
    margin:6px 0;
    font-size:13px;
    color:#666;
}
.flipCard .reservationInfo p:last-child{
    margin-top:4px;
    font-size:15px;
    font-weight:600;
    color:#222;
}
.flipCard .reservationCondition{
    width:120px;
    display:flex!important;
    flex-direction:column;
    justify-content:center;
    gap:8px;
    padding-left:15px;
    border-left:1px solid #eee;
    flex-shrink:0;
}
.flipCard .reservationCondition button{
    width:100%;
    height:34px;
    border:1px solid #d9d9d9;
    border-radius:5px;
    background-color:white;
    font-size:12px;
    color:#333;
    cursor:pointer;
}
.flipCard .reservationCondition button:first-child{
    border:none;
    background-color:#eff6ff;
    color:#2563eb;
    font-weight:600;
    cursor:default;
}
.flipCard .reservationCondition button:disabled{opacity:1;}
.flipCard .reservationCondition button:not(:disabled):hover{
    background-color:#222;
    color:white;
    border-color:#222;
}

.couponContainer{
    width:100%;
    margin-top:80px;
    padding-bottom:30px;
}
.couponSectionTitle{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:20px;
}
.couponSectionTitle span{
    font-size:18px;
    font-weight:700;
    color:#222;
}
.couponSectionTitle a{
    font-size:13px;
    color:#64748b;
    text-decoration:none;
    transition:color .2s;
}
.couponSectionTitle a:hover{color:#2563eb;}
.coupon_point{
    padding:20px !important;
    background:#fff;
    border:1px solid #e5e7eb;
    border-radius:12px;
    box-shadow:0 3px 12px rgba(0,0,0,.03);
}
.coupon_point table{
    width:100%;
    border-collapse:collapse;
    table-layout:fixed;
    text-align:center;
}
.coupon_point thead{background:#f8fafc;}
.coupon_point th{
    height:46px;
    padding:10px;
    color:#64748b;
    font-size:13px;
    font-weight:600;
    border-top:1px solid #e5e7eb;
    border-bottom:1px solid #e5e7eb;
}
.coupon_point td{
    height:48px;
    padding:10px;
    color:#475569;
    font-size:13px;
    border-bottom:1px solid #f0f2f5;
    overflow-wrap:anywhere;
}
.coupon_point tbody tr{transition:background .2s;}
.coupon_point tbody tr:hover{background:#f8fbff;}
.coupon_point tbody tr:last-child td{border-bottom:none;}
.coupon_point th:nth-child(1),.coupon_point td:nth-child(1){
    width:22%;
    text-align:left;
}
.coupon_point th:nth-child(2),.coupon_point td:nth-child(2){
    width:38%;
    text-align:left;
}
.coupon_point th:nth-child(3),.coupon_point td:nth-child(3){width:18%;}
.coupon_point th:nth-child(4),.coupon_point td:nth-child(4){
    width:22%;
    text-align:right;
    white-space:nowrap;
    font-weight:700;
}
.couponList{
    display:grid;
    grid-template-columns:repeat(2,minmax(0,1fr));
    gap:16px;
    margin-top:24px;
}
.couponBox{
    width:100%;
    min-height:150px;
    padding:20px;
    background:linear-gradient(135deg,#f8fbff,#eef5ff);
    border:1px solid #dce8fa;
    border-radius:12px;
    transition:transform .2s,box-shadow .2s;
}
.couponBox:hover{
    transform:translateY(-2px);
    box-shadow:0 6px 16px rgba(37,99,235,.08);
}
.couponBox strong{
    display:block;
    margin-bottom:10px;
    color:#1e3a5f;
    font-size:15px;
    font-weight:700;
}
.couponBox p{
    margin:0 0 16px;
    color:#64748b;
    font-size:12px;
    line-height:1.6;
}
.couponBox button{
    min-width:80px;
    height:32px;
    padding:0 14px;
    color:#fff;
    background:#2563eb;
    border:1px solid #2563eb;
    border-radius:6px;
    font-size:12px;
    font-weight:600;
    cursor:pointer;
    transition:background .2s;
}
.couponBox button:hover{
    background:#1d4ed8;
    border-color:#1d4ed8;
    color:#fff;
}
@media(max-width:560px){
    .coupon_point{padding:12px !important;}
    .coupon_point th,.coupon_point td{
        padding:8px 4px;
        font-size:11px;
    }
    .coupon_point th:nth-child(1),.coupon_point td:nth-child(1){width:25%;}
    .coupon_point th:nth-child(2),.coupon_point td:nth-child(2){width:32%;}
    .coupon_point th:nth-child(3),.coupon_point td:nth-child(3){width:18%;}
    .coupon_point th:nth-child(4),.coupon_point td:nth-child(4){width:25%;}
    .couponList{grid-template-columns:1fr;gap:12px;}
    .couponBox{min-height:auto;padding:16px;}
}
.plannerContainer .sectionTitle,.sharedPlanContainer .sectionTitle,.reservationContainer>.sectionTitle,.wishlistContainer>.sectionTitle,.reviewContainer>.sectionTitle{
    margin-bottom:50px;
}
.emptyPlanner{
    padding:20px;
    border:1px solid #e5e7eb;
    border-radius:10px;
    background:white;
    color:#777;
    font-size:13px;
}
@media(max-width:900px){
    .mypageContainer{max-width:calc(100% - 24px);}
    .sideBox{
        width:100%;
        float:none;
        margin-bottom:20px;
    }
    .mainContainer{
        width:100%;
        margin-left:0;
        padding-left:0;
    }
    .sharedPlanCard{flex-wrap:wrap;gap:14px;}
    .sharedPlanCard>.img{
        width:120px;
        height:90px;
        flex-basis:120px;
    }
    .sharedPlanInfo{
        padding:0 8px;
        flex:1;
    }
    .sharedPlanCondition{
        width:100%;
        flex-basis:100%;
        align-items:stretch;
        gap:10px;
    }
    .sharedPlanCondition .btnGroup{width:100%;}
    .wishlistGrid{grid-template-columns:repeat(2,minmax(0,1fr));}
}
@media(max-width:560px){
    .wishlistGrid{grid-template-columns:1fr;}
    .plannerBox{
        flex-direction:column;
        align-items:flex-start;
    }
    .plannerBox .plannerBtns{flex-wrap:wrap;}
    .sharedPlanCard>.img{
        width:100%;
        height:180px;
        flex-basis:100%;
    }
    .sharedPlanInfo{
        padding:0;
        width:100%;
        flex-basis:100%;
    }
}

/* 인스타그램 스타일 리뷰 영역 */
.reviewContainer{
    width:100%;
    margin:30px 0;
    color:#262626;
    font-family:'Segoe UI',Arial,sans-serif;
}
.reviewContainer .sectionTitle{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:20px;
    padding-bottom:14px;
    border-bottom:1px solid #efefef;
}
.reviewContainer .sectionTitle>span{
    font-size:21px;
    font-weight:700;
    color:#262626;
}
.reviewContainer .sectionTitle>a{
    color:#0095f6;
    font-size:13px;
    font-weight:600;
    text-decoration:none;
    transition:color .2s;
}
.reviewContainer .sectionTitle>a:hover{
    color:#00376b;
}
.reviewContainer .reviewList{
    display:grid;
    grid-template-columns:repeat(3,minmax(0,1fr));
    gap:22px;
    align-items:start;
}
.reviewContainer .reviewCard{
    min-width:0;
    overflow:hidden;
    background:#fff;
    border:1px solid #dbdbdb;
    border-radius:12px;
    transition:transform .25s,box-shadow .25s;
}
.reviewContainer .reviewCard:hover{
    transform:translateY(-4px);
    box-shadow:0 8px 24px rgba(0,0,0,.08);
}
.reviewContainer .reviewUser{
    display:flex;
    align-items:center;
    gap:10px;
    padding:13px 14px;
}
.reviewContainer .reviewProfile{
    display:flex;
    justify-content:center;
    align-items:center;
    width:38px;
    height:38px;
    flex-shrink:0;
    border-radius:50%;
    padding:2px;
    background:linear-gradient(135deg,#feda75,#fa7e1e,#d62976,#962fbf,#4f5bd5);
}
.reviewContainer .reviewProfile span{
    display:flex;
    justify-content:center;
    align-items:center;
    width:100%;
    height:100%;
    border:2px solid #fff;
    border-radius:50%;
    background:#fff;
    color:#d62976;
    font-size:17px;
    font-weight:800;
}
.reviewContainer .reviewUserInfo{
    display:flex;
    flex-direction:column;
    gap:3px;
    min-width:0;
}
.reviewContainer .reviewUserInfo strong{
    overflow:hidden;
    color:#262626;
    font-size:13px;
    text-overflow:ellipsis;
    white-space:nowrap;
}
.reviewContainer .reviewUserInfo>span{
    color:#8e8e8e;
    font-size:11px;
}
.reviewContainer .reviewMore{
    margin-left:auto;
    padding:5px;
    border:0;
    border-radius:4px;
    background:transparent;
    color:#262626;
    font-size:17px;
    cursor:pointer;
    outline:none;
    box-shadow:none;
    -webkit-tap-highlight-color:transparent;
}

.reviewContainer .reviewMore:hover,
.reviewContainer .reviewMore:focus,
.reviewContainer .reviewMore:focus-visible,
.reviewContainer .reviewMore:active{
    background:transparent !important;
    color:#262626 !important;
    outline:none !important;
    box-shadow:none !important;
}

.reviewContainer .reviewImage{
    width:100%;
    aspect-ratio:1/1;
    overflow:hidden;
    background:#fafafa;
}
.reviewContainer .reviewImage img{
    display:block;
    width:100%;
    height:100%;
    object-fit:cover;
    transition:transform .35s;
}
.reviewContainer .reviewCard:hover .reviewImage img{
    transform:scale(1.03);
}
.reviewContainer .reviewNoImage{
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
    width:100%;
    height:100%;
    color:#c13584;
    background:linear-gradient(135deg,#fff0f6,#f3e8ff,#e8f4ff);
}
.reviewContainer .reviewNoImage>span{
    font-size:45px;
}
.reviewContainer .reviewNoImage p{
    margin:12px 0 0;
    color:#777;
    font-size:12px;
}
.reviewContainer .reviewInfo{
    padding:13px 14px 15px;
}
.reviewContainer .reviewIcons{
    display:flex;
    align-items:center;
    gap:15px;
    margin-bottom:10px;
}
.reviewContainer .reviewIcons span{
    display:inline-flex;
    align-items:center;
    justify-content:center;
    color:#262626;
    font-size:25px;
    line-height:1;
}
.reviewContainer .reviewIcons .reviewHeart{
    color:#ed4956;
    font-size:29px;
}
.reviewContainer .reviewIcons .reviewShareIcon{
    margin-left:auto;
    color:#262626;
    font-size:25px;
}
.reviewContainer .reviewLike{
    margin:0 0 10px;
    color:#262626;
    font-size:13px;
}
.reviewContainer .reviewLike strong{
    color:#c13584;
    font-size:15px;
}
.reviewContainer .reviewDescription{
    display:-webkit-box;
    overflow:hidden;
    margin:0 0 9px;
    color:#262626;
    font-size:13px;
    line-height:1.7;
    overflow-wrap:anywhere;
    -webkit-box-orient:vertical;
    -webkit-line-clamp:3;
}
.reviewContainer .reviewTag{
    margin:0 0 10px;
    color:#00376b;
    font-size:12px;
}
.reviewContainer .reviewDate{
    margin:10px 0 0;
    color:#a8a8a8;
    font-size:10px;
}
.reviewContainer .reviewActions{
    display:flex;
    justify-content:flex-end;
    gap:12px;
    margin-top:12px;
    padding-top:10px;
    border-top:1px solid #efefef;
}
.reviewContainer .reviewActions a{
    color:#8e8e8e;
    font-size:11px;
    text-decoration:none;
}
.reviewContainer .reviewActions a:hover{
    color:#c13584;
}
.reviewContainer .emptyReview{
    grid-column:1/-1;
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
    min-height:200px;
    padding:30px 15px;
    border:1px dashed #dbdbdb;
    border-radius:12px;
    background:#fff;
    text-align:center;
}
.reviewContainer .emptyReview>span{
    margin-bottom:12px;
    color:#c13584;
    font-size:42px;
}
.reviewContainer .emptyReview strong{
    color:#262626;
    font-size:16px;
}
.reviewContainer .emptyReview p{
    margin:8px 0 0;
    color:#8e8e8e;
    font-size:13px;
}
@media(max-width:1100px){
    .reviewContainer .reviewList{
        grid-template-columns:repeat(2,minmax(0,1fr));
        gap:16px;
    }
}
@media(max-width:600px){
    .reviewContainer .reviewList{
        grid-template-columns:1fr;
        gap:18px;
    }
    .reviewContainer .reviewCard{
        border-radius:10px;
    }
    .reviewContainer .sectionTitle>span{
        font-size:19px;
    }
}


.pagination{display:flex;justify-content:center;align-items:center;gap:7px;margin:25px 0}
.pagination a{display:flex;justify-content:center;align-items:center;min-width:34px;height:34px;padding:0 10px;border:1px solid #e0e5eb;border-radius:6px;background:#fff;color:#596574;font-size:13px;text-decoration:none;transition:.2s}
.pagination a:hover,.pagination a.active{background:#263238;border-color:#263238;color:#fff}


.plannerPagination {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
    margin: 20px 0;
}
.plannerPagination a {
    display: flex;
    justify-content: center;
    align-items: center;
    min-width: 32px;
    height: 32px;
    padding: 0 8px;
    border: 1px solid #ddd;
    border-radius: 6px;
    color: #555;
    text-decoration: none;
    font-size: 14px;
}
.plannerPagination a.active {
    background: #2563eb;
    border-color: #2563eb;
    color: #fff;
}
.plannerPagination a:hover {
    background: #eff6ff;
}
</style>
</head>
<body>
<c:choose>
<c:when test="${loginId != null}">
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="mypageContainer">
        <h2 style="margin:24px 0 4px;">마이페이지</h2>
        <h5 style="font-size:13px;color:#7c7c7c;margin:0 0 16px;">예약 내역과 찜한 여행지, 내가 남긴 기록을 한 곳에서 관리</h5>
        <c:if test="${not empty reservationUpdateMessage}">
		    <script>
		        alert("${reservationUpdateMessage}");
		    </script>
		</c:if>
        <hr style="border:1px solid rgb(248,246,246);margin:0 0 20px;">
        <div class="breadcrumb" style="font-size:12px;margin:20px;">홈 &gt; 마이페이지 &gt; 대시보드</div>
        <div class="sideBox">
            <div class="loginId">
                <strong>${nickname}</strong><span>님</span><br>
                <span>일반회원</span><span>등급</span>
            </div>
            <hr>
            <div class="sideTitle">
                <span>예약/활동</span>
                <ul>
                    <li class="active"><a href="/members/mypage">마이페이지 홈</a></li>
                    <li><a href="/members/reservationpage">예약 내역</a></li>
                    <li><a href="/members/wishlist">찜한 목록</a></li>
                    <li><a href="/members/planner">여행 일정 플래너</a></li>
                    <li><a href="/review/reviewlist">내가 쓴 리뷰</a></li>
                    <li><a href="#">내가 쓴 게시글</a></li>
                </ul>
                <span>혜택</span>
                <ul>
                    <li><a href="/members/mileage">마일리지 내역</a></li>
                    <li><a href="/coupon/myCoupon">쿠폰함</a></li>
                </ul>
                <span>계정</span>
                <ul>
                    <li><a href="/members/update">내 정보 수정</a></li>
                    <li><a href="/members/pwsearchpage">비밀번호 변경</a></li>
                    <li><a href="#">알림 설정</a></li>
                    <li><a href="#">1:1 문의</a></li>
                    <li><a href="/members/deleted">회원탈퇴</a></li>
                </ul>
            </div>
        </div>
        <div class="mainContainer">
            <nav class="mybarBox">
                <a class="a1"><strong>${upcomingCount}</strong><span>다가오는 예약</span></a>
                <a class="a2"><strong>${myWishTotalCount}</strong><span>찜한 목록</span></a>
                <a class="a3"><strong>${reviewCount}</strong><span>작성한 리뷰</span></a>
                <a class="a4"><strong><fmt:formatNumber value="${mileage}" pattern="#,##0"/>M</strong><span>보유마일리지</span></a>
                <a class="a5"><strong><fmt:formatDate value="${regdate}" pattern="yyyy-MM-dd"/></strong><span>가입일자</span></a>
            </nav>
            <div class="plannerContainer">
                <div class="sectionTitle"><span>여행 일정 플래너</span></div>
                <div class="plannerBox">
                    <div class="plannerText">
                        <strong>찜해둔 장소를 일차별 일정으로 정리해보세요.</strong>
                        <p>관광지·맛집·숙소를 드래그해 일정에 추가하고 완성한 여행을 게시판에 공유할 수 있습니다.</p>
                    </div>
                    <div class="plannerBtns">
                        <button type="button" class="newScheduleBtn" onclick="location.href='/members/planner'">새 일정 만들기</button>
                        <button type="button" class="viewShareBtn" onclick="location.href='/travelPlan/list?cpage=1'">공유일정 전부 보기</button>
                    </div>
                </div>
            </div>
            <div class="sharedPlanContainer">
                <div class="sectionTitle"><span>내가 공유한 여행 일정</span></div>
                <c:choose>
                    <c:when test="${not empty myPlannerList}">
                        <c:forEach var="plan" items="${myPlannerList}">
                            <div class="sharedPlanCard">
                                <div class="img">
                                    <c:choose>
                                        <c:when test="${not empty plan.IMAGE_NAME}">
                                            <img src="<c:out value='${plan.IMAGE_NAME}'/>" alt="<c:out value='${plan.PLAN_TITLE}'/>">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;color:#999;font-size:12px;">이미지 준비 중</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="sharedPlanInfo">
                                    <h3><c:out value="${plan.PLAN_TITLE}"/></h3>
                                    <p><c:out value="${plan.START_DATE}"/> ~ <c:out value="${plan.END_DATE}"/> · 방문지 <c:out value="${plan.SPOT_COUNT}"/>곳</p>
                                    <p>공유일 <fmt:formatDate value="${plan.CREATED_AT}" pattern="yyyy-MM-dd"/></p>
                                </div>
                                <div class="sharedPlanCondition">
                                    <span class="shareBadge">전체 공개</span>
                                    <div class="btnGroup">
                                    	<form action="${pageContext.request.contextPath}/travelPlan/delete" method="post" onsubmit="return confirm('이 여행 일정을 삭제하시겠습니까? 삭제하면 복구할 수 없습니다.');">
										    <input type="hidden" name="planId" value="${plan.PLAN_ID}">
										    <button type="button" class="deleteBtn" style="background-color:red;" onclick="if(confirm('삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/travelPlan/delete?planId=${plan.PLAN_ID}'">삭제</button>
										</form>
                                        <button type="button" class="boardViewBtn" onclick="location.href='${pageContext.request.contextPath}/travelPlan/detail?planId=${plan.PLAN_ID}'">일정 보기</button>
                                    </div>
                               	</div>
                            </div>
                        </c:forEach>
                        <c:if test="${plannerTotalPage > 1}">
						    <div class="plannerPagination">
						        <c:if test="${plannerCpage > 1}">
						            <a href="${pageContext.request.contextPath}/members/mypage?cpage=${cpage}&wishCpage=${wishCpage}&mileageCpage=${mileageCpage}&plannerCpage=${plannerCpage - 1}">&lt;</a>
						        </c:if>
						
						        <c:forEach var="i" begin="1" end="${plannerTotalPage}">
						            <a href="${pageContext.request.contextPath}/members/mypage?cpage=${cpage}&wishCpage=${wishCpage}&mileageCpage=${mileageCpage}&plannerCpage=${i}"
						               class="${plannerCpage == i ? 'active' : ''}">${i}</a>
						        </c:forEach>
						    </div>
						</c:if>
                    </c:when>
                    <c:otherwise>
                        <p class="emptyPlanner">아직 공유한 여행 일정이 없습니다.</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="reservationContainer" id="reservationSection">
                <div class="sectionTitle">
                    <span>예약내역</span>
                    <a href="/members/reservationpage">예약내역 열기</a>
                    
                </div>

                <div class="reservationVar">
                    <span class="tab active" data-tab="all">전체</span>
                    <span class="tab" data-tab="upcoming">이용 예정</span>
                    <span class="tab" data-tab="completed">이용 완료</span>
                    <span class="tab" data-tab="cancelled">취소 / 환불</span>
                </div>

                <div class="reservationList" id="reservationList">
                    <c:forEach var="rs" items="${myRsList}">                      
					<c:choose>
					    <c:when test="${rs.status eq '예약취소'}">
					        <c:set var="reservationType" value="cancelled"/>
					    </c:when>
					    <c:otherwise>
					        <c:set var="reservationType" value="upcoming"/>
					    </c:otherwise>
					</c:choose>

                        <div class="flipCard" data-tab="${reservationType}">
                            <div class="flipCardInner">
                                <div class="flipCardFront">
                                    <div class="img"><img src="${rs.image1}" alt="호텔 이미지"></div>
                                    <div class="reservationInfo">
                                        <h3>${rs.roomName}</h3>
                                        <p>· 체크인 ${rs.checkIn} / 체크아웃 ${rs.checkOut}</p>
                                        <p>· 성인 ${rs.guestNum}명<br>· 예약번호 ${rs.paymentId}<br>
                                            <c:choose>
                                                <c:when test="${rs.status ne '예약취소'}">
                                                    <strong>· 적립 마일리지 + ${rs.mileage}M</strong>
                                                </c:when>
                                                <c:otherwise>
                                                    <strong>· 회수 마일리지 - ${rs.mileage}M</strong>
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                        <p>결제금액 ${rs.price}원</p>
                                    </div>
                                    <div class="reservationCondition">
                                         <button disabled>
										    <c:choose>
										        <c:when test="${rs.reservationType eq 'completed'}">이용 완료</c:when>
										        <c:when test="${rs.reservationType eq 'cancelled'}">예약취소</c:when>
										        <c:when test="${rs.reservationType eq 'confirmed'}">예약완료</c:when>
										        <c:otherwise>이용 예정</c:otherwise>
										    </c:choose>
										</button>
									    <button type="button" class="detailBtn">예약 상세</button>
									    <c:if test="${rs.reservationType eq 'confirmed'}">
										    <button type="button" class="updateBtn" data-payment-id="${rs.paymentId}">예약 변경</button>
										    <button type="button" class="cancelBtn" data-payment-id="${rs.paymentId}">예약 취소</button>
										</c:if>
                                    </div>
                                </div>
                                <div class="flipCardBack">
                                    <div class="reservationInfo">
                                        <h3>${rs.roomName} 상세정보</h3>
                                        <p>· 체크인: ${rs.checkIn}</p>
                                        <p>· 체크아웃: ${rs.checkOut}</p>
                                        <p>· 성인: ${rs.guestNum}명</p>
                                        <p>· 예약번호: ${rs.paymentId}</p>
                                        <p>· 결제금액: ${rs.price}원</p>
                                        <p>· 예약일: ${rs.reserveDate}</p>
                                    </div>
                                    <div class="reservationCondition">
                                        <button type="button" class="backBtn">돌아가기</button>
                                        <c:if test="${reservationType eq 'upcoming'}">
                                            <button type="button" class="updateBtn" data-payment-id="${rs.paymentId}" style="background-color:blue;">예약 변경</button>
                                            <button type="button" class="cancelBtn" data-payment-id="${rs.paymentId}" style="background-color:rgb(153,44,44);">예약 취소</button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>


                <div class="reservationPaging">
                    <c:forEach var="i" begin="1" end="${totalPage}">
                        <a href="${pageContext.request.contextPath}/members/mypage?cpage=${i}&wishCpage=${wishCpage}#reservationSection"
                           class="${cpage == i ? 'active' : ''}">${i}</a>
                    </c:forEach>
                </div>
            </div>

            <div class="wishlistContainer" id="wishlistSection">
                <div class="sectionTitle">
                    <span>찜한 관광지 맛집 숙소</span>
                    <a href="/members/wishlist">더 보기 &gt;</a>
                </div>
                <div class="wishlistTab">
                    <button type="button" class="active" data-type="all">전체</button>
                    <button type="button" data-type="spot">관광지</button>
                    <button type="button" data-type="food">맛집</button>
                    <button type="button" data-type="stay">숙박</button>
                </div>
                <div class="wishlistGrid">
                    <c:forEach var="wishList" items="${wishList}">
                        <div class="wishlistCard">
                            <div class="img"><img src="${wishList.image_name}" alt="${wishList.name}"></div>
                            <div class="wishlistInfo">
                                <h3>${wishList.name}</h3>
                                <p>${wishList.region}</p>
                                <button type="button">자세히 보기</button>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="wishlistPagination">
                <c:forEach var="page" begin="1" end="${wishTotalPage}">
                    <a href="/members/mypage?cpage=${cpage}&wishCpage=${page}#wishlistSection" class="${wishCpage == page ? 'active' : ''}">${page}</a>
                </c:forEach>
            </div>



			<div class="reviewContainer">
			    <div class="sectionTitle">
			        <span>내가 쓴 리뷰</span>
			        <a href="/review/reviewBoard?cpage=1">더 보기 <span>→</span></a>
			    </div>
			    <div class="reviewList">
			        <c:forEach var="rv" items="${reviewList}">
			            <div class="reviewCard">
			                <div class="reviewUser">
			                    <div class="reviewProfile">
			                        <span>G</span>
			                    </div>
			                    <div class="reviewUserInfo">
			                        <strong>${rv.member_id}</strong>
			                        <span>${rv.target_type} 리뷰</span>
			                    </div>
			                    <button type="button" class="reviewMore">•••</button>
			                </div>
			                <div class="reviewImage">
			                    <c:choose>
			                        <c:when test="${not empty rv.image1}">
			                            <img src="${rv.image1}" alt="리뷰 이미지">
			                        </c:when>
			                        <c:otherwise>
			                            <div class="reviewNoImage">
			                                <span>✈</span>
			                                <p>여행의 순간을 기록해 보세요</p>
			                            </div>
			                        </c:otherwise>
			                    </c:choose>
			                </div>
			                <div class="reviewInfo">
			                    <div class="reviewIcons">
			                        <span class="reviewHeart">♡</span>
			                        
			                        <span class="reviewShareIcon">↗</span>
			                    </div>
			                    <p class="reviewLike">좋아요 <strong>${rv.rating}</strong></p>
			                    <p class="reviewDescription">${rv.contents}</p>
			                    <c:if test="${not empty rv.tag}">
			                        <p class="reviewTag">${rv.tag}</p>
			                    </c:if>
			                    <p class="reviewDate">
			                        ${rv.reg_date}
			                    </p>
			                    <div class="reviewActions">
			                        <a href="/review/update?seq=${rv.seq}">수정</a>
			                        <a href="/review/delete?seq=${rv.seq}" onclick="return confirm('리뷰를 삭제하시겠습니까?')">삭제</a>
			                    </div>
			                </div>
			            </div>
			        </c:forEach>
			        <c:if test="${empty reviewList}">
			            <div class="emptyReview">
			                <span>♡</span>
			                <strong>아직 작성한 리뷰가 없어요</strong>
			                <p>여행의 소중한 순간을 리뷰로 남겨보세요.</p>
			            </div>
			        </c:if>
			    </div>
			</div>


            <div class="couponContainer" id="mileageSection">
                <div class="couponSectionTitle">
                    <span>마일리지 · 쿠폰</span>
                    <a href="/members/mileage">더 보기 &gt;</a>
                </div>
                <div class="coupon_point" style="padding:20px 20px 12px">
                    <table align="center">
                    	<thead>
	                         <tr><th>날짜</th><th>내용</th><th>구분</th><th>포인트</th></tr>
	                    </thead>

	                        <tbody>
							    <c:forEach var="mh" items="${mileageHistory}">
							        <tr>
							            <td><fmt:formatDate value="${mh.regDate}" pattern="yyyy-MM-dd"/></td>
							            <td>${mh.reason}</td>
							            <td>
							                <c:choose>
							                    <c:when test="${mh.type eq 'EARN'}">적립</c:when>
							                    <c:when test="${mh.type eq 'USE'}">사용</c:when>
							                    <c:when test="${mh.type eq 'RETURN'}">복구</c:when>
							                    <c:when test="${mh.type eq 'REVOKE'}">회수</c:when>
							                    <c:otherwise>${mh.type}</c:otherwise>
							                </c:choose>
							            </td>
							            <td>
							                <c:choose>
							                    <c:when test="${mh.type eq 'EARN' or mh.type eq 'RETURN'}">+<fmt:formatNumber value="${mh.amount}" pattern="#,##0"/>M</c:when>
							                    <c:when test="${mh.type eq 'USE' or mh.type eq 'REVOKE'}">- <fmt:formatNumber value="${mh.amount}" pattern="#,##0"/>M</c:when>
							                    <c:otherwise><fmt:formatNumber value="${mh.amount}" pattern="#,##0"/>M</c:otherwise>
							                </c:choose>
							            </td>
							        </tr>
							    </c:forEach>
							</tbody>								                    
                    </table>
                    
				<div class="pagination">
				    <c:if test="${mileageCpage > 1}">
				        <a href="${pageContext.request.contextPath}/members/mypage?cpage=${cpage}&wishCpage=${wishCpage}&mileageCpage=${mileageCpage - 1}#mileageSection">&lt;</a>
				    </c:if>
				
				    <c:forEach var="i" begin="1" end="${mileageTotalPage}">
				        <a href="${pageContext.request.contextPath}/members/mypage?cpage=${cpage}&wishCpage=${wishCpage}&mileageCpage=${i}#mileageSection"
				           class="${mileageCpage == i ? 'active' : ''}">${i}</a>
				    </c:forEach>
				</div>

                </div>
                <div class="couponList">
                        <div class="couponBox">
                            <strong>첫 회원가입 3%쿠폰</strong>
                            <p>?????까지 100만원 이상 결제시</p>
                            <button type="button" onclick="location.href='/reservation/list?cpage=1'">사용하기</button>
                        </div>
                        <div class="couponBox">
                            <strong>첫 회원가입 10%쿠폰</strong>
                            <p>?????까지 300만원 이상 결제시</p>
                            <button type="button" onclick="location.href='/reservation/list?cpage=1'">사용하기</button>
                        </div>
                 </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </div>
</c:when>

<c:otherwise>
    <script>location.href="${pageContext.request.contextPath}/members/loginpage";</script>
</c:otherwise>

</c:choose>

<script>
$(".reservationVar .tab").on("click",function(){
    $(".reservationVar .tab").removeClass("active");
    $(this).addClass("active");
    const selectedTab=$(this).data("tab");
    $(".reservationList .flipCard").each(function(){
        const reservationType=$(this).attr("data-tab");
        $(this).toggle(selectedTab==="all"||reservationType===selectedTab);
    });
});

$(".cancelBtn").on("click", async function() {
    if (!confirm("이 결제를 취소할까요?")) return;
    let paymentId = $(this).data("payment-id");
    try {
        const res = await fetch("${pageContext.request.contextPath}/reservation/cancelMyReservation", {
            method: "POST",
            headers: {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"},
            body: "paymentId=" + encodeURIComponent(paymentId)
        });
        const text = await res.text();
        console.log("취소 응답:", text);
        if (res.ok && text.trim() === "success") {
            alert("결제와 예약이 취소되었으며, 사용 마일리지를 복구했습니다.");
            location.reload();
        } else {
            alert("취소 처리 결과: " + text);
        }
    } catch (error) {
        console.error("요청 실패:", error);
        alert("취소 요청 중 오류가 발생했습니다.");
    }
});

$(".updateBtn").on("click", function() {
    let paymentId = $(this).data("payment-id");
    if (!paymentId) {
        alert("예약 정보를 찾을 수 없습니다.");
        return;
    }
    location.href = "${pageContext.request.contextPath}/reservation/reservationUpdate?paymentId=" + encodeURIComponent(paymentId);
});


$(".detailBtn").on("click", function() {
    $(this).closest(".flipCard").addClass("flipped");
});

$(".backBtn").on("click", function() {
    $(this).closest(".flipCard").removeClass("flipped");
});


</script>
</body>
</html>