<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>


<html>
<head>
<link rel="icon" href="/resources/images/favicon.ico">
<style>
/* 전체 레이아웃 */
.container {
	display: flex;
	width: 100%;
	min-height: 600px;
	padding-top: 40px;
	box-sizing: border-box;
}


/* 왼쪽 메뉴 스타일 */
.left-menu {
	width: 220px; /* 메뉴 너비 확대 */
	background-color: #ffffff; /* 흰색 배경 */
	height: 100vh;
	position: fixed; /* 화면 고정 */
	top: 100px; /* 헤더와의 간격 */
	left: 0;
	padding: 20px;
	box-sizing: border-box;
	border-right: 1px solid #ddd;
	box-shadow: 2px 0px 10px rgba(0, 0, 0, 0.1); /* 메뉴에 그림자 추가 */
	z-index: 100; /* 오른쪽 콘텐츠보다 위에 표시 */
}

.left-menu ul {
	list-style: none;
	padding: 0;
	margin: 0;
	display: flex;
	flex-direction: column;
	justify-content: flex-start;
}

.left-menu ul li a {
	display: block;
	padding: 12px 25px;
	color: #333;
	background-color: #fff;
	border-radius: 5px;
	text-align: center;
	margin-bottom: 10px;
	text-decoration: none;
	transition: background-color 0.3s;
	border-bottom: 1px solid #ddd;
	margin-top: 10px;
}

.left-menu ul li {
	margin-top: 10px; /* 메뉴 항목 간의 간격 */
	padding-bottom: 10px; /* 메뉴 항목 아래 여백 */
}

.left-menu ul li a:hover {
	background-color: #f0f0f0;
}

/* 오른쪽 게시판 및 검색 */
.right-content {
	flex-grow: 1;
	padding: 20px;
	margin-left: 200px;
	padding-top: 80px;
	box-sizing: border-box;
}

/* 검색바 중앙 정렬 */
.search-bar {
	text-align: center;
	margin-bottom: 20px;
}

.search-bar input, .search-bar button {
	padding: 10px;
	border-radius: 4px;
	border: 1px solid #ddd;
	font-size: 14px;
}

.search-bar button {
	background-color: #007bff;
	color: white;
	cursor: pointer;
	transition: background-color 0.3s;
}

.search-bar button:hover {
	background-color: #0056b3;
}

/* 게시판 목록 스타일 */
#boardContainer {
	margin: 0 auto;
	text-align: center;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column; /* 아이템을 세로로 정렬 */
	width: 80%; /* 게시판 너비 조정 */
}

table {
	width: 80%;
	border-collapse: collapse;
	table-layout: fixed;
	margin-top: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

th, td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #f1f1f1;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	color: #333;
}

th {
	background-color: #f5f5f5;
	color: #666;
	font-weight: bold;
}

td a {
	text-decoration: none;
	color: #007bff;
	font-weight: bold;
}

td a:hover {
	text-decoration: underline;
}

/* 페이징 */
.pagination {
	text-align: center;
	margin-top: 20px;
}

.pagination button {
	padding: 10px 15px;
	margin: 0 5px;
	background-color: #f8f8f8;
	border: 1px solid #ddd;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.pagination button:hover {
	background-color: #e0e0e0;
}

/* 하단 내비게이션 */
.footer-nav {
	position: fixed;
	bottom: 0;
	width: 100%;
	background-color: #ffffff;
	padding: 15px 0;
	text-align: center;
	border-top: 1px solid #eee;
	box-shadow: 0 -2px 5px rgba(0, 0, 0, 0.05);
}

.footer-nav ul {
	list-style: none;
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
}

.footer-nav ul li {
	margin: 0 20px;
}

.footer-nav ul li a {
	text-decoration: none;
	color: #333;
	font-size: 16px;
	font-weight: bold;
	transition: color 0.3s;
}

.footer-nav ul li a:hover {
	color: #007bff;
}
/* 초기 상태로 버튼 숨기기 */
.pagination button {
    display: none;
}
</style>

</head>
<body>
	<div class="header">
		<jsp:include page="layout/popUpHeader.jsp" />
	</div>

	<div class="container">
		<!-- 왼쪽 메뉴 -->
		<div class="left-menu">
			<input type="hidden" value="2" name="userNo" id="userNo">
			<ul>
				<li><a href="#" onclick="loadBoard('popupComments')">팝업스토어
						댓글</a></li>
				<li><a href="#" onclick="loadBoard('goodsComments')">굿즈 댓글</a></li>
				<li><a href="#" onclick="loadBoard('userInquiry')">1:1 문의 글</a></li>
			</ul>
		</div>

		<!-- 오른쪽 검색 및 게시판 -->
		<div class="right-content">

			<!-- 게시판 목록 -->
			<div id="boardContainer">
				<!-- AJAX로 게시판 목록이 로드될 영역 -->
				<!--       <div id="inquiryList"></div>
             <div id="popupReplyList"></div> -->
			</div>

			<!-- 페이징 영역 -->
			<div class="pagination">
				<button class="prevInquiry">이전 문의글</button>
				<button class="nextInquiry">다음 문의글</button>
				<button class="prevGoods">이전 굿즈 댓글</button>
				<button class="nextGoods">다음 굿즈 댓글</button>
				<button class="prevPopup">이전 팝업 댓글</button>
				<button class="nextPopup">다음 팝업 댓글</button>
			</div>
		</div>
	</div>
	<!-- 하단 내비게이션 -->
	<div class="footer-nav">
		<ul>
			<li><a href="/profile">프로필</a></li>
			<li><a href="/settings">설정</a></li>
			<li><a href="/logout">로그아웃</a></li>
		</ul>
	</div>


	<script type="text/javascript" src="/resources/memberJs/myReply.js"></script>

</body>
</html>