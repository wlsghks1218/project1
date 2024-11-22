<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="/resources/images/favicon.ico">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 관리하기 리스트 스타일 */
#AllList {
    display: flex; /* 가로로 배치 */
    flex-direction: column; /* 세로 방향 정렬 */
    gap: 10px; /* 요소 간 간격 */
    margin: 20px 0; /* 상하 여백 */
}
#AllList a {
    display: block; /* 링크 전체를 클릭 가능하게 함 */
    background-color: #e0f7ff; 
    padding: 15px; /* 내부 여백 */
    border-radius: 5px; /* 모서리 둥글게 */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 미세한 그림자 */
    border: 1px solid rgba(0, 0, 0, 0.1); /* 은은한 테두리 */
    text-decoration: none; /* 밑줄 제거 */
    transition: background-color 0.3s; /* 배경색 변경 시 애니메이션 */
}
#AllList a:hover {
    background-color: #fee7ed; /* 호버 시 색상 변화 */
}
/* 페이지네이션 스타일 */
#pagination {
    display: flex; /* 가로로 배치 */
    justify-content: center; /* 중앙 정렬 */
    margin: 20px 0; /* 상하 여백 */
}
#pagination button,
#pagination a {
    background-color: #00aff0;
    color: #fee7ed;
    padding: 10px 15px; /* 패딩 */
    margin: 0 5px; /* 좌우 여백 */
    border: none; /* 테두리 제거 */
    border-radius: 5px; /* 모서리 둥글게 */
    cursor: pointer; /* 커서 변경 */
    text-decoration: none; /* 링크 밑줄 제거 */
    transition: background-color 0.3s; /* 배경색 변경 시 애니메이션 */
}
#pagination button:hover,
#pagination a:hover {
    background-color: #0099cc; 
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
#exhBannerImg, #exhDetailImg{
    display: inline-block;
    padding: 10px 15px; /* 내부 여백 */
    background-color: #00aff0; /* 버튼 색상 */
    color: #fee7ed;
    border-radius: 5px; /* 모서리 둥글게 */
    cursor: pointer; /* 커서 변경 */
    text-align: center; /* 중앙 정렬 */
}
#exhBannerImg:hover {
	background-color: #0099cc; /* 호버 시 배경색 변경 */
}
#exhDetailImg:hover {
	background-color: #0099cc; /* 호버 시 배경색 변경 */
}
#uploadedImages {
    margin-top: 5px; /* 상단 여백 */
    min-height: 70px; /* 최소 높이 */    
    padding: 10px; /* 내부 여백 */
}
/* 버튼 스타일 */
button {
    padding: 10px 15px; /* 내부 여백 */
    background-color: #00aff0; /* 버튼 색상 */
    color: #fee7ed; 
    border: none; /* 테두리 없음 */
    border-radius: 5px; /* 모서리 둥글게 */
    cursor: pointer; /* 커서 변경 */
}
button:hover {
    background-color: #0099cc; /* 버튼 호버 색상 */
}
#storeExp {
    flex-direction: column;
    align-items: center;
}
#storeExp textarea {
	width : 100%;
	height : 300px;
    resize: none;
    border: 1px solid #ccc;
    font-size: 14px;
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
	    <label for="exhInfo">설명글</label>
	    <div id="storeExp">
	    	<textarea rows="20" cols="100" name="exhInfo"></textarea>
	    </div>	 
	    
        <button type="button" id="exhRegisterBtn" onclick="exhRegister();">등록하기</button>
        <button type="button" id="backToMainPage" onclick="backToMainPage();">관리자 메인 페이지</button>

	</form>	
	
	<div id="pagination"></div>
	
<script type="text/javascript" src="/resources/adminJs/admin.js"></script>  
<script type="text/javascript" src="/resources/adminJs/adminExhibit.js"></script>  
</body>
</html>