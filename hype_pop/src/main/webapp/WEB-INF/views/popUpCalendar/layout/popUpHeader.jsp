
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<style>
#hamburgerList ul {
    display: none; /* 기본 상태를 닫힌 상태로 설정 */
}
<!--
/* 전체 요소에 대한 기본 스타일 */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box; /* Add box-sizing for better layout control */
}

/* popUpHeader 클래스 내부 스타일 */
body .popUpHeader {
    width: 100%;
    display: flex; /* Use flexbox for better layout */
    align-items: center; /* Center items vertically */
    position: sticky; /* Sticky positioning for scrolling */
    top: 0; /* Sticky effect starts at the top */
    background-color: #282828; /* 헤더 배경색 */
    color: #fff; /* 텍스트 색상 */
    padding: 10px 20px; /* 헤더 내부 여백 */
    z-index: 1000; /* Ensure the header is above other content */
}


/* 햄버거 메뉴 리스트 스타일 */
body .popUpHeader #hamburgerList ul {
    list-style: none;
    padding: 0;
    position: absolute; /* 절대 위치 */
    left: 0; /* 왼쪽 정렬 */
    z-index: 1000; /* z축 상단에 표시 */
    background: white; /* 배경색 */
    box-shadow: 0 2px 5px rgba(0,0,0,0.2); /* 그림자 효과 */
    display: none;
}

/* 햄버거 리스트 항목 스타일 */
body .popUpHeader #hamburgerList ul li {
    padding: 10px 15px; /* 내부 여백 */
    cursor: pointer; /* 커서 모양 변경 */
    transition: background-color 0.3s; /* 배경색 변화에 애니메이션 추가 */
}

/* 햄버거 리스트 항목 hover 스타일 */
body .popUpHeader #hamburgerList ul li:hover {
    background-color: #f0f0f0; /* 마우스 오버 시 배경색 변화 */
}

/* 햄버거 리스트 항목 active 스타일 */
body .popUpHeader #hamburgerList ul li:active {
    background-color: #e0e0e0; /* 클릭 시 배경색 변화 */
}

/* 햄버거 버튼이 보일 때 */
body .popUpHeader .show {
    display: block;  /* Show items when necessary */
}

/* 햄버거 버튼 스타일 */
body .popUpHeader #hamburgerBTN {
    width: 20px; /* Adjusted size for better usability */
    height: 20px;
    cursor: pointer; /* Change cursor to pointer */
}

/* Header 내부 div 스타일 */
body .popUpHeader div {
    text-align: center;
    padding: 0 1%;
}

/* Header에서 각 요소들의 비율 */
body .popUpHeader #hamburgerDiv {
    flex: 0 0 5%; /* Fixed width */
}

body .popUpHeader #mainLogoDiv {
    flex: 0 0 10%; /* Adjusted for better proportion */
}

body .popUpHeader #goodsMainLogoDiv {
    flex: 0 0 10%; /* Adjusted for better proportion */
}

body .popUpHeader #popUpSearchDiv {
    flex: 1; /* Take up remaining space */
    display: flex; /* Flexbox for input and button */
    align-items: center; /* Center items vertically */
}

/* 검색창 스타일 */
body .popUpHeader #popUpSearchBox {
    width: 70%; /* Adjust input width */
    padding: 5px; /* Padding for input */
}

/* 알림 아이콘 스타일 */
body .popUpHeader #noticeDiv {
    flex: 0 0 5%; /* Fixed width */
}

body .popUpHeader #notice {
    cursor: pointer; /* Change cursor to pointer */
}
-->
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
      <div class="popUpHeader"> 	
         <div id="hamburgerDiv"><img id="hamburgerBTN" src="/resources/images/hamburger.png"></div>
         <div id="mainLogoDiv"><span id="mainLogo">메인 로고</span></div>
         <div id="goodsMainLogoDiv"><span id="goodsMainLogo">굿즈 메인 로고</span></div>
      <div id="popUpSearchDiv"><input type="text" id="popUpSearchBox"> <span id="searchBTN">검색</span></div>
      <div id="noticeDiv"><span id="notice">알림</span></div>
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