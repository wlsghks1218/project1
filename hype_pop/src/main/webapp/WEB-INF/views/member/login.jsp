<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="icon" href="/resources/images/favicon.ico">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인</title>
<link rel="stylesheet">
<!-- CSS 파일 링크 -->
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f5f5f5;
	margin: 0;
	padding: 20px;
}

.header {
	text-align: center;
	margin-bottom: 20px;
}

.header a {
	color: #007bff;
	text-decoration: none;
	font-size: 20px;
}

.container {
	max-width: 400px;
	margin: 0 auto;
	padding: 30px;
	background-color: #ffffff;
	border-radius: 5px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

h1 {
	text-align: center;
	color: #333;
	margin-bottom: 20px;
}

label {
	display: block;
	margin: 10px 0 5px;
	color: #555;
}

input[type="text"], input[type="password"], input[type="email"] {
	width: calc(100% - 20px);
	padding: 10px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 16px;
}

.checkbox-group {
	display: flex;
	align-items: center;
	margin-bottom: 15px;
}

.checkbox-group input {
	margin-right: 5px;
}

button {
	width: 100%;
	padding: 10px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	margin-bottom: 10px;
}

button:hover {
	background-color: #0056b3;
}

.link-group {
	display: flex;
	justify-content: space-around;
	padding: 10px;
}

.link-btn {
	background-color: transparent;
	border: none;
	color: #007bff;
	font-size: 16px;
	cursor: pointer;
	text-decoration: underline;
	padding: 5px 10px;
	transition: color 0.3s;
}

.link-btn:focus {
	outline: none;
}

.social-login {
	margin-top: 20px;
	text-align: center;
}

.social-login button {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	margin: 5px;
	background-color: #e0e0e0;
	color: #333;
	border: 1px solid #ccc;
	font-size: 20px;
}

.social-login button:hover {
	background-color: #d0d0d0;
}

/* 모달 기본 스타일 */
.modal {
	position: fixed;
	z-index: 1;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	display: none;
	z-index: 1000;
	background-color: rgba(0, 0, 0, 0.5); /* 배경 어두운 투명도 */
	width: 100%;
	height: 100%;
	overflow: hidden;
}

/* 모달 내용 */
.modal-content {
    background-color: white;
    padding: 20px;
    width: 400px; /* 가로 크기 */
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    text-align: center;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

/* 모달 닫기 버튼 */
.close {
	position: absolute;
	top: 10px;
	right: 10px;
	font-size: 24px;
	font-weight: bold;
	color: #aaa;
	cursor: pointer;
	transition: color 0.3s ease;
}

.close:hover {
	color: #000;
}

/* 모달 내부의 폼 */
.modal-body .form-group {
	margin-bottom: 15px;
}


/* 모달의 제출 버튼 */
.modal-footer {
	text-align: center;
}

.modal-input {
	width: calc(100% - 20px);
	height: 40px;
	padding: 5px;
	font-size: 16px;
	margin: 10px 0;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.modal-footer button {
	width: 100%;
	padding: 10px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.modal-footer button:hover {
	background-color: #0056b3;
}

#customAlert {
	position: fixed;
	top: 10%;
	left: 50%;
	transform: translate(-50%, -50%);
	display: none;
	z-index: 1000;
	background-color: rgba(255, 255, 255, 0.8); /* 흰색 배경에 불투명도 추가 */
	padding: 20px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 약간의 그림자 추가 */
	color: black; /* 글씨 색상 검정 */
}
</style>
</head>
<body>

	<div class="header">
		<a href="/">홈</a>
		<!-- 홈으로 가는 링크 추가 -->
	</div>

	<div class="container">
		<h1>로그인</h1>
		<form action="/member/login" method="post">
		<input type="hidden" id="redirect" name="redirect">  
			<label for="username">아이디</label> <input type="text" id="userId"
				name="userId" required placeholder="아이디를 입력하세요."> <label
				for="password">비밀번호</label> <input type="password" id="userPw"
				name="userPw" required placeholder="비밀번호를 입력하세요.">
            <div class="checkbox-group">
                <input type="checkbox" id="rememberMe" name="remember-me">
                <label for="rememberMe">로그인 상태 유지</label>
            </div>
			<button type="submit" class="btn btn-sec" id="loginBtn">로그인</button>

		</form>

		<div class="link-group">
			<button id="searchIdBtn" class="link-btn">아이디 찾기</button>

			<button id="searchPwBtn" class="link-btn">비밀번호 찾기</button>
			<button onclick="location.href='join'" class="link-btn">회원가입</button>
		</div>
		<div id="customAlert">인증코드를 전송 중입니다.</div>



	</div>

	<!-- 아이디 찾기 모달 -->
	<div id="searchIdModal" style="display: none;">
		<div class="modal-content">
			<!-- X 버튼 추가 -->
			<span class="close" onclick="closeSearchIdModal()">&times;</span>
			<form id="searchIdModal">
				<div class="modal-body">
					<!--이름 입력 -->
					<div class="form-group form-group-inline">
						<input type="text" class="modal-input" id="userName"
							placeholder="이름 입력">
					</div>

					<!-- 이메일 전송 필드 -->
					<div class="form-group form-group-inline">
						<input type="email" class="modal-input" id="userEmail"
							placeholder="이메일 입력">

						<button type="button" id="sendEmailBtn" class="btn btn-sec">이메일
							전송</button>
					</div>

					<!-- 코드 입력 및 확인 버튼 -->
					<div class="form-group form-group-inline">
						<input type="number" class="modal-input" name="verifyCode"
							id="verifyCodeInput" placeholder="코드 입력" required>
						<button type="button" id="sendEmailCode" class="btn btn-sec"
							onclick="verifyEmailCode()">코드 확인</button>
					</div>

					<!-- 아이디 확인하기 버튼 추가 -->
					<div class="form-group">
						<button type="button" id="checkMyId" class="btn btn-sec">아이디
							확인</button>
					</div>
				</div>

			</form>
		</div>
	</div>


	<!-- 비밀번호 찾기 모달 -->
	<div id="foundUserPwModal" style="display: none;">
		<div class="modal-content">
			<!-- X 버튼 추가 -->
			<span class="close" onclick="closeSearchPwModal()">&times;</span>
			<form action="/member/goPwChange" method="get"
				id="passwordChangeForm" onsubmit="return submitPwChange()">
				<div class="modal-body">
					<div class="form-group">
						<p>
							<input type="text" class="modal-input" name="userId"
								id="userIdSearchPw" placeholder="아이디 입력" required>
						</p>
						<button type="button" id="confirmId" class="btn btn-sec">아이디
							확인</button>
					</div>
					<div class="form-group form-group-inline">
						<input type="email" class="modal-input" id="userEmailPw"
							placeholder="이메일 입력">

						<button type="button" id="sendEmailBtnPw" class="btn btn-sec">이메일
							전송</button>
					</div>

					<!-- 코드 입력 및 확인 버튼 -->
					<div class="form-group form-group-inline">
						<input type="number" class="modal-input" name="verifyCodeInputPw"
							id="verifyCodeInputPw" placeholder="코드 입력" required>
						<button type="button" id="verifyCodeInputPw" class="btn btn-sec"
							onclick="verifyEmailCodePw()">코드 확인</button>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" "
						class="btn btn-sec">비밀번호
						변경하기</button>
				</div>


			</form>
		</div>
	</div>


	<script type="text/javascript" src="/resources/memberJs/login.js"></script>
	<script src="https://accounts.google.com/gsi/client" async defer></script>

</body>
</html>
