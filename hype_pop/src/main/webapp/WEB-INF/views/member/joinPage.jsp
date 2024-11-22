<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="icon" href="/resources/images/favicon.ico">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<!-- CSS 링크 추가 -->
<!-- <link rel="stylesheet" type="text/css" href="/resources/css/joinPage.css">
 -->
<style type="text/css">
/* 기본 스타일 */
body {
	font-family: Arial, sans-serif;
	background-color: #fCE4EC;
	margin: 0;
	padding-bottom: 100px; /* 하단 여백을 100px로 설정 */
	overflow-x: hidden; /* 가로 스크롤 방지 */
	height: 100%;
	overflow-y: auto;
}

/* 헤더 스타일 */
header {
	background-color: #2196F3;
	color: white;
	padding: 5px;
	text-align: center;
}

.home-link {
	color: white;
	text-decoration: none;
	font-size: 16px;
	position: absolute;
	left: 20px;
	top: 20px;
}

/* 컨테이너 스타일 */
.container {
	max-width: 600px;
	margin: 50px auto;
	padding: 20px;
	background-color: white;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
	max-height: 100vh; /* 화면의 높이를 넘지 않도록 설정 */
	padding: 40px 20px; /* 상단, 하단 여백을 넉넉하게 설정 (상단 40px, 하단 20px) */
	box-sizing: border-box; /* padding이 요소 크기에 포함되도록 설정 */
}

.input-group {
	display: flex;
	align-items: center;
	justify-content: center;
	width: 100%;
	margin-bottom: 15px;
}

.input-group label {
	display: block;
	margin-right: 10px;
	font-weight: bold;
	flex-basis: 100px;
	font-size: 14px;
}

.input-group input {
	flex-grow: 1;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	margin-right: 10px;
}

#idCardNum2 {
	margin-left: 10px;
}

.verified {
	background-color: lightgray;
}

#interestBtn, #joinBtn, #duplicateCheckButton {
	background-color: #2196F3;
	color: white;
	border: none;
	padding: 10px 15px;
	border-radius: 4px;
	cursor: pointer;
}

.interestModal {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	display: flex;
	align-items: center;
	justify-content: center;
	z-index: 1000;
}

.interestBoxContainer {
	background: white;
	padding: 20px;
	border-radius: 8px;
	max-width: 80%;
	overflow-y: auto;
	max-height: 80%;
}

.interestBox {
	display: inline-block;
	padding: 10px;
	margin: 5px;
	margin-bottom: 10px;
	background-color: #e7e7e7;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.interestBox label {
	cursor: pointer;
}

.selectedBox {
	background-color: #0056b3;
	color: white;
}

.confirm-button, .close-button {
	background-color: #2196F3;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 4px;
	cursor: pointer;
	margin-top: 20px; /* 위쪽 여백을 추가 */
	width: 100%; /* 버튼의 너비를 100%로 설정 */
	align-items: center;
}

.selectedInterests {
	display: inline-block;
	padding: 8px 12px;
	margin: 5px;
	border-radius: 4px;
}

.selectedInterestBox {
	display: inline-block;
	padding: 8px 12px;
	margin: 5px;
	background-color: #e7e7e7;
	border-radius: 4px;
	box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
	font-size: 14px;
	color: #333;
	font-weight: bold;
}

.agreement {
	margin-bottom: 10px;
}

.toggle-switch {
	position: relative;
	display: inline-block;
	width: 34px;
	height: 20px;
}

.toggle-switch input {
	opacity: 0;
	width: 0;
	height: 0;
}

.slider {
	position: absolute;
	cursor: pointer;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #ccc;
	transition: .4s;
	border-radius: 20px;
}

.slider:before {
	position: absolute;
	content: "";
	height: 16px;
	width: 16px;
	left: 2px;
	bottom: 2px;
	background-color: white;
	border-radius: 50%;
	transition: .4s;
}

input:checked+.slider {
	background-color: #0056b3;
}

