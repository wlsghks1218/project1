<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="/resources/images/favicon.ico">
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no">
<!-- 확대/축소 방지 -->
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	overflow-x: hidden; /* 수평 스크롤 방지 */
	background-color: #f7f9fc; /* 연한 하늘색 배경 */
}

.tab {
	display: flex;
	justify-content: center;
	background-color: #fce4ec; /* 연한 핑크색 배경 */
	padding: 10px 0;
	border-bottom: 2px solid #f48fb1; /* 밝은 핑크색 */
}

.tab div {
	margin: 0 15px;
	padding: 10px 20px;
	cursor: pointer;
	border-radius: 5px;
	transition: background-color 0.3s;
}

.tab div:hover {
	background-color: #f1c6d0; /* 연한 핑크색 hover */
}

.tab .active {
	background-color: #4caf50; /* 녹색으로 선택된 탭 색상 */
	color: white;
}

.container {
	display: flex;
	justify-content: center;
	margin: 0 40px;
	max-width: 100%; /* 컨테이너 최대 너비 */
}

.content {
	max-width: 90%; /* 너비를 70%로 설정 */
	margin: 20px;
	padding: 20px;
	background-color: #ffffff; /* 흰색 배경 */
	border-radius: 5px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	min-width: 300px; /* 최소 너비 설정 */
}

.popUpList {
	position: sticky;
	top: 100px;
	max-width: 30%;
	margin: 20px;
	padding: 20px;
	background-color: #b3e5fc; /* 하늘색 배경 */
	border-radius: 5px;
	min-width: 350px;
	max-height: 700px;
	overflow-y: auto;
}

.popUpItem {
    display: flex; /* 수평 배치 */
    align-items: center; /* 수직 중앙 정렬 */
    justify-content: flex-start; /* 좌측 정렬 */
    margin-bottom: 20px; /* 아이템 간 간격 */
    width: 100%; /* 전체 너비 */
    border: 2px solid #ccc; /* 테두리 추가 */
    border-radius: 8px; /* 테두리 둥글게 */
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    transition: all 0.3s ease; /* 호버 시 부드럽게 전환 */
    padding: 10px; /* 내부 여백 추가 */
}

.popUpItem:hover {
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2); /* 호버 시 그림자 효과 강조 */
    transform: translateY(-5px); /* 마우스 올렸을 때 살짝 위로 올라가는 효과 */
    border-color: #007BFF; /* 호버 시 테두리 색 변경 */
}
.itemInfo {
    width: 30%; 
    height: 300px;
    overflow: hidden;
}

.itemInfo ul {
	padding-left: 0;
	list-style: none; /* 기본 불릿 제거 */
	margin: 0;
}

.itemInfo ul li {
    font-size: 14px; /* 글자 크기 */
    line-height: 1.6; /* 줄 간격 */
    display: block; /* li 항목을 블록으로 설정 */
    margin-bottom: 10px; /* li 간 간격 추가 */
    overflow: visible; /* 텍스트가 잘리지 않도록 설정 */
    text-overflow: unset; /* ellipsis 사용하지 않음 */
    white-space: normal; /* 텍스트 줄 바꿈 가능 */
    max-width: 100%; /* 최대 너비 제한 없애기 */
    height: auto; /* 높이를 자동으로 늘려서 내용이 모두 보이도록 설정 */
}


.itemInfo ul li strong {
	color: #00796b; /* 다크한 초록색 강조 텍스트 */
	font-weight: bold;
}

.all-list {
	list-style: none;
	padding: 0;
}

.all-list li {
	padding: 10px;
	border-bottom: 1px solid #ccc;
}

.all-list li:last-child {
	border-bottom: none;
}

section {
	display: none;
}

section.active {
	display: block;
}

.calendar-container {
    width: 100%; /* 캘린더 전체 너비 */
    margin: 20px;
    padding: 20px;
    margin-left: -5px; /* 왼쪽으로 10px 이동 */
}

