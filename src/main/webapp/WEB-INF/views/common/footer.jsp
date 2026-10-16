<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<hr>
    <div class="footer">
        <p>Go To Travel 당신이 떠나는 모든 순간</p>
        <p>회사명 : GOTT | 대표 : 장윤아 | 사업자등록번호 : 123-45-67890</p>
        <p>이용약관 | 개인정보처리방침 | 고객센터</p>
        <div id="footerLogo"><img src="/images/logo.png" alt="GOTT 로고"> </div>
    </div>

<script>
		$(".menubtn").on("click", function(){
		    $("#sidemenu").toggleClass("open");
		});
</script>

</body>
</html>