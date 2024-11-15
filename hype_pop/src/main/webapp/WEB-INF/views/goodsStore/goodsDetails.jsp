<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix = "sec" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>굿즈 스토어 상세 페이지</title>
<style>
/* 기본 설정 */
body {
   font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
   background-color: #141414;
   color: #fff;
   margin: 0;
   padding: 0;
   overflow-x: hidden;
   font-size: 16px;
}

h1, h2, p, span {
   color: #fff;
   font-size: 1rem;
}

/* 굿즈 상세 섹션 */
.goodsDetails {
   display: flex;
   flex-wrap: wrap;
   width: 90%;
   max-width: 75rem; /* 동일한 최대 너비 */
   margin: 3vh auto;
   border-radius: 0.625rem;
   background-color: #222;
   box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.5);
   overflow: hidden;
}

#goodsBanner {
   width: 50%;
   min-width: 18.75rem;
   background-color: #333;
   display: flex;
   justify-content: center;
   align-items: center;
   box-sizing: border-box;
   padding: 2rem;
   background-size: cover;
   background-position: center;
   background-repeat: no-repeat;
   border-radius: 0.625rem;
}

#goodsInfo {
   width: 50%;
   min-width: 18.75rem;
   background-color: #181818;
   box-sizing: border-box;
   padding: 2rem;
}

#goodsInfo span {
   display: block;
   font-size: 1.125rem;
   margin-bottom: 0.9375rem;
   word-wrap: break-word;
}

/* 굿즈 상세 이미지 */
.goodsDetailImg {
   width: 90%;
   max-width: 75rem; /* 동일한 최대 너비 */
   margin: 3vh auto;
   background-color: #222;
   border-radius: 0.625rem;
   box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.5);
   background-size: contain;
   background-position: center center;
   background-repeat: no-repeat;
   height: auto;
   min-height: 18.75rem;
}

/* 버튼 및 액션 스타일 */
.quantityBar {
   display: flex;
   align-items: center;
   margin: 2vh 0;
}

.quantityBar button {
   width: 2.5rem;
   height: 2.5rem;
   background-color: #444;
   color: #fff;
   border: none;
   font-size: 1.25rem;
   cursor: pointer;
   transition: background-color 0.3s;
}

.quantityBar button:hover {
   background-color: #888;
}

#quantity {
   width: 3rem;
   font-size: 1.125rem;
   text-align: center;
   border: 1px solid #333;
   background-color: #222;
   color: #fff;
   margin: 0 0.625rem;
}

.totalPrice {
   font-size: 1.375rem;
   font-weight: bold;
   color: #e50914;
   margin-top: 2vh;
}

.actionButtons {
   display: flex;
   flex-wrap: wrap;
   gap: 1rem;
}

.actionButtons button {
   padding: 0.625rem;
   flex: 1 1 auto;
   background-color: #e50914;
   color: white;
   border: none;
   font-size: 1rem;
   cursor: pointer;
   transition: background-color 0.3s;
   min-width: 7.5rem;
}

.actionButtons button:hover {
   background-color: #c3070a;
}

.actionButtons button.directPurchase {
   background-color: #f44336;
}

.actionButtons #chkLike {
   padding: 0;
   width: 2.5rem;
   height: 2.5rem;
   display: flex;
   justify-content: center;
   align-items: center;
}

/* 리뷰 폼 및 별점 스타일 */
#reviewForm {
   width: 90%;
   max-width: 75rem; /* 동일한 최대 너비 */
   margin: 3vh auto;
   display: flex;
   flex-direction: column;
   align-items: center;
   justify-content: center;
   background-color: #222;
   padding: 2rem;
   border-radius: 0.625rem;
   box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.5);
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
   background-color: #e50914;
   color: #fff;
   border: none;
   padding: 0.625rem 1.25rem;
   font-size: 1rem;
   cursor: pointer;
   border-radius: 0.3125rem;
   transition: background-color 0.3s;
}

#addReply:hover {
   background-color: #c3070a;
}

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

#selectedRating {
   margin-bottom: 0.9375rem;
   text-align: center;
}

.avgStarRating {
   width: 90%;
   max-width: 75rem; /* 동일한 최대 너비 */
   margin: 3vh auto;
   display: flex;
   align-items: center;
   justify-content: space-between;
}

/* 후기 스타일 */
#userReviews {
   width: 90%;
   max-width: 75rem; /* 동일한 최대 너비 */
   margin: 3vh auto;
   padding: 2rem;
   background-color: #222;
   border-radius: 0.625rem;
   box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.5);
}

#userReviews h2 {
   font-size: 1.75rem;
   font-weight: 600;
   margin-bottom: 2vh;
   text-align: left;
   padding-bottom: 0.625rem;
   border-bottom: 0.125rem solid #e50914;
}

.myChat, .allChat {
   list-style-type: none;
   padding: 0;
   color: #fff;
}

.myChat li, .allChat li {
   background-color: #333;
   padding: 1rem;
   margin-bottom: 0.625rem;
   border-radius: 0.5rem;
   box-shadow: 0 0.125rem 0.3125rem rgba(0, 0, 0, 0.3);
   width: calc(100% - 2rem);
   margin: 0 auto 0.625rem;
}

/* 케밥 메뉴 */
.kebabMenu {
   position: absolute;
   top: 0.9375rem;
   right: 0.625rem;
   cursor: pointer;
}

