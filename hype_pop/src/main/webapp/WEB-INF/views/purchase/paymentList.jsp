<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>결제 목록</title>
<style>
body {
   font-family: Arial, sans-serif;
   margin: 0;
   padding: 0;
}

.navbar {
   background-color: #007bff;
   color: white;
   padding: 10px;
}

.navbar ul {
   list-style-type: none;
   padding: 0;
}

.navbar li {
   display: inline;
   margin-right: 15px;
}

.purchase-header {
   text-align: center;
   margin: 20px 0;
}

.purchase-list {
   display: flex;
   flex-direction: column;
   align-items: center;
}

.purchase-item {
   border: 1px solid #ddd;
   padding: 10px;
   margin: 10px 0;
   display: flex;
   align-items: center;
}

.item-image {
   width: 100px;
   height: auto;
   margin-right: 15px;
}

.pagination {
   text-align: center;
   margin: 20px 0;
}

.pagination a {
   margin: 0 5px;
}

.footer {
   text-align: center;
   padding: 20px;
   background-color: #f1f1f1;
   position: relative;
   bottom: 0;
   width: 100%;
}
</style>
</head>
<body>
   <nav class="navbar">
      <ul>
         <li><a href="#">홈</a></li>
         <li><a href="#">상품 목록</a></li>
         <li><a href="#">마이페이지</a></li>
      </ul>
   </nav>

   <header class="purchase-header">
      <h2>결제 목록</h2>
   </header>

   <section class="purchase-list">
      <c:forEach var="item" items="${getPayList}">
         <div class="purchase-item">
            <c:forEach var="img" items="${item.gimg}">
               <img src="${img.uploadPath}/${img.uuid}_${img.fileName}"
                  alt="${item.gname}" class="item-image">
            </c:forEach>
            <div class="item-details">
               <h3 class="item-name">상품명: ${item.gname}</h3>
               <p class="item-quantity">수량: ${item.camount}</p>
               <p class="item-price">가격: ${item.gprice}원</p>
               <p class="item-date">구매 날짜: ${item.gbuyDate}</p>
               <p class="item-status">상품 현황: ${item.gsituation}</p>
            </div>
         </div>
      </c:forEach>
   </section>

   <div class="pagination">
      <c:if test="${currentPage > 1}">
         <a href="paymentList.jsp?page=${currentPage - 1}">이전</a>
      </c:if>
      <c:forEach begin="1" end="${totalPages}" var="i">
         <a href="paymentList.jsp?page=${i}">${i}</a>
      </c:forEach>
      <c:if test="${currentPage < totalPages}">
         <a href="paymentList.jsp?page=${currentPage + 1}">다음</a>
      </c:if>
   </div>

   <footer class="footer">
      <p>푸터 내용</p>
   </footer>
</body>
</html>
