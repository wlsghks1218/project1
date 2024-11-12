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
        
	<form id="exhRegisterForm" method="POST" action="/admin/eRegister" enctype="multipart/form-data">
	    <div id="exhBannerImg" style="cursor: pointer;">전시회 배너 이미지</div>
        <input type="file" id="exhBannerImageFile" name="imageExhFiles[0]" style="display: none;">
        <div id="uploadedExBannerImages"></div>
        
	    <div id="exhDetailImg" style="cursor: pointer;">전시회 상세 이미지</div>
        <input type="file" id="exhDetailImageFile" name="imageExhFiles[1]" style="display: none;">
        <div id="uploadedExDetailImages"></div>
	    
	    <div id="exhName">이름 <input type="text" name="exhName"></div>
	    <div id="exhAddress">주소 <input type="text" name="exhLocation"></div>
	    <div id="exhStartDate">시작일 <br><input type="date" name="exhStartDate"></div>
	    <div id="exhEndDate">종료일 <br><input type="date" name="exhEndDate"></div>
	    <div id="exhWatchTime">러닝타임 <input type="number" name="exhWatchTime"></div>
	    <div id="exhWatchAge">연령가 <input type="text" name="exhWatchAge"></div>
	    <div id="ePrice">가격 <input type="number" name="exhPrice"></div>
	    
	    <div id="exhExp">설명글 <input type="text" name="exhInfo"></div>
	    
        <button type="button" id="exhRegisterBtn" onclick="exhRegister();">등록하기</button>
	</form>	
	
	<div id="pagination"></div>
	
<script type="text/javascript" src="/resources/adminJs/admin.js"></script>  
<script type="text/javascript" src="/resources/adminJs/adminExhibit.js"></script>  
</body>
</html>