input:checked+.slider:before {
	transform: translateX(14px);
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.closehover, .closefocus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.modal-trigger {
	background: none; /* 배경 제거 */
	border: none; /* 테두리 제거 */
	color: inherit; /* 글자 색상 (부모의 색상 상속) */
	cursor: pointer; /* 커서를 포인터로 변경 */
	padding: 0; /* 패딩 제거 */
	font-size: inherit; /* 부모 요소의 글꼴 크기를 상속 */
	outline: none; /* 포커스 시 외곽선 제거 */
}

.modal-trigger:hover {
	text-decoration: underline; /* 호버 시 강조 효과 (선택 사항) */
}

/* 모달 배경 */
.modal {
	position: fixed; /* 스크롤을 해도 고정 */
	display: none; /* 기본적으로 모달을 숨김 */
	z-index: 1000; /* 다른 요소 위에 표시되도록 설정 */
	left: 0;
	top: 0;
	width: 100%; /* 전체 화면 너비 */
	height: 100%; /* 전체 화면 높이 */
	background-color: rgba(0, 0, 0, 0.5); /* 반투명 검정 배경 */
}

/* 모달 내용 */
.modal-content {
	background-color: rgba(255, 255, 255, 0.85);
	color: black;
	padding: 20px;
	border: 1px solid #888;
	width: 38%; /* 가로 길이 */
	height: 50%; /* 세로 길이 */
	overflow-y: auto; /* 내용이 넘칠 경우 스크롤 가능 */
	border-radius: 8px; /* 모서리 둥글게 */
	/* 중앙 정렬 */
	position: absolute;
	top: 50%; /* 세로 중앙 */
	left: 50%; /* 가로 중앙 */
	transform: translate(-50%, -50%); /* 정확한 중앙 위치 */
}

/* 닫기 버튼 */
.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}
/* 체크박스 라벨에 스타일을 추가해서, 체크박스를 더 직관적으로 만들어줌 */
.interestBox input[type="checkbox"] {
	display: none; /* 체크박스를 보이지 않게 숨기고 */
}
/* 모달 창 스타일 */
.userInterest {
	position: relative;
	padding: 20px;
	width: 400px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	top: 20px;
}
/* 닫기 버튼 오른쪽 위로 배치 */
.close-interest {
	position: absolute;
	top: 10px;
	right: 10px;
	font-size: 24px;
	cursor: pointer;
	color: #333;
}

.confirm-button:hover {
	background-color: #0056b3;
}
/* 선택된 관심사 텍스트 스타일 */
#selectedInterests {
	font-weight: bold;
	color: black;
}

/* 선택된 항목을 빨간색으로 굵게 표시 */
.selected {
	color: black;
	font-weight: bold;
}

#validateBtn {
	padding: 8px 15px; /* padding */
	border: none; /* 테두리 없애기 */
	border-radius: 4px; /* 둥근 테두리 */
	cursor: pointer; /* 커서가 손 모양으로 변경 */
	display: inline-flex; /* 버튼 안의 텍스트를 가로로 나열 */
	justify-content: center; /* 텍스트 중앙 정렬 */
	align-items: center; /* 텍스트 세로 중앙 정렬 */
	text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.15); /* 글씨 그림자 */
}
/* 첫 번째 input (생년월일) 스타일 */
#idCardNum {
	padding: 8px 12px; /* padding */
	font-size: 14px; /* 글씨 크기 */
	border: 1px solid #ccc; /* 테두리 스타일 */
	border-radius: 4px; /* 둥근 테두리 */
	width: 120px; /* 첫 번째 input 너비 */
}

/* 두 번째 input (뒷자리) 스타일 */
#idCardNum2 {
	padding: 8px 12px; /* padding */
	font-size: 14px; /* 글씨 크기 */
	border: 1px solid #ccc; /* 테두리 스타일 */
	border-radius: 4px; /* 둥근 테두리 */
	width: 120px; /* 두 번째 input 너비 */
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
	margin: 20px 0;
	font-size: 24px;
	font-weight: bold;
	color: #333;
}

