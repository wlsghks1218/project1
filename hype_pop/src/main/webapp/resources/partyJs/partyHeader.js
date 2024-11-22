document.addEventListener("DOMContentLoaded", function() {
	const userNoElement = document.getElementById("userNo");
	const userIdElement = document.getElementById("userId");
	const userNo = userNoElement ? userNoElement.value : null;
	const userId = userIdElement ? userIdElement.value : null;
	
	window.showLogos = function() {
	    const logoContainer = document.getElementById("logoContainer");
	    const overlay = document.getElementById("overlay");
	
	    // 슬라이드 메뉴 및 오버레이 표시
	    logoContainer.classList.toggle("show");
	    overlay.classList.toggle("show");
	
	    // 오버레이 클릭 시 메뉴 숨기기
	    overlay.onclick = function() {
	        logoContainer.classList.remove("show");
	        overlay.classList.remove("show");
	    }
	};
	document.getElementById("goodsLogo").addEventListener('click', function() {
	    if (userNo) {
	        location.href = `/goodsStore/goodsMain?userNo=${userNo}`;
	    } else {
	        location.href = "/goodsStore/goodsMain";
	    }
	});
});