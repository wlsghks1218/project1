<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix = "sec" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Goods Search Result</title>
<style type="text/css">
/* 전체 요소에 대한 기본 스타일 */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* 기본 배경 색상 설정 */
body {
    font-family: 'Helvetica Neue', Arial, sans-serif;
    background-color: #fee7ed;
    color: #00aff0;
    font-size: 1rem; /* 기본 글꼴 크기 */
}

/* 헤더 스타일 */
#popUpHeader {
    background-color: #141414;
    padding: 0.625rem 1.25rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

#popUpHeader h1 {
    font-size: 1.5rem;
    color: #e50914;
    font-weight: bold;
    text-transform: uppercase;
}

#popUpHeader nav {
    display: flex;
    gap: 0.9375rem;
}

#popUpHeader a {
    color: #fff;
    text-decoration: none;
    font-weight: 500;
    font-size: 1rem;
}

#popUpHeader a:hover {
    color: #e50914;
}

/* 검색 결과 영역 */
#goodsSearchResult {
    padding: 2rem;
}

/* 검색 조건 스타일 */
.searchCategory {
    display: flex;
    justify-content: center;
    margin: 2rem 0;
}

.searchCategory span {
    padding: 0.625rem 1rem;
    border-radius: 0.5rem;
    background-color: #fee7ed;
    color: #00aff0;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.searchCategory span:hover {
    background-color: #00aff0;
    color: white;
}

.searchCategory span.active {
    background-color: #00aff0;
    color: white;
}

/* 카테고리 선택 버튼 스타일 */
#selectCat {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    margin: 2rem auto;
    gap: 1rem;
    max-width: 80%;
}

#selectCat::-webkit-scrollbar {
    display: none;
}

.categoryFilter {
    background-color: #ffffff;
    color: #00aff0;
    border: 1px solid #00aff0;
    padding: 0.625rem 1rem;
    cursor: pointer;
    border-radius: 0.5rem;
    transition: background-color 0.3s ease, color 0.3s ease;
}

.categoryFilter:hover {
    background-color: #00aff0;
    color: white;
}

.categoryFilter.active {
    background-color: #00aff0;
    color: white;
}

/* 검색어 초기화 버튼 스타일 */
#init {
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 2rem auto;
    background-color: #00aff0;
    color: white;
    border: 1px solid #00aff0;
    padding: 0.625rem 1rem;
    cursor: pointer;
    border-radius: 0.5rem;
    font-size: 1rem;
    text-align: center;
    transition: background-color 0.3s ease, color 0.3s ease;
}

#init:hover {
    background-color: #0082b3;
    color: white;
    border-color: #0082b3;
}

/* 검색 결과 리스트 컨테이너 */
.goodsContainer {
    width: 80%; /* 화면 크기에 따라 반응하는 너비 설정 */
    max-width: 1200px; /* 최대 너비 제한 */
    margin: 0 auto; /* 중앙 정렬 */
    padding: 2rem; /* 반응형 여백 */
    background-color: #fee7ed;
    overflow: visible;
    font-size: 1rem; /* 기본 폰트 크기 */
}

/* 검색 결과 카드 */
.goodsResult {
    width: 100%; /* 부모 요소의 너비를 따라감 */
    background-color: #00aff0;
    color: #ffffff;
    border-radius: 0.625rem;
    box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.1);
    padding: 2rem;
    margin-bottom: 2rem;
    display: flex;
    align-items: center;
    position: relative;
    transition: transform 0.3s ease, background-color 0.3s ease;
}

.goodsResult:hover {
    transform: scale(1.05);
    background-color: #0082b3;
}

/* 이미지 영역 */
.goodsImg {
    flex: 0 0 auto;
    margin-right: 1.5rem;
    width: 15%; /* 상대적인 너비 */
    aspect-ratio: 4 / 3; /* 비율 유지 */
    object-fit: cover;
    border-radius: 0.5rem;
    background-size: cover;
    background-position: center center;
    background-repeat: no-repeat;
}

/* 카드 내부 정보 */
.goodsInfo {
    flex: 1;
    margin-top: 0.5rem;
}

