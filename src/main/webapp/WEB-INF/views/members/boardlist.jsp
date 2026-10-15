<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<style>
*{box-sizing:border-box}
.myBoardPage{width:1100px;max-width:calc(100% - 40px);margin:0 auto 80px;font-family:'Malgun Gothic','맑은 고딕',sans-serif;color:#222}
.boardTitle{text-align:center;padding:42px 0 30px}
.boardTitle h2{margin:0 0 12px;font-size:28px;font-weight:800;letter-spacing:-1px}
.boardTitle p{margin:0;color:#888;font-size:13px;line-height:1.7}
.boardBreadcrumb{padding:13px 0;border-top:1px solid #eee;font-size:12px;color:#999}
.boardBreadcrumb span{color:#333;font-weight:700}
.boardSummary{display:flex;align-items:center;justify-content:space-between;margin:24px 0 30px;padding:25px 28px;background:linear-gradient(120deg,#f4f8ff,#fff);border:1px solid #d8e5ff;border-radius:14px}
.summaryLabel{font-size:14px;color:#777}
.summaryCount{margin-top:9px;font-size:26px;font-weight:800;letter-spacing:-.5px}
.summaryCount strong{color:#2563eb}
.boardWriteBtn{display:inline-flex;align-items:center;justify-content:center;gap:7px;padding:12px 19px;border:0;border-radius:8px;background:#2563eb;color:#fff;text-decoration:none;font-size:13px;font-weight:700;transition:background .2s,transform .2s}
.boardWriteBtn:hover{background:#1d4ed8;transform:translateY(-1px)}
.boardListHeader{display:flex;justify-content:space-between;align-items:center;margin:0 0 15px}
.boardListHeader h3{margin:0;font-size:18px;font-weight:800;letter-spacing:-.4px}
.boardListHeader span{font-size:12px;color:#999}
.myBoardList{display:flex;flex-direction:column;gap:16px}
.myBoardCard{display:flex;align-items:stretch;gap:23px;padding:22px;background:#fff;border:1px solid #e9edf2;border-radius:14px;color:#222;transition:transform .2s,box-shadow .2s,border-color .2s}
.myBoardCard:hover{transform:translateY(-2px);border-color:#bdd0ff;box-shadow:0 8px 24px rgba(31,41,55,.06)}
.boardInfo{display:flex;flex:1;min-width:0;flex-direction:column;padding:3px 0}
.boardMeta{display:flex;align-items:center;flex-wrap:wrap;gap:10px;margin-bottom:15px}
.boardType{padding:5px 10px;border-radius:20px;background:#eff6ff;color:#2563eb;font-size:11px;font-weight:700;letter-spacing:.3px}
.boardViewCount{color:#888;font-size:13px}
.boardDate{margin-left:auto;color:#999;font-size:12px}
.boardCardTitle{margin:0 0 12px;font-size:17px;font-weight:800;letter-spacing:-.4px}
.boardText{display:-webkit-box;overflow:hidden;-webkit-line-clamp:3;-webkit-box-orient:vertical;color:#626b78;font-size:13px;line-height:1.9;word-break:break-word}
.boardText p{margin:0}
.boardBottom{display:flex;justify-content:flex-end;align-items:center;gap:5px;margin-top:auto;padding-top:14px;color:#2563eb;font-size:12px;font-weight:700}
.boardBottom a{color:#2563eb;text-decoration:none}
.boardBottom a:hover{text-decoration:underline}
.emptyBoard{margin-top:10px;padding:75px 20px;text-align:center;background:#fafbfc;border:1px dashed #dfe3e8;border-radius:14px}
.emptyIcon{margin-bottom:17px;font-size:42px;color:#93b4ff}
.emptyBoard h3{margin:0 0 10px;font-size:18px;font-weight:800}
.emptyBoard p{margin:0 0 24px;color:#888;font-size:13px;line-height:1.7}
.boardNavi{display:flex;justify-content:center;align-items:center;flex-wrap:wrap;gap:6px;margin-top:28px}
.boardNavi a{min-width:34px;height:34px;display:inline-flex;align-items:center;justify-content:center;padding:0 10px;border:1px solid #e1e4e8;border-radius:7px;background:#fff;color:#777;text-decoration:none;font-size:12px;transition:all .2s}
.boardNavi a.on,.boardNavi a:hover{background:#222;border-color:#222;color:#fff}
@media(max-width:650px){
    .myBoardPage{max-width:calc(100% - 24px);margin-bottom:50px}
    .boardTitle{padding:30px 0 23px}
    .boardTitle h2{font-size:24px}
    .boardSummary{gap:12px;margin:20px 0 25px;padding:18px 15px}
    .summaryLabel{font-size:12px}
    .summaryCount{font-size:23px}
    .boardWriteBtn{padding:11px 12px;font-size:12px;white-space:nowrap}
    .boardListHeader h3{font-size:16px}
    .boardListHeader span{font-size:11px}
    .myBoardList{gap:12px}
    .myBoardCard{gap:13px;padding:13px;border-radius:11px}
    .boardMeta{gap:6px;margin-bottom:9px}
    .boardType{padding:4px 7px;font-size:10px}
    .boardDate{width:100%;margin-left:0;font-size:11px}
    .boardCardTitle{margin-bottom:7px;font-size:14px}
    .boardText{-webkit-line-clamp:2;font-size:12px;line-height:1.7}
    .boardBottom{padding-top:8px;font-size:11px}
    .emptyBoard{padding:55px 15px}
    .emptyBoard h3{font-size:16px}
}
.boardText img, .boardText video, .boardText iframe { display: none; }
</style>
<div class="myBoardPage">
<jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div class="boardTitle">
        <h2>내가 쓴 게시글</h2>
        <p>내가 커뮤니티에 남긴 소중한 이야기들을 확인해 보세요.</p>
    </div>
    <div class="boardBreadcrumb">홈 &nbsp;&gt;&nbsp; 마이페이지 &nbsp;&gt;&nbsp; <span>내가 쓴 게시글</span></div>
    <div class="boardSummary">
        <div>
            <div class="summaryLabel">내가 작성한 게시글</div>
            <div class="summaryCount">총 <strong><c:out value="${totalCount}"/></strong>개</div>
        </div>
        <a href="${pageContext.request.contextPath}/board/boardWrite?cpage=1" class="boardWriteBtn">게시글 작성하기 <span>＋</span></a>
    </div>
    <div class="boardListHeader">
        <h3>나의 게시글 목록</h3>
        <span>최근 작성한 글 순</span>
    </div>
    <c:choose>
        <c:when test="${not empty boardList}">
            <div class="myBoardList">
                <c:forEach var="board" items="${boardList}">
                    <div class="myBoardCard">
                        <div class="boardInfo">
                            <div class="boardMeta">
                                <span class="boardType">MY POST</span>
                                <span class="boardViewCount">👁 <c:out value="${board.view_count}"/></span>
                                <span class="boardViewCount">👍 <c:out value="${board.recommendCount}"/></span>
                                <span class="boardDate"><fmt:formatDate value="${board.write_date}" pattern="yyyy.MM.dd"/></span>
                            </div>
                            <div class="boardCardTitle">${board.title}</div>
                            <div class="boardText">${board.contents}</div>
                            <div class="boardBottom">
                                게시글 보기 <a href="${pageContext.request.contextPath}/board/boardContent?seq=${board.seq}&cpage=${cpage}"><span>→</span></a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="boardNavi">
                <c:forEach var="i" begin="1" end="${totalPage}">
                    <a href="${pageContext.request.contextPath}/board/boardList?cpage=${i}"
                       class="${cpage == i ? 'on' : ''}">${i}</a>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="emptyBoard">
                <div class="emptyIcon">✎</div>
                <h3>아직 작성한 게시글이 없어요.</h3>
                <p>커뮤니티에 여행 이야기를 남겨 보세요.</p>
                <a href="${pageContext.request.contextPath}/board/boardWrite?cpage=1" class="boardWriteBtn">첫 게시글 작성하기</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>