<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성</title>
<style>
/* cnContext 스타일 */
.cnContext {
	max-width: 800px; /* 최대 너비를 800px로 증가 */
	margin: 0 auto; /* 중앙 정렬 */
	padding: 30px; /* 여백을 30px로 증가 */
	border: 1px solid #ccc; /* 테두리 */
	border-radius: 5px; /* 둥근 모서리 */
	background-color: #f9f9f9; /* 배경 색상 */
}

/* 제목 및 날짜 스타일 */
.title-date {
	display: flex; /* Flexbox 사용 */
	justify-content: space-between; /* 양쪽 끝으로 정렬 */
	margin-bottom: 20px; /* 아래 여백 추가 */
}

/* 텍스트 필드 스타일 */
#cnTitle {
	flex-grow: 1; /* 가능한 공간을 차지 */
	margin-right: 10px; /* 제목과 날짜 간격 */
	padding: 10px; /* 패딩을 10px로 증가 */
	font-size: 16px; /* 폰트 크기를 증가 */
}

input[type="text"][readonly] {
	background-color: #e9ecef; /* 읽기 전용 배경 색상 */
	border: 1px solid #ccc; /* 테두리 */
	padding: 10px; /* 패딩을 10px로 증가 */
	flex-basis: 150px; /* 고정 너비 */
	font-size: 16px; /* 폰트 크기를 증가 */
}

/* 내용 입력 필드 스타일 */
textarea {
	width: 100%; /* 전체 너비 */
	height: 300px; /* 높이를 300px로 증가 (12줄 정도) */
	padding: 10px; /* 패딩을 10px로 증가 */
	margin-bottom: 20px; /* 아래 여백 추가 */
	resize: none; /* 크기 조절 비활성화 */
	font-size: 16px; /* 폰트 크기를 증가 */
}

/* 버튼 스타일 */
button {
	padding: 10px 20px; /* 패딩 */
	background-color: #007bff; /* 배경 색상 */
	color: white; /* 글자 색상 */
	border: none; /* 테두리 없애기 */
	border-radius: 5px; /* 둥근 모서리 */
	cursor: pointer; /* 포인터 커서 */
	font-size: 16px; /* 폰트 크기를 증가 */
	margin-top: 10px; /* 버튼 위쪽 여백 추가 */
}

button:hover {
	background-color: #0056b3; /* 호버 시 색상 변경 */
}

#goBack {
	padding: 10px 20px; /* 패딩 */
	background-color: #007bff; /* 배경 색상 */
	color: white; /* 글자 색상 */
	border: none; /* 테두리 없애기 */
	border-radius: 5px; /* 둥근 모서리 */
	cursor: pointer; /* 포인터 커서 */
	font-size: 16px; /* 폰트 크기를 증가 */
	margin-top: 10px; /* 버튼 위쪽 여백 추가 */
}

#goBack:hover {
	background-color: #0056b3; /* 호버 시 색상 변경 */
}

/* 버튼 컨테이너 스타일 */
.button-container {
	text-align: center; /* 버튼 중앙 정렬 */
	margin-top: 20px; /* 위쪽 여백 추가 */
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

	<div class="cnContext">
		<form action="/support/createNotice" method="post">
			<div class="title-date">
				<input type="text" id="cnTitle" name=title
					placeholder="제목을 입력하세요..."> <input type="text"
					id="currentDate" name="currentDate" readonly="readonly">
			</div>
			<div>
				<textarea rows="10" cols="30" name=content
					placeholder="내용을 입력하세요..."></textarea>
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
	<script type="text/javascript"
		src="/resources/customerServiceJs/createNotice.js"></script>
	<script type="text/javascript" src="/resources/popUpJs/popUpMain.js"></script>
	    <script type="text/javascript" src="/resources/customerServiceJs/menu.js"></script>
</body>
</html>