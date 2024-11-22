<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix = "sec" %>   
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="/resources/images/favicon.ico">
<meta charset="UTF-8">
<title>굿즈 스토어 상세 페이지</title>
<style>
/* 기본 설정 */
body {
    font-family: 'Arial', sans-serif;
    background-color: #fee7ed; /* 밝은 배경 */
    color: #141414; /* 어두운 글자색 */
    margin: 0;
    padding: 0;
    text-align: center; /* 기본 텍스트 중앙 정렬 */
    box-sizing: border-box; /* 패딩을 포함한 크기 계산 */
}

h1, h2, p, span {
    color: #000000;
    font-size: 1rem;
}

/* 굿즈 상세 섹션 */
.goodsDetails {
    display: flex; /* 좌우 배치를 위한 플렉스 박스 */
    width: 75%;
    max-width: 1200px; /* 최대 너비 제한 */
    margin: 0 auto; /* 가운데 정렬 */
    background-color: #ffffff; /* 배경색 흰색 */
    border-radius: 8px; /* 둥근 모서리 */
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
    overflow: hidden; /* 내용 넘침 방지 */
}

#goodsBannerDiv {
    flex: 1; /* 좌우 비율 1:1 */
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: #f0f0f0; /* 이미지 없는 경우 배경색 */
    border-right: 1px solid #ddd; /* 배너와 정보 영역 구분 */
    overflow: hidden; /* 이미지가 영역을 넘어가지 않도록 설정 */
    position: relative;
}

#goodsBanner {
    width: 100%; /* 부모 가로 영역을 완전히 채움 */
    height: 100%; /* 부모 세로 영역을 완전히 채움 */
    display: block; /* 이미지가 블록 요소로 동작 */
}

#goodsInfo {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 40px 20px 20px; /* 상단 여백 추가 */
    background-color: #ffffff;
}

#goodsInfo span {
    display: block;
    word-wrap: break-word;
    font-weight: bold;
    color: #141414;
}

#goodsInfo span:not(#goodsName) {
    font-size: 24px; /* goodsName 제외 모든 span 요소 */
}

#goodsName {
    font-size: 2rem; /* 기존 설정 유지 */
    margin-bottom: 15px; /* 아래 여백 */
    text-align: left; /* 왼쪽 정렬 */
    color: #141414; /* 어두운 색상 */
    font-weight: bold; /* 강조 */
}


#goodsPrice {
    font-size: 1.5rem;
    margin-bottom: 15px;
    text-align: left;
    color: #444;
}

#goodsDes {
    font-size: 1.2rem;
    line-height: 1.5;
    margin-bottom: 15px;
    text-align: left;
    color: #666;
}

#endDate {
    font-size: 1.2rem;
    margin-bottom: 20px;
    text-align: left;
    color: #888;
}

/* 좋아요 카운트 스타일 */
#totalLikeCount {
    position: absolute;
    top: 10px;
    right: 10px;
    background-color: rgba(0, 0, 0, 0.5);
    padding: 5px;
    border-radius: 4px;
    color: white;
    font-size: 1rem;
    font-weight: bold;
    z-index: 10;
}

#goodsLike {
    display: inline;
    margin-right: 5px;
}

/* 수량 선택 및 총 가격 영역 */
.quantityBar {
    display: flex;
    align-items: center; /* 수직 가운데 정렬 */
    justify-content: center; /* 수평 가운데 정렬 */
    gap: 10px; /* 버튼과 입력 필드 간격 */
}


.quantityBar button {
    background-color: #00aff0;
    color: white;
    border: none;
    font-size: 1.25rem;
    width: 2.5rem;
    height: 2.5rem;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.quantityBar button:hover {
    background-color: #008fcb;
}

#quantity {
    width: 3rem;
    font-size: 1.125rem;
    text-align: center;
    border: 1px solid #333;
    background-color: #00aff0;
    color: #fff;
}

