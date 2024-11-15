document.addEventListener("DOMContentLoaded", function() {
	let userNoElement = document.getElementById("userNo");
	let userNo = userNoElement ? userNoElement.value : null;
	console.log(userNo);
	
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