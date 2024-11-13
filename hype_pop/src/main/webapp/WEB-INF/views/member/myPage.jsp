<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style>
html {
   height: 100%;
   overflow-y: auto; /* 세로 스크롤 활성화 */
}

body {
   font-family: Arial, sans-serif;
   margin: 0;
   padding: 0;
   overflow-y: auto;
}

.container {
   max-width: 90%;
   width: 800px; /* 컨테이너 가로 길이 확장 */
   margin: 50px auto;
   background-color: rgba(255, 255, 255, 0.8);
   border-radius: 8px;
   max-height: 80vh; /* 화면의 높이를 넘지 않도록 설정 */
   padding: 10px; /* 상단, 하단 여백을 넉넉하게 설정 */
   box-sizing: border-box; /* padding이 요소 크기에 포함되도록 설정 */
   padding-top: 40px;
   padding-bottom: 80px;
   min-height: 1300px; /* 최소 세로 길이 지정 */
   overflow: auto; /* 스크롤바가 필요할 때 자동으로 생성되도록 설정 */
   margin-bottom: 30px; /* 여백 추가 */
   overflow: hidden;
}

/* Header */
header {
   display: flex;
   justify-content: space-between;
   align-items: center;
   padding: 10px 20px;
   background-color: #eee;
   border-bottom: 2px solid #ccc;
}

header .home-btn, header .search-btn {
   background-color: #f5a9bc;
   border: none;
   padding: 10px;
   cursor: pointer;
}

header .search-bar {
   flex-grow: 1;
   margin: 0 20px;
}

header .search-bar input {
   width: 100%;
   padding: 10px;
   border: none;
   border-bottom: 2px solid #ccc;
   outline: none;
}

/* Form Layout */
.form-section {
   width: 60%;
   margin: 20px auto;
   font-size: 14px;
}

.form-section h2 {
   text-align: center;
   margin-bottom: 20px;
   font-size: 24px;
}

.form-item {
   margin-bottom: 20px; /* 아래 요소와의 간격 */
   position: relative;
}

.form-item label {
   display: block;
   font-size: 14px;
   margin-bottom: 5px;
}

.form-item input {
   width: 100%;
   padding: 5px 0;
   border: none;
   border-bottom: 2px solid #ccc;
   outline: none;
}

.form-item button {
   position: absolute;
   top: 10px;
   right: 0;
   padding: 5px 10px;
   background-color: #ccc;
   border: none;
   cursor: pointer;
   font-size: 12px;
}

/* 댓글 버튼 스타일 */
.comment-btn {
   margin-top: 10px; /* 버튼과 위 요소 간 간격 */
   text-align: right;
}

/* Image Grid for Stores and Goods */
.image-grid {
   display: grid;
   grid-template-columns: repeat(4, 1fr);
   gap: 10px;
   margin: 20px 0;
}
.image-goodsItem img {
    width: 100%; /* 이미지가 부모의 너비를 넘지 않도록 설정 */
    height: auto; /* 비율을 유지하며 자동 크기 조정 */
    object-fit: cover; /* 이미지 비율을 유지하며 크기를 맞추기 */
}
/* Image items */
.image-goodsItem {
    width: 100%; /* 부모의 너비를 가득 채움 */
    height: 200px; /* 고정된 높이 설정 */
    overflow: hidden; /* 내용이 넘칠 경우 숨김 처리 */
}
.image-item {
   position: relative;
   text-align: center;
}

.image-item img {
   width: 100%;
   height: auto;
   cursor: pointer;
}

.image-item button {
   position: absolute;
   top: 5px;
   right: 5px;
   background-color: red;
   color: white;
   border: none;
   cursor: pointer;
}

/* Button section */
.btn-section {
   display: flex;
   justify-content: space-between;
   align-items: center; /* 수직 중앙 정렬 */
   margin: 0 10px;
   margin-bottom: 200px;
   position: relative;
   flex-wrap: wrap;
   bottom: 50px; /* 화면 하단에서 20px 떨어진 위치 */
   z-index: 1000;
   margin-top: 80px;
   padding-bottom: 30px;
}

