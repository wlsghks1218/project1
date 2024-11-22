<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
   prefix="sec"%>
<!DOCTYPE html>
<html>

<head>
<link rel="icon" href="/resources/images/favicon.ico">
<meta charset="UTF-8">
<title>공지사항 작성</title>
<style>
/* cnContext 스타일 */
.ciContext {
	max-width: 800px;
	margin: 0 auto;
	padding: 30px;
	border: 1px solid #ccc;
	border-radius: 5px;
	background-color: #f9f9f9;
}

/* 제목 및 날짜 스타일 */
.title-date {
	display: flex;
	align-items: center; /* 수직 정렬 */
	margin-bottom: 20px;
}

/* 텍스트 필드 스타일 */
#ciTitle {
	flex-grow: 1;
	margin-right: 10px;
	padding: 10px;
	font-size: 16px;
}

/* 내용 입력 필드 스타일 */
textarea {
	width: 100%;
	height: 300px;
	padding: 10px;
	margin-bottom: 20px;
	resize: none;
	font-size: 16px;
}

/* 셀렉트박스 스타일 */
select {
	padding: 10px;
	font-size: 16px;
	border-radius: 5px;
	border: 1px solid #ccc;
	background-color: #f9f9f9;
	margin-left: 10px; /* 여백 추가 */
}

/* 버튼 스타일 */
button, #goBack {
	padding: 10px 20px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	margin-top: 10px;
}

button:hover, #goBack:hover {
	background-color: #0056b3;
}

/* 버튼 컨테이너 스타일 */
.button-container {
	text-align: center;
	margin-top: 20px;
}

.tab {
	display: flex; /* Flexbox를 사용하여 수평 배치 */
	gap: 20px; /* 각 탭 사이의 간격 */
	margin-bottom: 20px; /* 탭 아래 여백 */
	justify-content: center; /* 가운데 정렬 */
}

.tab div {
	padding: 10px 20px; /* 패딩 추가로 클릭 영역 확장 */
	background-color: #f0f0f0; /* 기본 배경 색상 */
	border-radius: 5px; /* 모서리 둥글게 */
	cursor: pointer; /* 마우스 커서를 포인터로 변경 */
	transition: background-color 0.3s; /* 배경 색상 변화 효과 */
}
</style>
</head>

<body>
	<jsp:include page="layout/popUpHeader.jsp" />

	<br>

	<div class="tab">
		<div id="tab-announcement" onclick="goToNotice()">공지사항</div>
		<div id="tab-inquiry" onclick="goToInquiry()">1:1 문의</div>
		<div id="tab-faq" onclick="goToFaq()">FAQ</div>
	</div>

	<div class="ciContext">
		<form action="/support/createInquiry" method="post">
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal" var="pinfo" />
				<input type="hidden" name="userNo" value="${pinfo.member.userNo}">
			</sec:authorize>

			<div class="title-date">
				<input type="text" id="ciTitle" name="title"
					placeholder="제목을 입력하세요..." required> <select id="qnaType"
					name="qnaType" required>
					<option value="" disabled selected>유형 선택</option>
					<option value="일반">일반</option>
					<option value="기술">기술</option>
					<option value="결제">결제</option>
					<option value="기타">기타</option>
				</select>
			</div>

			<div>
				<textarea rows="10" cols="30" name="content"
					placeholder="내용을 입력하세요..." required></textarea>
			</div>
			<div class="button-container">
				<input type="button" id="goBack" onclick="window.history.back()"
					value="돌아가기">
				<button type="submit">등록하기</button>
			</div>
		</form>
	</div>

	<br>

	<jsp:include page="layout/popUpFooter.jsp" />
	<jsp:include page="layout/popUpNavBar.jsp" />
	<script type="text/javascript" src="/resources/popUpJs/popUpMain.js"></script>
	<script type="text/javascript" src="/resources/customerServiceJs/menu.js"></script>
</body>

</html>