.calendar-table {
	min-width: 280px; /* 최소 너비 설정 */
	max-width: 100%; /* 최대 너비는 100%로 제한 */
	border-collapse: collapse; /* 경계를 겹치게 설정 */
}

.calendar-table th, .calendar-table td {
	border: 1px solid #ccc;
	text-align: center;
	padding: 5px;
	font-size: 7px;
	width: 35px; /* 고정된 너비 설정 */
	height: 35px; /* 고정된 높이 설정 */
	vertical-align: middle; /* 수직 중앙 정렬 */
	box-sizing: border-box; /* 여백을 포함한 크기 계산 */
}

.calendar-table td.monthDate {
	font-size: 12px !important; /* !important로 우선순위 강제 */
	font-weight: bold;
}

.calendar-table td.today {
	background-color: #ffeb3b; /* 노란색 배경 */
	font-weight: bold; /* 글자를 굵게 */
	border: 2px solid #e65100; /* 테두리를 진한 주황색 */
	font-size: 12px;
}

thead th {
	background-color: #f0f0f0;
	font-weight: bold;
}

.psName {
	width: 100px;
	height: 30px;
	max-width: 10ch; /* 최대 글자 수를 10자로 제한 */
	overflow: hidden; /* 넘치는 내용 숨김 */
	text-overflow: ellipsis; /* 줄임표(...) 추가 */
	white-space: nowrap; /* 줄 바꿈 방지 */
}

.schedule {
	width: 20px; /* 고정된 너비 설정 */
	height: 20px; /* 고정된 높이 설정 */
	vertical-align: middle; /* 수직 중앙 정렬 */
}

.schedule-1 {
	width: 20px; /* 고정된 너비 설정 */
	height: 20px;; /* 고정된 높이 설정 */
	background-color: #ff4081; /* 핑크색 배경 */
	background-image: linear-gradient(135deg, transparent 25%, rgba(255, 255, 255, 0.5)
		25%, rgba(255, 255, 255, 0.5) 50%, transparent 50%, transparent 75%,
		rgba(255, 255, 255, 0.5) 75%, rgba(255, 255, 255, 0.5));
	background-size: 10px 10px; /* 슬래시 크기 조절 */
}

.schedule-start {
	background-color: blue; /* 파란색 배경 */
	color: white; /* 글자색 흰색 */
	font-size: auto;
	width: 20px;
	height: 20px;
}

.schedule-end {
	background-color: red; /* 빨간색 배경 */
	color: white; /* 글자색 흰색 */
	font-size: auto;
	width: 20px;
	height: 20px;
}

.checkBoxList {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    max-width: 100%;
    background-color: #fce4ec; /* 연한 핑크색 배경 */
    padding: 10px;
}

.checkBoxList label {
    margin: 5px 25px; /* 위아래 5px, 좌우 10px 간격 */
}

.checkBoxList div {
	margin: 5px;
	width: 100px; /* 각 체크박스와 레이블이 함께 고정 너비로 설정 */
}

.monthChange {
	display: flex;
	justify-content: center; /* 수평 중앙 정렬 */
	align-items: center; /* 수직 중앙 정렬 (필요시 사용) */
	margin: 20px 0; /* 상하 간격 조절 */
}

.monthChange button {
	padding: 5px 10px; /* 버튼의 크기 조절 */
	font-size: 16px; /* 버튼 글자 크기 */
	background-color: #29b6f6; /* 파란색 버튼 */
	color: white;
	border: none;
	border-radius: 5px;
}

.monthChange span {
	font-size: 18px; /* 현재 월 글자 크기 */
	margin: 0 20px; /* 버튼과 현재 월 사이 간격 */
}

#currentDateMonth {
	margin-left: auto; /* 오른쪽으로 밀기 */
	margin-right: 30px; /* 오른쪽 여백 추가 */
}

