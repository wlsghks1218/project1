<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix = "sec" %>   
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="/resources/images/favicon.ico">
<meta charset="UTF-8">
<title>게시판 작성 페이지</title>
<style>
/* 기본 스타일 */
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #00aff0; /* 배경색 */
	color: #ffffff; /* 텍스트 흰색 */
}

.container {
   max-width: 1200px;
   margin: 0 auto;
   padding: 20px;
   min-height: 600px;
}

/* 헤더와 메인 배너 */
.mainBanner {
	text-align: center;
	padding: 20px;
	background-color: #007acc; /* 배너 배경 */
	margin-bottom: 20px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
}

.mainBanner h2 {
	font-size: 2em;
	color: #ffffff; /* 배너 텍스트 */
}

/* 입력 및 선택 필드 스타일 */
.inputGroup {
	background-color: #00Aff0; /* 입력 필드 영역 배경 */
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
}

.categorySelectGroup, .searchGroup, .selectedResultGroup,
	.titleInputGroup, .buttonGroup {
	margin-bottom: 15px;
}

label {
	display: block;
	font-weight: bold;
	margin-bottom: 5px;
	color: #ffffff; /* 라벨 색상 */
}

input[type="text"], select {
	width: 100%;
	padding: 12px;
	margin: 8px 0;
	box-sizing: border-box;
	border: 1px solid #004d80;
	border-radius: 4px;
	background-color: #ffffff; /* 입력 필드 배경 */
	color: #000000;
}

input[type="text"]::placeholder {
	color: #000000; /* 플레이스홀더 색상 */
}

/* 검색 결과 영역 */
#searchResults {
	margin-top: 10px;
	background-color: #ffffff; /* 검색 결과 배경 */
	padding: 10px;
	border-radius: 4px;
	color: #000000;
}

#selectedResult {
	margin-top: 10px;
	background-color: #ffffff; /* 선택 결과 배경 */
	padding: 10px;
	border: 1px solid #004d80;
	border-radius: 4px;
	color: #000000;
}

.resultItem {
	padding: 8px 10px;
	border-bottom: 1px solid #004d80;
	color: #000000;
}

.resultItem:hover {
	background-color: #005f99; /* 호버 색상 */
	cursor: pointer;
}

/* 버튼 스타일 */
button {
	padding: 10px 20px;
	font-size: 1em;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	margin-top: 10px;
	transition: background-color 0.3s ease;
	color: #ffffff; /* 버튼 텍스트 */
}

#submitBtn {
	background-color: #005f99; /* 작성 완료 버튼 */
}

#submitBtn:hover {
	background-color: #000000; /* 호버 색상 */
}

#resetBtn {
	background-color: #005f99; /* 초기화 버튼 */
}

#resetBtn:hover {
	background-color: #000000; /* 호버 색상 */
}

#goBack {
	background-color: #005f99; /* 뒤로가기 버튼 */
}

#goBack:hover {
	background-color: #000000; /* 호버 색상 */
}

/* 푸터와 네비게이션 스타일 */
footer, nav {
	background-color: #007acc;
	color: #ffffff; /* 텍스트 흰색 */
	padding: 10px;
	text-align: center;
	border-radius: 4px;
}
</style>
</head>
<body>
	<jsp:include page="layout/popUpHeader.jsp" />
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="pinfo"/>
   		<input type="hidden" id="userNo" value="${pinfo.member.userNo}">
	</sec:authorize>
	<div class="container">
		<div class="inputGroup">
			<form id="boardForm" method="post">
		   		<input type="hidden" name="userNo" value="${pinfo.member.userNo}">
				<div class="categorySelectGroup">
					<label for="categorySelect">카테고리 선택</label>
					<select name="category"	id="categorySelect" class="inputField">
						<option value="default" disabled selected>선택하세요</option>
						<option value="popup">팝업스토어</option>
						<option value="exhibition">전시회</option>
					</select>
				</div>

				<div class="searchGroup">
					<label for="searchInput">검색</label>
					<input type="text" id="searchInput" placeholder="검색어를 입력하세요" class="inputField">
					<div id="searchResults"></div>
				</div>

				<div class="selectedResultGroup">
					<label for="targetName">선택된 결과</label>
					<div id="selectedResult"></div>
					<input type="hidden" id="targetName" name="targetName">
				</div>

				<div class="titleInputGroup">
					<label for="boardTitle">게시판 제목</label>
					<input type="text" name="boardTitle" id="boardTitle" placeholder="제목을 입력하세요"	class="inputField">
				</div>
				<div class="setUserCountGroup">
					<label for="setUserCount">최대 인원</label>
					<select id="maxUser" name="maxUser">
						<option value="default" disabled selected>최대 인원을 선택하세요.</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
					</select>
				</div>
				<div class="buttonGroup">
					<button type="button" id="submitBtn">작성 완료</button>
					<button type="button" id="resetBtn">초기화</button>
					<button type="button" id="goBack">뒤로가기</button>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="layout/partyFooter.jsp" />
	<jsp:include page="layout/partyNavBar.jsp" />
</body>
<script type="text/javascript" src="/resources/partyJs/insertBoard.js"></script>
<script type="text/javascript" src="/resources/partyJs/partyHeader.js"></script>
<script type="text/javascript" src="/resources/partyJs/partyNav.js"></script>
</html>
