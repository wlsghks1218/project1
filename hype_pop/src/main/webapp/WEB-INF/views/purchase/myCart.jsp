<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="icon" href="/resources/images/favicon.ico">
<meta charset="UTF-8">
<title>장바구니</title>
<style>
html {
	height: 80%;
	overflow-y: auto; /* 세로 스크롤 활성화 */
}
/* 기본적인 스타일 정의 */
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f9f9f9;
	padding-bottom: 100px; /* Adjust this if necessary */
	min-height: 100vh; /* Ensures body fills the entire height */
	display: flex;
	flex-direction: column;
	overflow-y: auto; /* 세로 스크롤 활성화 */
}

.container {
	width: 80%;
	margin: 0 auto;
	padding: 20px;
	background-color: white;
	margin-bottom: 50px; /* 추가된 여백 */
}


.header {
	text-align: center;
	padding: 10px;
}

.cart-list {
	max-height: 400px; /* 장바구니 항목의 최대 높이 설정 */
	overflow-y: scroll; /* 세로 스크롤 활성화 */
	border: 1px solid #ddd; /* 경계선 추가 */
	margin-bottom: 20px; /* 항목과 총 가격 사이 간격 */
	backgound-color: white;
}

.cart-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 15px;
	border-bottom: 1px solid #ddd;
}

.cart-item img {
	width: 80px;
	height: 80px;
	object-fit: cover;
}

.cart-info {
	flex: 1;
	padding-left: 20px;
}

.cart-total, .checkout-button {
	text-align: right;
	padding: 20px;
}

.checkout-button button {
	padding: 10px 20px;
	background-color: #4CAF50;
	color: white;
	border: none;
	cursor: pointer;
}

.checkout-button button:hover {
	background-color: #45a049;
}

.delete-button {
	color: red;
	cursor: pointer;
}

/* 스크롤바 스타일 설정 */
.cart-list::-webkit-scrollbar {
	height: 1px; /* 스크롤바 너비 */
}

.cart-list::-webkit-scrollbar-thumb {
	background-color: #888; /* 스크롤바의 색상 */
}

.cart-list::-webkit-scrollbar-thumb:hover {
	background-color: #555; /* 스크롤바가 호버될 때의 색상 */
}

/* Header styles */
.purchase-header {
	text-align: center;
	margin: 20px 0;
	font-size: 24px;
	font-weight: bold;
	color: #333;
}
.footer-container {
	padding: 20px;
	background-color: #f8f8f8;
	border-top: 1px solid #ccc;
	text-align: center;
	margin-bottom: 40px;
	width: 100%;
}

.footer-contact h4 {
	margin-bottom: 10px;
	padding: 5px;
	color: black;
}


</style>
</head>
<body onload="calculateTotal()">

	<jsp:include page="layout/popUpHeader.jsp" />

	<!-- 장바구니 헤더 -->
	<br>
	<br>
	<br>
	<div class="container">
		<div class="header">
			<h2>장바구니</h2>
		</div>

		<!-- 전체 선택 체크박스 -->
		<div>
			<input type="checkbox" id="selectAll" onclick="toggleAll(this)"
				checked> 전체 선택/해제
		</div>

		<!-- 장바구니 목록을 감싸는 div -->
		<div class="cart-list">
			<!-- 장바구니 목록 -->


			<c:forEach var="cart" items="${cartInfo}">
				<div class="cart-item" id="cart-${cart.gno}">
					<input type="checkbox" class="cart-checkbox" id="cart-${cart.gno}"
						checked onchange="calculateTotal()">
					<c:forEach var="img" items="${cart.gimg}">
						<img src=""
							alt="${cart.gname}" width="100" height="100" />
							<input type="hidden" value="${img.uuid}_${img.fileName}" id="fileName">
							
					</c:forEach>
					<div class="cart-info">
						<h4>굿즈 이름 : ${cart.gname}</h4>
						<p>
							가격: ₩<span class="price">${cart.gprice}</span>
						</p>
						<!-- 가격에 class 추가 -->
						<button onclick="changeAmount(${cart.gno}, -1)">-</button>
						<input type="number" id="quantity-${cart.gno}"
							value="${cart.camount}" min="1" readonly>
						<button onclick="changeAmount(${cart.gno}, +1)">+</button>
						<p>
							상품 목록 1개의 총 가격: ₩<span class="total-price">${cart.camount * cart.gprice}</span>
						</p>
						<!-- 총 가격에 class 추가 -->
					</div>
					<span class="delete-button" onclick="deleteItem(${cart.gno})">X</span>
				</div>
			</c:forEach>
		</div>
	


	<!-- 총 가격 표시 -->
	<div class="cart-total">
		총 가격: ₩<span id="grandTotal">0</span>
	</div>

	<!-- 결제하기 버튼 -->
	<!--  <div class="checkout-button">
        <button  class="goPayInfo-button" onclick="goPayInfo()">결제하기</button>
    </div> -->


	<div class="checkout-button">
		<form id="cartForm" method="get" action="getPayInfo">
			<input type="hidden" name="grandTotal" id="hiddenGrandTotal"
				value="0"> <input type="hidden" name="cartData"
				id="hiddenCartData">
			<!-- 장바구니 데이터 -->
			<input type="hidden" value="2" name="userNo" id="userNo">

			<button type="button" class="goPayInfo-button"
				onclick="prepareCartData()">결제하기</button>
		</form>
	</div>
</div>
	<br><br><br><br><br><br><br><br><br><br><br><br>
	<br><br><br><br><br><br><br><br><br><br><br><br>
	<br><br><br><br><br><br><br><br><br><br><br><br>
	<jsp:include page="layout/popUpNavBar.jsp" />
	<jsp:include page="layout/popUpFooter.jsp" />

	
	<script type="text/javascript" src="/resources/purchaseJs/myCart.js"></script>

</body>
</html>
