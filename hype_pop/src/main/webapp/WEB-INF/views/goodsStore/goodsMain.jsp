<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
    margin: 0;
    font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
    background-color: #141414;
    color: white;
    overflow-x: hidden;
}

#popUpHeader {
    background-color: #141414;
    padding: 10px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

h1, h2 {
    text-align: center;
    color: #e50914;
    margin-bottom: 20px;
}

#hotGoods, #interestGoods1, #interestGoods2, #interestGoods3, 
#interestGoods4, #interestGoods5, #interestGoods6 {
    width: 80%;
    margin: 40px auto;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    overflow: hidden;
}

.goodsContainer1, .goodsContainer2, .goodsContainer3, .goodsContainer4, 
.goodsContainer5, .goodsContainer6, .goodsContainer7 {
    display: flex;
    overflow: hidden;
    width: 100%;
    height: 300px;
    border-radius: 10px;
    position: relative;
    box-sizing: border-box;
}

.goodsItem1, .goodsItem2, .goodsItem3, .goodsItem4, .goodsItem5, 
.goodsItem6, .goodsItem7 {
    position: relative;
    background-color: #333;
    color: white;
    width: 25%;
    height: 100%;
    margin-right: 10px;
    border-radius: 10px;
    padding: 10px;
    box-sizing: border-box;
    transition: transform 0.3s ease;
    background-size: cover;
    background-position: center center;
    background-repeat: no-repeat;
    overflow: hidden;
    transform-origin: center;
}

.goodsItem1:hover, .goodsItem2:hover, .goodsItem3:hover, .goodsItem4:hover,
.goodsItem5:hover, .goodsItem6:hover, .goodsItem7:hover {
    transform: scale(1.02);
}

.goodsContainer1:hover, .goodsContainer2:hover, .goodsContainer3:hover, 
.goodsContainer4:hover, .goodsContainer5:hover, .goodsContainer6:hover, 
.goodsContainer7:hover {
    height: 300px;
}

.goodsLike {
    position: absolute;
    top: 10px;
    right: 10px;
    background-color: rgba(0, 0, 0, 0.7);
    padding: 5px 10px;
    border-radius: 15px;
    font-size: 14px;
    color: white;
    font-weight: bold;
}
.goodsInfo {
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    background-color: rgba(0, 0, 0, 0.7);
    padding: 10px;
    box-sizing: border-box;
    color: white;
}

.goodsName {
    font-weight: bold;
    margin-bottom: 5px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.goodsPrice {
    color: #f5c518;
    font-weight: bold;
    text-align: right;
}

#prevBtn1, #nextBtn1, #prevBtn2, #nextBtn2, #prevBtn3, #nextBtn3, 
#prevBtn4, #nextBtn4, #prevBtn5, #nextBtn5, #prevBtn6, #nextBtn6, 
#prevBtn7, #nextBtn7 {
    background-color: #e50914;
    border: none;
    color: white;
    font-size: 18px;
    padding: 10px;
    cursor: pointer;
    border-radius: 50%;
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    z-index: 10;
}

#prevBtn1, #prevBtn2, #prevBtn3, #prevBtn4, #prevBtn5, #prevBtn6, #prevBtn7 {
    left: 10px;
}

