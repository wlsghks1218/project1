<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 기본 스타일 */
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #141414;
	color: #ffffff;
}

/* 메인 배너 스타일 */
.banner {
	text-align: center;
	padding: 30px;
	background-color: #333;
	color: #e50914;
	font-size: 1.8em;
	font-weight: bold;
	margin-bottom: 20px;
}

/* 콘텐츠 영역 스타일 */
.content {
	max-width: 800px;
	margin: 0 auto;
	padding: 20px;
	background-color: #222;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5); /* 그림자 효과 추가 */
}

/* 파티 정보 섹션 스타일 */
.info-section {
	margin-bottom: 15px;
	padding: 15px;
	background-color: #333;
	border-radius: 5px;
	display: flex;
	align-items: center;
}

.category {
	flex: 0 0 20%;
	font-size: 1em;
	font-weight: bold;
	color: #e50914;
	margin-right: 10px;
	text-transform: uppercase; /* 텍스트 대문자 */
}

.targetName {
	flex: 1;
	font-size: 1em;
	color: #ffffff;
	opacity: 0.9; /* 약간의 투명도 */
}

/* 게시글 제목 스타일 */
.boardTitle {
	font-size: 1.4em; /* 텍스트 크기 조정 */
	color: #e50914;
	font-weight: bold;
	margin-top: 15px;
	border-bottom: 2px solid #444;
	padding-bottom: 5px;
}

/* 실시간 채팅 제목 */
.chat-title {
	font-size: 1.5em;
	color: #e50914;
	margin: 20px 0;
	text-align: center;
}

/* 채팅 영역 스타일 */
#chatArea {
	max-height: 400px;
	overflow-y: auto;
	padding: 10px;
	background-color: #333;
	border-radius: 8px;
}

/* 채팅 입력 영역 스타일 */
#chatInputContainer {
	margin-top: 10px;
}

/* 채팅 입력창 스타일 */
#msg {
	width: 100%;
	padding: 10px;
}

/* 버튼 스타일 */
#sendButton {
	background-color: #e50914;
	color: #ffffff;
	padding: 10px;
	width: 100%;
	font-size: 1em;
	font-weight: bold;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

#sendButton:hover {
	background-color: #f40612;
}

/* 버튼 영역 스타일 */
#buttonArea {
	text-align: center;
	margin-top: 20px;
}

button:hover {
	background-color: #f40612;
}

/* 전체 메시지 스타일 */
#chatArea .message {
	display: flex;
	margin: 5px 0;
	max-width: 80%; /* 채팅창 너비를 화면의 80%로 제한 */
}

/* 내 메시지 (왼쪽 정렬) */
.my-message {
	justify-content: flex-start;
}

.my-message .name {
	font-weight: bold;
	color: #e50914;
	margin-right: 8px;
}

.my-message .content {
	background-color: #222;
	padding: 5px 10px;
	border-radius: 8px;
	color: #fff;
	margin-left: 5px;
}

/* 다른 사람 메시지 (오른쪽 정렬) */
.other-message {
	justify-content: flex-end;
}

.other-message .name {
	font-weight: bold;
	color: #00aaff;
	margin-left: 8px;
}

.other-message .content {
	background-color: #444;
	padding: 5px 10px;
	border-radius: 8px;
	color: #fff;
	margin-right: 5px;
}
</style>
</head>
<body>
	<jsp:include page="layout/popUpHeader.jsp" />
	<div class="banner">여기는 게시판 메인 배너</div>

	<div class="content">
		<div class="info-section">
			<div class="category">${vo.category}</div>
			<div class="targetName">${vo.targetName}</div>
		</div>
		<div class="boardTitle">${vo.boardTitle}</div>
		<div class="chat-title">실시간 채팅</div>
		<div class="joinMember"></div>

		<div id="chatArea"></div>
		<button id="scrollToBottomButton" style="display:none;">채팅 하단으로 이동</button>
		<div id="chatInputContainer">
			<input type="text" id="msg" placeholder="메시지를 입력하세요">
			<button id="sendButton">전송</button>
		</div>
	</div>
	<jsp:include page="layout/popUpFooter.jsp" />
	<jsp:include page="layout/goodsNavBar.jsp" />
</body>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src="/resources/partyJs/boardDetail.js"></script>
</html>
