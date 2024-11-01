<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <jsp:include page="layout/adminHeader.jsp"/>
   
   <div id="AllList"></div>
   
   <form id="memberForm" method="POST">
      <input type="text" name="userNo" value="${members.userNo }">
      <div id="mId">회원 아이디 <input type="text" name="userId" value="${members.userId}"></div>
      <div id="mName">회원 이름 <input type="text" name="userName" value="${members.userName}"></div>
      <div id="mEmail">회원 이메일 <input type="text" name="userEmail" value="${members.userEmail}"></div>
      <div id="mPhone">회원 전화번호 <input type="text" name="userNumber" value="${members.userNumber}"></div>
      <div id="activeAccount">계정 활성화 여부 <input type="text" name="enabled" value="${members.enabled}"></div>
      <div id="authority">권한 <input type="text" name="auth" value="${members.auth}"> </div>
       <button type="button" id="upBtn">↑</button>
       <button type="button" id="downBtn">↓</button>   
   </form>
	<div id="joinDate">가입일 <input type="text" name="regDate" value="${members.regDate}"></div>
      <div id="updateLogin">최신 로그인 날짜 <input type="text" name="lastLoginDate" value="${members.lastLoginDate}"></div>
   
    <button type="button" id="mCancel">취소 및 리스트로 돌아가기</button>   
    <button type="button" id="mUpdate" onclick="updateMemberList()">수정완료</button>
   
   <div id="pagination"></div>

<script type="text/javascript" src="/resources/adminJs/admin.js"></script>  
<script type="text/javascript" src="/resources/adminJs/adminMember.js"></script>  
</body>

</html>