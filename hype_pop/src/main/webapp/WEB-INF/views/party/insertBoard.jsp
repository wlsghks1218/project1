<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 작성 페이지</title>
<style>
/* 기본 스타일 */
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #141414;
	color: #ffffff;
}

.container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
}

/* 헤더와 메인 배너 */
.mainBanner {
	text-align: center;
	padding: 20px;
	background-color: #333333;
	margin-bottom: 20px;
}

.mainBanner h2 {
	font-size: 2em;
	color: #e50914;
}

/* 입력 및 선택 필드 스타일 */
.inputGroup {
	background-color: #222;
	padding: 20px;
	border-radius: 8px;
}

.categorySelectGroup, .searchGroup, .selectedResultGroup,
	.titleInputGroup, .buttonGroup {
	margin-bottom: 15px;
}

label {
	display: block;
	font-weight: bold;
	margin-bottom: 5px;
	color: #b3b3b3;
}

input[type="text"], select {
	width: 100%;
	padding: 12px;
	margin: 8px 0;
	box-sizing: border-box;
	border: 1px solid #444;
	border-radius: 4px;
	background-color: #333;
	color: #fff;
}

input[type="text"]::placeholder {
	color: #b3b3b3;
}

/* 검색 결과 영역 */
#searchResults {
	margin-top: 10px;
	background-color: #333;
	padding: 10px;
	border-radius: 4px;
}

#selectedResult {
	margin-top: 10px;
	background-color: #333;
	padding: 10px;
	border-radius: 4px;
}

.resultItem {
	padding: 8px 10px;
	border-bottom: 1px solid #444;
}

.resultItem:hover {
	background-color: #444;
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
}

#submitBtn {
	background-color: #e50914;
	color: #ffffff;
}

#submitBtn:hover {
	background-color: #f40612;
}

#resetBtn {
	background-color: #b3b3b3;
	color: #333;
}

#resetBtn:hover {
	background-color: #8c8c8c;
}

#goBack {
	background-color: #888;
	color: #ffffff;
}

#goBack:hover {
	background-color: #555;
}

/* 푸터와 네비게이션 스타일 */
footer, nav {
	background-color: #333;
	color: #b3b3b3;
	padding: 10px;
	text-align: center;
}
</style>
</head>
<body>
	<jsp:include page="layout/popUpHeader.jsp" />

	<div class="container">
		<div class="mainBanner">
			<h2>여기는 게시판 메인 배너</h2>
		</div>

		<div class="inputGroup">
			<form id="boardForm" method="post">
				<div class="categorySelectGroup">
					<label for="categorySelect">카테고리 선택</label>
					<select name="category"	id="categorySelect" class="inputField">
						<option value="default" disabled selected>선택하세요</option>
						<option value="popup">팝업스토어</option>
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
				<div class="buttonGroup">
					<button type="button" id="submitBtn">작성 완료</button>
					<button type="button" id="resetBtn">초기화</button>
					<button type="button" id="goBack">뒤로가기</button>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="layout/popUpFooter.jsp" />
	<jsp:include page="layout/goodsNavBar.jsp" />
</body>
<script type="text/javascript" src="/resources/partyJs/insertBoard.js"></script>
</html>
