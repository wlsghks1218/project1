	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> <!-- fn 라이브러리 추가 -->
	<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=v3s0wu5ddz"></script>
<!-- 팝업스토어 배너 및 좋아요 수 -->

<div class="popUpbanner">
    <table>
        <tr>
            <td>
                <h1>
                    <span id="bannerImg">팝업스토어 배너</span>
                </h1>
            </td>
            <td>
                <div id="likeCount_${storeInfo.psNo}">
                    <span id="totalLikeCount">좋아요 수: ${storeInfo.likeCount}</span>
                </div>
            </td>
        </tr>
    </table>
</div>
	<!-- 팝업스토어 정보 -->
	<table class="popUpStoreInfo">
	    <tr>
	        <td id="popUpStoreInfo">
	            <span id="popUpName">${storeInfo.psName}</span>
	            <span id="likeCount">좋아요</span>
	            <h3 id="category">
	                관심사: <span>${storeInfo.interest}</span>
	            </h3>
	            <h3 id="popUpStoreAdd">${storeInfo.psAddress}</h3>
	        </td>
	    </tr>
	    <tr>
	        <td>
	            <h3>${storeInfo.psExp}</h3>
	        </td>
	    </tr>
	</table>
	
	<!-- 팝업스토어 위치 지도 -->
	<div id="map" style="width: 800px; height: 400px; margin: 0 auto; display: flex; justify-content: center;" ></div>
	
	<!-- 기타 정보 -->
	<div id="popUpETCInfo">
	    <h3>주최사 정보: ${storeInfo.comInfo}</h3>
	    <h3>교통편: ${storeInfo.transInfo}</h3>
	    <h3>주차 가능 여부: ${storeInfo.parkingInfo}</h3>
	    <h3>팝업스토어 SNS 주소: ${storeInfo.snsAd}</h3>
	</div>
	
	<!-- 리뷰 작성 폼 -->
	<form id="reviewForm"  style="display:none;">
	    <div class="StarRating" id="newReviewStars">
	        <span data-value="1">★</span>
	        <span data-value="2">★</span>
	        <span data-value="3">★</span>
	        <span data-value="4">★</span>
	        <span data-value="5">★</span>
	    </div>	
	    <textarea id="reviewText" name="reviewText" placeholder="후기를 작성해주세요!" rows="5"></textarea>
	    <input type="hidden" id="rating" name="rating" value="0">
	    <input type="hidden" id="psNo" name="psNo" value="${storeInfo.psNo}">
	    <input type="hidden" id="userNo" name="userNo" value="2">
	    <input type="button" value="등록하기" onclick="send(this.form)">
	</form>
	
	<!-- 작성한 댓글이 없을 때 표시할 메시지 -->
	<p id="noReviewMessage" style="display: none;">작성한 댓글이 없습니다!</p>
	
	<!-- 내가 남긴 후기 -->
	<div id="userReviewSection" style="display:none;">
	    <h2>내가 남긴 후기</h2>
	    <div id="reviewList">
	        <!-- 동적으로 리뷰 목록 추가 -->
	    </div>
	</div>
	
	<form id="updateForm" style="display:none;">
    <div class="StarRating" id="newReviewStars">
        <span data-value="1">★</span>
        <span data-value="2">★</span>
        <span data-value="3">★</span>
        <span data-value="4">★</span>
        <span data-value="5">★</span>
    </div>  
    <textarea id="updateText" name="updateText" placeholder="후기를 수정해주세요!" rows="5"></textarea>
    <input type="hidden" id="rating" name="rating" value="0">
    <input type="hidden" id="psNo" name="psNo" value="${storeInfo.psNo}">
    <input type="hidden" id="userNo" name="userNo" value="100"> 
   <span
    data-storeInfo='{
        "latitude": ${storeInfo.latitude}, 
        "longitude": ${storeInfo.longitude}, 
        "psName": "${fn:escapeXml(storeInfo.psName)}", 
        "psStartDate": "${fn:escapeXml(storeInfo.psStartDate)}", 
        "psEndDate": "${fn:escapeXml(storeInfo.psEndDate)}"
    }'
    data-psNo='${storeInfo.psNo}'>
    </span> 

		<input type="button" value="수정 취소" onclick="updateCancle()">
    <input type="button" value="수정 완료" onclick="update(this.form)">
</form>
<!-- 내가 남긴 후기 아래에 다른 사용자들의 후기를 볼 수 있는 섹션 추가 -->
	<div id="allReviewsSection">
    <h2>다른 사용자가 남긴 후기</h2>
    <div id="allReviewsList">
        <!-- 동적으로 다른 사용자의 리뷰 목록 추가 -->
    </div>
</div>
<div id="pagination">
    <button id="prevPage" onclick="changePage(currentPage - 1)">이전</button>
    <span id="pageNumbers"></span>
    <button id="nextPage" onclick="changePage(currentPage + 1)">다음</button>
</div>
<!-- 체크박스 추가 -->
<label>
    <input type="checkbox" id="toggleGoodsList"> 상품 리스트 출력
</label>
<!-- 인기 상품 배너 -->
<table class="hitGoods" id="goodsTable" style="display: none;"> <!-- 기본적으로 보이지 않게 설정 -->
    <tr>
        <td>
            <span id="popUpGoods1">인기상품 배너1</span>
            <input type="hidden" id="gno1" name="gno1" value="${goodsInfo[0].gno}">
        </td>
        <td>
            <span id="popUpGoods2">인기상품 배너2</span>
            <input type="hidden" id="gno2" name="gno2" value="${goodsInfo[1].gno}">
        </td>
        <td>
            <span id="popUpGoods3">인기상품 배너3</span>
            <input type="hidden" id="gno3" name="gno3" value="${goodsInfo[2].gno}">
        </td>
    </tr>
    <tr>
        <td><span id="popUpGoodsInfo1">${goodsInfo[0].gname} - ${goodsInfo[0].gprice}원</span></td>
        <td><span id="popUpGoodsInfo2">${goodsInfo[1].gname} - ${goodsInfo[1].gprice}원</span></td>
        <td><span id="popUpGoodsInfo3">${goodsInfo[2].gname} - ${goodsInfo[2].gprice}원</span></td>
    </tr>
</table>