/* Footer */
footer {
   text-align: center;
   margin: 40px 0;
}

/* Navigation Bar */
nav {
   position: fixed;
   bottom: 0;
   left: 0;
   width: 100%;
   background-color: #ccc;
   text-align: center;
}

nav a {
   margin: 10px;
   text-decoration: none;
   color: black;
}

#foundUserPwModal, #changeUserEmailModal, #changePhoneNumberModal {
   position: fixed;
   top: 50%;
   left: 50%;
   transform: translate(-50%, -50%);
   display: none;
   z-index: 1000;
   background-color: white;
   border-radius: 10px;
}

/* 모달 창 컨텐츠 */
.modal-content {
   background-color: white;
   padding: 20px;
   width: 450px; /* 가로 크기 줄이기 */
   border-radius: 10px; /* 둥근 모서리 */
   box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
   text-align: center;
   position: relative; /* X 버튼 위치를 위한 상대적 위치 */
   padding: 50px;
}

/* 모달 제목 */
.modal-title {
   font-size: 18px;
   font-weight: bold;
   margin-bottom: 20px;
}

/* 모달 내부의 폼 */
.modal-body .form-group {
   margin-bottom: 15px;
}

/* 모달의 제출 버튼 */
.modal-footer {
   text-align: center;
}

/* 모달 안에 있는 input 박스 스타일링 */
.modal-input {
   width: calc(100% - 20px); /* 가로 크기 줄이기, padding을 고려 */
   height: 40px; /* 세로 크기 */
   padding: 5px; /* 내부 여백 */
   font-size: 16px; /* 글자 크기 */
   box-sizing: border-box; /* padding 포함하여 전체 크기 계산 */
   margin: 10px; /* 바깥 여백 추가 */
   border: 1px solid #ccc;
   flex: 1;
}

/* X 버튼 스타일링 */
.close {
   position: absolute;
   top: 10px;
   right: 10px; /* 오른쪽 여백 줄여서 안쪽으로 이동 */
   font-size: 24px;
   font-weight: bold;
   color: #aaa;
   cursor: pointer;
   transition: color 0.3s ease;
}

/* 닫기 버튼 스타일 */
.close-interest {
   position: absolute; /* 절대 위치로 설정 */
   top: 5px; /* 상단에서 10px */
   right: 10px; /* 오른쪽에서 10px */
   font-size: 28px;
   font-weight: bold;
   cursor: pointer;
   color: black; /* 글자 색상 */
   z-index: 9999; /* 다른 요소보다 위로 올리기 */
}

.close:hover, .close-interest {
   color: #000; /* 호버 시 색상 변경 */
}

/*인증코드를 전송중입니다 창  */
#customAlert {
   position: fixed;
   top: 10%;
   left: 50%;
   transform: translate(-50%, -50%);
   display: none;
   z-index: 1000;
   background-color: rgba(255, 255, 255, 0.8); /* 흰색 배경에 불투명도 추가 */
   padding: 20px;
   box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 약간의 그림자 추가 */
   color: black; /* 글씨 색상 검정 */
}

.slider-container {
   display: flex;
   align-items: center;
   position: relative;
   max-height: 300px;
}

.image-grid {
   display: flex;
   overflow: hidden;
   width: 100%; /* 또는 원하는 크기 */
}

.image-item {
   flex: 0 0 25%; /* 한 번에 4개 보이도록 설정 */
   box-sizing: border-box;
   padding: 10px;
}

.arrow {
   background-color: transparent;
   border: none;
   font-size: 2em;
   cursor: pointer;
   z-index: 1; /* 버튼이 이미지 위에 오도록 설정 */
   position: absolute;
   top: 50%;
   transform: translateY(-50%);
}

.left {
   left: 10px; /* 좌측 화살표 위치 */
}

.right {
   right: 10px; /* 우측 화살표 위치 */
}

