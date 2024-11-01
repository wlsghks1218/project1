<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Helvetica Neue', Arial, sans-serif;
	background-color: #141414; /* 넷플릭스 스타일의 어두운 배경 */
	color: white;
}

.popUpHeader {
	width: 100%;
	display: flex;
	align-items: center;
	background-color: #141414; /* 어두운 배경 */
	padding: 10px 20px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5); /* 헤더 하단에 그림자 */
}

#hamburgerBTN {
	width: 25px; /* 햄버거 버튼 크기 조정 */
	cursor: pointer;
}

#mainLogoDiv, #goodsMainLogoDiv {
	flex: 0 0 10%; /* 로고를 위한 고정 크기 */
	text-align: left;
}

#mainLogo, #goodsMainLogo {
	font-size: 24px;
	font-weight: bold;
}

#goodsSearchBoxDiv {
	flex: 1; /* 검색 박스가 나머지 공간을 차지 */
	display: flex;
	justify-content: center;
	align-items: center;
}

#goodsSearchBox {
	width: 60%;
	height: 35px;
	background-color: #333; /* 어두운 배경 */
	color: white;
	border: none;
	border-radius: 20px;
	padding-left: 20px;
	font-size: 16px;
	outline: none;
}

#searchBTN {
	margin-left: 10px;
	font-size: 16px;
	background-color: #e50914; /* 넷플릭스의 빨간색 */
	padding: 8px 20px;
	border-radius: 20px;
	cursor: pointer;
	transition: background-color 0.3s;
}

#searchBTN:hover {
	background-color: #f40612; /* hover 효과 */
}

#noticeDiv {
	flex: 0 0 5%; /* 알림 영역 고정 크기 */
	text-align: right;
	font-size: 16px;
	cursor: pointer;
}

#hamburgerList ul {
	list-style: none;
	padding: 0;
	margin: 0;
	position: absolute;
	top: 60px;
	left: 0;
	background-color: #333; /* 어두운 메뉴 배경 */
	width: 200px;
	display: none;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5); /* 메뉴 그림자 */
	z-index:1000;
}

#hamburgerList ul li {
	padding: 15px 20px;
	cursor: pointer;
	color: white;
	transition: background-color 0.3s;
}

#hamburgerList ul li:hover {
	background-color: #444; /* 마우스 오버 시 배경색 */
}

.show {
	display: block;
}

/* 전체 화면에 맞게 조정 */
.main {
	padding: 20px;
	text-align: center;
	min-height: 100vh; /* 최소 높이를 화면 크기에 맞게 */
}

.main h1 {
	font-size: 36px;
	margin-bottom: 20px;
}
</style>
</head>
<body>
	<div class="popUpHeader">
		<div id="hamburgerDiv">
			<img id="hamburgerBTN" src="/resources/images/hamburger.png">
		</div>
		<div id="mainLogoDiv">
			<span id="mainLogo">메인 로고</span>
		</div>
		<div id="goodsMainLogoDiv">
			<span id="goodsMainLogo">굿즈 메인 로고</span>
		</div>
		<div id="goodsSearchBoxDiv">
			<input type="text" id="goodsSearchBox"> <span id="searchBTN">검색</span>
		</div>
		<div id="noticeDiv">
			<span id="notice">알림</span>
		</div>
	</div>
	<div id="hamburgerList">
		<ul>
			<li id="searchPopUp">팝업 스토어 검색</li>
			<li id="goodsSearch">굿즈 검색</li>
			<li id="aroundMe">내 주변</li>
			<li id="calendar">캘린더</li>
			<li id="support">고객센터</li>
			<li id="login">로그인</li>
			<li id="signIn">회원가입</li>
		</ul>
	</div>
	<div class="main">