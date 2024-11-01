<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="layout/adminHeader.jsp"/>
	
	<form id="deleteForm" method="POST" action="/admin/psDelete">
		<input type="hidden" name="psNo" value="${vo.psNo}">
		<div id="popUpimg" style="cursor: pointer;">팝업스토어 이미지</div>
		<input type="file" id="fileInput" name="imageFile" style="display: none;">
		<input type="hidden" name="imageUuid" value="${image.uuid}">
		<div id="uploadedImages"></div>
				
		<div id="psLatitude">위도 <input type="text" name="latitude" value="${vo.latitude}"></div>
		<div id="psLongitude">경도 <input type="text" name="longitude" value="${vo.longitude}"></div>
		
		<div id="storeName">팝업스토어 이름 <input type="text" name="psName" value="${vo.psName}"></div>
		<div id="storeCat">팝업스토어 카테고리 <input type="text" name="psCat" value="${vo.psCat}"></div> 
		<div id="startDate">시작일 <input type="text" name="psStartDate" value="${vo.psStartDate}"></div>
		<div id="endDate">종료일 <input type="text" name="psEndDate" value="${vo.psEndDate}"></div>
		<div id="address">주소 <input type="text" name="psAddress" value="${vo.psAddress}"></div>
		<div id="snsAddress">SNS 주소 <input type="text" name="snsAd" value="${vo.snsAd}"></div>
		<div id="company">주최사 정보 <input type="text" name="comInfo" value="${vo.comInfo}"></div>
		<div id="transfer">교통편 <input type="text" name="transInfo" value="${vo.transInfo}"></div>
		<div id="parking">주차장 정보 <input type="text" name="parkinginfo" value="${vo.parkinginfo}"></div>
		<div id="storeExp">설명글 <input type="text" name="psExp" value="${vo.psExp}"></div>
	</form>
	
	<div id="psCancel">취소 및 리스트로 돌아가기</div>	
	<div id="psDelete" style="cursor: pointer;">삭제</div>	
	<div id="psUpdate">수정완료</div>	
	
<script type="text/javascript" src="/resources/adminJs/admin.js"></script>  
<script type="text/javascript" src="/resources/adminJs/adminPopUp.js"></script>
</body>
</html>