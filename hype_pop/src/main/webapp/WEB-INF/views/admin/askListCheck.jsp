<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="/resources/images/favicon.ico">
<meta charset="UTF-8">
<title>문의 목록</title>
<style>
table {
        border-collapse: collapse;
        width: 100%;
}
th, td {
    border: 2px solid #fee7ed; /* 테두리 빨간색 */
    padding: 8px;
    text-align: center; /* 가운데 정렬 */
}
th {
    background-color: #e0f7ff; /* 헤더 배경색 */
}
#qnaTypeBox {
	margin-bottom: 10px;
}
#askType {
    width: 70px; /* 원하는 너비로 조정 */
    margin-right: 10px; /* select 박스와 체크박스 사이의 간격 */
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
/* 관리하기 리스트 스타일 */
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
/* 검색 버튼 스타일 수정 */
#qnaListCat tbody a {
    color: inherit; /* 기본 텍스트 색상으로 설정 */
    text-decoration: none; /* 밑줄 제거 */
}
#backToMainPage{
	margin-left: 10px;
	padding: 2px 4px;
	font-size : 12px;
	background-color: #00aff0; 
    color: #fee7ed; 
    border: none; 
    border-radius: 3px; 
    cursor: pointer; 
    transition: background-color #0099cc;
}
</style>
</head>
<body>
    <jsp:include page="layout/adminHeader.jsp"/>

	<div id="AllList">
	</div>
	
    <form action="#" id="qnaTypeBox">
        <label for="qnaType">문의 유형 선택:</label>
        <select id="qnaType">
            <option value="전체">전체</option>
            <option value="일반">일반</option>
            <option value="결제">결제</option>
            <option value="기술">기술</option>
            <option value="기타">기타</option>
        </select>
        <label for="qnaAnswer">답변 여부:</label>
        <select id="qnaAnswer">
        	<option value="전체 답변">전체 답변</option>
        	<option value="답변 완료">답변 완료</option>
            <option value="답변 미완료">답변 미완료</option>
        </select>
        <!-- 메인 페이지 이동 버튼 -->
        <button type="button" id="backToMainPage" onclick="backToMainPage();">관리자 메인 페이지</button>

    </form>

    <table id="qnaListCat">
        <thead>
            <tr>
                <th>문의 번호</th>
                <th>문의 유형</th>
                <th>문의 제목</th>
                <th>문의 작성 날짜</th>
                <th>답변 여부</th>
            </tr>
        </thead>
        <tbody id="qnaListBody">
            <!-- 데이터가 여기에 삽입됩니다 -->
        </tbody>
    </table>

	<div id="pagination"></div>
	
<script type="text/javascript" src="/resources/adminJs/adminQna.js"></script>  
<script type="text/javascript" src="/resources/adminJs/admin.js"></script>  
</body>
</html>