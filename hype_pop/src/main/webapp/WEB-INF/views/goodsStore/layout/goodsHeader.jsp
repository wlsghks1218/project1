<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 기본 스타일 초기화 */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    background-color: #fee7ed; /* 전체 배경 색상 */
}

/* 헤더 스타일 */
.popUpHeader {
    width: 100%;
    display: flex;
    align-items: center;
    padding: 5px 20px;
    background-color: #fee7ed;
    position: relative;
    z-index: 1002;
}

/* 메인 로고 및 햄버거 버튼 역할 */
#mainLogoButton {
    background: none;
    border: none;
    cursor: pointer;
    display: flex;
    align-items: center;
    margin-right: 20px; /* 로고와 검색창 사이의 간격 */
    z-index: 1002;
}

#mainLogo img {
    max-height: 35px;
    width: auto;
}

/* 검색 및 알림 스타일 */
#popUpSearchBox {
    display: flex;
    align-items: center; /* 버튼과 검색창 수직 정렬 */
    justify-content: center; /* 중앙 정렬 추가 */
    flex-grow: 1; /* 검색창을 가운데 정렬 */
    margin: 0 20px; /* 좌우 간격 추가 */
}

#popUpSearchBox input {
    padding: 12px 20px; /* 패딩을 약간 증가시켜 높이 조정 */
    width: 600px; /* 크기 두 배 증가 */
    border: 1px solid #ccc;
    border-radius: 25px; /* 끝부분 둥글게 */
    outline: none;
    text-align: center; /* 텍스트 중앙 정렬 */
    font-size: 16px;
    margin-right: 10px; /* 검색 버튼과의 간격 */
}

#popUpSearchClick, #noticeDiv {
    cursor: pointer;
}

/* 알림 버튼 */
#noticeDiv {
    margin-left: 20px; /* 검색창과 알림 버튼 사이의 간격 */
}

/* 슬라이드 메뉴 */
#logoContainer {
    position: fixed;
    top: 0;
    left: 0;
    height: auto;
    width: 150px;
    background-color: #fee7ed;
    transform: translateX(-100%);
    transition: transform 0.3s ease;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding-top: 60px;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    z-index: 1001;
}

#logoContainer.show {
    transform: translateX(0);
}

#logoContainer div {
    padding: 15px;
    cursor: pointer;
    width: 100%;
    text-align: center;
    transition: background-color 0.3s;
}

#logoContainer div:hover {
    background-color: #f0f0f0;
}

#logoContainer img {
    max-height: 50px;
    width: auto;
}

/* 오버레이 */
.overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0, 0, 0, 0.5);
    display: none;
    z-index: 999;
}

.overlay.show {
    display: block;
}

/* 오버레이에서 메인 로고와 슬라이더 제외 */
.noOverlay {
    z-index: 1003; /* 최상위로 올려서 슬라이더보다 위에 표시 */
    position: relative;
}

#alarmDiv {
    display: inline-block; /* 버튼이 세로로 쌓이지 않게 */
    margin-left: 20px; /* 검색창과 알림 버튼 사이의 간격 */
    position: relative; /* 절대 위치를 기준으로 하기 위해 relative로 설정 */
}

/* 알림 목록 스타일 */
#notificationList {
    display: none;
    position: absolute;
    top: 70px;
    right: 20px;
    background-color: white;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
    z-index: 1000;
    padding: 15px;
    width: 500px; /* 너비 증가 */
    max-height: 400px; /* 최대 높이 설정 */
    overflow-y: auto; /* 스크롤 추가 */
}

#notificationList div {
    margin: 5px 0; /* 여백 */
    padding: 5px; /* 여백 */
    border-bottom: 1px solid #eee; /* 구분선 */
}

#notificationList div:last-child {
    border-bottom: none; /* 마지막 아이템의 구분선 제거 */
}

.notification-dot {
    position: absolute; /* 아이콘에 겹치게 하기 위해 절대 위치 설정 */
    bottom: 8px; /* 알림 버튼 아래 위치 */
    right: 28px; /* 알림 버튼 오른쪽 위치 */
    width: 10px; /* 점의 너비 */
    height: 10px; /* 점의 높이 */
    background-color: red; /* 빨간색 */
    border-radius: 50%; /* 둥글게 만들기 */
    z-index: 1003; /* 알림 아이콘 위에 표시 */
    display: none;
}

.delete-button {
    background-color: transparent; /* 배경 투명 */
    border: none; /* 테두리 없음 */
    color: #00aff0; /* 버튼 색상 */
    cursor: pointer; /* 커서 포인터로 변경 */
    transition: color 0.3s; /* 색상 변화에 애니메이션 추가 */
}

.delete-button:hover {
    color: #ff0000; /* 호버 시 색상 변경 */
}
#searchBTN {
    background-color: #00aff0; /* 버튼 배경색 */
    color: white; /* 버튼 텍스트 색상 */
    padding: 12px 20px; /* 검색창과 동일한 패딩 */
    border: none; /* 테두리 제거 */
    border-radius: 25px; /* 검색창과 동일한 둥근 모서리 */
    font-size: 16px; /* 텍스트 크기 */
    text-align: center; /* 텍스트 중앙 정렬 */
    cursor: pointer; /* 클릭 가능한 포인터 커서 */
    display: inline-block; /* 검색창과 같은 블록 형태 */
    transition: background-color 0.3s ease; /* 배경색 전환 효과 */
    margin-left: 10px; /* 검색창과 버튼 사이 간격 */
}

#searchBTN:hover {
    background-color: #007acc; /* 호버 시 색상 변경 */
}
</style>
</head>
<body>
    <!-- 오버레이 -->
    <div class="overlay" id="overlay"></div>
   	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="pinfo"/>
   		<input type="hidden" id="userNo" value="${pinfo.member.userNo}">
   		<input type="hidden" id="userId" value="${pinfo.member.userId}">
	</sec:authorize>
    <div class="popUpHeader"> 
        <button id="mainLogoButton" onclick="showLogos()" class="noOverlay">
            <img src="/resources/images/mainLogo.png" alt="메인 로고" id="mainLogo">
        </button>
        <div id="popUpSearchBox">
            <input type="text" id="popUpSearchInput" placeholder="검색어 입력">
            <div id="popUpSearchClick"><span id="searchBTN">검색</span></div>
        </div>
        <div id="alarmDiv">
            <img src="/resources/images/alarm.png" alt="알림" id="alarmImage" style="cursor: pointer; max-height: 35px; width: auto;" onclick="handleAlarmClick()">
            <span id="notificationDot"  class="notification-dot"></span> <!-- 빨간 점 추가 -->
        </div>
        <div id="notificationList"></div> <!-- 알림 목록 추가 -->
    </div>

    <!-- 슬라이드 메뉴 -->
    <div id="logoContainer" class="noOverlay">
        <div onclick="location.href='/hypePop/popUpMain'">
            <img src="/resources/images/popUpLogo.png" alt="팝업 스토어 로고">
        </div>
        <div id="goodsLogo">
            <img src="/resources/images/goodsLogo.png" alt="굿즈 스토어 로고">
        </div>
        <div onclick="location.href='/exhibition/exhibitionMain'">
            <img src="/resources/images/exhibition.png" alt="전시관 로고">
        </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script type="text/javascript" src="/resources/goodsJs/goodsHeader.js"></script> <!-- 새로운 JS 파일 추가 -->
</body>
</html>