.totalPrice {
    font-size: 1.375rem;
    font-weight: bold;
    color: #000000;
    white-space: nowrap; /* 텍스트 줄바꿈 방지 */
    display: flex;
    align-items: center; /* 텍스트와 숫자 수직 정렬 */
    gap: 5px; /* "총 가격:"과 가격 숫자 사이 간격 */
}
#totalPrice{
   margin: 0;
}
.totalPrice span {
    margin: 0; /* totalPrice 내부의 span 요소만 margin 제거 */
}

.totalPriceContainer {
    display: flex;
    align-items: center; /* 수직 가운데 정렬 */
    justify-content: center; /* 수평 가운데 정렬 */
    gap: 20px; /* 수량 선택과 총 가격 사이 간격 */
    width: 100%; /* 부모 컨테이너의 너비를 채움 */
}

/* 버튼 스타일 */
#addToCart, #directPurchase, #moveToStore {
    background-color: #00aff0;
    color: white;
    border: none;
    cursor: pointer;
    font-size: 1rem;
    padding: 0.625rem;
    border-radius: 4px;
    transition: background-color 0.3s;
}

#addToCart:hover, #directPurchase:hover, #moveToStore:hover {
    background-color: #008fcb;
}

#chkLike {
    background-color: #ffffff;
    border: none;
    cursor: pointer;
    padding: 0.5rem;
    display: flex;
    justify-content: center;
    align-items: center;
    transition: background-color 0.3s;
    border: 1px solid black;
    order: 1; /* 버튼 순서 변경 */
}

#chkLike:hover {
    background-color: #008fcb;
}
.actionButtons {
    display: flex;
    flex-wrap: wrap;
    justify-content: center; /* 버튼들을 가운데 정렬 */
    gap: 15px; /* 버튼 사이 간격 */
    margin-top: 30px; /* 상단 여백 추가 */
    padding-bottom: 20px; /* 하단 여백 추가 */
}
/* 리뷰 섹션 */

#reviewForm {
    background-color: #ffffff; /* 흰색 배경 */
    padding: 30px; /* 내부 여백 */
    border-radius: 8px; /* 둥근 모서리 */
    margin: 20px auto; /* 중앙 정렬 */
    width: 90%; /* 너비 설정 */
    max-width: 900px; /* 최대 너비 제한 */
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
}

#reviewForm textarea {
    width: 100%; /* 너비 100% */
    padding: 10px; /* 내부 여백 */
    border: none; /* 테두리 제거 */
    border-radius: 4px; /* 둥근 모서리 */
    background-color: #f0f0f0; /* 연한 회색 배경 */
    color: #141414; /* 어두운 텍스트 */
    font-size: 1rem; /* 기본 텍스트 크기 */
    margin-bottom: 15px; /* 하단 여백 */
}

#reviewForm .starRating span {
    font-size: 2rem; /* 별 크기 */
    color: gray; /* 기본 별 색상 */
    cursor: pointer;
    transition: color 0.3s; /* 색상 변화 부드럽게 */
}

#reviewText {
    width: 100%;
    background-color: #333;
    color: #fff;
    border: 1px solid #444;
    border-radius: 0.3125rem;
    padding: 1rem;
    margin-bottom: 0.9375rem;
    font-size: 1rem;
    resize: none;
}

#addReply {
    background-color: #00aff0;
    color: white;
    border: none;
    padding: 0.625rem 1.25rem;
    font-size: 1rem;
    cursor: pointer;
    border-radius: 0.3125rem;
    transition: background-color 0.3s;
}

#addReply:hover {
    background-color: #008fcb;
}

/* 별점 */
.starRating {
    display: flex;
    justify-content: center;
    margin-bottom: 0.625rem;
}

.starRating span {
    font-size: 1.875rem;
    cursor: pointer;
    color: gold;
}

