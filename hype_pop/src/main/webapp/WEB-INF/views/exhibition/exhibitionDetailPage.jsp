<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags"   prefix="sec"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="icon" href="/resources/images/favicon.ico">
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
   background: #fee7ed; /* 핑크색 배경 */
   box-shadow: none; /* 그림자 없애기 */
   border: none; /* 보더를 아예 없애기 */
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
   background: #e0f7ff;
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
   background-color: #e0f7ff;
}
/* 별점 및 후기 스타일 */
.starRating span {
   font-size: 30px;
   cursor: pointer;
   color: gray;
}

.starRating span.active {
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
   color: black;
   font-weight: bold; /* 폰트를 두껍게 설정 */
}

#reviewForm {
   display: flex;
   flex-direction: column;
   align-items: center;
   justify-content: center;
   width: 80%;
   margin: 30px auto;
   background-color: #ffccf2; /* 연핑크 배경 */
   padding: 20px;
   border-radius: 10px;
   box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 투명도 줄임 */
}

#reviewText {
   width: 100%;
   background-color: #e0f7ff; /* 연하늘색 배경 */
   color: #333; /* 텍스트 색상: 어두운 회색 */
   border: 1px solid #99dfff; /* 하늘색 테두리 */
   border-radius: 5px;
   padding: 10px;
   margin-bottom: 15px;
   font-size: 16px;
   resize: none;
}

#addReply {
   background-color: #ff6ec7; /* 핫핑크 버튼 */
   color: #fff; /* 버튼 텍스트는 흰색 */
   border: none;
   padding: 10px 20px;
   font-size: 16px;
   cursor: pointer;
   border-radius: 5px;
   transition: background-color 0.3s;
   float: right;
}

#addReply:hover {
   background-color: #ff3aa8; /* 더 진한 핑크로 변경 */
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
   width: 100%;
   height: 100px;
   resize: none;
   padding: 5px;
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
    justify-content: center; /* 이미지를 중앙에 배치 */
    align-items: center; /* 이미지를 수직으로 중앙에 배치 */
    overflow: hidden; /* 이미지가 넘치지 않도록 자르기 */
}

.image-section img {
    width: 100%; /* 이미지 너비를 컨테이너의 너비에 맞추기 */
    height: auto; /* 이미지 비율을 유지하면서 높이를 자동으로 맞추기 */
    object-fit: cover; /* 이미지의 비율을 유지하면서 컨테이너에 맞게 잘라내기 */
}
.background-image {
    display: block;
    width: 100%; /* 이미지의 가로 크기 조정 */
    height: auto; /* 이미지의 세로 비율 유지 */
}

#likeContainer {
    position: absolute; /* 이미지 위에 겹쳐 배치 */
    top: 10px; /* 위쪽에서 10px 떨어짐 */
    right: 10px; /* 오른쪽에서 10px 떨어짐 */
    background-color: rgba(0, 0, 0, 0.6); /* 반투명 검은색 배경 */
    color: white; /* 텍스트 색상 흰색 */
    padding: 5px 10px; /* 안쪽 여백 조정 */
    border-radius: 5px; /* 모서리를 둥글게 */
    text-align: center; /* 내용 중앙 정렬 */
    z-index: 10; /* 이미지 위에 표시 */
    font-size: 14px; /* 글자 크기 작게 조정 */
    display: flex; /* 일자 배치를 위한 flexbox 사용 */
    align-items: center; /* 수직 중앙 정렬 */
    justify-content: flex-start; /* 가로로 나열 */
}
#likeContainer p {
    margin-right: 5px; /* 텍스트와 하트 간 간격 */
}

#likeCount {
    margin-right: 2px; /* 하트와의 간격 조정 */
    font-size: 20px; /* 글자 크기 조정 (필요시) */
}

#heartIcon {
    font-size: 30px; /* 하트 크기 */
    color: black; /* 초기 색상 변경 */
    cursor: pointer; /* 커서 모양 변경 */
}

#heartIcon.active {
    color: red; /* 활성화된 상태 */
}
.filled {
    color: gold;  /* 채운 별의 색 */
}

.empty {
    color: lightgray;  /* 빈 별의 색 */
}
/* 버튼이 포함된 컨테이너를 중앙 정렬 */
#paginationControls {
    display: flex; /* 플렉스 박스를 사용하여 요소 배치 */
    justify-content: center; /* 버튼들을 수평으로 중앙 정렬 */
    align-items: center; /* 버튼들을 수직으로 중앙 정렬 (필요할 경우) */
    margin-top: 20px; /* 버튼들 위쪽 여백 추가 */
}
/* 기본 페이지 버튼 스타일 */
.page-button {
    background-color: #f0f0f0;
    color: #333;
    border: 1px solid #ddd;
    padding: 5px 10px;
    font-size: 14px;
    cursor: pointer;
    margin: 0 5px;
    border-radius: 5px;
    transition: background-color 0.3s ease, transform 0.2s;
}

/* 페이지 버튼 호버 효과 */
.page-button:hover {
    background-color: #e0e0e0;
    transform: scale(1.1);
}

/* 활성화된 페이지 버튼 스타일 */
.page-button.active {
    background-color: #007bff;
    color: white;
    border: 1px solid #007bff;
}

