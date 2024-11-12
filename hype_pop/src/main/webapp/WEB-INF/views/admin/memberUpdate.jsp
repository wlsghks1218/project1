<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
    font-family: Arial, sans-serif; /* 기본 글꼴 */
    background-color: #f8f9fa; /* 배경색 */
    margin: 0; /* 기본 마진 제거 */
    padding: 20px; /* 내부 여백 */
}

#AllList {
    margin-bottom: 20px; /* 하단 여백 */
}

#AllList div {
    background-color: #f8f9fa; /* 연한 회색 배경 */
    padding: 15px; /* 내부 여백 */
    border-radius: 5px; /* 모서리 둥글게 */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 미세한 그림자 */
    border: 1px solid rgba(0, 0, 0, 0.1); /* 은은한 테두리 */
    transition: background-color 0.3s; /* 배경색 변경 시 애니메이션 */
}

#AllList div:hover {
    background-color: #e2e6ea; /* 호버 시 색상 변화 */
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

#adminSearchBox {
    width: auto; /* 자동 너비 조정 */
    margin: 20px 10px 10px; /* 위쪽 여백 추가 */
    padding: 8px; /* 입력 상자 내부 여백 */
    border: 2px solid #dc3545; /* 테두리 색상 */
    border-radius: 5px; /* 모서리 둥글게 */
    height: 36px; /* 높이 지정 */
    box-sizing: border-box; /* 패딩과 테두리 포함 */
}

button {
    padding: 10px 15px; /* 내부 여백 */
    background-color: transparent; /* 배경색 제거 */
    color: #dc3545; /* 글자색 빨간색 */
    border: 3px solid #dc3545; /* 빨간색 테두리 */
    border-radius: 5px; /* 모서리 둥글게 */
    cursor: pointer; /* 커서 변경 */
}

button:hover {
    background-color: #dc3545; /* 호버 시 배경색 */
    color: white; /* 호버 시 글자색 흰색 */
    border-color: #c82333; /* 호버 시 테두리 색상 변경 */
}

#upBtn, #downBtn {
    background-color: #dc3545; /* 버튼 색상 */
    color: white; /* 글자색 흰색 */
    border: none;
}

#upBtn:hover, #downBtn:hover {
    background-color: white; /* 호버 색상 흰색 */
    color: #dc3545; /* 글자색 빨간색으로 변경 */
    border: 2px solid #dc3545; /* 빨간색 테두리 */
}

#cancel, #update {
    margin-top: 20px; /* 상단 여백 */
    display: inline-block; /* 버튼과 같은 줄에 배치 */
    background-color: #6c757d; /* 기본 버튼 색상 */
    color: white; /* 글자색 흰색 */
    text-align: center; /* 중앙 정렬 */
}

#cancel {
    margin-top: 20px; /* 상단 여백 */
    display: inline-block; /* 버튼과 같은 줄에 배치 */
    background-color: #dc3545; /* 취소 버튼 색상 */
    color: white; /* 글자색 흰색 */
}

#cancel:hover {
    background-color: #c82333; /* 취소 버튼 호버 색상 */
}

#update {
    margin-top: 20px; /* 상단 여백 */
    display: inline-block; /* 버튼과 같은 줄에 배치 */
    background-color: #28a745; /* 수정완료 버튼 색상 */
    color: white; /* 글자색 흰색 */
}

#update:hover {
    background-color: #218838; /* 수정완료 버튼 호버 색상 */
}

/* 페이지네이션 스타일 */
#pagination {
    display: flex; /* 가로로 배치 */
    justify-content: center; /* 중앙 정렬 */
    margin: 20px 0; /* 상하 여백 */
}

#pagination button,
#pagination a {
    background-color: #dc3545; /* 빨간색 배경 */
    color: white; /* 글자색 흰색 */
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
    background-color: #c82333; /* 호버 시 어두운 빨간색 */
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
		<div id="mPhone">회원 전화번호 <input type="number" name="userNumber" value="${svo.userNumber}"></div>
		<div id="authority">권한 
			<label><input type="radio" name="auth" value="1" ${svo.auth == 1 ? 'checked' : ''}> 유저</label>
            <label><input type="radio" name="auth" value="2" ${svo.auth == 2 ? 'checked' : ''}> 관리자</label>	
		</div>
		<div id="joinDate">가입일 <input type="text" name="regDate" value="${svo.regDate}" readonly></div>
		<div id="updateLogin">최신 로그인 날짜 <input type="text" name="lastLoginDate" value="${svo.lastLoginDate}" readonly></div>
	</form>
	
    <button type="button" id="mCancel" onclick="backtoMList()">취소 및 리스트로 돌아가기</button>	
    <button type="button" id="mUpdate" onclick="updateMemberList()">수정완료</button>
	
	<div id="pagination"></div>

<script type="text/javascript" src="/resources/adminJs/admin.js"></script>  
<script type="text/javascript" src="/resources/adminJs/adminMember.js"></script>  
</body>
</html>