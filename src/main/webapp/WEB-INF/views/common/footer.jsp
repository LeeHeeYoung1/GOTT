<hr>
	<div class="footer">
		<p>AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA</p>
		<p>회사명 : GOTT | 대표 : ??? | 사업자등록번호 : 123-45-67890</p>
		<p>이용약관 | 개인정보처리방침 | 고객센터 </p>
		<div class="textbox">사이트로고</div>
	</div>
</div>

<script>
	
	let verticalunderline = document.getElementById("vertical-underline");
	let verticalmenus = document.querySelectorAll("nav:first-child a");
	
	verticalmenus.forEach(menu=>menu.addEventListener("click", (e)=>createunderline(e)))
	function createunderline(e) {
	    verticalunderline.style.left = e.currentTarget.offsetLeft + "px";
	    verticalunderline.style.width = e.currentTarget.offsetWidth + "px";
	    verticalunderline.style.top = e.currentTarget.offsetTop + 
	                                    e.currentTarget.offsetHeight + "px";
	
	}

	
</script>

</body>
</html>