.psImage {
    width: 70%; /* 이미지 영역을 70%로 설정 */
    height: 300px; /* 이미지 높이 */
    margin-right: 20px; /* 텍스트와 간격 */
    display: flex; /* 이미지가 컨테이너에 맞게 배치될 수 있도록 설정 */
    justify-content: center; /* 이미지가 가운데 정렬되도록 설정 */
    align-items: center; /* 이미지가 수직 중앙 정렬되도록 설정 */
}

.psImage img {
    width: 100%; /* 컨테이너 너비에 맞게 이미지 크기 조정 */
    height: 100%; /* 컨테이너 높이에 맞게 이미지 크기 조정 */
    object-fit: cover; /* 이미지 비율을 유지하면서 영역을 채우도록 설정 */
}

.popUpItem span {
	font-size: 17px; /* 글자 크기 조정 */
	line-height: 1.5; /* 줄 간격 조정 */
	display: block; /* 각 항목을 블록으로 만들어 줄 바꿈 */
}

.tooltip {
	position: absolute;
	background-color: rgba(0, 0, 0, 0.7);
	color: #fff;
	padding: 5px;
	border-radius: 5px;
	z-index: 1000;
	white-space: nowrap; /* 툴팁 텍스트가 줄 바꿈되지 않도록 설정 */
	display: none; /* 기본적으로 숨김 */
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: white;
	text-decoration: none;
	cursor: pointer;
}

.checkbox-disabled {
    pointer-events: none; /* 클릭할 수 없게 만듬 */
    opacity: 0.5; /* 비활성화된 느낌을 위해 투명도를 낮춤 */
    background-color: #d3d3d3; /* 비활성화된 배경색 */
    border-color: #b0b0b0; /* 회색 테두리 */
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
	background-color: #ff66b2; /* 핑크색 버튼 */
	color: white;
	border: none;
	cursor: pointer;
	font-size: 16px;
	border-radius: 5px;
	transition: background-color 0.3s;
}

.modal-content button:hover {
	background-color: #ff3399; /* 버튼 호버 시 색상 변경 */
}
.scroll-btn {
   position: fixed;
   bottom: 10vh;
   right: 2vw;
   display: flex;
   flex-direction: column; /* 버튼들이 위에서 아래로 정렬되게 설정 */
   gap: 0.625rem;
   z-index: 20;
}

.scroll-btn button {
   background-color: #00aff0; /* 배경색을 #00aff0로 변경 */
   color: white;
   padding: 1rem;
   border: none;
   border-radius: 10px; /* 모서리 둥글게 설정 */
   font-size: 0; /* 텍스트는 보이지 않도록 설정 */
   cursor: pointer;
   transition: background-color 0.3s, opacity 0.3s;
   display: flex;
   justify-content: center;
   align-items: center;
   width: 3rem; /* 버튼 크기 */
   height: 3rem; /* 버튼 크기 */
   position: relative; /* 삼각형을 위한 relative 위치 지정 */
   opacity: 0.5; /* 기본적으로 불투명 상태 */
}

.scroll-btn button:hover {
   background-color: #0092c4; /* 호버 시 색상 변경 */
   opacity: 1; /* 호버 시 불투명도 1로 설정 */
}


.scroll-btn button::before {
   content: "";
   position: absolute;
   width: 0;
   height: 0;
   border-left: 0.6rem solid transparent; /* 삼각형 크기 조정 */
   border-right: 0.6rem solid transparent; /* 삼각형 크기 조정 */
   left: 50%; /* 수평 중앙 정렬 */
   transform: translateX(-50%); /* 정확한 중앙 정렬 */
}

#scrollUp::before {
   border-bottom: 1.2rem solid white; /* 위로 화살표 크기 조정 */
   top: 50%; /* 버튼 중앙에 삼각형을 배치 */
   transform: translateY(-50%) translateX(-50%); /* 삼각형을 정확히 중앙에 맞추기 위한 변환 */
}