/* 모달 배경 */
.modal-background {
   position: fixed;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   background: rgba(0, 0, 0, 0.5);
   z-index: 999;
}

.userInterest {
   position: fixed;
   top: 50%;
   left: 50%;
   transform: translate(-50%, -50%);
   background-color: white;
   border-radius: 8px;
   box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
   z-index: 1000;
   padding: 20px;
   width: 80%;
   max-width: 600px;
   overflow-y: auto;
   text-align: center; /* 추가: 내용 가운데 정렬 */
}

.interestBoxContainer {
   text-align: center; /* 확인 버튼을 가운데 정렬 */
   position: fixed;
   top: 50%;
   left: 50%;
   transform: translate(-50%, -50%);
   background-color: white;
   border-radius: 8px;
   box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
   border: 2px solid #ddd; /* 테두리 추가 */
   z-index: 1000;
   padding: 20px;
   width: 80%;
   max-width: 600px;
   overflow-y: auto;
   text-align: center;
   position: absolute; /* .crest 버튼 기준 */
}

.interestmodal {
   position: fixed;
   top: 50%;
   left: 50%;
   transform: translate(-50%, -50%);
   background-color: white;
   border-radius: 8px;
   box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
   border: 2px solid #ddd; /* 테두리 추가 */
   z-index: 1000;
   padding: 20px;
   width: 80%;
   max-width: 600px;
   overflow-y: auto;
   text-align: center;
   position: relative; /* .crest 버튼 기준 */
}

/* 관심사 박스 스타일 */
.interestBox {
   display: inline-flex;
   padding: 0;
   box-sizing: border-box;
   cursor: pointer;
   margin: 10px;
   border-radius: 4px;
   transition: background-color 0.3s ease;
   width: calc(33% - 20px); /* 세 개씩 가로로 나열 */
   text-align: center;
   justify-content: center; /* 자식 요소 가로 중앙 정렬 */
   align-items: center; /* 자식 요소 세로 중앙 정렬 */
   font-size: 14px;
   height: 40px; /* 높이를 고정해서 div와 label 크기를 일치시킴 */
}

.interestBox.selected {
   background-color: #e89ef0;
   color: #fff;
   border: 1px solid #007bff;
}

.interestBox:hover {
   background-color: #f0f0f0;
}

/* 체크박스를 체크했을 때 색깔을 변경 */
.interestBox input[type="checkbox"]:checked+label {
   background-color: #e89ef0; /* 체크된 상태에서 배경색 변경 */
   color: white; /* 글자 색 변경 */
}

/* 체크박스에 마우스를 올렸을 때 배경 색을 변경 */
.interestBox:hover label {
   background-color: #f0f0f0;
}

/* 체크박스 기본 상태에서 배경색 */
.interestBox label {
   display: flex;
   padding: 0;
   font-size: 14px; /* 글자 크기 조정 */
   padding-left: 10px;
   margin: 0; /* 마진 제거 */
   border-radius: 4px;
   border: 1px solid #ddd;
   cursor: pointer;
   transition: background-color 0.3s;
   align-items: center; /* 세로 중앙 정렬 */
   justify-content: center; /* 가로 중앙 정렬 */
   height: 100%; /* 부모 div의 높이에 맞추기 */
   cursor: pointer;
   display: flex; /* Flex 사용 */
   align-items: center; /* 세로 중앙 정렬 */
   justify-content: center; /* 가로 중앙 정렬 */
   height: 100%; /* 부모 div의 높이에 맞추기 */
   width: 100%; /* 부모 div의 너비에 맞추기 */
}

/* 체크박스 라벨에 스타일을 추가해서, 체크박스를 더 직관적으로 만들어줌 */
.interestBox input[type="checkbox"] {
   display: none; /* 체크박스를 보이지 않게 숨기고 */
   transform: scale(0.9); /* 체크박스 크기 키우기 */
   margin-right: 10px;
}

.interestBox input[type="checkbox"]:checked+label:before {
   margin-right: 8px;
}

