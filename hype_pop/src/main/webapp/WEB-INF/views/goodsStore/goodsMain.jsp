<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="/resources/images/favicon.ico">
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

#allGoodsContainer {
    font-family: 'Helvetica Neue', Arial, sans-serif; /* 기본 폰트 설정 */
    max-width: 800px; /* 최대 너비 설정 */
    margin: 0 auto; /* 중앙 정렬 */
    padding: 20px; /* 패딩 추가 */
    background-color: #00aff0; /* 배경 색상 변경 */
    border-radius: 8px; /* 둥근 모서리 */
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5); /* 깊이감 있는 그림자 효과 */
    color: #fee7ed; /* 텍스트 색상 변경 */
}

/* 제목 스타일 */
#allGoodsContainer h1 {
    font-size: 28px; /* 제목 크기 */
    margin: 15px 0; /* 상하 여백 */
    text-align: left; /* 왼쪽 정렬 */
    color: #fee7ed; /* 제목 색상 변경 */
}

#allGoodsContainer h2 {
    font-size: 22px; /* 소제목 크기 */
    margin: 20px 0 10px 0; /* 상하 여백 */
    text-align: left; /* 왼쪽 정렬 */
    color: #fee7ed; /* 소제목 색상 변경 */
}

#hotGoods, #interestGoods1, #interestGoods2, #interestGoods3,
#interestGoods4, #interestGoods5, #interestGoods6 {
    width: 100%;
    max-width: 800px;
    margin: 0 auto;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    overflow: hidden;
}

.goodsContainer1, .goodsContainer2, .goodsContainer3, 
.goodsContainer4, .goodsContainer5, .goodsContainer6, .goodsContainer7 {
    display: flex;
    align-items: center;
    overflow: hidden; /* 요소가 밖으로 넘치지 않도록 설정 */
    position: relative;
    width: 100%;
    max-width: 800px; /* 원하는 최대 너비 설정 */
    margin: 0 auto;
    transition: transform 0.5s ease;
}

.goodsItem1, .goodsItem2, .goodsItem3, .goodsItem4, 
.goodsItem5, .goodsItem6, .goodsItem7 {
    flex: 0 0 24%; /* 아이템 크기를 24%로 설정 */
    height: 200px; /* 고정 높이 */
    margin-right: 1%; /* 아이템 간의 마진 */
    text-align: center;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-end;
    position: relative;
    border: 1px solid #ccc; /* 테두리 */
    box-sizing: border-box; /* 내부 패딩 포함 크기 계산 */
    background-size: cover; /* 배경 이미지가 div를 꽉 채우도록 설정 */
    background-position: center center; /* 이미지 가운데 정렬 */
    border-radius: 8px; /* 모서리를 둥글게 */
}
.goodsItem1:last-child, .goodsItem2:last-child, .goodsItem3:last-child, 
.goodsItem4:last-child, .goodsItem5:last-child, .goodsItem6:last-child, .goodsItem7:last-child {
    margin-right: 0; /* 마지막 아이템에 오른쪽 마진 제거 */
}

.goodsLike {
    position: absolute; /* 위치를 절대값으로 설정 */
    top: 10px; /* 이미지 상단에서 10px 떨어진 위치 */
    right: 10px; /* 이미지 오른쪽에서 10px 떨어진 위치 */
    font-size: 16px; /* 글자 크기 */
    color: #fff; /* 글자 색상 */
    background-color: rgba(0, 0, 0, 0.6); /* 배경색을 약간 투명하게 */
    padding: 5px; /* 내부 여백 */
    border-radius: 5px; /* 둥근 모서리 */
    z-index: 10; /* 다른 요소들 위에 오도록 설정 */
}

.goodsInfo {
    font-size: 14px; /* 텍스트 크기 */
    font-weight: bold;
    color: #fff; /* 텍스트 색상 */
    background-color: rgba(0, 0, 0, 0.6); /* 배경을 반투명 검정으로 */
    padding: 8px 5px; /* 텍스트와 영역 사이에 충분한 여백 추가 */
    position: absolute;
    bottom: 10px; /* 이미지 아래에 텍스트 배치 */
    left: 50%;
    transform: translateX(-50%);
    border-radius: 4px;
    width: 90%; /* 텍스트 영역의 너비 */
    height: 50px; /* 고정 높이 설정을 약간 더 높게 */
    white-space: nowrap; /* 한 줄로 표시 */
    overflow: hidden; /* 넘치는 텍스트 숨기기 */
    text-overflow: ellipsis; /* 넘치는 텍스트 말줄임 표시 */
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
    background: rgba(255, 255, 255, 0.8); 
    border: 1px solid #ccc; 
    border-radius: 5px;
    font-size: 24px;
    cursor: pointer;
    padding: 5px 10px; 
    position: absolute;
    top: 50%; /* 세로 가운데 정렬 */
    transform: translateY(-50%); 
    z-index: 50; /* 다른 콘텐츠보다 위에 표시 */
}

#prevBtn1, #prevBtn2, #prevBtn3, #prevBtn4, #prevBtn5, #prevBtn6, #prevBtn7 {
    left: 10px;
}

#nextBtn1, #nextBtn2, #nextBtn3, #nextBtn4, #nextBtn5, #nextBtn6, #nextBtn7 {
    right: 10px;
}
/* 버튼 호버 시 스타일 */
#prevBtn1:hover, #nextBtn1:hover, #prevBtn2:hover, #nextBtn2:hover,
#prevBtn3:hover, #nextBtn3:hover, #prevBtn4:hover, #nextBtn4:hover,
#prevBtn5:hover, #nextBtn5:hover, #prevBtn6:hover, #nextBtn6:hover,
#prevBtn7:hover, #nextBtn7:hover {
    background-color: #f0f0f0; /* 호버 시 배경색 변경 */
}


