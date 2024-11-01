<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin Page</title>
</head>
<style>
/* 팝업스토어 관리 스타일 */
#AllList {
    display: flex; /* 가로로 배치 */
    flex-direction: column; /* 세로 방향 정렬 */
    gap: 10px; /* 요소 간 간격 */
    margin: 20px 0; /* 상하 여백 */
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

/* 검색 버튼 스타일 수정 */
#searchBTN {
    background-color: #28a745; /* 초록색 배경 */
}

#searchBTN:hover {
    background-color: #218838; /* 호버 시 어두운 초록색 */
}
</style>
<body>
	<jsp:include page="layout/adminHeader.jsp"/>

	<div id="AllList"></div>
	
	<div id="pagination"></div>
         
	<jsp:include page="layout/adminFooter.jsp"/>
	
	<script type="text/javascript" src="/resources/adminJs/admin.js"></script>    
</body>
</html>