.starRating span:hover, .starRating span.active {
    color: gold;
}
.goodsDetailImg {
    width: 75%; /* 부모 너비에 맞게 */
    max-width: 1200px; /* 최대 너비 제한 */
    margin: 20px auto; /* 상단 여백 및 중앙 정렬 */
    border-radius: 8px; /* 모서리 둥글게 */
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
    background-size: cover; /* 이미지를 영역에 맞게 채우기 */
    background-position: center; /* 이미지 중앙 정렬 */
    height: auto; /* 고정 높이 */
}
#addToCart, #directPurchase, #moveToStore {
    background-color: #00aff0;
    color: white;
    border: none;
    cursor: pointer;
    font-size: 1rem;
    padding: 0.625rem 1.25rem; /* 버튼 내부 패딩 */
    border-radius: 4px;
    transition: background-color 0.3s;
}
#addToCart:hover, #directPurchase:hover, #moveToStore:hover {
    background-color: #008fcb; /* 호버 시 약간 어두운 색상 */
}
#reviewFormWrapper {
    background-color: #00aff0; /* 전체 배경색 */
    padding: 20px;
    border-radius: 15px;
    box-sizing: border-box;
    margin-top: 20px;
    width: 75%; /* 동일한 너비 */
    margin-left: auto; /* 왼쪽 여백 자동 */
    margin-right: auto; /* 오른쪽 여백 자동 */
    display: block; /* 블록 요소로 변경하여 중앙 정렬 */
    position: relative; /* 자식 요소의 절대 위치 기준 */
}

#reviewFormWrapper h2 {
    text-align: center; /* 중앙 정렬 */
    color: white; /* 흰색 텍스트 */
    margin-bottom: 20px; /* 아래 여백 */
    font-size: 1.8rem; /* 제목 크기 조정 */
    font-weight: bold; /* 글씨 굵게 */
}

#avgReviewStars {
    position: absolute; /* 절대 위치 지정 */
    top: 25px; /* 부모의 상단에 배치 */
    left: 25px; /* 부모의 왼쪽에 배치 */
    color: #FFD700; /* 노란색 글씨 */
    padding: 5px 15px; /* 상하 여백 5px, 좌우 여백 15px */
    border-radius: 10px; /* 둥근 모서리 */
    font-size: 20px; /* 글씨 크기 키우기 */
    font-weight: bold; /* 글씨 굵게 */
    display: inline-flex; /* 텍스트 크기만큼 배경색이 적용되도록 설정 */
    align-items: center;
    background-color: rgba(0, 0, 0, 0.6); /* 배경색 */
}
#userReviews {
    width: 90%; /* 리뷰 섹션 너비 */
    margin: 20px auto; /* 중앙 정렬 및 상단 여백 */
    padding: 20px; /* 내부 여백 */
    background-color: #ffffff; /* 흰 배경 */
    border-radius: 8px; /* 둥근 모서리 */
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
}
.myChat {
   list-style-type: none; /* li marker 제거 */
    display: block; /* 내 댓글은 항상 표시 */
    width: 100%; /* 유저 리뷰 섹션의 너비를 90%로 설정 */
    margin: auto; /* 중앙 정렬 및 상단 여백 */
    border-radius: 8px; /* 둥근 모서리 */
    background-color: #e8f5e9; /* 연한 녹색 배경 */
    text-align: left; /* 텍스트 왼쪽 정렬 */
    font-size: 1rem;
     color: #141414; /* 텍스트 색상 */
    position: relative; /* 케밥 메뉴의 위치 기준 */
    padding: 10px;
}
.myChat h2 {
    font-size: 1.8rem; /* 제목 크기 */
    color: #141414; /* 제목 텍스트 색상 */
    font-weight: bold; /* 굵은 텍스트 */
    margin-bottom: 15px; /* 제목 하단 여백 */
    padding-left : 10px;
}
.myChat p {
    margin: 10px 0;
    line-height: 1.5;
    color: #141414; /* 댓글 텍스트 색상 */
}
.allChat {
   list-style-type: none; /* li marker 제거 */
    background-color: #f9f9f9; /* 연한 회색 배경 */
    padding: 15px;
    margin-bottom: 10px;
    border-radius: 8px;
    border: 1px solid #ddd; /* 연한 회색 테두리 */
    text-align: left;
    font-size: 1rem;
    color: #424242; /* 진한 회색 텍스트 */
}

/* 케밥 메뉴 버튼 */
.kebabMenu {
    position: absolute;
    top: 10px;
    right: 10px;
    cursor: pointer;
    font-size: 1.5rem;
    color: #757575; /* 기본 회색 아이콘 */
    transition: color 0.3s ease;
}

