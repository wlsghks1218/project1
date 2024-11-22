<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="icon" href="/resources/images/favicon.ico">
<meta charset="UTF-8">
<title>결제 목록</title>
<style>
body {
	font-family: 'Noto Sans KR', Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #ffe6f0; /* Light background */
	color: #333;
	width: 100%; /* 전체 화면에 맞게 width 설정 */
	height: 100vh; /* 화면 높이 100% 설정 */
	display: flex;
	flex-direction: column; /* 세로로 정렬 */
	justify-content: flex-start; /* 세로 방향 상단에 맞추기 */
	align-items: center; /* 가로 방향 중앙 정렬 */
}

.container {
	width: 80%; /* 내용이 들어갈 영역 너비 */
	max-width: 1200px; /* 최대 너비 제한 */
	margin: 0 auto; /* 가로 중앙 정렬 */
}

/* Navbar styles */
.navbar {
	background-color: #ffffff;
	color: #333;
	padding: 15px 20px;
	border-bottom: 1px solid #e5e5e5;
	display: flex;
	justify-content: space-between;
}

.navbar ul {
	list-style: none;
	margin: 0;
	padding: 0;
	display: flex;
}

.navbar li {
	margin-right: 15px;
}

.navbar a {
	color: #333;
	text-decoration: none;
	font-weight: bold;
	font-size: 14px;
}

.navbar a:hover {
	color: #0078ff;
}

/* Header styles */
.purchase-header {
	text-align: center;
	margin: 10px 0;
	font-size: 24px;
	font-weight: bold;
	color: #333;
}

/* Main content styles */
.purchase-list {
	max-width: 900px;
	margin: 0 auto;
	display: flex;
	flex-direction: column;
	gap: 20px;
	padding: 10px;
}

.purchase-order {
	background: #ffffff;
	border: 1px solid #e5e5e5;
	border-radius: 10px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	padding: 20px;
	position: relative;
	width: 60%; /* Takes up 60% of the available width */
	margin: 0 auto; /* Horizontally centers the element */
	margin-bottom: 20px; /* Adds space between each .purchase-order */
}

.order-id-box {
	font-size: 14px;
	font-weight: bold;
	color: #0078ff;
	margin-bottom: 10px;
	position: absolute;
	top: 10px;
	left: 15px; /* 주문 번호를 왼쪽 위에 배치 */
	margin-bottom: 20px;
}

.delivery-info {
	font-size: 14px;
	color: #666;
	margin-bottom: 10px;
}

.purchase-item {
	display: flex;
	align-items: center; /* 이미지와 텍스트를 수평으로 정렬 */
	gap: 20px;
	padding-top: 20px;
}

.item-image {
	width: 100px; /* 이미지 고정 크기 */
	height: 100px;
	border-radius: 8px;
	overflow: hidden;
	border: 1px solid #ddd;
	margin-bottom: 10px; /* 화면 크기 줄어들 때 아래에 간격 추가 */
}

.item-image img {
	width: 100%; /* 부모 div의 크기에 맞게 이미지 크기 조정 */
	height: 100%; /* 부모 div의 크기에 맞게 이미지 크기 조정 */
	object-fit: cover;
}

.item-details {
	flex-grow: 1;
	margin-bottom: 10px;
}

.item-details h3 {
	font-size: 16px;
	margin: 0 0 5px;
	margin-left: 10px;
}

.item-details p {
	font-size: 14px;
	color: #666;
	margin: 2px 0;
	min-width: 200px;
}

/* Load more button */
#loadMoreBtn {
	background-color: #0078ff;
	color: white;
	padding: 10px 20px;
	font-size: 14px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	text-align: center;
	display: block;
	margin: 20px auto 40px auto; /* 위, 아래, 양쪽 마진 설정 */
}

#loadMoreBtn:hover {
	background-color: #005fcc;
}

.navbar ul li a {
	line-height: 5; /* 텍스트 줄 간격을 늘려서 아래로 내려줌 */
}
</style>
</head>
<body>
	<jsp:include page="layout/popUpHeader.jsp" />
	<div class="container">

		<header class="purchase-header">
			<h2>결제 목록</h2>
		</header>


		<section class="purchase-list" id="purchase-list-container">
			<c:set var="previousOrderId" value="null" />
			<!-- 초기값을 null로 설정 -->
			<c:forEach var="item" items="${getPayList}">
				<!-- 새로운 orderId일 때만 블록 시작 -->
				<c:if test="${previousOrderId != item.orderId}">
					<!-- 이전 블록 닫기 -->
					<c:if test="${previousOrderId != null}">
	</div>
	<!-- 이전 purchase-order div 닫기 -->
	</c:if>

	<!-- 새로운 주문 번호 블록 시작 -->
	<div class="purchase-order">
		<div class="order-id-box">주문 번호: ${item.orderId}</div>
		</c:if>

		<!-- 같은 orderId에 속하는 항목 추가 -->
		<div class="purchase-item">
			<c:if test="${not empty item.gimg}">
				<c:forEach var="img" items="${item.gimg}">
					<div class="item-image" id="item-${item.gno}"
						data-file-name="${img.uuid}_${img.fileName}">
						<input type="hidden" value="${img.uuid}_${img.fileName}"
							class="file-name" /> <img id="item-img-${item.gno}"
							alt="${item.gname}" />
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${empty item.gimg}">
				<div class="item-image">
					<img id="item-img-${item.gno}" alt="${item.gname}"
						src="/path/to/default-image.jpg" />
				</div>
			</c:if>


			<div class="item-details">
				<h3 class="item-name">상품명: ${item.gname}</h3>
				<p class="item-quantity">수량: ${item.camount}</p>
				<p class="item-price">가격: ${item.gprice * item.camount}원</p>
				<p class="item-date">구매 날짜: ${item.gbuyDate}</p>
				<p class="item-status">상품 현황: ${item.gsituation}</p>
			</div>
		</div>

		<!-- 이전 orderId 업데이트 -->
		<c:set var="previousOrderId" value="${item.orderId}" />
		</c:forEach>

		<!-- 마지막 주문 블록 닫기 -->
		<c:if test="${previousOrderId != null}">
	</div>
	<!-- 마지막 purchase-order div 닫기 -->
	</c:if>
	</section>

	<button id="loadMoreBtn" data-page="1"
		style="display: block; margin: 20px auto;">더보기</button>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<!-- container div 끝 -->
	<jsp:include page="layout/popUpNavBar.jsp" />
	<jsp:include page="layout/popUpFooter.jsp" />

	<script type="text/javascript"
		src="/resources/purchaseJs/paymentList.js"></script>

</body>
</html>
