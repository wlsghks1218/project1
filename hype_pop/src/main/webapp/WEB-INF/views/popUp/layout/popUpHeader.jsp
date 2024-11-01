<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
    <div class="popUpHeader"> 
    <div id="hamburgerDiv"><img id="hamburgerBTN" src="/resources/images/hamburger.png"></div>
    <div id="mainLogoDiv"><span id="mainLogo">메인 로고</span></div>
    <div id="goodsMainLogoDiv"><span id="goodsMainLogo">굿즈 메인 로고</span></div>
    <div id="popUpSearchBox"><input type="text" id="popUpSearchInput"></div> <!-- ID 변경 -->
    <div id="popUpSearchClick"> <span id="searchBTN">검색</span></div>
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

<div class="main"></div>