.kebabMenu:hover {
    color: #2e7d32; /* 호버 시 녹색 */
}

/* 케밥 메뉴 옵션 */
.menuOptions {
    position: absolute;
    top: 40px;
    right: 10px;
    visibility: hidden; /* 기본적으로 숨김 */
    background-color: white;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
    z-index: 10; /* 다른 요소 위에 표시 */
}

.menuOptions button {
    display: block;
    width: 100%;
    padding: 10px;
    border: none;
    background: none;
    font-size: 1rem;
    text-align: left;
    cursor: pointer;
    transition: background-color 0.3s;
}

.menuOptions button:hover {
    background-color: #f0f0f0;
}

/* 별점 스타일 */
.userRating span {
    font-size: 1.5rem;
    color: gray; /* 기본 회색 */
    margin-right: 2px;
}

.userRating span.active {
    color: gold; /* 활성화된 별점 */
}

/* 수정 및 삭제 버튼 스타일 */
.styledButton {
    background-color: #00aff0;
    color: white;
    border: none;
    border-radius: 4px;
    padding: 8px 15px;
    cursor: pointer;
    font-size: 0.9rem;
    margin-right: 5px;
    transition: background-color 0.3s;
}

.styledButton:hover {
    background-color: #007bb8;
}
/* 모달 스타일 */
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.6); /* 반투명 검정 */
}

.modal-content {
    background-color: #ffffff; /* 모달 배경 흰색 */
    color: #000000; /* 텍스트 검은색 */
    margin: 15% auto;
    padding: 20px;
    border-radius: 8px;
    width: 300px;
    text-align: center;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5); /* 그림자 효과 */
}

.modal-content p {
    font-size: 18px;
    margin-bottom: 20px;
}

.modal-content button {
    background-color: #add8e6; /* 기본 배경 */
    color: #000000; /* 텍스트 검은색 */
    padding: 10px 20px; /* 내부 여백 */
    font-size: 16px; /* 글자 크기 */
    border: none; /* 테두리 제거 */
    border-radius: 5px; /* 둥근 모서리 */
    cursor: pointer; /* 클릭 가능한 포인터 */
    transition: background-color 0.3s ease, transform 0.2s ease; /* 부드러운 효과 */
}

.modal-content button:hover {
    background-color: #cce7ff; /* 호버 색상 */
    transform: scale(1.05); /* 약간 커지는 효과 */
}

