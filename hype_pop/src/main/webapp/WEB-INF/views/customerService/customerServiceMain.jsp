<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<style>
/* CSS 스타일 */
/* a 태그의 기본 스타일 */
a {
   text-decoration: none; /* 밑줄 제거 */
   color: black; /* 기본 텍스트 색상 검정색 */
   transition: color 0.3s ease; /* 색상 변화에 대한 트랜지션 효과 추가 */
}

a:hover {
   color: blue; /* 마우스를 가져다 대면 색상이 파란색으로 변경 */
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

.tab div.active {
   background-color: #ccc; /* 활성화된 탭의 배경 색상 */
}

.content {
   max-width: 800px; /* 최대 너비 설정 */
   height: 600px;
   margin: 0 auto; /* 중앙 정렬 */
   padding: 20px; /* 패딩 추가 */
   border: 1px solid #ccc; /* 테두리 추가 */
   border-radius: 5px; /* 모서리 둥글게 */
   background-color: #f9f9f9; /* 배경 색상 */
   position: relative; /* 부모 요소에 상대 위치 설정 */
}

.content section {
   display: none; /* 기본적으로 모든 섹션 숨기기 */
   text-align: center;
}

.content section.active {
   display: block; /* 활성화된 섹션만 보이기 */
}

.createAnnouncementBtn, .createInquiryBtn {
   position: absolute; /* 절대 위치로 설정 */
   bottom: 10px; /* 아래쪽 여백 */
   right: 10px; /* 오른쪽 여백 */
}

.content ul {
   list-style-type: none;
   padding: 0;
}

.content ul li {
   display: flex;
   align-items: center;
   justify-content: space-between;
   background-color: #f0f0f0;
   border: 1px solid #ccc;
   border-radius: 5px;
   margin: 10px 0;
   padding: 10px;
   transition: background-color 0.3s;
}

.content ul li:hover {
   background-color: #e0e0e0;
}

.content ul li .title {
   flex-grow: 1;
   margin-left: 10px;
}

.content ul li .number, .content ul li .date {
   margin-left: 10px;
}

.search {
   display: flex;
   align-items: center;
   justify-content: flex-end;
   margin-bottom: 20px;
}

.search input[type="text"] {
   padding: 5px;
   margin-right: 10px;
}

.search img {
   cursor: pointer;
}

.pagination {
   display: flex;
   justify-content: center;
   align-items: center;
   margin-top: 20px;
}

.pagination a {
   margin: 0 5px;
   padding: 10px 15px;
   border: 1px solid #ccc;
   border-radius: 5px;
   text-decoration: none;
   color: black;
   transition: background-color 0.3s ease;
}

.pagination a:hover {
   background-color: #f0f0f0;
}

.pagination a.active {
   background-color: #007bff;
   color: white;
}

.answerStatus {
   margin-left: 10px; /* 여백 추가 */
   color: green; /* 기본 색상 */
}

.answerStatus
:contains
 
('
답변
 
대기
 
중
 
')
{
color
:
 
orange
; /* 대기 중일 때 색상 변경 */


}
.answerStatus
:contains
 
('
답변
 
완료
 
')
{
color
:
 
blue
; /* 완료 시 색상 변경 */


}
.answer {
    display: none;
    margin-left: 20px; /* 답변을 약간 들여쓰기 해서 구분 */
}
</style>
</head>
<body>
   <jsp:include page="layout/popUpHeader.jsp" />

   <br>
   <div class="tab">
      <div id="tab-announcement" class="active"
         onclick="switchTab('announcement')">공지사항</div>
      <div id="tab-inquiry" onclick="switchTab('inquiry')">1:1 문의</div>
      <div id="tab-faq" onclick="switchTab('faq')">FAQ</div>
   </div>

   <div class="content">
      <!-- 공지사항 -->
      <section id="section-announcement" class="active">
         <div>
            <h2>공지사항</h2>
            <div class="search">
               <input type="text" id="search" placeholder="제목 검색..."> <img
                  id="searchBtn" src="/resources/images/searchicon.png" alt="Search">
            </div>
         </div>
         <br>
         <hr>
         <br>
         <ul class="announcement-list">
            <li>로딩 중...</li>
         </ul>

         <br> <br>

         <div class="pagination">
            <span class="notice-page-numbers"></span>
         </div>

         <div class="createAnnouncementBtn">
            <input type="button" onclick="createNotice()" value="공지작성">
         </div>
      </section>

      <!-- 1:1 문의 -->
      <section id="section-inquiry">
         <h2>1:1 문의</h2>
         <br>
         <hr>
         <br>
         <ul class="inquiry-list">
            <li>로딩 중...</li>
         </ul>

         <br> <br>

         <div class="pagination">
            <span class="inquiry-page-numbers"></span>
         </div>

         <div>
            <button type="button" onclick="createInquiry()"
               class="createInquiryBtn">문의 등록</button>
         </div>
      </section>

      <!-- FAQ -->
      <section id="section-faq">
         <h2>FAQ</h2>
         <ul class="faq-list">
            <li>Q: 고객센터 운영 시간은 언제인가요? <a href="#" class="toggle-answer">▼</a></li>
            <li class="answer">A: 몰라용</li>

            <li>Q: 개꿀팀 있을까요? <a href="#" class="toggle-answer">▼</a></li>
            <li class="answer">A: 몰라용</li>

            <li>Q: 회원 탈퇴는 어떻게 하나요? <a href="#" class="toggle-answer">▼</a></li>
            <li class="answer">A: 몰라용</li>
         </ul>
      </section>


   </div>

   <br>
   <hr>
   <br>

   <jsp:include page="layout/popUpFooter.jsp" />
   <jsp:include page="layout/popUpNavBar.jsp" />
   <script type="text/javascript"
      src="/resources/customerServiceJs/customerService.js"></script>
   <script type="text/javascript" src="/resources/popUpJs/popUpMain.js"></script>

</body>
</html>
