<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    // 총 결제 금액 받기
    String grandTotal = request.getParameter("grandTotal");

    // userNo
    String userNo = request.getParameter("userNo");
%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="/resources/images/favicon.ico">
<meta charset="UTF-8">
<title>결제 정보 입력</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>


.container{
background-color:white;
  margin-bottom: 20px; /* Remove bottom margin */
  padding-bottom: 20px; /

}
/* 결제 수단 버튼 스타일 */
.payment-method-btn {
	background-color: #007bff;
	color: white;
	padding: 15px 30px;
	font-size: 16px;
	font-weight: bold;
	border: none;
	border-radius: 50px;
	cursor: pointer;
	transition: all 0.3s ease;
	width: 100%;
	max-width: 220px; /* 버튼 최대 너비 */
	margin: 5px;
}

.payment-method-btn:hover {
	background-color: #0056b3;
	transform: translateY(-3px);
}

.payment-method-btn:focus {
	outline: none;
}

.payment-method-btn img {
	max-height: 25px;
	margin-right: 10px;
}

.payment-method-btn span {
	vertical-align: middle;
}

.btn-group {
	display: flex;
	justify-content: center;
	gap: 15px;
	margin-top: 20px;
}

.required {
	color: red;
}

.hide {
	display: none;
}

.center-btn-container {
	text-align: center; /* 수평 중앙 정렬 */
}

.bank-transfer-btn {
	display: inline-block;
	padding: 10px 15px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	width: 80%;
	box-sizing: border-box;
}

.bank-transfer {
	position: relative;
}

.bank-transfer-btn:hover {
	background-color: #0056b3;
}

.custom-dropdown {
	margin-top: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	background-color: white;
	position: absolute;
	width: 80%;
	max-height: 200px;
	overflow-y: auto;
	z-index: 999;
	box-sizing: border-box;
	left: 50%; /* 화면의 가로 중앙 위치 */
	transform: translateX(-50%); /* 실제로 가운데 정렬 */
}

.dropdown-option {
	padding: 10px;
	cursor: pointer;
}

.dropdown-option:hover {
	background-color: #f0f0f0;
}

.selected-account {
	display: block; /* 계좌 표시를 블록 레벨로 설정 */
	margin-top: 10px; /* 버튼과 계좌 간의 간격 조정 */
	font-size: 16px;
	font-weight: bold;
	color: #333;
	width: 100%; /* 전체 폭을 차지하도록 */
}

.payment-method-btn#toss, .payment-method-btn#kakaopay {
	background-color: #ffffff; /* 흰색 배경 */
	color: #007bff; /* 글자색은 파란색 */
	padding: 15px 30px;
	font-size: 16px;
	font-weight: bold;
	border: 1px solid #007bff; /* 테두리 색상 */
	border-radius: 50px;
	cursor: pointer;
	transition: all 0.3s ease;
	width: 100%; /* 가로 길이를 100%로 설정 */
	max-width: 300px; /* 최대 너비를 설정 */
	margin: 5px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.payment-method-btn#toss img, .payment-method-btn#kakaopay img {
	max-height: 30px; /* 이미지 높이를 조금 더 키우기 */
	margin-right: 15px; /* 이미지와 텍스트 간의 간격 */
}

.payment-method-btn#toss span, .payment-method-btn#kakaopay span {
	vertical-align: middle; /* 텍스트를 가운데 정렬 */
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
<body>
	
	<jsp:include page="layout/popUpHeader.jsp" />


	<br><br>
	<div class="container">
	<br><br>
			<h1 class="text-center">결제 정보 입력</h1>


		<div class="container my-4">
			<!-- 구매자 정보 테이블 -->
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>구매자 정보</th>
						<th>상세 입력</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>이름</td>
						<td><input type="text" class="form-control" id="userName"
							value="${getPayInfo.userName}" readonly></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="email" class="form-control" id="userEmail"
							value="${getPayInfo.userEmail}" readonly></td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td><input type="tel" class="form-control" id="userNumber"
							value="${getPayInfo.userNumber}" readonly></td>
					</tr>
					<tr>
						<td>배송지 주소</td>
						<td><input type="text" id="sample6_postcode"
							placeholder="우편번호"> <input type="button"
							onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
							<input type="text" id="sample6_address" placeholder="주소"><br>
							<input type="text" id="sample6_detailAddress" placeholder="상세주소">
							<input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
						</td>
					</tr>
					<tr>
						<td>배송 요청 사항</td>
						<td><select class="form-control" id="deliveryRequest">
								<option value="">선택하세요</option>
								<option value="부재 시 경비실에 맡겨주세요">부재 시 경비실에 맡겨주세요</option>
								<option value="직접 전달해 주세요">직접 전달해 주세요</option>
								<option value="배송 전에 연락 주세요">배송 전에 연락 주세요</option>
								<option value="문 앞에 놔주세요">문 앞에 놔주세요</option>
								<option value="직접 입력">직접 입력</option>
						</select></td>
					</tr>
				</tbody>
			</table>

			<!-- 결제 정보 테이블 -->
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>결제 정보</th>
						<th>상세 입력</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>가격</td>
						<td><input type="text" class="form-control" id="priceInput"
							value="<%= grandTotal %>" readonly></td>
					</tr>
					<tr>
						<td>배송비</td>
						<td><input type="text" class="form-control" value="무료"
							readonly></td>
					</tr>
					<tr>
						<td>총 결제 금액</td>
						<td><input type="text" class="form-control" id="totalPrice"
							value="<%= grandTotal %>" readonly></td>
					</tr>
					<tr>
						<td>결제 수단</td>
						<td>
							<!-- 실시간 계좌이체 체크박스 및 은행 선택 --> <!-- 실시간 계좌이체 버튼 및 은행 선택 -->
							<div class="bank-transfer">
								<div class="center-btn-container">
									<button id="bankTransferButton" class="bank-transfer-btn">실시간
										계좌이체</button>
								</div>
								<!-- 선택된 계좌 표시 영역, 버튼 바로 아래에 위치 -->
								<div id="selectedAccount" class="selected-account hide">
									선택된 계좌: <span id="accountName"></span>
								</div>
								<div id="customDropdown" class="custom-dropdown hide">
									<div class="dropdown-option" data-value="우리은행">우리은행
										(123-1234123-1-123 예금주:hypePop)</div>
									<div class="dropdown-option" data-value="신한은행">신한은행
										(110-112-123456 예금주:hypePop)</div>
									<div class="dropdown-option" data-value="국민은행">국민은행
										(1234567-112-123456 예금주:hypePop)</div>
								</div>
							</div> <!-- 결제 수단 버튼들 -->
							<div class="btn-group">
								<button class="payment-method-btn" id="toss">
									<img src="/resources/images/tossSymbol.png" alt="토스페이" /> <span>토스페이
										& 신용/체크카드</span>
								</button>
								<button class="payment-method-btn" id="kakaopay">
									<img src="/resources/images/kakaoPayLogo.png" alt="카카오페이" /> <span>카카오페이</span>
								</button>
							</div>
						</td>
					</tr>
				</tbody>
			</table>


		</div>
	</div><br><br><br><br><br><br>
	<jsp:include page="layout/popUpNavBar.jsp" />
	<jsp:include page="layout/popUpFooter.jsp" />
	<script type="text/javascript" src="/resources/memberJs/myPage.js"></script>
	<script type="text/javascript" src="/resources/purchaseJs/myCart.js"></script>


	<!-- JS 라이브러리 -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/resources/purchaseJs/payInfo.js"></script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="/resources/purchaseJs/main.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
</body>
</html>
