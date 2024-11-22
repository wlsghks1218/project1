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
#searchBTN:hover {
    background-color: #fee7ed; 
    color : #00aff0;
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
input[type="text"], input[type="file"] {
    width: 100%; /* 전체 너비 */
    padding: 10px; /* 내부 여백 */
    border: 1px solid #ced4da; /* 테두리 */
    border-radius: 5px; /* 모서리 둥글게 */
    box-sizing: border-box; /* 패딩과 테두리 포함 */
    margin-bottom: 10px; /* 필드 간 여백 축소 */
}
input[type="date"] {
	padding: 10px; /* 내부 여백 */
    border: 1px solid #ced4da; /* 테두리 */
    border-radius: 5px; /* 모서리 둥글게 */
    box-sizing: border-box; /* 패딩과 테두리 포함 */
}
/* 이미지 업로드 버튼 스타일 */
#popUpimg {
    display: inline-block;
    padding: 10px 15px; /* 내부 여백 */
    background-color: #00aff0; /* 버튼 색상 */
    color: #fee7ed;
    border-radius: 5px; /* 모서리 둥글게 */
    cursor: pointer; /* 커서 변경 */
    text-align: center; /* 중앙 정렬 */
}
#popUpimg:hover {
    background-color: #0099cc; /* 호버 시 배경색 변경 */
}
/* 필드 섹션 스타일 */
#psLatitude, #psLongitude, #storeName, #storeCat, #startDate, #endDate, 
#address, #snsAddress, #company, #transfer, #parking, #storeExp {
	margin-bottom: 1px; /* 필드 간 여백 */
    padding: 5px;
}
/* 업로드된 이미지 섹션 */
#uploadedImages {
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
		<img id="beforeImg" width="400" height="400">
		<input type="hidden" name="beforeFileName" value="${popStore.psImg.uuid}_${popStore.psImg.fileName}">
	</div>
	<form id="psUpdateDeleteForm" method="POST" enctype="multipart/form-data">
		<input type="hidden" name="psNo" value="${popStore.psNo}">
		<div id="popUpimg" style="cursor: pointer;">팝업스토어 이미지</div>
	    <input type="file" id="imageFile" name="imageFile" style="display: none;">
	    <div id="uploadedImages"></div>
		
		<div id="storeName">팝업스토어 이름 <input type="text" name="psName" value="${popStore.psName}"></div>
		<div id="psLatitude">위도 <input type="text" name="latitude" value="${popStore.latitude}"></div>
	    <div id="psLongitude">경도 <input type="text" name="longitude" value="${popStore.longitude}"></div>
	    <div id="cats">팝업스토어 카테고리
		    <div>
		        <input type="checkbox" name="psCat.healthBeauty" value="1" 
		            <c:if test="${popStore.psCat.healthBeauty == '1'}">checked</c:if>>헬스/뷰티
		        <input type="checkbox" name="psCat.game" value="1" 
		            <c:if test="${popStore.psCat.game == '1'}">checked</c:if>>게임
		        <input type="checkbox" name="psCat.culture" value="1" 
		            <c:if test="${popStore.psCat.culture == '1'}">checked</c:if>>문화
		        <input type="checkbox" name="psCat.shopping" value="1" 
		            <c:if test="${popStore.psCat.shopping == '1'}">checked</c:if>>쇼핑
		        <input type="checkbox" name="psCat.supply" value="1" 
		            <c:if test="${popStore.psCat.supply == '1'}">checked</c:if>>문구
		        <input type="checkbox" name="psCat.kids" value="1" 
		            <c:if test="${popStore.psCat.kids == '1'}">checked</c:if>>키즈
		        <input type="checkbox" name="psCat.design" value="1" 
		            <c:if test="${popStore.psCat.design == '1'}">checked</c:if>>디자인
		        <input type="checkbox" name="psCat.foods" value="1" 
		            <c:if test="${popStore.psCat.foods == '1'}">checked</c:if>>식품
		        <input type="checkbox" name="psCat.interior" value="1" 
		            <c:if test="${popStore.psCat.interior == '1'}">checked</c:if>>인테리어
		        <input type="checkbox" name="psCat.policy" value="1" 
		            <c:if test="${popStore.psCat.policy == '1'}">checked</c:if>>정책
		        <input type="checkbox" name="psCat.character" value="1" 
		            <c:if test="${popStore.psCat.character == '1'}">checked</c:if>>캐릭터
		        <input type="checkbox" name="psCat.experience" value="1" 
		            <c:if test="${popStore.psCat.experience == '1'}">checked</c:if>>체험
		        <input type="checkbox" name="psCat.collaboration" value="1" 
		            <c:if test="${popStore.psCat.collaboration == '1'}">checked</c:if>>콜라보
		        <input type="checkbox" name="psCat.entertainment" value="1" 
		            <c:if test="${popStore.psCat.entertainment == '1'}">checked</c:if>>방송
		    </div>
		</div>
		<div id="startDate">시작일 <br><input type="date" name="psStartDate" value="${popStore.psStartDate}"></div>
		<div id="endDate">종료일 <br><input type="date" name="psEndDate" value="${popStore.psEndDate}"></div>
		<div id="address">주소 <input type="text" name="psAddress" value="${popStore.psAddress}"></div>
		<div id="snsAddress">SNS 주소 <input type="text" name="snsAd" value="${popStore.snsAd}"></div>
		<div id="company">주최사 정보 <input type="text" name="comInfo" value="${popStore.comInfo}"></div>
		<div id="transfer">교통편 <input type="text" name="transInfo" value="${popStore.transInfo}"></div>
		<div id="parking">주차장 정보 <input type="text" name="parkingInfo" value="${popStore.parkingInfo}"></div>
		<label for="psExp">설명글</label>
	    <div id="storeExp">
	    	<textarea rows="20" cols="100" name="psExp">${popStore.psExp}</textarea>
	    </div>	 
	</form>
	
	<div id="pagination"></div>

	<button type="button" id="psCancel" onclick="backtoPsList();">취소 및 리스트로 돌아가기</button>	
    <button type="button" id="psDelete" onclick="popStoreDelete()">삭제</button>
    <button type="button" id="psUpdate" onclick="popStoreUpdate();">수정완료</button>
    <button type="button" id="backToMainPage" onclick="backToMainPage();">관리자 메인 페이지</button>
	
<script type="text/javascript" src="/resources/adminJs/admin.js"></script>  
<script type="text/javascript" src="/resources/adminJs/adminPopUp.js"></script>  
</body>
</html>