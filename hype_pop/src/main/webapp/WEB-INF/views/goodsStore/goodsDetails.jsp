<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
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
}

h1, h2, p, span {
   color: #fff;
}

/* 굿즈 상세 섹션 */
.goodsDetails {
   width: 80%;
   margin: 30px auto;
   display: flex;
   flex-direction: row;
   border-radius: 10px;
   background-color: #222;
   box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
   overflow: hidden;
}

#goodsBanner, #goodsInfo {
   width: 50%;
   padding: 20px;
   box-sizing: border-box;
}

#goodsBanner {
   background-color: #333;
   text-align: center;
   display: flex;
   justify-content: center;
   align-items: center;
}

#goodsBanner img {
   max-width: 100%;
   height: auto;
   border-radius: 10px;
}

#goodsInfo {
   background-color: #181818;
   padding: 20px;
}

#goodsInfo span {
   display: block;
   margin-bottom: 15px;
   font-size: 18px;
}

.quantityBar {
   display: flex;
   align-items: center;
   margin: 20px 0;
}

.quantityBar button {
   width: 40px;
   height: 40px;
   background-color: #444;
   color: #fff;
   border: none;
   font-size: 20px;
   cursor: pointer;
   transition: background-color 0.3s;
}

.quantityBar button:hover {
   background-color: #888;
}

#quantity {
   width: 60px;
   text-align: center;
   border: 1px solid #333;
   font-size: 18px;
   background-color: #222;
   color: #fff;
   margin: 0 10px;
}

.totalPrice {
   font-size: 22px;
   font-weight: bold;
   color: #e50914;
}

.actionButtons {
   display: flex;
   gap: 15px;
}

.actionButtons button {
   padding: 15px 20px;
   background-color: #e50914;
   color: white;
   border: none;
   font-size: 18px;
   cursor: pointer;
   transition: background-color 0.3s;
}

.actionButtons button:hover {
   background-color: #c3070a;
}

.actionButtons button.directPurchase {
   background-color: #f44336;
}

/* 굿즈 상세 이미지 */
.goodsDetailImg {
    width: 80%;
    margin: 30px auto;
    text-align: center;
    background-color: #222;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
    height: 600px;
    position: relative;
}

/* 별점 및 후기 스타일 */
.starRating span {
   font-size: 30px;
   cursor: pointer;
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

/* 케밥 메뉴 */
.kebabMenu {
   position: absolute;
   top: 15px;
   right: 10px;
   cursor: pointer;
}

.menuOptions {
   visibility: hidden;
   position: absolute;
   right: 0;
   top: 30px;
   background: white;
   box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.5);
   padding: 10px;
   border-radius: 8px;
   z-index: 1000;
   color: black;
}

.menuOptions button {
   display: block;
   width: 100%;
   padding: 10px;
   margin-bottom: 5px;
   cursor: pointer;
   background-color: #e50914;
   color: white;
   border: none;
   border-radius: 5px;
   text-align: center;
}

#chkLike {
   background-color: white;
}

.menuOptions button:hover {
   background-color: #c3070a;
}

.menuOptions .deleteBtn {
   background-color: #f44336;
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

.starRating {
   display: flex;
   justify-content: center;
   margin-bottom: 10px;
}

.starRating span {
   font-size: 30px;
   cursor: pointer;
   color: gold;
}

#selectedRating {
   margin-bottom: 15px;
   text-align: center;
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
.styledButton {
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
    border: none;
    border-radius: 5px;
    margin-right: 10px;
    transition: background-color 0.3s;
}

.saveEditBtn {
    background-color: #e50914;
    color: white;
}

.saveEditBtn:hover {
    background-color: #c3070a;
}

.cancelEditBtn {
    background-color: #444;
    color: white;
}

.cancelEditBtn:hover {
    background-color: #888;
}

.pagination {
    text-align: center;
    margin-top: 20px;
}
.pagination button {
    background-color: #e50914;
    color: white;
    border: none;
    padding: 10px 20px;
    margin: 0 5px;
    font-size: 16px;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s;
}

.pagination button.active {
    background-color: #c3070a;
    font-weight: bold;
}

.pagination button:hover {
    background-color: #f44336;
}
</style>
</head>
<body>
   <jsp:include page="layout/popUpHeader.jsp" />
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
   <jsp:include page="layout/popUpFooter.jsp" />
   <jsp:include page="layout/goodsNavBar.jsp" />
</body>
<script type="text/javascript" src="/resources/goodsJs/gReply.js"></script>
<script type="text/javascript" src="/resources/goodsJs/goodsDetail.js"></script>
<script type="text/javascript" src="/resources/goodsJs/goodsHeader.js"></script>
<script type="text/javascript" src="/resources/goodsJs/goodsNav.js"></script>
<!--추가(윤) -->
<script type="text/javascript" src="/resources/purchaseJs/myCart.js"></script>
<script>
    var goodsPrice = ${goods.gprice};
    console.log(goodsPrice);
</script>
</html>