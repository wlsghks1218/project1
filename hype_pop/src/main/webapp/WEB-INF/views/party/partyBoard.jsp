<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Party Board</title>
<style>
/* 전체 배경과 텍스트 색상 설정 */
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
</style>
</head>
<body>
	<jsp:include page="layout/popUpHeader.jsp" />
	<div>여기는 게시판 메인 배너</div>
	<table>
		<thead>
			<tr>
				<th>카테고리</th>
				<th>팝업스토어 or 전시회 이름</th>
				<th>파티 구인 제목</th>
				<th>파티 등록 날짜</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
	<div id="pagination" class="pagination"></div>
	<div class="buttonArea">
		<button id="goInsertBoard">게시글 작성</button>
	</div>

	<jsp:include page="layout/popUpFooter.jsp" />
	<jsp:include page="layout/goodsNavBar.jsp" />
</body>
<script type="text/javascript" src="/resources/partyJs/partyBoard.js"></script>
</html>
