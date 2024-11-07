<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
    font-family: Arial, sans-serif; /* 기본 글꼴 */
    background-color: #f8f9fa; /* 배경색 */
    margin: 0; /* 기본 마진 제거 */
    padding: 20px; /* 내부 여백 */
}

#AllList {
    margin-bottom: 20px; /* 하단 여백 */
}

form {
    background-color: white; /* 폼 배경색 */
    padding: 20px; /* 폼 내부 여백 */
    border-radius: 5px; /* 모서리 둥글게 */
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    margin-bottom: 20px; /* 하단 여백 */
}

div {
    margin-bottom: 15px; /* 각 요소 간 여백 */
}

input[type="text"] {
    width: 100%; /* 전체 너비 */
    padding: 10px; /* 내부 여백 */
    border: 1px solid #ced4da; /* 테두리 */
    border-radius: 5px; /* 모서리 둥글게 */
    box-sizing: border-box; /* 패딩과 테두리 포함 */
}

select {
    width: 100%; /* 너비를 50%로 조정 */
    padding: 10px; /* 내부 여백 */
    margin-bottom : 30px;
    border: 1px solid #ced4da; /* 테두리 */
    border-radius: 5px; /* 모서리 둥글게 */
    box-sizing: border-box; /* 패딩과 테두리 포함 */
}


input[type="date"] {
	padding: 10px; /* 내부 여백 */
    border: 1px solid #ced4da; /* 테두리 */
    border-radius: 5px; /* 모서리 둥글게 */
    box-sizing: border-box; /* 패딩과 테두리 포함 */
}

#gImg {
    display: inline-block;
    padding: 10px 15px; /* 내부 여백 */
    background-color: #007bff; /* 버튼 색상 */
    color: white; /* 글자색 흰색 */
    border-radius: 5px; /* 모서리 둥글게 */
    cursor: pointer; /* 커서 변경 */
    text-align: center; /* 중앙 정렬 */
}

#uploadedImages {
    margin-top: 5px; /* 상단 여백 */
    min-height: 70px; /* 최소 높이 */    
    padding: 10px; /* 내부 여백 */
}

button {
    padding: 10px 15px; /* 내부 여백 */
    background-color: #dc3545; /* 버튼 색상 */
    color: white; /* 글자색 흰색 */
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 모서리 둥글게 */
    cursor: pointer; /* 커서 변경 */
}

button:hover {
    background-color: #c82333; /* 버튼 호버 색상 */
}

#pagination {
    text-align: center; /* 중앙 정렬 */
    margin-top: 20px; /* 상단 여백 */
}
</style>
</head>
<body>
	<jsp:include page="layout/adminHeader.jsp"/>
	
	<div id="AllList"></div>
	
	<select id="storeList">
        <option value="전체">전체</option>
	    <c:forEach var="store" items="${popStores}">
	        <option value="${store.psName}" data-psno="${store.psNo}">${store.psName}</option>
	    </c:forEach>
    </select>
        
	<form id="gRegisterForm" method="POST" action="/admin/gRegister" enctype="multipart/form-data">
	    <div id="gImg" style="cursor: pointer;">굿즈 이미지</div>
	    <input type="file" id="gImageFile" name="imageFiles" multiple style="display: none;">
	    <div id="uploadedGImages"></div>
	    
	    
	    <div id="pName">팝업스토어 이름 <input type="hidden" name="psno" ></div>
	    <div id="gName">상품 이름 <input type="text" name="gname"></div>
	    <div id="gPrice">상품 가격 <input type="text" name="gprice"></div>
	    
	    <div id="gEndDate">상품 판매 종료일 <br>
	    	<input type="date" name="sellDate">
	    </div>
	    <div id="storeExp">설명글 <input type="text" name="gexp"></div>
	    
        <button type="button" id="gRegisterBtn" onclick="goodsRegister();">등록하기</button>
	</form>	
	
	<div id="pagination"></div>
	
<script type="text/javascript" src="/resources/adminJs/admin.js"></script>  
<script type="text/javascript" src="/resources/adminJs/adminGoods.js"></script>  
</body>
</html>