/* 확인 버튼 */
.confirm-button {
   background-color: #6c757d;
   color: white;
   border: none;
   padding: 10px 20px;
   border-radius: 5px;
   cursor: pointer;
   margin-top: 10px;
   transition: background-color 0.3s ease;
}

.confirm-button:hover {
   background-color: #5a6268;
}

/* 닫기 버튼 */
.close {
   color: #aaa;
   font-size: 28px;
   font-weight: bold;
   cursor: pointer;
}

.close:hover, .close:focus {
   color: black;
}

/* 관심사 선택 3개 제한 메시지 */
.limitMessage {
   color: red;
   font-size: 14px;
}

#userInterestDisplay {
   white-space: nowrap; /* 한 줄로 표시되고 공백을 유지 */
   display: inline-block; /* 인라인 요소처럼 처리 */
}

.btn-sec {
   background-color: #495057; /* 기본 배경색 (회색) */
   color: white; /* 텍스트 색상 */
   font-size: 14px; /* 글자 크기 */
   font-weight: 600; /* 글자 두께 */
   padding: 12px 24px; /* 상하좌우 패딩 */
   border: none; /* 테두리 제거 */
   cursor: pointer; /* 마우스 포인터를 손 모양으로 */
   transition: all 0.3s ease; /* 부드러운 효과 */
   flex: 1;
   max-width: 200px; /* 버튼의 최대 너비 설정 */
   margin: 5px; /* 버튼 사이에 여백 추가 */
   margin-top: 10px;
}

.btn-sec:hover {
   background-color: #5a6268; /* 호버 시 배경색 변경 (더 어두운 회색) */
   transform: translateY(-2px); /* 살짝 위로 올라가는 효과 */
}

.btn-sec:active {
   background-color: #343a40; /* 클릭 시 배경색 더 어두워짐 (진한 회색) */
   transform: translateY(2px); /* 클릭 시 눌리는 효과 */
}

.btn-sec:focus {
   outline: none; /* 포커스 시 외곽선 제거 */
   box-shadow: 0 0 0 2px rgba(108, 117, 125, 0.5); /* 회색 테두리 추가 */
}

.form-group-inline {
   display: flex;
   align-items: center; /* 수직 정렬 */
   gap: 10px; /* 입력 필드와 버튼 사이의 간격 */
}

#userReplyBtn {
   background-color: #6c757d; /* 기본 배경색 (회색) */
   color: white; /* 텍스트 색상 */
   font-size: 12px; /* 글자 크기 */
   font-weight: 600; /* 글자 두께 */
   padding: 10px 20px; /* 상하좌우 패딩 */
   border: none; /* 테두리 제거 */
   cursor: pointer; /* 마우스 포인터를 손 모양으로 */
   transition: all 0.3s ease; /* 부드러운 효과 */
   margin-top: 10px;
}
</style>