#nextBtn1, #nextBtn2, #nextBtn3, #nextBtn4, #nextBtn5, #nextBtn6, #nextBtn7 {
    right: 10px;
}
</style>
</head>
<body>
	<jsp:include page="layout/popUpHeader.jsp" />
	<h1>현재 인기있는 굿즈</h1>
	<div id="hotGoods">
		<button id="prevBtn1">◀</button>
		<div class="goodsContainer1" id="goodsContainer1">
			<c:forEach var="vo" items="${likeGoods}">
				<div class="goodsItem1">
					<input type="hidden" value="${vo.gno}">
					<input type="hidden" value="${vo.attachList[0].uuid}_${vo.attachList[0].fileName}" id="fileName">
					<div class="goodsLike">❤️ ${vo.likeCount}</div>
			        <div class="goodsInfo">
        			    <div class="goodsName">${vo.gname}</div>
            			<div class="goodsPrice">${vo.gprice}</div>
        			</div>
				</div>
			</c:forEach>
		</div>
		<button id="nextBtn1">▶</button>
	</div>
	<h1>관심사별 인기 목록</h1>
	<h2>
		<c:choose>
			<c:when test="${categoryOne == 'healthBeauty'}">건강 & 뷰티</c:when>
			<c:when test="${categoryOne == 'game'}">게임</c:when>
			<c:when test="${categoryOne == 'culture'}">문화</c:when>
			<c:when test="${categoryOne == 'shopping'}">쇼핑</c:when>
			<c:when test="${categoryOne == 'supply'}">문구</c:when>
			<c:when test="${categoryOne == 'kids'}">키즈</c:when>
			<c:when test="${categoryOne == 'design'}">디자인</c:when>
			<c:when test="${categoryOne == 'foods'}">식품</c:when>
			<c:when test="${categoryOne == 'interior'}">인테리어</c:when>
			<c:when test="${categoryOne == 'policy'}">정책</c:when>
			<c:when test="${categoryOne == 'character'}">캐릭터</c:when>
			<c:when test="${categoryOne == 'experience'}">체험</c:when>
			<c:when test="${categoryOne == 'collaboration'}">콜라보</c:when>
			<c:when test="${categoryOne == 'entertainment'}">방송</c:when>
		</c:choose>
	</h2>
	<div id="interestGoods1">
		<button id="prevBtn2">◀</button>
		<div class="goodsContainer2" id="goodsContainer2">
			<c:forEach var="vo" items="${interestOneNotLogin}">
				<div class="goodsItem2">
					<input type="hidden" value="${vo.gno}">
					<input type="hidden" value="${vo.attachList[0].uuid}_${vo.attachList[0].fileName}" id="fileName">
					<div class="goodsLike">❤️ ${vo.likeCount}</div>
			        <div class="goodsInfo">
        			    <div class="goodsName">${vo.gname}</div>
            			<div class="goodsPrice">${vo.gprice}</div>
        			</div>
				</div>
			</c:forEach>
		</div>
		<button id="nextBtn2">▶</button>
	</div>
	<h2>
		<c:choose>
			<c:when test="${categoryTwo == 'healthBeauty'}">건강 & 뷰티</c:when>
			<c:when test="${categoryTwo == 'game'}">게임</c:when>
			<c:when test="${categoryTwo == 'culture'}">문화</c:when>
			<c:when test="${categoryTwo == 'shopping'}">쇼핑</c:when>
			<c:when test="${categoryTwo == 'supply'}">문구</c:when>
			<c:when test="${categoryTwo == 'kids'}">키즈</c:when>
			<c:when test="${categoryTwo == 'design'}">디자인</c:when>
			<c:when test="${categoryTwo == 'foods'}">식품</c:when>
			<c:when test="${categoryTwo == 'interior'}">인테리어</c:when>
			<c:when test="${categoryTwo == 'policy'}">정책</c:when>
			<c:when test="${categoryTwo == 'character'}">캐릭터</c:when>
			<c:when test="${categoryTwo == 'experience'}">체험</c:when>
			<c:when test="${categoryTwo == 'collaboration'}">콜라보</c:when>
			<c:when test="${categoryTwo == 'entertainment'}">방송</c:when>
		</c:choose>
	</h2>
	<div id="interestGoods2">
		<button id="prevBtn3">◀</button>
		<div class="goodsContainer3" id="goodsContainer3">
			<c:forEach var="vo" items="${interestTwoNotLogin}">
				<div class="goodsItem3">
					<input type="hidden" value="${vo.gno}">
					<input type="hidden" value="${vo.attachList[0].uuid}_${vo.attachList[0].fileName}" id="fileName">
					<div class="goodsLike">❤️ ${vo.likeCount}</div>
			        <div class="goodsInfo">
        			    <div class="goodsName">${vo.gname}</div>
            			<div class="goodsPrice">${vo.gprice}</div>
        			</div>
				</div>
			</c:forEach>
		</div>
		<button id="nextBtn3">▶</button>
	</div>
	<h2>
		<c:choose>
			<c:when test="${categoryThree == 'healthBeauty'}">건강 & 뷰티</c:when>
			<c:when test="${categoryThree == 'game'}">게임</c:when>
			<c:when test="${categoryThree == 'culture'}">문화</c:when>
			<c:when test="${categoryThree == 'shopping'}">쇼핑</c:when>
			<c:when test="${categoryThree == 'supply'}">문구</c:when>
			<c:when test="${categoryThree == 'kids'}">키즈</c:when>
			<c:when test="${categoryThree == 'design'}">디자인</c:when>
			<c:when test="${categoryThree == 'foods'}">식품</c:when>
			<c:when test="${categoryThree == 'interior'}">인테리어</c:when>
			<c:when test="${categoryThree == 'policy'}">정책</c:when>
			<c:when test="${categoryThree == 'character'}">캐릭터</c:when>
			<c:when test="${categoryThree == 'experience'}">체험</c:when>
			<c:when test="${categoryThree == 'collaboration'}">콜라보</c:when>
			<c:when test="${categoryThree == 'entertainment'}">방송</c:when>
		</c:choose>
	</h2>
	<div id="interestGoods3">
		<button id="prevBtn4">◀</button>
		<div class="goodsContainer4" id="goodsContainer4">
			<c:forEach var="vo" items="${interestThreeNotLogin}">
				<div class="goodsItem4">
					<input type="hidden" value="${vo.gno}">
					<input type="hidden" value="${vo.attachList[0].uuid}_${vo.attachList[0].fileName}" id="fileName">
					<div class="goodsLike">❤️ ${vo.likeCount}</div>
			        <div class="goodsInfo">
        			    <div class="goodsName">${vo.gname}</div>
            			<div class="goodsPrice">${vo.gprice}</div>
        			</div>
				</div>
			</c:forEach>
		</div>
		<button id="nextBtn4">▶</button>
	</div>
	
	<br><hr><br>
	
	<h1>관심사별 인기 목록</h1>
	<h2>
		<c:choose>
			<c:when test="${categoryFour == 'healthbeauty'}">건강 & 뷰티</c:when>
			<c:when test="${categoryFour == 'game'}">게임</c:when>
			<c:when test="${categoryFour == 'culture'}">문화</c:when>
			<c:when test="${categoryFour == 'shopping'}">쇼핑</c:when>
			<c:when test="${categoryFour == 'supply'}">문구</c:when>
			<c:when test="${categoryFour == 'kids'}">키즈</c:when>
			<c:when test="${categoryFour == 'design'}">디자인</c:when>
			<c:when test="${categoryFour == 'foods'}">식품</c:when>
			<c:when test="${categoryFour == 'interior'}">인테리어</c:when>
			<c:when test="${categoryFour == 'policy'}">정책</c:when>
			<c:when test="${categoryFour == 'character'}">캐릭터</c:when>
			<c:when test="${categoryFour == 'experience'}">체험</c:when>
			<c:when test="${categoryFour == 'collaboration'}">콜라보</c:when>
			<c:when test="${categoryFour == 'entertainment'}">방송</c:when>
		</c:choose>
	</h2>
	<div id="interestGoods4">
		<button id="prevBtn5">◀</button>
		<div class="goodsContainer5" id="goodsContainer5">
			<c:forEach var="vo" items="${interestOneNotLogin}">
			
				<div class="goodsItem5">
					<input type="hidden" value="${vo.gno}">
					<input type="hidden" value="${vo.attachList[0].uuid}_${vo.attachList[0].fileName}" id="fileName">
					<div class="goodsLike">❤️ ${vo.likeCount}</div>
			        <div class="goodsInfo">
        			    <div class="goodsName">${vo.gname}</div>
            			<div class="goodsPrice">${vo.gprice}</div>
        			</div>
				</div>
			</c:forEach>
		</div>
		<button id="nextBtn5">▶</button>
	</div>
	<h2>
		<c:choose>
			<c:when test="${categoryFive == 'healthbeauty'}">건강 & 뷰티</c:when>
			<c:when test="${categoryFive == 'game'}">게임</c:when>
			<c:when test="${categoryFive == 'culture'}">문화</c:when>
			<c:when test="${categoryFive == 'shopping'}">쇼핑</c:when>
			<c:when test="${categoryFive == 'supply'}">문구</c:when>
			<c:when test="${categoryFive == 'kids'}">키즈</c:when>
			<c:when test="${categoryFive == 'design'}">디자인</c:when>
			<c:when test="${categoryFive == 'foods'}">식품</c:when>
			<c:when test="${categoryFive == 'interior'}">인테리어</c:when>
			<c:when test="${categoryFive == 'policy'}">정책</c:when>
			<c:when test="${categoryFive == 'character'}">캐릭터</c:when>
			<c:when test="${categoryFive == 'experience'}">체험</c:when>
			<c:when test="${categoryFive == 'collaboration'}">콜라보</c:when>
			<c:when test="${categoryFive == 'entertainment'}">방송</c:when>
		</c:choose>
	</h2>
	<div id="interestGoods5">
		<button id="prevBtn6">◀</button>
		<div class="goodsContainer6" id="goodsContainer6">
			<c:forEach var="vo" items="${interestTwoNotLogin}">
				<div class="goodsItem6">
					<input type="hidden" value="${vo.gno}">
					<input type="hidden" value="${vo.attachList[0].uuid}_${vo.attachList[0].fileName}" id="fileName">
					<div class="goodsLike">❤️ ${vo.likeCount}</div>
			        <div class="goodsInfo">
        			    <div class="goodsName">${vo.gname}</div>
            			<div class="goodsPrice">${vo.gprice}</div>
        			</div>
				</div>
			</c:forEach>
		</div>
		<button id="nextBtn6">▶</button>
	</div>
	<h2>
		<c:choose>
			<c:when test="${categorySix == 'healthbeauty'}">건강 & 뷰티</c:when>
			<c:when test="${categorySix == 'game'}">게임</c:when>
			<c:when test="${categorySix == 'culture'}">문화</c:when>
			<c:when test="${categorySix == 'shopping'}">쇼핑</c:when>
			<c:when test="${categorySix == 'supply'}">문구</c:when>
			<c:when test="${categorySix == 'kids'}">키즈</c:when>
			<c:when test="${categorySix == 'design'}">디자인</c:when>
			<c:when test="${categorySix == 'foods'}">식품</c:when>
			<c:when test="${categorySix == 'interior'}">인테리어</c:when>
			<c:when test="${categorySix == 'policy'}">정책</c:when>
			<c:when test="${categorySix == 'character'}">캐릭터</c:when>
			<c:when test="${categorySix == 'experience'}">체험</c:when>
			<c:when test="${categorySix == 'collaboration'}">콜라보</c:when>
			<c:when test="${categorySix == 'entertainment'}">방송</c:when>
		</c:choose>
	</h2>
	<div id="interestGoods6">
		<button id="prevBtn7">◀</button>
		<div class="goodsContainer7" id="goodsContainer7">
			<c:forEach var="vo" items="${interestThreeNotLogin}">
				<div class="goodsItem7">
					<input type="hidden" value="${vo.gno}">
					<input type="hidden" value="${vo.attachList[0].uuid}_${vo.attachList[0].fileName}" id="fileName">
					<div class="goodsLike">❤️ ${vo.likeCount}</div>
			        <div class="goodsInfo">
        			    <div class="goodsName">${vo.gname}</div>
            			<div class="goodsPrice">${vo.gprice}</div>
        			</div>
				</div>
			</c:forEach>
		</div>
		<button id="nextBtn7">▶</button>
	</div>
	<jsp:include page="layout/popUpFooter.jsp" />
	<jsp:include page="layout/goodsNavBar.jsp" />
</body>
<script type="text/javascript" src="/resources/goodsJs/goodsHeader.js"></script>
<script type="text/javascript" src="/resources/goodsJs/goodsMain.js"></script> 
<script type="text/javascript" src="/resources/goodsJs/goodsNav.js"></script>
</html>