<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상태 조회 페이지</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
    }
    .askTable {
        position: relative; /* 상대 위치 지정 */
        margin-top: 20px; /* 위쪽 여백을 조정하여 간격 설정 */
    }
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th {
    	background-color: #f2f2f2;
    }
    th, td {
        border: 2px solid red; /* 테두리 빨간색 */
        padding: 12px;
        text-align: center; /* 가운데 정렬 */
        color: black; /* 글자색 검정으로 변경 */
    }
    #saveGoods {
        margin-top: 10px; /* 위쪽 여백 */
	    padding: 10px 20px;
	    background-color: #dc3545; /* 빨간색 */
	    color: white;
	    border: none;
	    border-radius: 5px;
	    cursor: pointer;
	    float: right; /* 오른쪽으로 정렬 */
	    text-align: center; /* 중앙 정렬 */
    }
    #saveGoods:hover {
        background-color: #c82333; /* 조금 어두운 빨간색 */
    }
</style>
</head>
<body>
    <jsp:include page="layout/adminHeader.jsp"/>

	<div id="AllList"></div>
	
    <div class="goodsTable">
        <table>
            <thead>
                <tr>
                    <th>구매 번호</th>
                    <th>개수</th>
                    <th>가격</th>
                    <th>구매날짜</th>
                    <th>상품현황</th>
                </tr>
            </thead>
            <tbody id="goodsListBody">
            	<!-- JavaScript로 동적으로 채워질 부분 -->
	            
	        </tbody>
        </table>
    </div>
        
    <button type="button" id="saveGoods" onclick="updateGoodsList()">저장</button>

    <div id="pagination"></div>
    
<script type="text/javascript" src="/resources/adminJs/admin.js"></script> 
<script type="text/javascript" src="/resources/adminJs/adminGoods.js"></script>  
</body>
</html>