<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=v3s0wu5ddz"></script>

<div class="popUpRecommend"> 
    <h1>현재 인기있는 팝업스토어</h1>
    <div class="slider-container">
        <button id="leftArrow" class="arrow">&#9664;</button>
        <div id="hotPopUpStore" class="slider">
            <c:forEach var="popUp" items="${popularPopUps}">
                <span class="popUpItem">${popUp.psName}</span>
            </c:forEach>
        </div>
        <button id="rightArrow" class="arrow">&#9654;</button>
    </div>
    
    <br>
    <h1>핫한 관심사로 추천!</h1>

	<c:forEach var="entry" items="${topStoresByInterest}"
		varStatus="status">
		<h2>${entry.key}</h2>
		<div class="slider-container">
			<button id="leftArrow${status.index + 1}" class="arrow">&#9664;</button>
			<!-- 1부터 시작 -->
			<div id="hotCatSlider${status.index + 1}" class="slider">
				<c:forEach var="store" items="${entry.value}">
					<span class="popUpItem">${store.psName}</span>
				</c:forEach>
			</div>
			<button id="rightArrow${status.index + 1}" class="arrow">&#9654;</button>
		</div>
		<br>
	</c:forEach>

</div>

<div id="map" style="width: 800px; height: 400px; margin: 0 auto; display: flex; justify-content: center;" ></div>
