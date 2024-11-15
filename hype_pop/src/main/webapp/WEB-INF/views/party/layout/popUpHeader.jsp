<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    font-family: 'Helvetica Neue', Arial, sans-serif; /* 폰트 스타일 */
    color: #00aff0; /* 기본 텍스트 색상 */
}

/* 헤더 스타일 */
.popUpHeader {
    width: 100%;
    display: flex;
    align-items: center;
    padding: 10px 20px;
    background-color: #fee7ed;
    position: relative;
    z-index: 1002;
}

/* 메인 로고 및 슬라이드 버튼 */
#mainLogoButton {
    background: none;
    border: none;
    cursor: pointer;
    display: flex;
    align-items: center;
    margin-right: 20px;
    z-index: 1002;
}

#mainLogo img {
    max-height: 35px;
    width: auto;
}

/* 알림 스타일 */
#alarmDiv {
    display: inline-block;
    margin-left: auto; /* 왼쪽 여백 자동으로 설정하여 오른쪽 정렬 */
    position: relative;
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
    z-index: 1003;
    position: relative;
}

/* 알림 목록 스타일 */
#notificationList {
    display: none;
    position: absolute;
    top: 50px;
    right: 20px;
    background-color: white;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
    z-index: 1000;
    padding: 15px;
    width: 300px; /* 너비 증가 */
    max-height: 400px; /* 최대 높이 설정 */
    overflow-y: auto;
}

#notificationList div {
    margin: 5px 0;
    padding: 5px;
    border-bottom: 1px solid #eee;
}

#notificationList div:last-child {
    border-bottom: none;
}

/* 알림 빨간 점 */
.notification-dot {
    position: absolute;
    bottom: 8px;
    right: 28px;
    width: 10px;
    height: 10px;
    background-color: red;
    border-radius: 50%;
    z-index: 1003;
    display: none;
}

/* 삭제 버튼 스타일 */
.delete-button {
    background-color: transparent;
    border: none;
    color: #00aff0;
    cursor: pointer;
    transition: color 0.3s;
}

.delete-button:hover {
    color: #ff0000;
}
/* 배너 컨테이너 */
#bannerDiv {
    width: 90%; /* 화면 너비에 맞게 설정 */
    height: 300px; /* 고정된 배너 높이 */
    overflow: hidden; /* 이미지가 넘치는 경우 잘라냄 */
    display: flex; /* Flexbox로 정렬 */
    justify-content: center; /* 가로 중앙 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
    background-color: #141414; /* 배경색 */
    margin: 20px auto;
    border-radius: 8px; /* 둥근 모서리 */
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5); /* 그림자 효과 */
}

/* 배너 이미지 */
#bannerImg {
    width: 100%; /* 부모 요소의 너비에 맞춤 */
    height: 100%; /* 부모 요소의 높이에 맞춤 */
    display: block; /* 기본 여백 제거 */
    object-fit: cover; /* 이미지 비율 유지 및 부모 요소에 꽉 채움 */
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
<script type="text/javascript" src="/resources/partyJs/partyHeader.js"></script>
</head>
<body>
    <!-- 오버레이 -->
    <div class="overlay" id="overlay"></div>
    <div class="popUpHeader">
        <button id="mainLogoButton" onclick="showLogos()" class="noOverlay">
            <img src="/resources/images/mainLogo.png" alt="메인 로고" id="mainLogo">
        </button>
        <div id="alarmDiv">
            <img src="/resources/images/alarm.png" alt="알림" id="alarmImage" style="cursor: pointer; max-height: 35px; width: auto;" onclick="handleAlarmClick()">
            <span id="notificationDot" class="notification-dot"></span> <!-- 빨간 점 -->
        </div>
        <div id="notificationList"></div> <!-- 알림 목록 -->
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
   	<div id="bannerDiv"><img id="bannerImg" src="../resources/images/partyBanner.jpeg" alt="배너 이미지" /></div>
</body>
</html>
