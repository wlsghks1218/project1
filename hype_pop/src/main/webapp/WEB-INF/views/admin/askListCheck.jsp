<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 목록</title>
<style>
    table {
            border-collapse: collapse;
            width: 100%;
    }
    th, td {
        border: 2px solid red; /* 테두리 빨간색 */
        padding: 8px;
        text-align: center; /* 가운데 정렬 */
    }
    th {
        background-color: #f2f2f2; /* 헤더 배경색 */
    }
    #qnaTypeBox {
    	margin-bottom: 10px;
    }
    #askType {
        width: 70px; /* 원하는 너비로 조정 */
        margin-right: 10px; /* select 박스와 체크박스 사이의 간격 */
    }
</style>
</head>
<body>
    <jsp:include page="layout/adminHeader.jsp"/>

	<div id="AllList">
	</div>
	
    <form action="#" id="qnaTypeBox">
        <label for="qnaType">문의 유형 선택:</label>
        <select id="qnaType">
            <option value="refund">일반</option>
            <option value="delivery">결제</option>
            <option value="complain">기타</option>
        </select>
        <label for="answerStatus">답변 여부:</label>
        <input type="checkbox" id="answerStatus"> 답변 완료
    </form>

    <table id="qnaListCat">
        <thead>
            <tr>
                <th>문의 번호</th>
                <th>문의 유형</th>
                <th>문의 제목</th>
                <th>문의 작성 날짜</th>
                <th>답변 여부</th>
            </tr>
        </thead>
        <tbody>
        	<c:forEach var="qnaList" items="${qna}">
                <tr>
                    <td>${qna.qnaNo}</td>
                    <td>${qna.qnaType}</td>
                    <td>${qna.qnaTitle}</td>
                    <td>${qna.qnaRegDate}</td>                    
                    <td>${qna.qnaAnswer}</td>                    
                    <%-- <td>${qna.qnaAnswer != null && !qna.qnaAnswer.isEmpty() ? '답변 완료' : '답변 미완료'}</td> --%>
                </tr>
            </c:forEach>           
        </tbody>
    </table>

	<div id="pagination">         
	</div>
	
<script type="text/javascript" src="/resources/adminJs/adminQna.js"></script>  
<script type="text/javascript" src="/resources/adminJs/admin.js"></script>  
</body>
</html>