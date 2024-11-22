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
/* 폼과 입력 필드 스타일 */
form {
    background-color: white; /* 폼 배경색 */
    padding: 20px; /* 폼 내부 여백 */
    border-radius: 5px; /* 모서리 둥글게 */
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    margin-bottom: 20px; /* 하단 여백 */
}
/* 입력 박스 스타일 */
input[type="text"] {
    width: 100%; /* 전체 너비 */
    padding: 10px; /* 내부 여백 */
    border: 1px solid #ced4da; /* 테두리 */
    border-radius: 5px; /* 모서리 둥글게 */
    box-sizing: border-box; /* 패딩과 테두리 포함 */
}
input[type="text"], input[type="date"], input[type="file"] {
    width: 100%; /* 전체 너비 */
    padding: 10px; /* 내부 여백 */
    border: 1px solid #ced4da; /* 테두리 */
    border-radius: 5px; /* 모서리 둥글게 */
    box-sizing: border-box; /* 패딩과 테두리 포함 */
    margin-bottom: 10px; /* 필드 간 여백 축소 */
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
/* 필드 섹션 스타일 */
#exhName, #address, #startDate, #endDate, 
#watchTime, #watchAge, #price, #exhExp {
    padding: 2px;
}
/* 업로드된 이미지 섹션 */
#uploadedBannerImages {
	margin-top : 15px;
    margin-bottom: 15px;
    display: flex;
    flex-wrap: wrap;
}
#uploadedDetailImages {
	margin-top : 15px;
    margin-bottom: 15px;
    display: flex;
    flex-wrap: wrap;
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
	
	<div>
		<img id="beforeImg1" width="400" height="500" alt="배너이미지"><br>
		<img id="beforeImg2" width="600" height="3000" alt="상세이미지">
		<input type="hidden" name="beforeFileName1" value="${exh.attachExhList[0].uuid}_${exh.attachExhList[0].fileName}">
		<input type="hidden" name="beforeFileName2" value="${exh.attachExhList[1].uuid}_${exh.attachExhList[1].fileName}">
	</div>
	
	<form id="exhForm" method="POST" enctype="multipart/form-data">
		<input type="hidden" name="exhNo" value="${exh.exhNo}">
	    <div id="exhBannerImg" style="cursor: pointer;">전시회 배너 이미지</div>
        <input type="file" id="exhBannerImageFile" name="imageFiles[0]" style="display: none;">
        <div id="uploadedBannerImages"></div>
        <br>
	    <div id="exhDetailImg" style="cursor: pointer;">전시회 상세 이미지</div>
        <input type="file" id="exhDetailImageFile" name="imageFiles[1]" style="display: none;">
        <div id="uploadedDetailImages"></div>
		<br>
		<div id="exhTtitle">전시회 이름 <input type="text" name="exhName" value="${exh.exhName}"></div>
		<div id="address">주소 <input type="text" name="exhLocation" value="${exh.exhLocation}"></div>
		<div id="startDate">시작일 <input type="date" name="exhStartDate" value="${exh.exhStartDate}"></div>
		<div id="endDate">종료일 <input type="date" name="exhEndDate" value="${exh.exhEndDate}"></div>
		<div id="watchTime">러닝타임 <input type="text" name="exhWatchTime" value="${exh.exhWatchTime}"></div>
		<div id="watchAge">연령가 <input type="text" name="exhWatchAge" value="${exh.exhWatchAge}"></div>
		<div id="price">가격 <input type="text" name="exhPrice" value="${exh.exhPrice}"></div>
		<label for="exhInfo">설명글</label>
	    <div id="storeExp">
	    	<textarea rows="20" cols="100" name="exhInfo">${exh.exhInfo}</textarea>
	    </div>	 
	</form>

	<button type="button" id="exhCancel" onclick="backtoExhList();">취소 및 리스트로 돌아가기</button>	
    <button type="button" id="exhDelete" onclick="exhDelete();">삭제</button>
    <button type="button" id="exhUpdate" onclick="exhUpdate();">수정완료</button>
    <button type="button" id="backToMainPage" onclick="backToMainPage();">관리자 메인 페이지</button>

    
    <div id="pagination"></div>
	
<script type="text/javascript" src="/resources/adminJs/admin.js"></script>  
<script type="text/javascript" src="/resources/adminJs/adminExhibit.js"></script>  
</body>
</html>