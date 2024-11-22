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
/* 폼 스타일 */
form {
    background-color: white;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
}
/* 입력 필드 스타일 */
input[type="text"], input[type="file"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ced4da;
    border-radius: 5px;
    box-sizing: border-box;
    margin-bottom: 10px;
}
/* 이미지 업로드 버튼 스타일 */
#gBannerImg, #gDetailImg {
    display: inline-block;
    padding: 10px 15px; /* 내부 여백 */
    background-color: #00aff0; /* 버튼 색상 */
    color: #fee7ed;
    border-radius: 5px; /* 모서리 둥글게 */
    cursor: pointer; /* 커서 변경 */
    text-align: center; /* 중앙 정렬 */
}
#gBannerImg:hover {
	background-color: #0099cc; /* 호버 시 배경색 변경 */
}
#gDetailImg:hover {
	background-color: #0099cc; /* 호버 시 배경색 변경 */
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
/* 필드 섹션 스타일 */
#gName, #gPrice, #gEndDate, #storeExp {
    margin-bottom: 1px;
    padding: 5px;
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
#beforeList{
	border : 1px solid pink;
	width : 2000px;
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
	
	<div id="beforeList">
		<img id="beforeImg1" width="400" height="400" alt="배너이미지"><br>
		<img id="beforeImg2" width="400" height="700" alt="상세이미지">
		<input type="hidden" name="beforeFileName1" value="${goods.attachList[0].uuid}_${goods.attachList[0].fileName}">
		<input type="hidden" name="beforeFileName2" value="${goods.attachList[1].uuid}_${goods.attachList[1].fileName}">
	</div>
	<form id="goodsForm" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="gno" value="${goods.gno}">
		<input type="hidden" name="imageUuid" value="${image.uuid}">
		
        <div id="gBannerImg" style="cursor: pointer;">상품 배너 이미지</div>
        <input type="file" id="gBannerImageFile" name="imageFiles[0]" style="display: none;">
        <div id="uploadedBannerImages"></div>
        <br>
	    <div id="gDetailImg" style="cursor: pointer;">상품 상세 이미지</div>
        <input type="file" id="gDetailImageFile" name="imageFiles[1]" style="display: none;">
        <div id="uploadedDetailImages"></div>
        
        <div id="gName">상품 이름 <input type="text" name="gname" value="${goods.gname}"></div>
        <div id="cats">상품 카테고리
		    <div>
		        <input type="checkbox" name="gcat.healthBeauty" value="1"
				    <c:if test="${goods.gcat.healthBeauty == '1'}"> checked</c:if>>헬스/뷰티
				<input type="checkbox" name="gcat.game" value="1"
				    <c:if test="${goods.gcat.game == '1'}"> checked</c:if>>게임
				<input type="checkbox" name="gcat.culture" value="1"
				    <c:if test="${goods.gcat.culture == '1'}"> checked</c:if>>문화
				<input type="checkbox" name="gcat.shopping" value="1"
				    <c:if test="${goods.gcat.shopping == '1'}"> checked</c:if>>쇼핑
				<input type="checkbox" name="gcat.supply" value="1"
				    <c:if test="${goods.gcat.supply == '1'}"> checked</c:if>>문구
				<input type="checkbox" name="gcat.kids" value="1"
				    <c:if test="${goods.gcat.kids == '1'}"> checked</c:if>>키즈
				<input type="checkbox" name="gcat.design" value="1"
				    <c:if test="${goods.gcat.design == '1'}"> checked</c:if>>디자인
				<input type="checkbox" name="gcat.foods" value="1"
				    <c:if test="${goods.gcat.foods == '1'}"> checked</c:if>>식품
				<input type="checkbox" name="gcat.interior" value="1"
				    <c:if test="${goods.gcat.interior == '1'}"> checked</c:if>>인테리어
				<input type="checkbox" name="gcat.policy" value="1"
				    <c:if test="${goods.gcat.policy == '1'}"> checked</c:if>>정책
				<input type="checkbox" name="gcat.character" value="1"
				    <c:if test="${goods.gcat.character == '1'}"> checked</c:if>>캐릭터
				<input type="checkbox" name="gcat.experience" value="1"
				    <c:if test="${goods.gcat.experience == '1'}"> checked</c:if>>체험
				<input type="checkbox" name="gcat.collaboration" value="1"
				    <c:if test="${goods.gcat.collaboration == '1'}"> checked</c:if>>콜라보
				<input type="checkbox" name="gcat.entertainment" value="1"
				    <c:if test="${goods.gcat.entertainment == '1'}"> checked</c:if>>방송
		    </div>
		</div>
        <div id="gPrice">상품 가격 <input type="text" name="gprice" value="${goods.gprice}"></div>
        <div id="gEndDate">상품 판매 종료일 <input type="text" name="sellDate" value="${goods.sellDate}"></div>
        <label for="gexp">설명글</label>
	    <div id="storeExp">
	    	<textarea rows="20" cols="100" name="gexp">${goods.gexp}</textarea>
	    </div>	 
    </form>
	
	<button type="button" id="gCancel" onclick="backtoGList();">취소 및 리스트로 돌아가기</button>	
    <button type="button" id="gDelete" onclick="goodsDelete();">삭제</button>
    <button type="button" id="gUpdate" onclick="goodsUpdate();">수정완료</button>
    <button type="button" id="backToMainPage" onclick="backToMainPage();">관리자 메인 페이지</button>

    
    <div id="pagination"></div>
    
<script type="text/javascript" src="/resources/adminJs/admin.js"></script>  
<script type="text/javascript" src="/resources/adminJs/adminGoods.js"></script>  
	
</body>
</html>