/* 활성화된 버튼 호버 시 색상 변화 */
.page-button.active:hover {
    background-color: #0056b3;
}
/* details-section의 너비 설정 */
.details-section {
    margin: 20px auto;
    padding: 15px;
    max-width: 1200px;
    background: #fff;
    border: 2px solid #333;
    border-radius: 5px;
    display: block;
    width: 100%;
}

/* 이미지 컨테이너 크기 및 배치 */
#detailedImageContainer {
    width: 70%;  /* 원하는 너비로 설정 */
    margin: 0 auto;  /* 가로 중앙 정렬 */
    display: flex;
    justify-content: center;  /* 이미지가 가로로 중앙 정렬되게 설정 */
    align-items: center;  /* 세로로 중앙 정렬 */
}

/* 이미지 스타일 */
#detailedImageContainer img {
    width: 100%; /* 컨테이너의 가로 100% 크기 */
    height: auto; /* 세로는 자동으로 비율에 맞게 설정 */
    object-fit: contain;  /* 이미지가 잘리지 않도록 비율을 유지하며 크기 맞춤 */
    image-rendering: -webkit-optimize-contrast;  /* Chrome과 Safari에서 고해상도 렌더링 */
    image-rendering: crisp-edges;  /* Edge나 Firefox에서 고해상도 렌더링 */
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
   background-color: #e50914;
   color: white;
   border: none;
   cursor: pointer;
   font-size: 16px;
   border-radius: 5px;
   transition: background-color 0.3s;
}

.modal-content button:hover {
   background-color: #c3070a;
}

.close {
   color: #aaa;
   float: right;
   font-size: 28px;
   font-weight: bold;
   cursor: pointer;
}

.close:hover, .close:focus {
   color: #fff;
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
   <jsp:include page="layout/exhibitionDetailHeader.jsp" />
   <sec:authorize access="isAuthenticated()">
      <sec:authentication property="principal" var="pinfo" />
      <input type="hidden" id="userNo" value="${pinfo.member.userNo}">
   </sec:authorize>
   <br>

   <div class="container">
      <div class="image-section">
         
         <div id="likeContainer">
            <p id="likeCount"></p>
            <span class="heart" id="heartIcon" onclick="toggleHeart(this)">❤️</span>
         </div>
      </div>
      <div class="info-section">
         <input type=hidden id="exhNo" value="${exhibition.exhNo}">

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
      <h3 id="replyToggle">후기</h3>
   </div>

   <div class="viewing-info" id="viewingInfo">
      <p id="exhibitionInfo">${exhibition.exhInfo}</p>
   </div>

   <div class="details-section" id="detailsSection">
      <div id="detailedImageContainer">
         
      </div>
   </div>

   <div class="reply-section" id="replySection">
      <div id="replyContainer">
         <form id="reviewForm" method="post">
            <div class="starRating" id="newReviewStars">
               <span data-value="1">★</span> <span data-value="2">★</span> <span
                  data-value="3">★</span> <span data-value="4">★</span> <span
                  data-value="5">★</span>
            </div>
            <p id="selectedRating">
               선택한 별점: <span></span>
            </p>

            <textarea id="reviewText" name="reviewText"
               placeholder="후기를 작성해주세요..." rows="5" cols="50"></textarea>
            <input type="hidden" id="rating" name="rating" value="0"> <input
               type="button" id="addReply" value="등록하기">
         </form>

         <div>
            <h2>후기 목록</h2>
            <div style="display: flex; align-items: center;">
               <p style="margin: 0;">평균별점 : <span id="averageRatingValue"></span></p>
               <div class="averageStarRating" id="averageStarRating"
                  style="display: flex; margin-left: 10px;">
                  <c:forEach var="i" begin="1" end="5">
                     <span class="${avgRating >= i ? 'filled' : 'empty'}">★</span>
                  </c:forEach>
               </div>

            </div>

            <br>
            <hr>
            <br>
            <ul id="reviewsList">

            </ul>
         </div>
         <div id="paginationControls"></div>

      </div>
   </div>

   <div class="back-button">
      <a href="${pageContext.request.contextPath}/exhibition/exhibitionMain"
         class="btn">뒤로 가기</a>
   </div>
   
   <!-- 모달 창 HTML -->
   <div id="loginModal" class="modal">
      <div class="modal-content">
         <span class="close">&times;</span>
         <p>로그인이 필요한 기능입니다.</p>
         <button id="goToLogin">로그인하러 가기</button>
      </div>
   </div>

   <br>
   <hr>
   <br>

<div class="scroll-btn">
    <button id="scrollUp" aria-label="위로 이동"></button>
    <button id="scrollDown" aria-label="아래로 이동"></button>
</div>

   <jsp:include page="layout/exhibitionFooter.jsp" />
   <script type="text/javascript" src="/resources/popUpJs/popUpMain.js"></script>
   <script type="text/javascript"
      src="/resources/exhibitionJs/exhibitionDetail.js"></script>

   <script type="text/javascript">
    // exhibitionInfo 값을 HTML로 안전하게 출력
    var exhibitionInfo = "${exhibition.exhInfo}";

    // 줄바꿈을 <br> 태그로 변환
    exhibitionInfo = exhibitionInfo.replace(/\n/g, "<br/>");

    // 변환된 정보를 HTML에 삽입
    document.getElementById("exhibitionInfo").innerHTML = exhibitionInfo;
   </script>

</body>
</html>
