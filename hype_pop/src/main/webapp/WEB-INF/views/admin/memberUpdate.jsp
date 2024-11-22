<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="/resources/images/favicon.ico">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
    font-family: Arial, sans-serif; /* 기본 글꼴 */
    background-color: #f8f9fa; /* 배경색 */
    margin: 0; /* 기본 마진 제거 */
    padding: 20px; /* 내부 여백 */
}
/* 관리하기 리스트 스타일 */
#AllList {
    display: flex; /* 가로로 배치 */
    flex-direction: column; /* 세로 방향 정렬 */
    gap: 10px; /* 요소 간 간격 */
    margin: 20px 0; /* 상하 여백 */
}
#AllList a {
    display: block; /* 링크 전체를 클릭 가능하게 함 */
    background-color: #e0f7ff; 
    padding: 15px; /* 내부 여백 */
    border-radius: 5px; /* 모서리 둥글게 */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 미세한 그림자 */
    border: 1px solid rgba(0, 0, 0, 0.1); /* 은은한 테두리 */
    text-decoration: none; /* 밑줄 제거 */
    transition: background-color 0.3s; /* 배경색 변경 시 애니메이션 */
}
#AllList a:hover {
    background-color: #fee7ed; /* 호버 시 색상 변화 */
}
/* 페이지네이션 스타일 */
#pagination {
    display: flex; /* 가로로 배치 */
    justify-content: center; /* 중앙 정렬 */
    margin: 20px 0; /* 상하 여백 */
}
#pagination button,
#pagination a {
    background-color: #00aff0;
    color: #fee7ed;
    padding: 10px 15px; /* 패딩 */
    margin: 0 5px; /* 좌우 여백 */
    border: none; /* 테두리 제거 */
    border-radius: 5px; /* 모서리 둥글게 */
    cursor: pointer; /* 커서 변경 */
    text-decoration: none; /* 링크 밑줄 제거 */
    transition: background-color 0.3s; /* 배경색 변경 시 애니메이션 */
}
#pagination button:hover,
#pagination a:hover {
    background-color: #0099cc; 
}
form {
    background-color: white; /* 폼 배경색 */
    padding: 20px; /* 폼 내부 여백 */
    border-radius: 5px; /* 모서리 둥글게 */
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    margin-bottom: 20px; /* 하단 여백 */
}
div {
    margin-bottom: 15px; /* 각 요소 간 여백 */
}
input[type="text"] {
    width: 100%; /* 전체 너비 */
    padding: 10px; /* 내부 여백 */
    border: 1px solid #ced4da; /* 테두리 */
    border-radius: 5px; /* 모서리 둥글게 */
    box-sizing: border-box; /* 패딩과 테두리 포함 */
}
/* 버튼 스타일 */
button {
    padding: 10px 15px; /* 내부 여백 */
    background-color: #00aff0; /* 버튼 색상 */
    color: #fee7ed; 
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 모서리 둥글게 */
    cursor: pointer; /* 커서 변경 */
}
button:hover {
    background-color: #0099cc; /* 버튼 호버 색상 */
}
</style>
</head>
<body>
	<jsp:include page="layout/adminHeader.jsp"/>
	
	<div id="AllList"></div>
	
	<form id="memberForm" method="POST">
		<input type="text" name="userNo" value="${svo.userNo}" readonly>
		<div id="mId">회원 아이디 <input type="text" name="userId" value="${svo.userId}" readonly></div>
		<div id="mName">회원 이름 <input type="text" name="userName" value="${svo.userName}"></div>
		<div id="mEmail">회원 이메일 <input type="text" name="userEmail" value="${svo.userEmail}"></div>
		<div id="mPhone">회원 전화번호 <input type="tel" name="userNumber" value="${svo.userNumber}"></div>
		<div id="authority">권한 
			<label><input type="radio" name="auth" value="1" ${svo.auth == 1 ? 'checked' : ''}> 유저</label>
            <label><input type="radio" name="auth" value="2" ${svo.auth == 2 ? 'checked' : ''}> 관리자</label>	
		</div>
		<div id="joinDate">가입일 <input type="text" name="regDate" value="${svo.regDate}" readonly></div>
		<div id="updateLogin">최신 로그인 날짜 <input type="text" name="lastLoginDate" value="${svo.lastLoginDate}" readonly></div>
	</form>
	
    <button type="button" id="mCancel" onclick="backtoMList()">취소 및 리스트로 돌아가기</button>	
    <button type="button" id="mUpdate" onclick="updateMemberList()">수정완료</button>
	<button type="button" id="backToMainPage" onclick="backToMainPage();">관리자 메인 페이지</button>

	
	<div id="pagination"></div>

<script type="text/javascript" src="/resources/adminJs/admin.js"></script>  
<script type="text/javascript" src="/resources/adminJs/adminMember.js"></script>  
</body>
</html>