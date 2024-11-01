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
  <style>
    ul {
      list-style: none;
      padding: 0;
    }
    ul li {
      display: none; /* display none을 줘서 안보이게 만들고 */
    }
    .show {
      display: block; /* show를 부여해서 다시 보이게 만듦 */
    }
  </style>
</head>
<body>
   <div class="popUpHeader"> 
      <span id="hamburgerBTN">햄버거 버튼</span> 
      <span id="mainLogo">메인 로고</span>
		<input type="text" id="goodsSearchBox"> <span id="searchBTN">검색</span>
		<span id="notice">알림</span>
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