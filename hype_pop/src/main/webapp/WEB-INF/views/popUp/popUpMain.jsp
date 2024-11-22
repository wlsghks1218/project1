<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<head>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=v3s0wu5ddz"></script>


</head>
<div class="popUpRecommend"> 
    <h1>현재 인기있는 팝업스토어</h1>
    <div class="slider-container">
        <button class="arrow leftArrow">&#9664;</button>
        <div class="slider" id="hotPopUpStore">
            <c:forEach var="popUp" items="${popularPopUps}">
                <div class="popUpItem">
                   <div class="popUpLikeCount">❤️ ${popUp.likeCount}</div>
                    <img class="popUpImage" alt="${popUp.psName}">
                    <input type="hidden" class="fileData" value="<c:out value="${popUp.psImg.uuid}_${popUp.psImg.fileName}" />">
                    <div class="popUpText">${popUp.psName}</div>
                </div>
            </c:forEach>
        </div>
        <button class="arrow rightArrow">&#9654;</button>
    </div>

    <br>
   
    <h1>핫한 관심사로 추천!</h1>
    <sec:authorize access="isAuthenticated()">
    <c:forEach var="entry" items="${topStoresByInterestMap}" varStatus="status">
        <h2>
            <c:choose>
                <c:when test="${entry.key.equalsIgnoreCase('healthBeauty')}">건강 & 뷰티</c:when>
                <c:when test="${entry.key.equalsIgnoreCase('game')}">게임</c:when>
                <c:when test="${entry.key.equalsIgnoreCase('culture')}">문화</c:when>
                <c:when test="${entry.key.equalsIgnoreCase('shopping')}">쇼핑</c:when>
                <c:when test="${entry.key.equalsIgnoreCase('supply')}">문구</c:when>
                <c:when test="${entry.key.equalsIgnoreCase('kids')}">키즈</c:when>
                <c:when test="${entry.key.equalsIgnoreCase('design')}">디자인</c:when>
                <c:when test="${entry.key.equalsIgnoreCase('foods')}">식품</c:when>
                <c:when test="${entry.key.equalsIgnoreCase('interior')}">인테리어</c:when>
                <c:when test="${entry.key.equalsIgnoreCase('policy')}">정책</c:when>
                <c:when test="${entry.key.equalsIgnoreCase('character')}">캐릭터</c:when>
                <c:when test="${entry.key.equalsIgnoreCase('experience')}">체험</c:when>
                <c:when test="${entry.key.equalsIgnoreCase('collaboration')}">콜라보</c:when>
                <c:when test="${entry.key.equalsIgnoreCase('entertainment')}">방송</c:when>
                <c:otherwise>기타</c:otherwise>
            </c:choose>
        </h2>
        <div class="slider-container">
            <button class="arrow leftArrow">&#9664;</button>
            <div class="slider" id="hotCatSlider${status.index + 1}">
                <c:forEach var="store" items="${entry.value}">
                    <div class="popUpItem">
                        <input type="hidden" class="fileData" value="${store.psImg.uuid}_${store.psImg.fileName}">
                        <div class="popUpLikeCount">❤️ ${store.likeCount}</div>
                        <img class="popUpImage" alt="${store.psName}">
                        <div class="popUpText">${store.psName}</div>
                    </div>
                </c:forEach>
            </div>
            <button class="arrow rightArrow">&#9654;</button>
        </div>
        <br>
    </c:forEach>
</sec:authorize>




   <sec:authorize access="!isAuthenticated()">
    <c:forEach var="category" items="${topCategoriesByLikesMap}" varStatus="status">
        <h2>
            <c:choose>
                <c:when test="${category.key.equalsIgnoreCase('healthBeauty')}">건강 & 뷰티</c:when>
                <c:when test="${category.key.equalsIgnoreCase('game')}">게임</c:when>
                <c:when test="${category.key.equalsIgnoreCase('culture')}">문화</c:when>
                <c:when test="${category.key.equalsIgnoreCase('shopping')}">쇼핑</c:when>
                <c:when test="${category.key.equalsIgnoreCase('supply')}">문구</c:when>
                <c:when test="${category.key.equalsIgnoreCase('kids')}">키즈</c:when>
                <c:when test="${category.key.equalsIgnoreCase('design')}">디자인</c:when>
                <c:when test="${category.key.equalsIgnoreCase('foods')}">식품</c:when>
                <c:when test="${category.key.equalsIgnoreCase('interior')}">인테리어</c:when>
                <c:when test="${category.key.equalsIgnoreCase('policy')}">정책</c:when>
                <c:when test="${category.key.equalsIgnoreCase('character')}">캐릭터</c:when>
                <c:when test="${category.key.equalsIgnoreCase('experience')}">체험</c:when>
                <c:when test="${category.key.equalsIgnoreCase('collaboration')}">콜라보</c:when>
                <c:when test="${category.key.equalsIgnoreCase('entertainment')}">방송</c:when>
                <c:otherwise>기타</c:otherwise>
            </c:choose>
        </h2>
        <div class="slider-container">
            <button class="arrow leftArrow">&#9664;</button>
            <div class="slider" id="catSlider${status.index + 1}">
                <c:forEach var="store" items="${category.value}">
                    <div class="popUpItem">
                        <div class="popUpLikeCount">❤️ ${store.likeCount}</div>
                        <input type="hidden" class="fileData" value="${store.psImg.uuid}_${store.psImg.fileName}">
                        <img class="popUpImage" alt="${store.psName}">
                        <div class="popUpText">${store.psName}</div>
                    </div>
                </c:forEach>
            </div>
            <button class="arrow rightArrow">&#9654;</button>
        </div>
        <br>
    </c:forEach>
</sec:authorize>

</div>

<div id="map" style="width: 800px; height: 400px; margin: 30px auto; display: flex; justify-content: center;" ></div>


<div class="scroll-btn">
    <button id="scrollUp" aria-label="위로 이동"></button>
    <button id="scrollDown" aria-label="아래로 이동"></button>
</div>