.scroll-btn {
   position: fixed;
   bottom: 10vh;
   right: 2vw;
   display: flex;
   flex-direction: column; /* 버튼들이 위에서 아래로 정렬되게 설정 */
   gap: 0.625rem;
   z-index: 20;
}

.scroll-btn button {
   background-color: #00aff0; /* 배경색을 #00aff0로 변경 */
   color: white;
   padding: 1rem;
   border: none;
   border-radius: 10px; /* 모서리 둥글게 설정 */
   font-size: 0; /* 텍스트는 보이지 않도록 설정 */
   cursor: pointer;
   transition: background-color 0.3s, opacity 0.3s;
   display: flex;
   justify-content: center;
   align-items: center;
   width: 3rem; /* 버튼 크기 */
   height: 3rem; /* 버튼 크기 */
   position: relative; /* 삼각형을 위한 relative 위치 지정 */
   opacity: 0.5; /* 기본적으로 불투명 상태 */
}

.scroll-btn button:hover {
   background-color: #0092c4; /* 호버 시 색상 변경 */
   opacity: 1; /* 호버 시 불투명도 1로 설정 */
}


.scroll-btn button::before {
   content: "";
   position: absolute;
   width: 0;
   height: 0;
   border-left: 0.6rem solid transparent; /* 삼각형 크기 조정 */
   border-right: 0.6rem solid transparent; /* 삼각형 크기 조정 */
   left: 50%; /* 수평 중앙 정렬 */
   transform: translateX(-50%); /* 정확한 중앙 정렬 */
}

#scrollUp::before {
   border-bottom: 1.2rem solid white; /* 위로 화살표 크기 조정 */
   top: 50%; /* 버튼 중앙에 삼각형을 배치 */
   transform: translateY(-50%) translateX(-50%); /* 삼각형을 정확히 중앙에 맞추기 위한 변환 */
}

#scrollDown::before {
   border-top: 1.2rem solid white; /* 아래로 화살표 크기 조정 */
   bottom: 50%; /* 버튼 중앙에 삼각형을 배치 */
   transform: translateY(50%) translateX(-50%); /* 삼각형을 정확히 중앙에 맞추기 위한 변환 */
}

.scroll-btn button:hover {
   background-color: #0092c4; /* 호버 시 색상 변경 */
}

button:disabled {
   cursor: not-allowed;
   opacity: 0.5;
}


</style>
</head>
<body>
	<jsp:include page="layout/goodsHeader.jsp" />
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="pinfo" />
		<input type="hidden" id="userNo" value="${pinfo.member.userNo}">
	</sec:authorize>
	<div id="allGoodsContainer">
		<h1>현재 인기있는 굿즈</h1>
		<div id="hotGoods">
			<button id="prevBtn1">◀</button>
			<div class="goodsContainer1" id="goodsContainer1">
				<c:forEach var="vo" items="${likeGoods}">
					<div class="goodsItem1">
						<input type="hidden" value="${vo.gno}"> <input
							type="hidden"
							value="${vo.attachList[0].uuid}_${vo.attachList[0].fileName}"
							id="fileName">
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
		<sec:authorize access="!isAuthenticated()">
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
							<input type="hidden" value="${vo.gno}"> <input
								type="hidden"
								value="${vo.attachList[0].uuid}_${vo.attachList[0].fileName}"
								id="fileName">
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
							<input type="hidden" value="${vo.gno}"> <input
								type="hidden"
								value="${vo.attachList[0].uuid}_${vo.attachList[0].fileName}"
								id="fileName">
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
							<input type="hidden" value="${vo.gno}"> <input
								type="hidden"
								value="${vo.attachList[0].uuid}_${vo.attachList[0].fileName}"
								id="fileName">
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
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
			<h1>관심사별 인기 목록</h1>
			<h2>
				<c:choose>
					<c:when test="${categoryFour == 'healthBeauty'}">건강 & 뷰티</c:when>
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
					<c:forEach var="vo" items="${interestOneLogined}">

						<div class="goodsItem5">
							<input type="hidden" value="${vo.gno}"> <input
								type="hidden"
								value="${vo.attachList[0].uuid}_${vo.attachList[0].fileName}"
								id="fileName">
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
					<c:when test="${categoryFive == 'healthBeauty'}">건강 & 뷰티</c:when>
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
					<c:forEach var="vo" items="${interestTwoLogined}">
						<div class="goodsItem6">
							<input type="hidden" value="${vo.gno}"> <input
								type="hidden"
								value="${vo.attachList[0].uuid}_${vo.attachList[0].fileName}"
								id="fileName">
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
					<c:when test="${categorySix == 'healthBeauty'}">건강 & 뷰티</c:when>
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
					<c:forEach var="vo" items="${interestThreeLogined}">
						<div class="goodsItem7">
							<input type="hidden" value="${vo.gno}"> <input
								type="hidden"
								value="${vo.attachList[0].uuid}_${vo.attachList[0].fileName}"
								id="fileName">
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
	</sec:authorize>
	</div>
<div class="scroll-btn">
    <button id="scrollUp" aria-label="위로 이동"></button>
    <button id="scrollDown" aria-label="아래로 이동"></button>
</div>
	
	
	<jsp:include page="layout/goodsFooter.jsp" />
	<jsp:include page="layout/goodsNavBar.jsp" />
</body>
<script type="text/javascript" src="/resources/goodsJs/goodsMain.js"></script>
</html>