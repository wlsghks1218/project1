<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix = "sec" %>   
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="/resources/images/favicon.ico">
<meta charset="UTF-8">
<title>Party Board</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #141414; /* 어두운 배경 */
    color: #000000; /* 텍스트 검은색 */
    margin: 0;
    padding: 0;
}

.boardBanner {
    text-align: center;
    padding: 20px;
    background-color: #333;
    color: #e50914;
    font-size: 1.8em;
}

table {
    width: 90%;
    margin: 20px auto;
    border-collapse: collapse;
    background-color: #333; /* 테이블 배경색 */
    color: #000000; /* 기본 텍스트 색상 검은색 */
    border: 2px solid #000000; /* 테이블 전체 테두리 검은색 */
}

th, td {
    padding: 15px;
    text-align: center;
    border-bottom: 1px solid #000000; /* 행 간 구분선 검은색 */
}

th {
    background-color: #add8e6; /* 연한 하늘색 */
    font-weight: bold;
    color: #000000; /* 검은색 텍스트 */
}

td {
    background-color: #ffffff; /* 흰색 배경 */
    color: #000000; /* 검은색 텍스트 */
}

tr:hover td {
    background-color: #cce7ff; /* 강조 색상 연한 하늘색 */
}

/* 버튼 영역 */
.buttonArea {
    text-align: center;
    margin: 20px;
}

/* #goInsertBoard 버튼 스타일 */
#goInsertBoard {
    background-color: #add8e6; /* 연한 하늘색 */
    color: #000000; /* 텍스트 검은색 */
    padding: 10px 20px; /* 내부 여백 */
    font-size: 16px; /* 글자 크기 */
    border: none; /* 테두리 제거 */
    border-radius: 5px; /* 둥근 모서리 */
    cursor: pointer; /* 클릭 가능한 포인터 */
    transition: background-color 0.3s ease, transform 0.2s ease; /* 부드러운 효과 */
}

#goInsertBoard:hover {
    background-color: #cce7ff; /* 호버 시 더 연한 하늘색 */
    transform: scale(1.05); /* 약간 커지는 효과 */
}

/* 페이지네이션 스타일 */
.pagination {
    text-align: center;
    padding: 10px;
    margin: 20px 0;
}

.pageItem {
    display: inline-block;
    background-color: #add8e6; /* 연한 하늘색 */
    color: #000000; /* 텍스트 검은색 */
    padding: 10px 15px;
    margin: 0 5px;
    border: 1px solid #000000; /* 테두리 검은색 */
    border-radius: 4px;
    cursor: pointer; /* 클릭 가능한 포인터 */
    transition: background-color 0.3s ease, transform 0.2s ease; /* 부드러운 효과 */
}

.pageItem:hover {
    background-color: #cce7ff; /* 호버 시 더 연한 하늘색 */
    transform: scale(1.05); /* 약간 커지는 효과 */
}

.pageItem.active {
    background-color: #cce7ff; /* 활성화된 버튼 색상 */
    color: #000000; /* 텍스트 검은색 */
    font-weight: bold;
}

/* 모달 스타일 */
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.6); /* 반투명 검정 */
}

.modal-content {
    background-color: #ffffff; /* 모달 배경 흰색 */
    color: #000000; /* 텍스트 검은색 */
    margin: 15% auto;
    padding: 20px;
    border-radius: 8px;
    width: 300px;
    text-align: center;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5); /* 그림자 효과 */
}

.modal-content p {
    font-size: 18px;
    margin-bottom: 20px;
}

.modal-content button {
    background-color: #add8e6; /* 기본 배경 */
    color: #000000; /* 텍스트 검은색 */
    padding: 10px 20px; /* 내부 여백 */
    font-size: 16px; /* 글자 크기 */
    border: none; /* 테두리 제거 */
    border-radius: 5px; /* 둥근 모서리 */
    cursor: pointer; /* 클릭 가능한 포인터 */
    transition: background-color 0.3s ease, transform 0.2s ease; /* 부드러운 효과 */
}

.modal-content button:hover {
    background-color: #cce7ff; /* 호버 색상 */
    transform: scale(1.05); /* 약간 커지는 효과 */
}

.close {
    color: #000000; /* 닫기 버튼 검은색 */
    float: right;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.close:hover,
.close:focus {
    color: #555; /* 호버 시 밝은 검은색 */
}
#empty{
   min-height: 500px;
}

</style>
</head>
<body>
	<jsp:include page="layout/popUpHeader.jsp" />
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="pinfo"/>
   		<input type="hidden" id="userNo" value="${pinfo.member.userNo}">
	</sec:authorize>

   <div id="empty">
      <table>
         <thead>
            <tr>
               <th>카테고리</th>
               <th>팝업스토어 or 전시회 이름</th>
               <th>파티 구인 제목</th>
               <th>파티 등록 날짜</th>
               <th>파티 인원 현황</th>
            </tr>
         </thead>
         <tbody></tbody>
      </table>
   </div>
	<div id="pagination" class="pagination"></div>
	<div class="buttonArea">
		<button id="goInsertBoard">게시글 작성</button>
	</div>
	<div id="loginModal" class="modal">
	   <div class="modal-content">
	      <span class="close">&times;</span>
	      <p>로그인이 필요한 기능입니다.</p>
	      <button id="goToLogin" onclick="location.href='/member/login'">로그인하러 가기</button>
	   </div>
	</div>
	
	<jsp:include page="layout/partyFooter.jsp" />
	<jsp:include page="layout/partyNavBar.jsp" />
</body>
<script type="text/javascript" src="/resources/partyJs/partyBoard.js"></script>
<script type="text/javascript" src="/resources/partyJs/partyHeader.js"></script>
<script type="text/javascript" src="/resources/partyJs/partyNav.js"></script>
</html>