/* 텍스트 및 정보 스타일 */
.goodsLike,
.goodsPrice,
.goodsExp,
.goodsSellDate {
    font-size: 1rem;
    color: #ffffff;
    margin-bottom: 0.5rem;
}

.goodsName {
    font-size: 1.25rem;
    margin-bottom: 0.5rem;
    color: #ffffff;
    font-weight: bold;
}

/* 카테고리 스타일 */
.goodsCategory .categories {
    display: inline-block;
    margin-right: 0.5rem;
    padding: 0.5rem 1rem;
    background-color: rgba(255, 255, 255, 0.3);
    color: #ffffff;
    border-radius: 0.375rem;
    font-size: 0.875rem;
}

.goodsResult:hover {
    background-color: #0082b3;
    transform: scale(1.02);
    transition: background-color 0.3s ease, transform 0.3s ease;
}

#loadMoreBtn {
    background-color: #00aff0; /* 주요 색상 */
    color: #ffffff; /* 흰색 텍스트 */
    border: none;
    padding: 10px 20px; /* 내부 여백 */
    border-radius: 5px; /* 버튼 모서리 둥글게 */
    cursor: pointer;
    transition: background-color 0.3s; /* 부드러운 색상 변화 */
    margin: 20px 0; /* 위아래 여백 추가 */
    display: block; /* 블록 요소로 변경 */
    margin-left: auto; /* 중앙 정렬 */
    margin-right: auto; /* 중앙 정렬 */
    text-align: center; /* 텍스트 중앙 정렬 */
}

#loadMoreBtn:hover {
    background-color: #0082b3; /* 호버 색상 */
}

/* 푸터 스타일 */
#popUpFooter {
    background-color: #141414;
    padding: 1.25rem;
    text-align: center;
    color: #999;
}

#popUpFooter a {
    color: #fff;
    text-decoration: none;
    margin: 0 0.625rem;
}

#popUpFooter a:hover {
    color: #e50914;
}

</style>
</head>
<body>
	<jsp:include page="layout/popUpHeader.jsp" />
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="pinfo"/>
   		<input type="hidden" id="userNo" value="${pinfo.member.userNo}">
	</sec:authorize>
	<div class="searchCategory">
		<span id="priceHigh">가격 높은순</span>
		<span id="priceLow">가격 낮은순</span>
		<span id="likeHigh">좋아요순</span>
		<span id="replyHigh">후기 많은순</span>
		<span id="newDate">최신순</span>
		<span id="categorySelect">관심사 선택</span>
	</div>
	<div>
		<button id="init">검색어 초기화(모든 리스트 출력)</button>
	</div>
	<div id="selectCat">
		<div class="categoryFilter" id="allCategory">전체</div>
		<div class="categoryFilter" id="healthBeauty">건강 & 뷰티</div>
		<div class="categoryFilter" id="game">게임</div>
		<div class="categoryFilter" id="culture">문화</div>
		<div class="categoryFilter" id="shopping">쇼핑</div>
		<div class="categoryFilter" id="supply">문구</div>
		<div class="categoryFilter" id="kids">키즈</div>
		<div class="categoryFilter" id="design">디자인</div>
		<div class="categoryFilter" id="foods">식품</div>
		<div class="categoryFilter" id="interior">인테리어</div>
		<div class="categoryFilter" id="policy">정책</div>
		<div class="categoryFilter" id="character">캐릭터</div>
		<div class="categoryFilter" id="experience">체험</div>
		<div class="categoryFilter" id="collaboration">콜라보</div>
		<div class="categoryFilter" id="entertainment">방송</div>
	</div>
    <div class="goodsContainer" id="goodsContainer">
    </div>
    <button id="loadMoreBtn">더보기</button>
	<jsp:include page="layout/popUpFooter.jsp" />
	<jsp:include page="layout/goodsNavBar.jsp" />
</body>
<script type="text/javascript" src="/resources/goodsJs/goodsHeader.js"></script>
<script type="text/javascript" src="/resources/goodsJs/goodsSearch.js"></script>
<script type="text/javascript" src="/resources/goodsJs/goodsNav.js"></script>
<script type="text/javascript">
    let searchText = "${searchText != null ? searchText : ''}";
</script>
</html>