.close {
    color: #000000; /* 닫기 버튼 검은색 */
    float: right;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.close:hover,
.close:focus {
    color: #555; /* 호버 시 밝은 검은색 */
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


.myChat li, .allChat li {
    display: block; /* 블록 형태로 변경 */
    width: 100%;
    margin: auto; /* 중앙 정렬 */
    padding: 10px; /* 내부 여백 */
    border-radius: 8px; /* 둥근 모서리 */
    background-color: #f9f9f9; /* 연한 회색 배경 */
    text-align: left; /* 텍스트 왼쪽 정렬 */
    font-size: 1rem;
    color: #424242; /* 진한 회색 텍스트 */
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
    position: relative;
    margin-bottom: 15px; /* 리스트 간격 추가 */
}
.avgStarString{
   color: gold;
}
.pagination {
    display: flex;
    justify-content: center; /* 가운데 정렬 */
    margin-top: 20px; /* 위쪽 여백 추가 */
    gap: 10px; /* 버튼 간격 추가 */
}

.pagination .pageBtn {
    padding: 10px 15px; /* 버튼 크기 설정 */
    font-size: 1rem; /* 버튼 글씨 크기 */
    color: #ffffff; /* 텍스트 흰색 */
    background-color: #00aff0; /* 기본 파란색 */
    border: none; /* 테두리 제거 */
    border-radius: 4px; /* 둥근 모서리 */
    cursor: pointer; /* 마우스 포인터 */
    transition: background-color 0.3s ease; /* 배경색 전환 효과 */
}

.pagination .pageBtn:hover {
    background-color: #008fcb; /* 호버 시 어두운 파란색 */
}

.pagination .pageBtn.active {
    background-color: #007bb8; /* 활성화된 페이지의 색상 */
    font-weight: bold; /* 활성화된 버튼의 텍스트 강조 */
    cursor: default; /* 클릭 불가능 표시 */
}
.editCommentInput{
   width: 300px;
   height: 25px;
   margin-right:15px;
}
</style>
</head>
<body>
   <jsp:include page="layout/goodsHeader.jsp" />
   <sec:authorize access="isAuthenticated()">
      <sec:authentication property="principal" var="pinfo"/>
         <input type="hidden" id="userNo" value="${pinfo.member.userNo}">
         <input type="hidden" id="userId" value="${pinfo.member.userId}">
   </sec:authorize>
   <div class="goodsDetails">
   <div id="goodsBannerDiv">
      <img id="goodsBanner">
         <div id="totalLikeCount">
            <span id="goodsLike">❤️ ${goods.likeCount }회</span>
         </div>
      </div>
      <div id="goodsInfo">
         <input type="hidden" id="fileNameBanner" value="${goods.attachList[0].uuid}_${goods.attachList[0].fileName }">
         <span id="goodsName">상품명: ${goods.gname }</span>
         <span id="goodsPrice">가격: ${goods.gprice }원</span>
         <span id="goodsDes"> ${goods.gexp } </span>
         <span id="endDate">판매 종료일: ${goods.sellDate }</span>
         <div class="totalPriceContainer">
          <div class="quantityBar">
              <button id="decreaseBtn">-</button>
              <input type="text" id="quantity" value="1" readonly />
              <button id="increaseBtn">+</button>
          </div>
          <div class="totalPrice">
              총 가격: <span id="totalPrice">0원</span>
          </div>
      </div>
         <div class="actionButtons">
            <button id="addToCart">장바구니 담기</button>
            <button id="directPurchase" class="directPurchase">바로 결제</button>
            <button id="moveToStore">팝업스토어로 이동</button>
            <button id="chkLike"><img id="likeIcon" src="/resources/images/emptyHeart.png" alt="Like" width="24"></button>
         </div>
      </div>
   </div>
   <img class="goodsDetailImg">
   <input type="hidden" id="fileNameDetail" value="${goods.attachList[1].uuid}_${goods.attachList[1].fileName}">
   <div id="reviewFormWrapper">
         <div class="avgStarRating" id="avgReviewStars">
         <span class="avgStarString">평균 별점: </span>
            <span id="avgStarsContainer"> </span>
      </div>
      <h2>후기들</h2>
      <form id="reviewForm" method="post">
         <div class="starRating" id="newReviewStars">
            <span dataValue="1">★</span>
            <span dataValue="2">★</span>
            <span dataValue="3">★</span>
            <span dataValue="4">★</span>
            <span dataValue="5">★</span>
         </div>
         <p id="selectedRating">선택한 별점: 0</p>
         <textarea id="reviewText" name="reviewText" placeholder="후기를 작성해주세요..." rows="5" cols="50"></textarea>
         <input type="hidden" id="rating" name="rating" value="0">
         <input type="button" id="addReply" value="등록하기">
      </form>
      <div id="userReviews">
         <ul class="myChat">
         </ul>
         <ul class="allChat">
         
         </ul>
      </div>
      <div class="pagination"></div>
   </div>
   
   <div id="loginModal" class="modal">
      <div class="modal-content">
         <span class="close">&times;</span>
         <p>로그인이 필요한 기능입니다.</p>
         <button id="goToLogin" onclick="location.href='/member/login'">로그인하러 가기</button>
      </div>
   </div>

<div class="scroll-btn">
    <button id="scrollUp" aria-label="위로 이동"></button>
    <button id="scrollDown" aria-label="아래로 이동"></button>
</div>


   <jsp:include page="layout/goodsFooter.jsp" />
   <jsp:include page="layout/goodsNavBar.jsp" />
</body>
<script type="text/javascript" src="/resources/goodsJs/gReply.js"></script>
<script type="text/javascript" src="/resources/goodsJs/goodsDetail.js"></script>
<script type="text/javascript" src="/resources/purchaseJs/myCart.js"></script>
