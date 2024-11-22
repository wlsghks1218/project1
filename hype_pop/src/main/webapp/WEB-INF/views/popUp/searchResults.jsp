<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="searchConditions">
    <h3>
        <span id="arrayByDis">거리순</span>
        <span id="arrayByLike">좋아요 순</span>
        <span id="arrayByLatest">최신순</span>
        <span id="arrayByRating">별점순</span>
        <button id="selectInterestsBtn">관심사 선택</button>
    </h3>
</div>
<div id="resetWrapper">
    <span id="resetBtn">초기화(모든 스토어 출력)</span>
</div>

<!-- 관심사 종류 버튼들 -->
<div id="interestButtons" style="display: none;">
    <button class="interestBtn">헬스&뷰티</button>
    <button class="interestBtn">게임</button>
    <button class="interestBtn">문화</button>
    <button class="interestBtn">쇼핑</button>
    <button class="interestBtn">문구</button>
    <button class="interestBtn">키즈</button>
    <button class="interestBtn">디자인</button>
    <button class="interestBtn">식품</button>
    <button class="interestBtn">인테리어</button>
    <button class="interestBtn">정책</button>
    <button class="interestBtn">캐릭터</button>
    <button class="interestBtn">체험</button>
    <button class="interestBtn">콜라보</button>
    <button class="interestBtn">방송</button>
</div>

<div class="searchResultStore">
    <c:forEach var="store" items="${searchData}">
        <div class="store-card">
            <!-- 이미지 영역 -->
            <div class="store-image">
                <img src="/resources/images/hamburger.png" alt="팝업스토어 배너 이미지">
            </div>

            <div class="store-info">
                <div class="header">
                    <h2><span class="storeName">${store.psName}</span></h2>
                    <span class="likeCount">${store.likeCount}</span>
                    <input type="hidden" class="psNo" value="${store.psNo}">
                    <input type="hidden" class="latitude" value="${store.latitude}">
                    <input type="hidden" class="longitude" value="${store.longitude}">    
                    <input type="hidden" class="rating" value="${store.avgRating}"> <!-- 별점 추가 -->
                </div>
                <h3>주소: ${store.psAddress}</h3>
                <span class="popUpCat">${store.interest}</span>
                <div class="date-info">
                    <span>시작일: ${store.psStartDate}</span>
                    <span>종료일: ${store.psEndDate}</span>
                </div>
            </div>
        </div>
    </c:forEach>
</div>


<div class="scroll-btn">
    <button id="scrollUp" aria-label="위로 이동"></button>
    <button id="scrollDown" aria-label="아래로 이동"></button>
</div>
