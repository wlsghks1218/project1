<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
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
#gImg {
    cursor: pointer;
    padding: 10px 15px;
    background-color: #dc3545;
    color: white;
    border-radius: 5px;
    text-align: center;
    display: inline-block;
    margin-bottom: 10px;
    transition: background-color 0.3s;
}

#gImg:hover {
    background-color: #c82333;
}

/* 업로드된 이미지 섹션 */
#uploadedImages {
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
#gCancel, #gDelete, #gUpdate {
    padding: 10px 15px;
    border-radius: 5px;
    color: white;
    text-align: center;
    cursor: pointer;
    border: 3px solid transparent;
    margin-top: 10px;
    display: inline-block;
    transition: background-color 0.3s, color 0.3s, border-color 0.3s;
}

/* 각각의 버튼에 고유 색상 설정 */
#gCancel, #gDelete, #gUpdate {
    background-color: transparent;
    color: #dc3545;
    border-color: #dc3545;
}

#gCancel:hover, #gDelete:hover, #gUpdate:hover {
    background-color: #dc3545;
    color: white;
    border-color: #c82333;
}

</style>
</head>
<body>
	<jsp:include page="layout/adminHeader.jsp"/>
	
	<form id="goodsForm" method="POST" action="/admin/updateGoods">
        <input type="hidden" name="gno" value="${vo.gno}">
        
        <div id="gImg" style="cursor: pointer;">굿즈 이미지</div>
		<input type="file" id="fileInput" name="imageFile" style="display: none;">
		<input type="hidden" name="imageUuid" value="${image.uuid}">
		<div id="uploadedImages"></div>
        
        <div id="gName">상품 이름 <input type="text" name="gname" value="${vo.gname}"></div>
        <div id="gPrice">상품 가격 <input type="text" name="gprice" value="${vo.gprice}"></div>
        <div id="gEndDate">상품 판매 종료일 <input type="text" name="sellDate" value="${vo.sellDate}"></div>
        <div id="storeExp">설명글 <input type="text" name="gexp" value="${vo.gexp}"></div>
    </form>
	
	<button type="button" id="gCancel" >취소 및 리스트로 돌아가기</button>	
    <button type="button" id="gDelete" >삭제</button>
    <button type="button" id="gUpdate" >수정완료</button>
	
</body>
</html>