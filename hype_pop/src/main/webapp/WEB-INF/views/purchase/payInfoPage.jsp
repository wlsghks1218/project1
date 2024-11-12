<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
.modal {
   display: none;
}

.required {
   color: red;
}

.remember-checkbox {
   
}
</style>
</head>
<body>


   <%
      //전달된 파라미터
   String totalPrice = request.getParameter("totalPrice");
   String userNo = request.getParameter("userNo");   
   %>
   <!-- 헤더 -->
   <header class="bg-light py-3">
      <div class="container">
         <h1 class="text-center">결제 정보 입력</h1>
         <a href="home.html" class="btn btn-primary">홈으로 가기</a>
      </div>
   </header>

   <div class="container my-4">
      <!-- 구매자 정보 테이블 -->
      <div class="float-right">
         <input type="checkbox" id="rememberAddress"> <label
            for="rememberAddress">이 배송지 기억</label>
      </div>
      <table class="table table-bordered">
         <thead>
            <tr>
               <th>구매자 정보</th>
               <th style="padding-right: 50px;">상세 입력</th>
            </tr>
         </thead>
         <tbody>
            <tr>
               <td>이름</td>
               <td><input type="text" class="form-control" id="userName"
                  value="${getPayInfo.userName}" readonly></td>
            </tr>
            <tr>
               <td>이메일</td>
               <td><input type="email" class="form-control" id="userEmail"
                  value="${getPayInfo.userEmail}" readonly></td>
            </tr>
            <tr>
               <td>전화번호</td>
               <td><input type="tel" class="form-control" id="userNumber"
                  value="${getPayInfo.userNumber}" readonly></td>
            </tr>
            <tr>
               <td>배송지 주소</td>
               <td><input type="text" id="sample6_postcode"
                  placeholder="우편번호"> <input type="button"
                  onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
                  <input type="text" id="sample6_address" placeholder="주소"><br>
                  <input type="text" id="sample6_detailAddress" placeholder="상세주소">
                  <input type="hidden" id="sample6_extraAddress" placeholder="참고항목">
                  <!--    <td>배송지 주소</td>
               <td>
                  <div class="input-group mb-2">
                     <input type="text" class="form-control" id="sample6_postcode"
                        placeholder="우편번호">
                     <div class="input-group-append">
                        <input type="button" class="btn btn-outline-secondary"
                           onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
                     </div>
                  </div> <input type="text" class="form-control mb-2" id="sample6_address"
                  placeholder="주소"> <input type="text" class="form-control"
                  id="sample6_detailAddress" placeholder="상세주소">
               </td>--></td>
            </tr>
            <tr>
               <td>배송 요청 사항</td>
               <td><select class="form-control" id="deliveryRequest">
                     <option value="">선택하세요</option>
                     <option value="부재 시 경비실에 맡겨주세요">부재 시 경비실에 맡겨주세요</option>
                     <option value="직접 전달해 주세요">직접 전달해 주세요</option>
                     <option value="배송 전에 연락 주세요">배송 전에 연락 주세요</option>
                     <option value="문 앞에 놔주세요">문 앞에 놔주세요</option>
                     <option value="직접 입력">직접 입력</option>
               </select></td>
            </tr>
         </tbody>
      </table>

      <!-- 결제 정보 테이블 -->
      <table class="table table-bordered">
         <thead>
            <tr>
               <th>결제 정보</th>
               <th>상세 입력</th>
            </tr>
         </thead>
         <tbody>
            <tr>
               <td>가격</td>
               <td><input type="text" class="form-control" id="priceInput"
                  value="<%= totalPrice %>" readonly></td>

            </tr>
            <tr>
               <td>배송비</td>
               <td><input type="text" class="form-control" value="무료"
                  readonly></td>
            </tr>
            <tr>
               <td>총 결제 금액</td>
               <td><input type="text" class="form-control" id="totalPrice"
                  value="<%=totalPrice%> " readonly></td>
            </tr>
            <tr>
               <td>결제 수단</td>
               <td>
                  <div>
                     <input type="checkbox" id="bankTransfer"> <label
                        for="bankTransfer">실시간 계좌이체</label> <select id="bankSelect"
                        class="form-control" style="display: none;">
                        <option value="">선택</option>
                        <option value="우리은행">우리은행 (123-1234123-1-123 예금주:hypePop)</option>
                        <option value="신한은행">신한은행 (110-112-123456  예금주:hypePop</option>
                        <option value="국민은행">국민은행 (1234567-112-123456 예금주:hypePop)</option>
                     </select> <span class="required"></span>
                  </div>
      
                  <div><button class="btn btn-success" id="toss">토스페이&신용/체크카드</button></div><br>
                  <button class="btn btn-success" id="kakaopay">카카오페이</button>
               </td>
            </tr>
         </tbody>
      </table>


      <!-- 결제하기 버튼 -->
      <button class="btn btn-success" id="paymentButton">결제하기</button>

   
   </div>


   <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
   <script
      src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
   <script
      src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
   <script type="text/javascript" src="/resources/purchaseJs/payInfo.js"></script>
   <script
      src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
   <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>-->
   <script type="text/javascript" src="/resources/purchaseJs/main.js"></script>
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
   <!-- 아임포트 JS SDK 추가 -->
</body>
</html>