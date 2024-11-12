<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Exhibition Banners</title>
<style>
/* 기존 스타일 유지 */
.banner-container {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 350px;
	overflow: hidden;
	background-color: #f0f0f0;
	padding: 20px;
	margin: 0 auto;
	width: 650px;
	border: 2px solid #ccc;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
.filter {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 50px;
	overflow: hidden;
	background-color: #f0f0f0;
	padding: 20px;
	margin: 0 auto;
	width: 650px;
	border: 2px solid #ccc;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	border-bottom: none; /* 하단 보더 제거 */
    margin-bottom: 0; /* 하단 간격 제거 */
}
.exhibition-info-container {
	display: flex;
	flex-direction: column;
	align-items: center;
	min-height: 350px;
	overflow: hidden;
	background-color: #f0f0f0;
	padding: 20px;
	margin: 0 auto;
	width: 650px;
	border: 2px solid #ccc;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	font-size: 10px;
    margin-top: 0; /* 상단 간격 제거 */
}

.exhibition-schedule {
	display: flex;
	justify-content: space-between;
	align-items: center;
	width: 580px;
	padding: 15px;
	background-color: #e0e0e0;
	border: 1px solid #ccc;
	border-radius: 5px;
	margin-bottom: 10px;
	cursor: pointer;
	height: 80px;
}

.exhibition-context {
    display: none;
    width: 580px;
    align-items: stretch;
    transition: height 0.3s ease;
    display: flex; /* Flexbox 사용 */
    flex-direction: column; /* 수직 방향으로 정렬 */
}

.exhibition-banner-img {
    width: 100%; /* 배너가 전체 너비를 차지하도록 설정 */
    height: 300px; /* 배너 이미지 높이 설정 (조정 가능) */
    background-color: #e0e0e0; /* 배경색 설정 (이미지가 없을 때) */
    background-size: cover; /* 배경 이미지가 요소의 크기에 맞게 조정 */
    background-position: center; /* 배경 이미지의 위치 설정 */
    margin-bottom: 10px; /* 아래 여백 추가 */
}

table {
    width: 100%; /* 테이블 너비를 100%로 설정하여 일관성 유지 */
    border-collapse: collapse;
    height: auto; /* 자동 높이로 설정 */
}

th, td {
    padding: 8px;
    text-align: left;
    border: 1px solid #ccc;
    font-size: 10px;

    /* 크기 고정 설정 */
    min-height: 50px; /* 최소 높이 설정 (조정 가능) */
    max-height: 50px; /* 최대 높이 설정 (조정 가능) */
    overflow: hidden; /* 내용이 넘칠 경우 숨김 */
    text-overflow: ellipsis; /* 텍스트 넘침 시 '...' 표시 */
    white-space: nowrap; /* 텍스트가 한 줄로 표시되도록 설정 */
}

th {
    background-color: #f2f2f2;
}

.exhibition-info {
	width: 100%;
	padding: 10px;
	background-color: #ffffff;
	border: none
	border-radius: 5px;
	margin-bottom: 20px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	list-style-type: none;
}

ul {
	list-style-type: none;
	padding: 0;
	margin: 0;
}

/* 중앙 정렬 및 스타일 개선 */
#load-more {
	display: block;
	margin: 20px auto; /* 중앙 정렬 */
	background-color: #007BFF; /* 버튼 배경 색상 */
	color: white; /* 글자 색상 */
	border: none; /* 테두리 제거 */
	padding: 10px 20px; /* 패딩 */
	border-radius: 5px; /* 모서리 둥글게 */
	cursor: pointer; /* 커서 모양 */
	font-size: 14px; /* 글자 크기 */
	transition: background-color 0.3s; /* 배경색 변화 효과 */
}

#load-more:hover {
	background-color: #0056b3; /* 마우스 호버 시 배경색 */
}
.filter {
    display: flex;
    justify-content: flex-end; /* `select` 박스를 오른쪽으로 정렬 */
    align-items: center; /* 수직 정렬 */
}

.filter select {
    text-align: center; /* `option` 안의 글자들을 중앙 정렬 */
    text-align-last: center; /* 선택된 항목의 글자를 중앙 정렬 */
}
#search {
    display: flex;
    align-items: center;
    margin-right: 10px; /* filterSelect와 간격을 줌 */
}

#searchExh {
    height: 25px; /* 원하는 높이로 설정 */
    padding: 5px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

#searchBtn {
    width: 30px; /* 이미지의 너비 */
    height: 25px; /* 텍스트 입력의 높이와 동일하게 설정 */
    margin-left: 5px; /* 텍스트 입력과 이미지 간격 */
    cursor: pointer;
}
</style>
</head>
<body>
	<jsp:include page="layout/popUpHeader.jsp" />

	<br>

	<div class="banner-container">
		<h2>배너 영역</h2>
	</div>

	<br>

	<div class="filter">
		<div id = "search">
			<input type = "text" id = "searchExh" placeholder = "검색...">
			<img id="searchBtn" src="/resources/images/searchicon.png" alt="Search">
		</div>
		<select id="filterSelect" onchange="filterExhibitions()">
			<option value="latest">시작일순</option>
			<option value="dueSoon">마감순</option>
			<option value="lowerPrice">낮은가격순</option>
			<option value="higherPrice">높은가격순</option>
			<option value="earlyBird">얼리버드</option>
		</select>
	</div>

	<div class="exhibition-info-container" id="exhibition-list">
		<c:forEach var="exhibition" items="${exhibitions}">
			<div class="exhibition-info">
				<div class="exhibition-schedule"
					onclick="toggleExhibitionContext(this)">
					<p style="margin: 0;">${exhibition.exhName}</p>
					<p style="margin: 0;">${exhibition.exhStartDate} ~
						${exhibition.exhEndDate}</p>
					<a href="javascript:void(0);"
						onclick="goToDetailPage(${exhibition.exhNo})"
						style="text-decoration: none;">
						<button
							style="background-color: #007BFF; color: white; border: none; padding: 5px 10px; border-radius: 5px;">
							상세페이지</button>
					</a>
				</div>
				<div class="exhibition-context">
					<div class="exhibition-banner-img">
						<!-- 배너 이미지가 들어갈 부분 -->
					</div>
					<table>
						<tbody>
							<tr>
								<th>전시회 이름</th>
								<td>${exhibition.exhName}</td>
							</tr>
							<tr>
								<th>전시회 기간</th>
								<td>${exhibition.exhStartDate} ~ ${exhibition.exhEndDate}</td>
							</tr>
							<tr>
								<th>전시회 장소</th>
								<td>${exhibition.exhLocation}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</c:forEach>
	</div>

	<button id="load-more" onclick="loadMoreExhibitions()">더보기</button>

	<br>
	<hr>
	<br>

	<jsp:include page="layout/popUpFooter.jsp" />
	<script type="text/javascript" src="/resources/popUpJs/popUpMain.js"></script>
	<script type="text/javascript"
		src="/resources/exhibitionJs/exhibitionMain.js"></script>
	
</body>
</html>