</head>
<body>

   <header>
      <jsp:include page="layout/popUpHeader.jsp" />
   </header>

   <div class="container">


      <div class="form-section">
         <h2>마이페이지</h2>

         <div class="form-item">
            <label for="userName">이름</label> <input type="text" id="userName"
               value="${userInfo.userName}" readonly>
         </div>

         <div class="form-item">
            <label for="userId">아이디</label> <input type="text" id="userId"
               value="${userInfo.userId}" readonly>
         </div>

         <div class="form-item">
            <label for="userPw">비밀번호</label> <input type="password" id="userPw"
               value="**********" readonly>
            <button type="button" class="btn btn-sec" id="newPasswordBtn">비밀번호
               변경</button>
         </div>

         <div class="form-item">
            <label for="userEmail">이메일</label> <input type="email"
               id="userEmail" value="${userInfo.userEmail}" readonly>
            <button type="button" class="btn btn-sec" id="newEmailBtn">이메일
               변경</button>
            <div id="customAlert">인증코드를 전송 중입니다.</div>
         </div>

         <div class="form-item">
            <label for="userNumber">전화번호</label> <input type="text"
               id="userNumber" value="${userInfo.userNumber}" readonly>
            <button type="button" class="btn btn-sec" id="newPhoneNumberBtn">전화번호
               변경</button>
         </div>


         <!--관심사 배열  -->
         <%--       <%
          String[] interestNames = {
              "헬스/뷰티", 
             "게임", 
             "문화", 
             "쇼핑", 
             "문구", 
             "키즈", 
             "디자인", 
             "식품", 
             "인테리어", 
             "정책", 
             "캐릭터", 
             "체험", 
             "콜라보", 
             "방송"   
          };
       %>  --%>




         <div class="form-item">
            <label for="userInterest">관심사</label>
            <div class="interest-container">
               <div id="userInterestDisplay">
                  <!-- JavaScript로 업데이트된 관심사들이 여기에 표시됩니다 -->

                  <c:if test="${userInterests.healthBeauty == 1}">
                     <span>헬스/뷰티 </span>
                  </c:if>
                  <c:if test="${userInterests.game == 1}">
                     <span>게임 </span>
                  </c:if>
                  <c:if test="${userInterests.culture == 1}">
                     <span>문화 </span>
                  </c:if>
                  <c:if test="${userInterests.shopping == 1}">
                     <span>쇼핑 </span>
                  </c:if>
                  <c:if test="${userInterests.supply == 1}">
                     <span>문구 </span>
                  </c:if>
                  <c:if test="${userInterests.kids == 1}">
                     <span>키즈 </span>
                  </c:if>
                  <c:if test="${userInterests.design == 1}">
                     <span>디자인 </span>
                  </c:if>
                  <c:if test="${userInterests.foods == 1}">
                     <span>식품 </span>
                  </c:if>
                  <c:if test="${userInterests.interior == 1}">
                     <span>인테리어 </span>
                  </c:if>
                  <c:if test="${userInterests.policy == 1}">
                     <span>정책 </span>
                  </c:if>
                  <c:if test="${userInterests.character == 1}">
                     <span>캐릭터 </span>
                  </c:if>
                  <c:if test="${userInterests.experience == 1}">
                     <span>체험 </span>
                  </c:if>
                  <c:if test="${userInterests.collaboration == 1}">
                     <span>콜라보 </span>
                  </c:if>
                  <c:if test="${userInterests.entertainment == 1}">
                     <span>방송 </span>
                  </c:if>
               </div>
               <button type="button" class="btn btn-sec" id="newInterestBtn"
                  onclick="openInterestModal()">관심사 변경</button>
            </div>
         </div>

         <!-- 모달 창  -->
         <div id="userInterest" class="interestModal" style="display: none;">
            <!-- <div class="modal-background" onclick="closeModal()"></div>-->
            <!-- 배경 클릭 시 모달 닫기 -->


            <div class="interestBoxContainer">
               <span class="close-interest" onclick="closeInterestModal()">&times;</span>
               <p>관심사를 선택하세요(3개를 선택해 주세요!)</p>
               <form id="interestForm">
                  <!-- 관심사 박스 -->
                  <div class="interestBox" data-interest="헬스/뷰티">
                     <input type="checkbox" id="healthBeauty"
                        name="userInterest.healthBeauty" value="1"> <label
                        for="healthBeauty" class="interestBoxDiv">헬스/뷰티</label>
                  </div>

                  <div class="interestBox" data-interest="게임">
                     <input type="checkbox" id="game" name="userInterest.game"
                        value="1"> <label for="game" class="interestBoxDiv">게임</label>
                  </div>

                  <div class="interestBox" data-interest="문화">
                     <input type="checkbox" id="culture" name="userInterest.culture"
                        value="1"> <label for="culture" class="interestBoxDiv">문화</label>
                  </div>

                  <div class="interestBox" data-interest="쇼핑">
                     <input type="checkbox" id="shopping" name="userInterest.shopping"
                        value="1"> <label for="shopping" class="interestBoxDiv">쇼핑</label>
                  </div>

                  <div class="interestBox" data-interest="문구">
                     <input type="checkbox" id="supply" name="userInterest.supply"
                        value="1"> <label for="supply" class="interestBoxDiv">문구</label>
                  </div>

                  <div class="interestBox" data-interest="키즈">
                     <input type="checkbox" id="kids" name="userInterest.kids"
                        value="1"> <label for="kids" class="interestBoxDiv">키즈</label>
                  </div>

                  <div class="interestBox" data-interest="디자인">
                     <input type="checkbox" id="design" name="userInterest.design"
                        value="1"> <label for="design" class="interestBoxDiv">디자인</label>
                  </div>

                  <div class="interestBox" data-interest="식품">
                     <input type="checkbox" id="foods" name="userInterest.foods"
                        value="1"> <label for="foods" class="interestBoxDiv">식품</label>
                  </div>

                  <div class="interestBox" data-interest="인테리어">
                     <input type="checkbox" id="interior" name="userInterest.interior"
                        value="1"> <label for="interior" class="interestBoxDiv">인테리어</label>
                  </div>

                  <div class="interestBox" data-interest="정책">
                     <input type="checkbox" id="policy" name="userInterest.policy"
                        value="1"> <label for="policy" class="interestBoxDiv">정책</label>
                  </div>

                  <div class="interestBox" data-interest="캐릭터">
                     <input type="checkbox" id="character"
                        name="userInterest.character" value="1"> <label
                        for="character" class="interestBoxDiv">캐릭터</label>
                  </div>

                  <div class="interestBox" data-interest="체험">
                     <input type="checkbox" id="experience"
                        name="userInterest.experience" value="1"> <label
                        for="experience" class="interestBoxDiv">체험</label>
                  </div>

                  <div class="interestBox" data-interest="콜라보">
                     <input type="checkbox" id="collaboration"
                        name="userInterest.collaboration" value="1"> <label
                        for="collaboration" class="interestBoxDiv">콜라보</label>
                  </div>

                  <div class="interestBox" data-interest="방송">
                     <input type="checkbox" id="entertainment"
                        name="userInterest.entertainment" value="1"> <label
                        for="entertainment" class="interestBoxDiv">방송</label>
                  </div>

                  <p id="limitMessage" class="limitMessage"
                     style="display: none; color: red;">관심사는 3개를 선택해 주세요!</p>



               </form>
               <button class="confirm-button" onclick="saveInterests()">확인</button>

            </div>

         </div>



         <div class="comment-btn">
            <button type="button" id="userReplyBtn" onclick="goToMyReply()">내가
               쓴 글 보기</button>
         </div>
         <!--       <button type="button" class="btn btn-sec" id="goCartBtn" onclick="goToMyCart">장바구니</button>
 -->

      </div>


      <div class="form-section">
         <h3>좋아요한 팝업스토어</h3>
         <div class="slider-container">
            <input type="hidden" value="2" name="userNo" id="userNo">
            <button class="arrow left" onclick="slideLeft('goodsSlider')">❮</button>
            <div class="image-grid" id="goodsSlider">
               <c:forEach var="goods" items="${gLikeList}">
                  <div class="image-goodsItem" id="goods-${goods.gno}"
                     data-file-name="${goods.uuid}_${goods.fileName}">
                     <c:if test="${not empty goods.gname}">
                        <img alt="${goods.gname}" id="goodsBannerImg" />
                     </c:if>
                     <button onclick="removeGoods(${goods.gno})">X</button>
                  </div>
               </c:forEach>
            <button class="arrow right" onclick="slideRight('goodsSlider')">❯</button>
            </div>
            </div>
            <h3>좋아요한 굿즈</h3>
            <div class="slider-container">
               <input type="hidden" value="2" name="userNo" id="userNo">
               <button class="arrow left" onclick="slideLeft('goodsSlider')">❮</button>
               <div class="image-grid" id="goodsSlider">
                  <c:forEach var="goods" items="${gLikeList}">
                      <input id="goodsImageFileName" type="hidden" value="${goods.uuid}_${goods.fileName}">
                      <div class="image-goodsItem" id="goods-${goods.gno}"
                        data-file-name="${goods.uuid}_${goods.fileName}">
                        <c:if test="${not empty goods.gname}">
                           <img alt="${goods.gname}" id="goodsBannerImg" />
                        </c:if>
                        <button onclick="removeGoods(${goods.gno})">X</button>
                     </div>
                  </c:forEach>
                  <button class="arrow right" onclick="slideRight('goodsSlider')">❯</button>

               </div>
            </div>
            <h3>좋아요한 전시</h3>
            <div class="slider-container">
               <input type="hidden" value="2" name="userNo" id="userNo">
               <button class="arrow left" onclick="slideLeft('goodsSlider')">❮</button>
               <div class="image-grid" id="goodsSlider">
                  <c:forEach var="goods" items="${gLikeList}">
                     <div class="image-exhibitionItem" id="goods-${goods.gno}"
                        data-file-name="${goods.uuid}_${goods.fileName}">
                        <c:if test="${not empty goods.gname}">
