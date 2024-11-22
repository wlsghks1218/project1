<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<link rel="icon" href="/resources/images/favicon.ico">
<meta charset="UTF-8">
<title>공지사항 정보</title>
<style>
.ciContext {
	max-width: 800px; /* 기존 크기 유지 */
	margin: 0 auto;
	padding: 30px;
	border: 1px solid #ccc; /* 기존 테두리 유지 */
	border-radius: 5px; /* 기존 둥근 모서리 */
	background-color: #f9f9f9; /* 기존 배경색 유지 */
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 추가된 그림자 */
	font-family: 'Arial', sans-serif;
}

/* 제목 및 날짜 스타일 */
.title-date {
	display: flex;
	align-items: center; /* 수직 정렬 */
	margin-bottom: 20px;
	gap: 10px; /* 추가된 간격 */
}

.ciContext input[type="text"] {
	flex-grow: 1;
	padding: 10px;
	font-size: 16px; /* 기존 폰트 크기 유지 */
	border: 1px solid #ccc;
	border-radius: 5px;
}

/* 내용 입력 필드 스타일 */
textarea {
	width: 100%;
	height: 300px; /* 기존 높이 유지 */
	padding: 10px;
	margin-bottom: 20px;
	resize: none;
	font-size: 16px; /* 기존 폰트 크기 유지 */
	border: 1px solid #ccc;
	border-radius: 5px;
}

/* 답변 영역 스타일 */
.answer-area textarea {
	height: 150px; /* 기존 높이에 맞춤 */
}

/* 셀렉트박스 스타일 */
select {
	padding: 10px;
	font-size: 16px; /* 기존 폰트 크기 유지 */
	border-radius: 5px;
	border: 1px solid #ccc;
	background-color: #f9f9f9;
	margin-left: 10px;
}

/* 버튼 스타일 */
.button-container {
	display: flex;
	justify-content: center; /* 버튼 중앙 정렬 */
	gap: 10px; /* 버튼 간격 유지 */
	margin-top: 20px;
}

.button {
	padding: 10px 20px;
	font-size: 16px; /* 기존 폰트 크기 유지 */
	color: white;
	background-color: #007bff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease; /* 부드러운 색상 전환 */
}

.button:hover {
	background-color: #0056b3;
}

/* 추가된 전체 컨텍스트 */
.ciContext .content-area {
	margin-bottom: 20px;
}

.ciContext .answer-area {
	margin-bottom: 20px;
}

.button:hover {
	background-color: #0056b3;
}

/* 버튼 컨테이너 스타일 */
.button-container {
	text-align: center;
	margin-top: 20px;
}

.modal {
	display: none; /* 기본적으로 숨김 */
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgb(0, 0, 0);
	background-color: rgba(0, 0, 0, 0.4);
	padding-top: 60px;
}

.modal-content {
	background-color: #fefefe;
	margin: 5% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
	max-width: 600px;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
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
		<form id="deleteForm" action="/support/deleteInquiry" method="post">
			<input type="hidden" name="qnaNo" id="qnaNo"
				value="${inquiryInfo.qnaNo}"> <input type="hidden"
				name="qnaAnswer" id="qnaAnswer" value="${inquiryInfo.qnaAnswer}">

			<div class="title-date">
				<input type="text" id="title" name="title"
					value="${inquiryInfo.qnaTitle}" readonly> <input
					type="text" id="type" name="type" value="${inquiryInfo.qnaType}"
					readonly>
			</div>

			<div>
				<textarea rows="10" cols="30" name="content" readonly>${inquiryInfo.qnaContext}</textarea>
			</div>

			<c:if test="${not empty inquiryInfo.qnaAnswer}">
				<div>
					<textarea rows="4" cols="30" name="answer" readonly
						style="height: 150px;">${inquiryInfo.qnaAnswer}</textarea>
				</div>
			</c:if>

			<div class="button-container">
				<input type="button" id="goBack" class="button"
					onclick="window.history.back()" value="돌아가기"> <input
					type="button" id="deleteInquiry" class="button" value="문의삭제">
				<input type="button" id="qnaAnswer" class="button" value="문의답변"
					onclick="openModal()">
			</div>
		</form>

	</div>

	<br>

	<div id="answerModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>
			<h2>답변 입력</h2>
			<br>
			<textarea id="answerContent" rows="4" placeholder="답변을 입력하세요..."></textarea>
			<div class="button-container">
				<input type="button" class="button" value="답변"
					onclick="submitResponse()">
			</div>
		</div>
	</div>

	<jsp:include page="layout/popUpFooter.jsp" />
	<jsp:include page="layout/popUpNavBar.jsp" />
	<script type="text/javascript"
		src="/resources/customerServiceJs/inquiryInfo.js"></script>
	<script type="text/javascript" src="/resources/popUpJs/popUpMain.js"></script>
	<script type="text/javascript"
		src="/resources/customerServiceJs/menu.js"></script>
</body>

</html>