<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <style>
        /* 기본적인 스타일 정의 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }
        .navbar {
            background-color: #333;
            color: white;
            padding: 10px;
            text-align: center;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
        }
        .header, .footer {
            text-align: center;
            padding: 10px;
        }
        .cart-list {
            max-height: 400px;  /* 장바구니 항목의 최대 높이 설정 */
            overflow-y: scroll; /* 세로 스크롤 활성화 */
            border: 1px solid #ddd; /* 경계선 추가 */
            margin-bottom: 20px; /* 항목과 총 가격 사이 간격 */
        }
        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid #ddd;
        }
        .cart-item img {
            width: 80px;
            height: 80px;
            object-fit: cover;
        }
        .cart-info {
            flex: 1;
            padding-left: 20px;
        }
        .cart-total, .checkout-button {
            text-align: right;
            padding: 20px;
        }
        .checkout-button button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        .checkout-button button:hover {
            background-color: #45a049;
        }
        .delete-button {
            color: red;
            cursor: pointer;
        }
        
        /* 스크롤바 스타일 설정 */
.cart-list::-webkit-scrollbar {
    height: 1px; /* 스크롤바 너비 */
    
}

.cart-list::-webkit-scrollbar-thumb {
    background-color: #888; /* 스크롤바의 색상 */
}

.cart-list::-webkit-scrollbar-thumb:hover {
    background-color: #555; /* 스크롤바가 호버될 때의 색상 */
}
        
        
    </style>
</head>
<body>

<!-- 내비게이션 바 -->
<div class="navbar">
    <h1>내비게이션 바</h1>
</div>

<!-- 장바구니 헤더 -->
<div class="container">
    <div class="header">
        <h2>장바구니</h2>
    </div>

  <!-- 장바구니 목록을 감싸는 div -->
<div class="cart-list">
    <input type="hidden" value="2" name="userNo" id="userNo"> 
    <!-- 장바구니 목록 -->
    <c:forEach var="cart" items="${cartInfo}">
        <div class="cart-item">
            <c:forEach var="img" items="${cart.gimg}">
                <img src="${img.uploadPath}/${img.uuid}_${img.fileName}" alt="${cart.gname}" width="100" height="100" />
            </c:forEach>
            <div class="cart-info">
                <h4>굿즈 이름 : ${cart.gname}</h4>
                <p>가격: ₩<span>${cart.gprice}</span></p>
                <p>개수: <input type="number" value="${cart.camount}" min="1"></p>
                <p>총 가격: ₩<span>${cart.camount * cart.gprice}</span></p>
            </div>
            <span class="delete-button" onclick="confirm('삭제 하시겠습니까?') ? alert('삭제되었습니다.') : '';">X</span>
        </div>
    </c:forEach>
</div>

    </div>

    <!-- 총 가격 표시 -->
    <div class="cart-total">
        <h3>총 가격: ₩<span>${cartInfo.camount} * ${cartInfo.gprice}</span></h3>
    </div>

    <!-- 결제하기 버튼 -->
    <div class="checkout-button">
        <button onclick="alert('결제 페이지로 이동합니다.')">결제하기</button>
    </div>
</div>

<!-- Footer -->
<div class="footer">
    <h1>footer</h1>    
</div>

</body>
</html>
