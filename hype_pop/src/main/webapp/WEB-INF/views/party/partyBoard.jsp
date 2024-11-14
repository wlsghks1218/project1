<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix = "sec" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Party Board</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #141414;
	color: #ffffff;
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
	background-color: #333;
	color: #ffffff;
}

th, td {
	padding: 15px;
	text-align: center;
	border-bottom: 1px solid #555;
}

th {
	background-color: #444;
	color: #e50914;
	font-weight: bold;
}

tr:hover {
	background-color: #555;
}

/* 버튼 영역 */
.buttonArea {
	text-align: center;
	margin: 20px;
}

#goInsertBoard {
	background-color: #e50914;
	color: white;
	padding: 10px 20px;
	font-size: 1em;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

#goInsertBoard:hover {
	background-color: #f40612;
}

/* 페이지네이션 스타일 */
.pagination {
	text-align: center;
	padding: 10px;
	margin: 20px 0;
}

.pageItem {
	display: inline-block;
	color: #ffffff;
	background-color: #333;
	padding: 10px 15px;
	margin: 0 5px;
	border: 1px solid #444;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.pageItem:hover {
	background-color: #e50914;
}

.pageItem.active {
	background-color: #e50914;
	color: #ffffff;
	font-weight: bold;
}
.modal {
   display: none;
   position: fixed;
   z-index: 1000;
   left: 0;
   top: 0;
   width: 100%;
   height: 100%;
   background-color: rgba(0, 0, 0, 0.6);
}

.modal-content {
   background-color: #222;
   color: white;
   margin: 15% auto;
   padding: 20px;
   border-radius: 8px;
   width: 300px;
   text-align: center;
   box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
}

.modal-content p {
   font-size: 18px;
   margin-bottom: 20px;
}

.modal-content button {
   padding: 10px 20px;
   background-color: #e50914;
   color: white;
   border: none;
   cursor: pointer;
   font-size: 16px;
   border-radius: 5px;
   transition: background-color 0.3s;
}

.modal-content button:hover {
   background-color: #c3070a;
}

.close {
   color: #aaa;
   float: right;
   font-size: 28px;
   font-weight: bold;
   cursor: pointer;
}

.close:hover,
.close:focus {
   color: #fff;
}
</style>
</head>
<body>
	<jsp:include page="layout/popUpHeader.jsp" />
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="pinfo"/>
   		<input type="hidden" id="userNo" value="${pinfo.member.userNo}">
	</sec:authorize>
	<div>여기는 게시판 메인 배너</div>
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
	<jsp:include page="layout/popUpFooter.jsp" />
	<jsp:include page="layout/goodsNavBar.jsp" />
</body>
<script type="text/javascript" src="/resources/partyJs/partyBoard.js"></script>
<script type="text/javascript" src="/resources/partyJs/partyHeader.js"></script>
<script type="text/javascript" src="/resources/partyJs/partyNav.js"></script>
</html>