.menuOptions {
   visibility: hidden;
   position: absolute;
   right: 0;
   top: 1.875rem;
   background: white;
   box-shadow: 0px 0.25rem 0.5rem rgba(0, 0, 0, 0.5);
   padding: 0.625rem;
   border-radius: 0.5rem;
   z-index: 1000;
   color: black;
}

.menuOptions button {
   display: block;
   width: 100%;
   padding: 0.625rem;
   margin-bottom: 0.3125rem;
   cursor: pointer;
   background-color: #e50914;
   color: white;
   border: none;
   border-radius: 0.3125rem;
   text-align: center;
}

.menuOptions button:hover {
   background-color: #c3070a;
}

.menuOptions .deleteBtn {
   background-color: #f44336;
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
   background-color: rgba(0, 0, 0, 0.6);
}

.modal-content {
   background-color: #222;
   color: white;
   margin: 15% auto;
   padding: 1.25rem;
   border-radius: 0.5rem;
   width: 80%;
   max-width: 18.75rem;
   text-align: center;
   box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.5);
}

.modal-content p {
   font-size: 1.125rem;
   margin-bottom: 2vh;
}

.modal-content button {
   padding: 0.625rem 1.25rem;
   background-color: #e50914;
   color: white;
   border: none;
   cursor: pointer;
   font-size: 1rem;
   border-radius: 0.3125rem;
   transition: background-color 0.3s;
}

.modal-content button:hover {
   background-color: #c3070a;
}

.close {
   color: #aaa;
   float: right;
   font-size: 1.75rem;
   font-weight: bold;
   cursor: pointer;
}

.close:hover,
.close:focus {
   color: #fff;
}

/* 스크롤 버튼 */
.scroll-btn {
   position: fixed;
   bottom: 10vh;
   right: 2vw;
   display: flex;
   flex-direction: row;
   gap: 0.625rem;
   z-index: 20;
}

.scroll-btn button {
   background-color: #e50914;
   color: white;
   padding: 1rem;
   border: none;
   border-radius: 50%;
   font-size: 1.25rem;
   cursor: pointer;
   transition: background-color 0.3s;
}

button:disabled {
   cursor: not-allowed;
   opacity: 0.5;
}
</style>
</head>
<body>
   <jsp:include page="layout/popUpHeader.jsp" />
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="pinfo"/>
   		<input type="hidden" id="userNo" value="${pinfo.member.userNo}">
   		<input type="hidden" id="userId" value="${pinfo.member.userId}">
	</sec:authorize>
   <div class="goodsDetails">
      <div id="goodsBanner"></div>
      <div id="goodsInfo">
         <input type="hidden" id="fileNameBanner" value="${goods.attachList[0].uuid}_${goods.attachList[0].fileName }">
         <span id="goodsLike">좋아요: ${goods.likeCount }회</span>
         <span id="goodsName">상품명: ${goods.gname }</span>
         <span id="goodsPrice">가격: ${goods.gprice }</span>
         <span id="goodsDes"> ${goods.gexp } </span>
         <span id="endDate">판매 종료일: ${goods.sellDate }</span>
         <div class="quantityBar">
            <button id="decreaseBtn">-</button>
            <input type="text" id="quantity" value="1" readonly />
            <button id="increaseBtn">+</button>
         </div>
         <div class="totalPrice">
            총 가격: <span id="totalPrice"></span>
         </div>
         <div class="actionButtons">
            <button id="addToCart">장바구니 담기</button>
            <button id="directPurchase" class="directPurchase">바로 결제</button>
            <button id="moveToStore">팝업스토어로 이동</button>
            <button id="chkLike"><img id="likeIcon" src="/resources/images/emptyHeart.png" alt="Like" width="24"></button>
         </div>
      </div>
   </div>
   <div class="goodsDetailImg">
   <input type="hidden" id="fileNameDetail" value="${goods.attachList[1].uuid}_${goods.attachList[1].fileName}">
   </div>
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
   <div class="avgStarRating" id="avgReviewStars">
      <span class="avgStarString">평균 별점:</span>
      <div id="avgStarsContainer"></div>
   </div>
   <div id="userReviews">
      <h2>후기들</h2>
      <ul class="myChat">
      </ul>
      <ul class="allChat">
      
      </ul>
   </div>
   <div class="pagination"></div>
   
	<div id="loginModal" class="modal">
	   <div class="modal-content">
	      <span class="close">&times;</span>
	      <p>로그인이 필요한 기능입니다.</p>
	      <button id="goToLogin" onclick="location.href='/member/login'">로그인하러 가기</button>
	   </div>
	</div>
	<div class="scroll-btn">
    <button id="scrollUp">위로</button>
    <button id="scrollDown">아래로</button>
</div>
   <jsp:include page="layout/popUpFooter.jsp" />
   <jsp:include page="layout/goodsNavBar.jsp" />
</body>
<script type="text/javascript" src="/resources/goodsJs/gReply.js"></script>
<script type="text/javascript" src="/resources/goodsJs/goodsDetail.js"></script>
<script type="text/javascript" src="/resources/goodsJs/goodsHeader.js"></script>
<script type="text/javascript" src="/resources/goodsJs/goodsNav.js"></script>
<script type="text/javascript" src="/resources/purchaseJs/myCart.js"></script>
