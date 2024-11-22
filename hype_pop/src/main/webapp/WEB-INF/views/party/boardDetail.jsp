<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix = "sec" %>   
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="/resources/images/favicon.ico">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 기본 스타일 */
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #00aff0; /* 배경색 변경 */
	color: #ffffff; /* 텍스트 흰색 */
}

/* 메인 배너 스타일 */
.banner {
	text-align: center;
	padding: 30px;
	background-color: #0088cc; /* 배너 배경색 */
	color: #ffffff; /* 텍스트 흰색 */
	font-size: 1.8em;
	font-weight: bold;
	margin-bottom: 20px;
}

/* 콘텐츠 영역 스타일 */
.content {
	max-width: 800px;
	margin: 0 auto;
	padding: 20px;
	background-color: #00Aff0; /* 콘텐츠 배경색 */
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5); /* 그림자 효과 추가 */
	color: #ffffff; /* 텍스트 흰색 */
}

/* 파티 정보 섹션 스타일 */
.info-section {
	margin-bottom: 15px;
	padding: 15px;
	background-color: #ffffff; /* 정보 섹션 배경 */
	border-radius: 5px;
	display: flex;
	align-items: center;
}

.category {
	flex: 0 0 20%;
	font-size: 1em;
	font-weight: bold;
	color: #000000; /* 카테고리 텍스트 흰색 */
	margin-right: 10px;
	text-transform: uppercase; /* 텍스트 대문자 */
}

.targetName {
	flex: 1;
	font-size: 1em;
	color: #000000;
	opacity: 0.9; /* 약간의 투명도 */
}

/* 게시글 제목 스타일 */
.boardTitle {
	font-size: 1.4em; /* 텍스트 크기 조정 */
	color: #000000; /* 텍스트 흰색 */
	font-weight: bold;
	margin-top: 15px;
	border-bottom: 2px solid #0088cc; /* 하단 경계선 */
	padding-bottom: 5px;
}

/* 실시간 채팅 제목 */
.chat-title {
	font-size: 1.5em;
	color: #000000; /* 텍스트 흰색 */
	margin: 20px 0;
	text-align: center;
}

/* 채팅 영역 스타일 */
#chatArea {
    display: flex;
    flex-direction: column;
    height: 400px; /* 고정 높이 설정 */
    overflow-y: auto;
    padding: 10px;
    background-color: #ffffff;
    border-radius: 8px;
    margin-bottom: 10px; /* 입력창과의 간격 */
}

/* 채팅 입력 영역 스타일 */
#chatInputContainer {
	margin-top: 10px;
}

/* 채팅 입력창 스타일 */
#msg {
	width: 100%;
	padding: 10px;
	border: none;
	border-radius: 4px;
}

/* 버튼 스타일 */
#sendButton, #leavePartyBtn, #scrollToBottomButton {
	background-color: #0088cc; /* 버튼 배경색 */
	color: #ffffff;
	padding: 10px;
	width: 100%;
	font-size: 1em;
	font-weight: bold;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s ease, transform 0.2s ease;
	margin-top : 10px;
}

#sendButton:hover, #leavePartyBtn:hover, #scrollToBottomButton:hover {
	background-color: #000000;
}

/* 버튼 영역 스타일 */
#buttonArea {
	text-align: center;
	margin-top: 20px;
}

/* 전체 메시지 스타일 */
#chatArea .message {
	display: flex;
	margin: 5px 0;
	max-width: 100%; /* 채팅창 너비를 화면의 80%로 제한 */
}

.my-message {
    justify-content: flex-end; /* 내 메시지를 오른쪽으로 */
}

.my-message .name {
    color: #000000; /* 내 이름 흰색 */
    margin-left: 8px;
    padding: 5px 10px;
}

.my-message .content {
    background-color: #00Aff0; /* 내 메시지 배경색 */
    color: #000000;
    padding: 5px 10px;
    border-radius: 8px;
    margin-right: 5px;
}

.other-message {
    justify-content: flex-start; /* 다른 유저의 메시지를 왼쪽으로 */
}

.other-message .name {
    color: #000000; /* 다른 유저 이름 노란색 */
    margin-right: 8px;
    padding: 5px 10px;
}

.other-message .content {
    background-color: #fee7ed; /* 다른 유저 메시지 배경색 */
    color: #000000;
    padding: 5px 10px;
    border-radius: 8px;
    margin-left: 5px;
}

/* 상태 메시지 (중앙 정렬) */
.state-message {
    text-align: center;
    color: #000000; /* 상태 메시지 텍스트 흰색 */
    font-size: 0.9em;
    margin: 10px 0; /* 위아래 여백 추가 */
}
.moveToDetail{
	color: #000000;
}
.memberCount {
    font-size: 1.2em;
    font-weight: bold;
    margin: 10px auto;
    text-align: center;
    background-color: #ffffff; /* 흰색 배경 */
    color: #000000; /* 검은색 텍스트 */
    padding: 10px;
    border: 2px solid #000000; /* 검은색 테두리 */
    border-radius: 8px;
    max-width: 300px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
}

/* joinMember 스타일 */
.joinMember {
    font-size: 1em;
    color: #000000; /* 텍스트 검은색 */
    background-color: #ffffff; /* 흰색 배경 */
    padding: 15px;
    margin: 15px auto;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
    border: 2px solid #000000; /* 검은색 테두리 */
    max-width: 300px;
}

.joinMember h3 {
    font-size: 1.2em;
    margin-bottom: 10px;
    color: #000000; /* 제목 검은색 */
}

.joinMember div {
    padding: 5px;
    border-bottom: 1px solid #cccccc; /* 경계선 */
}

.joinMember div:last-child {
    border-bottom: none; /* 마지막 요소 경계선 제거 */
}
</style>
</head>
<body>
	<jsp:include page="layout/popUpHeader.jsp" />
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="pinfo"/>
   		<input type="hidden" id="userNo" value="${pinfo.member.userNo}">
   		<input type="hidden" id="userId" value="${pinfo.member.userId}">
	</sec:authorize>
	<div class="content">
		<div class="info-section">
			<div class="category">${vo.category}</div>
			<div class="targetName">${vo.targetName}</div>
			<div><span class="moveToDetail">>> 상세 페이지로 이동하기</span></div>
		</div>
		<div class="boardTitle">${vo.boardTitle}</div>
		<div class="chat-title">실시간 채팅</div>
		<div id="chatUserInfo">
			<div class="memberCount"></div>
			<div class="joinMember"></div>
		</div>

		<div id="chatArea"></div>
		<button id="scrollToBottomButton" style="display:none;">채팅 하단으로 이동</button>
		<div id="chatInputContainer">
			<input type="text" id="msg" placeholder="메시지를 입력하세요">
			<button id="sendButton">전송</button>
		</div>
		<div id="leaveParty">
			<button id="leavePartyBtn">파티 나가기</button>
		</div>
	</div>
	<jsp:include page="layout/partyFooter.jsp" />
	<jsp:include page="layout/partyNavBar.jsp" />
</body>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src="/resources/partyJs/boardDetail.js"></script>
<script type="text/javascript" src="/resources/partyJs/partyHeader.js"></script>
<script type="text/javascript" src="/resources/partyJs/partyNav.js"></script>
</html>