<%--                            <img src="/images/${goods.uuid}_${goods.fileName}"
                              alt="${goods.gname}"> --%>
                        </c:if>
                        <button onclick="removeGoods(${goods.gno})">X</button>
                     </div>
                  </c:forEach>
                  <button class="arrow right" onclick="slideRight('goodsSlider')">❯</button>
               </div>
            </div>

            <div class="btn-section">
               <button type="button" class="btn btn-sec" id="goCartBtn"
                  onclick="goToMyCart()">장바구니</button>
               <input type="hidden" value="2" name="userNo" id="userNo">
               <button type="button" class="btn btn-sec" id="paymentListBtn"
                  onclick="getPayList(userNo)">내결제 목록</button>
               <button type="button" class="btn btn-sec" id="deleteIdBtn"
                  style="background-color: red; color: white;">회원 탈퇴</button>
            </div>
         </div>
      </div>

      <!--    <div class="image-item">
            <img src="popup1.jpg" alt="팝업스토어1" onclick="goToPopupDetail(1)">
            <button onclick="removePopup(1)">X</button>
         </div>
         <div class="image-item">
            <img src="popup2.jpg" alt="팝업스토어2" onclick="goToPopupDetail(2)">
            <button onclick="removePopup(2)">X</button>
         </div>
         <div class="image-item">
            <img src="popup3.jpg" alt="팝업스토어3" onclick="goToPopupDetail(3)">
            <button onclick="removePopup(3)">X</button>
         </div>
         <div class="image-item">
            <img src="popup4.jpg" alt="팝업스토어4" onclick="goToPopupDetail(4)">
            <button onclick="removePopup(4)">X</button>
         </div> -->



      <!--    <div class="image-item">
            <img src="goods1.jpg" alt="굿즈1" onclick="goToGoodsDetail(1)">
            <button onclick="removeGoods(1)">X</button>
         </div>
         <div class="image-item">
            <img src="goods2.jpg" alt="굿즈2" onclick="goToGoodsDetail(2)">
            <button onclick="removeGoods(2)">X</button>
         </div>
         <div class="image-item">
            <img src="goods3.jpg" alt="굿즈3" onclick="goToGoodsDetail(3)">
            <button onclick="removeGoods(3)">X</button>
         </div>
         <div class="image-item">
            <img src="goods4.jpg" alt="굿즈4" onclick="goToGoodsDetail(4)">
            <button onclick="removeGoods(4)">X</button>
         </div> -->




      <!-- 푸터 포함 -->
      <jsp:include page="layout/popUpFooter.jsp" />
      <jsp:include page="layout/popUpNavBar.jsp" />




      <!--///////////////모달 창//////////////  -->


      <!--비밀번호 변경 모달-->
      <div id="foundUserPwModal" style="display: none;">
         <div class="modal-content">
            <!-- X 버튼 추가 -->
            <span class="close" onclick="closePwModal()">&times;</span>
            <form action="passwordChange?userNo=${userNo}" method="get"
               id="passwordChangeForm" onsubmit="return submitPwChange()">
               <div class="modal-body">
                  <div class="form-group">
                     <p>
                        <input type="password" class="modal-input" name="oldPw"
                           placeholder="기존 비밀번호 입력" required>
                     </p>
                  </div>
                  <div class="form-group">
                     <p>
                        <input type="password" class="modal-input" name="newPw"
                           placeholder="신규 비밀번호 입력" required>
                     </p>
                  </div>
                  <div class="form-group">
                     <span> <input type="password" class="modal-input"
                        name="checkNewPw" placeholder="신규 비밀번호 확인" required>
                     </span>
                  </div>
               </div>
               <div class="modal-footer">
                  <button type="submit" class="btn btn-sec">비밀번호 변경</button>
               </div>


            </form>
         </div>
      </div>
      <!--이메일 변경 모달  -->

      <div id="changeUserEmailModal" style="display: none;">
         <div class="modal-content">
            <!-- X 버튼 추가 -->
            <span class="close" onclick="closeEmailModal()">&times;</span>
            <form id="EmailChangeForm">
               <div class="modal-body">
                  <!-- 이메일 전송 필드 -->
                  <div class="form-group form-group-inline">
                     <input type="email" class="modal-input" id="userEmail2"
                        value="${userInfo.userEmail}">
                     <button type="button" id="sendEmailBtn" class="btn btn-sec"
                        onclick="verifyEmailSend()">이메일 전송</button>
                  </div>

                  <!-- 코드 입력 및 확인 버튼 -->
                  <div class="form-group form-group-inline">
                     <input type="number" class="modal-input" name="verifyCode"
                        id="verifyCodeInput" placeholder="코드 입력" required>
                     <button type="button" id="sendEmailCode" class="btn btn-sec"
                        onclick="verifyEmailCode()">코드 확인</button>
                  </div>

                  <!-- 신규 이메일 입력 -->
                  <div class="form-group">
                     <input type="email" class="modal-input" name="newEmail"
                        placeholder="신규 이메일 입력" required>
                  </div>

                  <!-- 신규 이메일 확인 -->
                  <div class="form-group">
                     <input type="email" class="modal-input" name="checkNewEmail"
                        placeholder="신규 이메일 확인" required>
                  </div>
               </div>

               <div class="modal-footer">
                  <button type="button" class="btn btn-sec"
                     onclick="submitEmailChange()">이메일 변경</button>
               </div>
            </form>
         </div>
      </div>

      <!-- 전화번호 변경 모달 -->
      <div id="changePhoneNumberModal" style="display: none;">
         <div class="modal-content">
            <!-- X 버튼 추가 -->
            <span class="close" onclick="closePhoneNumModal()">&times;</span>
            <form action="phoneNumberChange?userNo=${userNo}" method="get"
               id="phoneNumberChange">
               <div class="modal-body">
                  <input id="userNo" type="hidden" value="2" name="userNo">
                  <div class="form-group">
                     <p>
                        <input type="text" class="modal-input" name="oldPhoneNumber"
                           placeholder="기존 전화번호 입력">
                     </p>
                  </div>
                  <div class="form-group">
                     <p>
                        <input type="text" class="modal-input" name="newPhoneNumber"
                           placeholder="신규 전화번호 입력">
                     </p>
                  </div>
                  <div class="form-group">
                     <span> <input type="text" class="modal-input"
                        name="checkNewPhoneNumber" placeholder="신규 전화번호 확인">
                     </span>
                  </div>
               </div>
               <div class="modal-footer">
                  <button type="submit" class="btn btn-sec"
                     onclick="return PhoneNumberChange()">전화번호 변경</button>
               </div>
            </form>
         </div>
      </div>




      <script type="text/javascript" src="/resources/memberJs/myPage.js"></script>
      <script type="text/javascript" src="/resources/purchaseJs/myCart.js"></script>
</body>


</html>