.navbar ul li a {
	line-height: 5; /* 텍스트 줄 간격을 늘려서 아래로 내려줌 */
}

.footer {
	text-align: center;
	padding: 20px;
	font-size: 14px;
	color: #666;
	background-color: #ffffff;
	border-top: 1px solid #e5e5e5;
}
</style>



</head>
<body>

	<jsp:include page="layout/popUpHeader.jsp" />
	<header>
		<!-- 홈으로 가는 링크 -->
		<h1>회원가입</h1>
	</header>


	<div class="container">
		<form id="joinForm" action="/member/join" method="post">
			<div class="input-group">
				<label for="userId">아이디</label> <input type="text" id="userId"
					name="userId" placeholder="4~8자, 영문 대소문자와 숫자">
				<button type="button" id="duplicateCheckButton"
					onclick="checkUserId()">중복 확인</button>
			</div>
			<!-- 아이디 중복 확인 버튼 -->

			<div class="input-group">
				<label for="password">비밀번호</label> <input type="password"
					id="userPw" name="userPw" placeholder="8~16자, 문자, 숫자, 특수문자">
			</div>

			<div class="input-group">
				<label for="passwordCheck">비밀번호 확인</label> <input type="password"
					id="passwordCheck" name="passwordCheck"
					placeholder="비밀번호를 다시 입력하세요.">
			</div>

			<div class="input-group">
				<label for="userEmail">이메일</label> <input type="email"
					id="userEmail" name="userEmail" placeholder="이메일을 입력하세요.">
			</div>

			<div class="input-group">
				<label for="userName">이름</label> <input type="text" id="userName"
					name="userName" placeholder="이름을 입력하세요.">
			</div>

			<div class="input-group">
				<label for="userNumber">전화번호</label> <input type="tel"
					maxlength="13" id="userNumber" name="userNumber"
					placeholder="하이픈(-) 제외 숫자만">
			</div>

			<div class="input-group">
				<label for="idCardNum">주민등록번호</label> <input type="text"
					maxlength="6" id="idCardNum" name="idCardNum"
					placeholder="생년월일(YYMMDD)"> - <input type="password"
					maxlength="7" id="idCardNum2" name="idCardNum2">
				<button type="button" id="validateBtn" onclick="confirmIdCardNum()">검증</button>
			</div>


			<!-- 관심사 선택 버튼 -->
			<div>

				<button type="button" id="interestBtn">관심사 선택</button>
			</div>

			<!-- 모달 창  -->
			<div id="userInterest" name="userInterest" class="userInterest"
				style="display: none;">
				<div class="interestBoxContainer">
					<span class="close-interest" onclick="closeInterestModal()">&times;</span>
					<input type="checkbox" style="display: none;">
					<div>
						<p>관심사를 선택하세요(3개 선택 필수)</p>
						<p id="limitMessage" class="limitMessage"
							style="display: none; color: red; font-size: 14px;">관심사 3개를
							선택해 주세요!</p>

					</div>
					<br>
					<!-- 관심사 박스 -->
					<div class="interestBox" data-interest="헬스/뷰티">
						<label for="healthBeauty"> <input type="checkbox"
							class="interestBox" name="userInterest.healthBeauty" value="1">
							헬스/뷰티
						</label>
					</div>
					<div class="interestBox" data-interest="게임">
						<label for="game"> <input type="checkbox"
							name="userInterest.game" value="1"> 게임
						</label>
					</div>
					<div class="interestBox" data-interest="문화">
						<label for="culture"><input type="checkbox"
							name="userInterest.culture" value="1"> 문화</label>
					</div>
					<div class="interestBox" data-interest="쇼핑">
						<label for="shopping"><input type="checkbox"
							name="userInterest.shopping" value="1"> 쇼핑</label>
					</div>
					<div class="interestBox" data-interest="문구">
						<label for="supply"><input type="checkbox"
							name="userInterest.supply" value="1"> 문구</label>
					</div>
					<div class="interestBox" data-interest="키즈">
						<label for="kids"><input type="checkbox"
							name="userInterest.kids" value="1"> 키즈</label>
					</div>
					<div class="interestBox" data-interest="디자인">
						<label for="design"><input type="checkbox"
							name="userInterest.design" value="1"> 디자인</label>
					</div>
					<div class="interestBox" data-interest="식품">
						<label for="foods"><input type="checkbox"
							name="userInterest.foods" value="1"> 식품</label>
					</div>
					<div class="interestBox" data-interest="인테리어">
						<label for="interior"><input type="checkbox"
							name="userInterest.interior" value="1"> 인테리어</label>
					</div>
					<div class="interestBox" data-interest="정책">
						<label for="policy"><input type="checkbox"
							name="userInterest.policy" value="1"> 정책</label>
					</div>
					<div class="interestBox" data-interest="캐릭터">
						<label for="character"><input type="checkbox"
							name="userInterest.character" value="1"> 캐릭터</label>
					</div>
					<div class="interestBox" data-interest="체험">
						<label for="experience"><input type="checkbox"
							name="userInterest.experience" value="1"> 체험</label>
					</div>
					<div class="interestBox" data-interest="콜라보">
						<label for="collaboration"><input type="checkbox"
							name="userInterest.collaboration" value="1"> 콜라보</label>
					</div>
					<div class="interestBox" data-interest="방송">
						<label for="entertainment"><input type="checkbox"
							name="userInterest.entertainment" value="1"> 방송</label>
					</div>

					<button class="confirm-button" onclick="saveInterests()">선택
						완료</button>
				</div>

			</div>

			<br>
			<p id="selectedInterests">선택된 관심사가 없습니다.</p>
			<br>
			<!-- 선택된 관심사 출력 영역 -->
			<!-- <div class="selectedInterests" id="selectedInterests"></div> -->

			<!-- 동의 항목 -->
			<div class="agreement">
				<label>개인정보 처리 방침 동의(필수)</label> <label class="toggle-switch">
					<input type="checkbox" id="privacy" required> <span
					class="slider"></span>
				</label>
				<button class="modal-trigger" onclick="policyModal('privacy')">&gt;</button>
			</div>
			<div class="agreement">
				<label>위치 정보 사용 동의(필수) </label> <label class="toggle-switch">
					<input type="checkbox" id="location" required> <span
					class="slider"></span>
				</label>
				<button class="modal-trigger" onclick="policyModal('location')">&gt;</button>
			</div>
			<div class="agreement">
				<label>알림 수신 동의(필수)</label> <label class="toggle-switch"> <input
					type="checkbox" id="notification" required> <span
					class="slider"></span>
				</label>
				<button class="modal-trigger" onclick="policyModal('notification')">&gt;</button>
			</div>

			<button type="button" id="joinBtn" onclick="formSubmit()">회원가입
				버튼</button>
		</form>

	</div>
	<!-- 푸터 포함 -->
	<jsp:include page="layout/popUpFooter.jsp" />
	<jsp:include page="layout/popUpNavBar.jsp" />




	<!--동의 내용 모달  -->

	<!--개인정보 처리 방침 동의 모달  -->
	<div id="policyModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closePolicyModal()">&times;</span>
			<div id="modalContent"></div>
		</div>
	</div>

	<!--위치기반서비스 동의 모달  -->
	<div id="locationModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>
			<div id="modalContent"></div>
		</div>
	</div>


	<!--마케팅 알림 수신 동의 안내  -->

	<div id="notificationModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>
			<div id="modalContent"></div>

		</div>
	</div>






	<script type="text/javascript" src="/resources/memberJs/joinPage.js"></script>
</body>
</html>
