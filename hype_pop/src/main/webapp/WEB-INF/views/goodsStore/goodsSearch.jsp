<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Goods Search Result</title>
<style type="text/css">
<style type="text/css">
body {
    margin: 0;
    font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
    background-color: #141414;
    color: #fff;
}

#popUpHeader {
    background-color: #141414;
    padding: 10px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

#popUpHeader h1 {
    font-size: 24px;
    color: #e50914;
    font-weight: bold;
    text-transform: uppercase;
}

#popUpHeader nav {
    display: flex;
    gap: 15px;
}

#popUpHeader a {
    color: #fff;
    text-decoration: none;
    font-weight: 500;
    font-size: 16px;
}

#popUpHeader a:hover {
    color: #e50914;
}

#goodsSearchResult {
    padding: 20px;
}

.searchCategory {
    display: flex;
    gap: 15px;
    margin-bottom: 20px;
}

.searchCategory span {
    cursor: pointer;
    font-size: 18px;
    padding: 8px 12px;
    border-radius: 5px;
    background-color: #333;
    transition: background-color 0.3s ease;
}

.searchCategory span:hover {
    background-color: #e50914;
}

.searchCategory span.active {
    background-color: #e50914;
    color: #fff;
}

.goodsContainer {
    display: grid;
    grid-template-columns: 1fr;
    gap: 20px;
}

.goodsResult {
    background-color: #222;
    display: flex;
    padding: 15px;
    border-radius: 10px;
    transition: transform 0.3s ease, background-color 0.3s ease;
    align-items: center;
}

.goodsResult:hover {
    transform: scale(1.05);
    background-color: #333;
}

.goodsImg {
    width: 150px;
    height: 150px;
    background-color: #fff;
    margin-right: 20px;
    border-radius: 10px;
    object-fit: cover;
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
}

.goodsInfo {
    flex-grow: 1;
}

.goodsName, .goodsPrice, .goodsExp, .goodsSellDate, .goodsLike {
    margin: 10px 0;
}

.goodsLike, .goodsPrice {
    font-size: 16px;
    font-weight: bold;
}

.goodsName {
    font-size: 18px;
}

.goodsExp {
    font-size: 14px;
    color: #999;
}

.goodsSellDate {
    font-size: 12px;
    color: #666;
}

#init {
    display: block;
    margin: 20px auto;
    padding: 10px 20px;
    background-color: #333;
    border: none;
    color: white;
    font-size: 16px;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s ease, transform 0.3s ease;
}

#init:hover {
    background-color: #e50914;
    transform: scale(1.05);
}

#loadMoreBtn {
    display: block;
    margin: 30px auto;
    padding: 10px 20px;
    background-color: #e50914;
    border: none;
    color: white;
    font-size: 16px;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s ease;
}

#loadMoreBtn:hover {
    background-color: #f40612;
}

#popUpFooter {
    background-color: #141414;
    padding: 20px;
    text-align: center;
    color: #999;
}

#popUpFooter a {
    color: #fff;
    text-decoration: none;
    margin: 0 10px;
}

#popUpFooter a:hover {
    color: #e50914;
}

#selectCat {
    display: flex;
    overflow-x: auto;
    gap: 10px;
    padding: 10px 20px;
    margin-bottom: 20px;
    scrollbar-width: none;
}

#selectCat::-webkit-scrollbar {
    display: none;
}

.categoryFilter {
    flex-shrink: 0;
    font-size: 18px;
    padding: 12px 20px;
    border-radius: 5px;
    background-color: #333;
    color: #fff;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.3s ease;
    white-space: nowrap;
}

.categoryFilter:hover {
    background-color: #e50914;
    transform: scale(1.05);
}

.categoryFilter.active {
    background-color: #e50914;
    color: #fff;
}
</style>
</head>
<body>
	<jsp:include page="layout/popUpHeader.jsp" />
	
<div id="goodsSearchResult">
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
</div>
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