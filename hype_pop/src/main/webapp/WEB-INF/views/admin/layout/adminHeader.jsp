<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.adminHeader {
    text-align: center; /* 중앙 정렬 */
    padding: 15px 0; /* 상하 여백 */
    margin-bottom: 20px; /* 아래 여백 */
}
.adminBox {
    display: inline-block; /* 가로로 배치 */
    background-color: #00aff0;     
    color: #fee7ed;
    padding: 10px 20px; /* 패딩 */
    margin: 0 15px; /* 양쪽 여백을 15px로 설정 */
    border-radius: 5px; /* 모서리 둥글게 */
    cursor: pointer; /* 커서 변경 */
    width: 200px; /* 가로 너비 지정 */
    text-align: center; /* 텍스트 중앙 정렬 */
}
#adminSearchBox {
    width: auto; /* 자동 너비 조정 */
    margin: 20px 10px 10px; /* 위쪽 여백 추가 */
    padding: 8px; /* 입력 상자 내부 여백 */
    border: 4px solid pink; /* 테두리 색상 */
    border-radius: 5px; /* 모서리 둥글게 */
    height: 36px; /* 높이 지정 */
    box-sizing: border-box; /* 패딩과 테두리 포함 */
}
#searchBTN {
    background-color: #00aff0;     
    color: #fee7ed;
    padding: 8px 15px; /* 패딩 */
    margin-left: 10px; /* 검색 버튼과 텍스트 박스 사이 여백 */
    border-radius: 5px; /* 모서리 둥글게 */
    cursor: pointer; /* 커서 변경 */
    height: 36px; /* 높이 지정 */
    line-height: 36px; /* 텍스트 수직 정렬 */
}
#searchBTN:hover {
    background-color: #fee7ed; 
    color : #00aff0;
}
/* 메인 페이지로 가는 버튼 */
.mainPageBtn {
    background-color: #0077b3; /* 메인 페이지 버튼 색상 */
    color: #008ac6; /* 흰색 글자 */
    font-weight: bold;
    /* padding: 10px 15px; */
    border-radius: 5px;
    margin-bottom: 20px; /* 아래 버튼들과 적당한 간격 */
    display: inline-block;
    width: auto; /* 가변 크기 */
    text-align: center;
    cursor: pointer;
}
.mainPageBtn:hover {
    background-color: #004e80; /* 호버 시 더 어두운 색 */
}


</style>
</head>
<body>
    <div class="adminHeader"> 

        <span class="adminBox" id="popUpManage">팝업스토어 관리하기</span> 
        <span class="adminBox" id="storeManage">쇼핑몰 관리하기</span>
        <span class="adminBox" id="exhManage">전시회 관리하기</span> 
        <br>
        <input type="text" id="adminSearchBox" style="display: none;"> 
        <span id="searchBTN" style="display: none;">검색</span>
        <br>
        <span class="adminBox" id="memberManage">회원 관리하기</span> 
        <span class="adminBox" id="askList">문의리스트 확인</span> 
      	<span class="adminBox" id="registerBtn">등록하기</span>
<!--       	<span class="adminBox" id="goodsState">상품 상태 조회</span> -->
    </div>
<div class="adminMain">  
</body>
</html>