<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> <!-- fn 라이브러리 추가 -->
	<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=v3s0wu5ddz"></script>
<!-- 팝업스토어 배너 및 좋아요 수 -->
<!-- 팝업스토어 배너 및 좋아요 수 --><div class="popUpbanner">
    <div class="banner-container">
        <!-- 배너 이미지를 삽입하는 img 태그 -->
        <img id="popupBannerImage" >
        <input type="hidden" class="fileData" value="<c:out value="${storeInfo.psImg.uuid}_${storeInfo.psImg.fileName}" />">
        <div class="likeCount" id="likeCount_${storeInfo.psNo}">
            <span id="totalLikeCount">❤️ ${storeInfo.likeCount}</span>
        </div>
    </div>
</div>

<!-- 팝업스토어 정보 -->
<div class="popUpStoreInfo">
    <table>
        <tr>
            <td id="popUpStoreInfo">
                <span id="popUpName">${storeInfo.psName}</span>
                <button id="likeCount">
           <img id="likeIcon" src="/resources/images/emptyHeart.png" alt="Like" width="24">
                 </button>
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
</div>
	<!-- 팝업스토어 위치 지도 -->
	<div id="map" 
	style="width: 800px; 
	height: 400px; 
	margin: 0 auto; 
	display: flex; 
	justify-content: center;" ></div>
	
	<!-- 기타 정보 -->
	<div id="popUpETCInfo">
	    <h3>주최사 정보: ${storeInfo.comInfo}</h3>
	    <h3>교통편: ${storeInfo.transInfo}</h3>
	    <h3>주차 가능 여부: ${storeInfo.parkingInfo}</h3>
	    <h3>팝업스토어 SNS 주소: ${storeInfo.snsAd}</h3>
	</div>
<!-- 전체 리뷰 래퍼 -->
<div id="reviewWrapper">

    <!-- 평균 별점 섹션 -->
    <h2>후기들</h2>
    <div id="popUpScoreAvg">
        <span>평균 별점: </span>
        <span id="averageRating">${storeInfo.avgRating}</span>
    </div>

    <!-- 리뷰 작성 폼 -->
    <form id="reviewForm" style="display:none;">
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
        <input type="hidden" id="userNo"  name="userNo" value="${pinfo.member.userNo}">
   	
        <input type="button" value="등록하기" onclick="send(this.form)">
    </form>


    <!-- 내가 남긴 후기 -->
    <div id="userReviewSection" style="display:none;">
        <div id="reviewList">
            <!-- 동적으로 리뷰 목록 추가 -->
        </div>
    </div>

    <!-- 후기 수정 폼 -->
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
        <span data-storeInfo='{
            "latitude": ${storeInfo.latitude}, 
            "longitude": ${storeInfo.longitude}, 
            "psName": "${fn:escapeXml(storeInfo.psName)}", 
            "psStartDate": "${fn:escapeXml(storeInfo.psStartDate)}", 
            "psEndDate": "${fn:escapeXml(storeInfo.psEndDate)}"
        }' data-psNo='${storeInfo.psNo}'></span> 
        <input type="button" value="수정 취소" onclick="updateCancel()">
        <input type="button" value="수정 완료" onclick="update(this.form)">
    </form>

    <!-- 다른 사용자의 후기 섹션 -->
    <div id="allReviewsSection">
        <div id="allReviewsList">
            <!-- 동적으로 다른 사용자의 리뷰 목록 추가 -->
        </div>
    </div>

    <!-- 페이지 네비게이션 -->
    <div id="pagination">
        <button id="prevPage" onclick="changePage(currentPage - 1)">이전</button>
        <span id="pageNumbers"></span>
        <button id="nextPage" onclick="changePage(currentPage + 1)">다음</button>
    </div>
    
</div>



<c:if test="${not empty goodsInfo}">
    <label>
        <input type="checkbox" id="toggleGoodsList"> 상품 리스트 출력
    </label>
    <div class="hitGoods" id="goodsList" style="display: none;">
        <div class="goodsItem" id="goodsItem1">
            <c:if test="${not empty goodsInfo[0]}">
                <div class="goodsInfo" id="goodsImg1">
                    <input type="hidden" 
                           value="${goodsInfo[0].attachList[0].uuid}_${goodsInfo[0].attachList[0].fileName}" 
                           id="fileName1">
                    <input type="hidden" id="gno1" name="gno1" value="${goodsInfo[0].gno}">
                    <img id="image1" src="" alt="상품 이미지" class="goodsImage">
                    <div class="goodsDetails">
                        <span class="productName">${goodsInfo[0].gname}</span>
                        <span class="productPrice">${goodsInfo[0].gprice}원</span>
                    </div>
                </div>
            </c:if>
        </div>
        <div class="goodsItem" id="goodsItem2">
            <c:if test="${not empty goodsInfo[1]}">
                <div class="goodsInfo" id="goodsImg2">
                    <input type="hidden" 
                           value="${goodsInfo[1].attachList[0].uuid}_${goodsInfo[1].attachList[0].fileName}" 
                           id="fileName2">
                    <input type="hidden" id="gno2" name="gno2" value="${goodsInfo[1].gno}">
                    <img id="image2" src="" alt="상품 이미지" class="goodsImage">
                    <div class="goodsDetails">
                        <span class="productName">${goodsInfo[1].gname}</span>
                        <span class="productPrice">${goodsInfo[1].gprice}원</span>
                    </div>
                </div>
            </c:if>
        </div>
        <div class="goodsItem" id="goodsItem3">
            <c:if test="${not empty goodsInfo[2]}">
                <div class="goodsInfo" id="goodsImg3">
                    <input type="hidden" 
                           value="${goodsInfo[2].attachList[0].uuid}_${goodsInfo[2].attachList[0].fileName}" 
                           id="fileName3">
                    <input type="hidden" id="gno3" name="gno3" value="${goodsInfo[2].gno}">
                    <img id="image3" src="" alt="상품 이미지" class="goodsImage">
                    <div class="goodsDetails">
                        <span class="productName">${goodsInfo[2].gname}</span>
                        <span class="productPrice">${goodsInfo[2].gprice}원</span>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</c:if>

<div id="loginModal" class="modal">
   <div class="modal-content">
      <span class="close">&times;</span>
      <p>로그인이 필요한 기능입니다.</p>
      <button id="goToLogin" onclick="location.href='/member/login'">로그인하러 가기</button>
   </div>
</div>
<div class="scroll-btn">
    <button id="scrollUp" aria-label="위로 이동"></button>
    <button id="scrollDown" aria-label="아래로 이동"></button>
</div>

