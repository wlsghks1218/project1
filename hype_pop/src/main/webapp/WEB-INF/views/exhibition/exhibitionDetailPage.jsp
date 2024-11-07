exhibitionDetailPage.jsp.txt
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>전시회 상세 페이지</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
}

.container {
	max-width: 1200px;
	margin: 20px auto;
	padding: 20px;
	background: #fff;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
	display: flex;
}

.image {
	width: 100%;
	height: auto;
	border-radius: 8px;
}

.info-section {
	flex: 2;
}

h1 {
	text-align: center;
	color: #333;
}

h2 {
	color: #c0392b;
}

.exhibition-info {
	margin: 10px 0;
	line-height: 1.5;
}

.back-button {
	text-align: center;
	margin-top: 20px;
}

.btn {
	display: inline-block;
	padding: 10px 20px;
	background-color: #c0392b;
	color: #fff;
	text-decoration: none;
	border-radius: 5px;
	transition: background-color 0.3s ease;
}

.btn:hover {
	background-color: #a93226;
}

.viewing-info, .details-section, .reply-section {
	margin: 20px auto;
	padding: 15px;
	max-width: 1200px;
	background: #fff;
	border: 2px solid #333;
	border-radius: 5px;
	display: none;
}

.viewing-info h3, .details-section h3, .reply-section h3 {
	color: #c0392b;
}

.table-container {
	margin: 20px 0;
	text-align: center;
}

.table-container h3 {
	display: inline;
	cursor: pointer;
	margin: 0 15px;
}

.separator {
	font-size: 1.8em; /* 폰트 크기를 조정하여 크기를 키움 */
	margin: 0 10px; /* 좌우 여백 추가 */
	line-height: 1; /* 줄 높이 조정 */
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #333;
	padding: 10px;
	text-align: left;
}

th {
	background-color: #c0392b;
	color: #fff;
}

td {
	background-color: #f9f9f9;
}
/* 별점 및 후기 스타일 */
.starRating span {
	font-size: 30px;
	cursor: pointer;
	color : gray;
}

.starRating span:hover, .starRating span.active {
	color: gold;
}

#userReviews {
	width: 80%;
	margin: 0 auto 30px auto;
	padding: 20px;
	background-color: #222;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
}

#userReviews h2 {
	color: #fff;
	font-size: 28px;
	font-weight: 600;
	margin-bottom: 20px;
	text-align: left;
	padding-bottom: 10px;
	border-bottom: 2px solid #e50914;
}

.myChat, .allChat {
	list-style-type: none;
	padding: 0;
	color: #fff;
}

.myChat li, .allChat li {
	background-color: #333;
	padding: 15px;
	margin-bottom: 10px;
	border-radius: 8px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
	color: #fff;
	width: 80%;
	margin: 0 auto 10px;
	position: relative;
}

.reviewItem {
	margin-bottom: 20px;
}

.reviewContent {
	width: 80%;
	display: inline-block;
}

.avgStarRating {
	display: flex;
	align-items: center;
	margin: 20px auto;
	width: 50%;
	justify-content: space-between;
}

#selectedRating {
	margin-bottom: 15px;
	text-align: center;
	color : white;
}

#reviewForm {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	width: 80%;
	margin: 30px auto;
	background-color: #222;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
}

#reviewText {
	width: 100%;
	background-color: #333;
	color: #fff;
	border: 1px solid #444;
	border-radius: 5px;
	padding: 10px;
	margin-bottom: 15px;
	font-size: 16px;
	resize: none;
}

#addReply {
	background-color: #e50914;
	color: #fff;
	border: none;
	padding: 10px 20px;
	font-size: 16px;
	cursor: pointer;
	border-radius: 5px;
	transition: background-color 0.3s;
}

#addReply:hover {
	background-color: #c3070a;
}
.editCommentInput {
	width: 100%;
	padding: 10px;
	margin-bottom: 10px;
	font-size: 16px;
	border: 1px solid #444;
	border-radius: 5px;
	background-color: #222;
	color: #fff;
}
.reply-container {
    border: 1px solid #ccc; /* 테두리 추가 */
    border-radius: 8px; /* 모서리 둥글게 */
    padding: 10px; /* 내부 여백 */
    margin: 10px 0; /* 항목 간격 */
    background-color: #f9f9f9; /* 배경색 추가 */
}

.reply-header {
    display: flex; /* 플렉스 박스 사용하여 정렬 */
    justify-content: space-between; /* 양쪽 끝으로 정렬 */
    margin-bottom: 5px; /* 헤더와 본문 간격 */
}

.user-no {
    font-weight: bold; /* 사용자 번호 강조 */
}

.exh-score {
    color: #ff9800; /* 별점 색상 설정 */
}

.exh-reg-date {
    color: #757575; /* 등록 날짜 색상 설정 */
}

.exh-comment {
    font-size: 16px; /* 댓글 내용 글자 크기 */
    color: #333; /* 댓글 내용 글자 색상 */
    margin-top: 5px; /* 상단 여백 */
    line-height: 1.5; /* 줄 높이 설정 */
    width : 100%;
    height : 100px;
    resize: none;
    padding : 5px;
}
ul {
    list-style-type: none; /* 마커 제거 */
    padding: 0; /* 기본 패딩 제거 */
    margin: 0; /* 기본 마진 제거 */
}
.reply-container {
    position: relative;
    padding-bottom: 40px; /* 버튼 컨테이너 공간 확보 */
}