#scrollDown::before {
   border-top: 1.2rem solid white; /* 아래로 화살표 크기 조정 */
   bottom: 50%; /* 버튼 중앙에 삼각형을 배치 */
   transform: translateY(50%) translateX(-50%); /* 삼각형을 정확히 중앙에 맞추기 위한 변환 */
}

.scroll-btn button:hover {
   background-color: #0092c4; /* 호버 시 색상 변경 */
}

button:disabled {
   cursor: not-allowed;
   opacity: 0.5;
}
</style>
</head>
<body>
	<jsp:include page="../popUp/layout/popUpHeader.jsp" />
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="pinfo" />
		<input type="hidden" id="userNo" value="${pinfo.member.userNo}">
	</sec:authorize>
	<br>

	<div class="container">
		<div class="content">
			<div class="calendar-container">
				<div class="checkBoxList">
					<label><input type="checkbox" id="selectAll"
						class="category-checkbox"> 전체보기</label> <label><input
						type="checkbox" class="category-checkbox" value="healthBeauty">
						헬스/뷰티</label> <label><input type="checkbox"
						class="category-checkbox" value="game"> 게임</label> <label><input
						type="checkbox" class="category-checkbox" value="culture">
						문화</label> <label><input type="checkbox" class="category-checkbox"
						value="shopping"> 쇼핑</label> <label><input type="checkbox"
						class="category-checkbox" value="supply"> 문구</label> <label><input
						type="checkbox" class="category-checkbox" value="kids"> 키즈</label>
					<label><input type="checkbox" class="category-checkbox"
						value="design"> 디자인</label> <label><input type="checkbox"
						class="category-checkbox" value="foods"> 음식</label> <label><input
						type="checkbox" class="category-checkbox" value="interior">
						인테리어</label> <label><input type="checkbox"
						class="category-checkbox" value="policy"> 정책</label> <label><input
						type="checkbox" class="category-checkbox" value="character">
						캐릭터</label> <label><input type="checkbox"
						class="category-checkbox" value="experience"> 경험</label> <label><input
						type="checkbox" class="category-checkbox" value="collaboration">
						콜라보</label> <label><input type="checkbox"
						class="category-checkbox" value="entertainment"> 방송</label> <label><input
						type="checkbox" class="category-checkbox" value="myInterest"
						id="myInterest"> 내 관심사</label> <label><input
						type="checkbox" class="category-checkbox" value="myLike"
						id="myLike"> 내 좋아요</label>
				</div>


				<br>

				<div class="monthChange">
					<button id="prevMonth">&lt;</button>
					<!-- 이전 달로 이동 -->
					<span id="currentMonth">10월</span>
					<!-- 현재 달 표시 -->
					<button id="nextMonth">&gt;</button>
					<!-- 다음 달로 이동 -->
					<button id="currentDateMonth">현재 날짜로 이동</button>
				</div>


				<br>
				<table class="calendar-table">
					<thead>
						<tr id="calendar-days">
							<!-- 날짜 나올 공간  -->
						</tr>
					</thead>

					<tbody id="calendar-body">

						<!-- 팝업스토어 목록 나올 공간 -->
					</tbody>
				</table>
			</div>
		</div>

		<div class="popUpList" id="popUpList"></div>


	</div>

	<br>
	<hr>
	<br>

	<div id="loginModal" class="modal">
		<div class="modal-content">
			<span class="close">&times;</span>
			<p>로그인이 필요한 기능입니다.</p>
			<button id="goToLogin">로그인하러 가기</button>
		</div>
	</div>
	
	<div class="scroll-btn">
    <button id="scrollUp" aria-label="위로 이동"></button>
    <button id="scrollDown" aria-label="아래로 이동"></button>
</div>
	

	<jsp:include page="../popUp/layout/popUpFooter.jsp" />
	<script type="text/javascript" src="/resources/popUpJs/popUpHeader.js"></script>
	<script type="text/javascript"
		src="/resources/calendarJs/calendarMain.js"></script>
</body>
</html>