.button-container {
    position: absolute;
    right: 0;
    bottom: 0;
}
.fa-star {
    font-size: 18px;
    color: #ccc; /* 기본 색상 */
}
.fa-star.active {
    color: #FFD700; /* 채워진 별 색상 */
}
.image-section {
    flex: 1;
    margin-right: 20px;
    background-color: gray;
    border-radius: 8px;
    padding: 10px;
    position: relative; /* 절대 위치 설정을 위한 상대 위치 */
    display: flex;
}

#likeContainer {
    position: absolute; /* 절대 위치 설정 */
    top: 10px; /* 상단 위치 */
    right: 10px; /* 오른쪽 위치 */
    display: flex; /* 수평으로 나열하기 위해 flex 사용 */
    align-items: center; /* 수직 중앙 정렬 */
}

#likeCount {
    margin-right: 2px; /* 하트와의 간격 조정 */
    font-size: 20px; /* 글자 크기 조정 (필요시) */
}

#heartIcon {
    font-size: 30px; /* 하트 크기 */
    color: white; /* 초기 색상 변경 */
    cursor: pointer; /* 커서 모양 변경 */
}

#heartIcon.active {
    color: red; /* 활성화된 상태 */
}
</style>
</head>
<body>
	<jsp:include page="layout/popUpHeader.jsp" />

	<br>

	<div class="container">
		<div class="image-section">
			<div id = "likeContainer">
			<p id = "likeCount"></p>
			<span class="heart" id = "heartIcon" onclick="toggleHeart(this)">&#9825;</span>		
			</div>
		</div>
		<div class="info-section">
			<input type=hidden id="exhNo" value = "${exhibition.exhNo}">
			
			<table>
				<tr>
					<th>이름</th>
					<td>${exhibition.exhName}</td>
				</tr>
				<tr>
					<th>위치</th>
					<td>${exhibition.exhLocation}</td>
				</tr>
				<tr>
					<th>전시 기간</th>
					<td>${exhibition.exhStartDate}~${exhibition.exhEndDate}</td>
				</tr>
				<tr>
					<th>관람 시간</th>
					<td><c:choose>
							<c:when test="${exhibition.exhWatchTime == 0}">
                            	제한없음
                        </c:when>
							<c:otherwise>
                            ${exhibition.exhWatchTime}분
                        </c:otherwise>
						</c:choose></td>
				</tr>
				<tr>
					<th>관람 연령</th>
					<td>${exhibition.exhWatchAge}</td>
				</tr>
				<tr>
					<th>가격</th>
					<td>${exhibition.exhPrice}원</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="table-container">
		<h3 id="viewingInfoToggle">관람정보</h3>
		<h3 class="separator">|</h3>
		<h3 id="viewingDetailToggle">상세정보</h3>
		<h3 class="separator">|</h3>
		<h3 id="replyToggle">후기작성</h3>
	</div>

	<div class="viewing-info" id="viewingInfo">
		<p id="exhibitionInfo"></p>
	</div>

	<div class="details-section" id="detailsSection">
		상세정보
		<div id="detailedImageContainer"></div>
	</div>

	<div class="reply-section" id="replySection">
		후기작성
		<div id="replyContainer">
			<form id="reviewForm" method="post">
				<div class="starRating" id="newReviewStars">
  			  		<span data-value="1" >★</span>
   			 		<span data-value="2" >★</span>
   			 		<span data-value="3" >★</span>
  			  		<span data-value="4" >★</span>
  			  		<span data-value="5" >★</span>
				</div>
				<p id="selectedRating">선택한 별점: <span></span></p>
			
				<textarea id="reviewText" name="reviewText"
					placeholder="후기를 작성해주세요..." rows="5" cols="50"></textarea>
				<input type="hidden" id="rating" name="rating" value="0"> <input
					type="button" id="addReply" value="등록하기">
			</form>
			
			<div>
				<h2>후기들</h2>
				<br><hr><br>
				<ul id = "reviewsList">
				
				</ul>
			</div>
			<div class="pagination"></div>

		</div>
	</div>

	<div class="back-button">
		<a href="${pageContext.request.contextPath}/exhibition/exhibitionMain"
			class="btn">뒤로 가기</a>
	</div>

	<br>
	<hr>
	<br>
	
	<jsp:include page="layout/popUpNavBar.jsp" />
	<jsp:include page="layout/popUpFooter.jsp" />
	<script type="text/javascript" src="/resources/popUpJs/popUpMain.js"></script>
	<script type="text/javascript"
		src="/resources/exhibitionJs/exhibitionDetail.js"></script>

	<script type="text/javascript">
		// JSP에서 exhibitionInfo 값을 JavaScript 변수로 가져오기
		var exhibitionInfo = "${exhibition.exhInfo}";

		// 줄바꿈을 <br> 태그로 변환
		exhibitionInfo = exhibitionInfo.replace(/\n/g, "<br/>");

		// 변환된 정보를 HTML에 삽입
		document.getElementById("exhibitionInfo").innerHTML = exhibitionInfo;
	</script>
</body>
</html>