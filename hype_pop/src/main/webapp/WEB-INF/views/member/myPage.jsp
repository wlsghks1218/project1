<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
}

/* Header */
header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px 20px;
	background-color: #eee;
	border-bottom: 2px solid #ccc;
}

header .home-btn, header .search-btn {
	background-color: #f5a9bc;
	border: none;
	padding: 10px;
	cursor: pointer;
}

header .search-bar {
	flex-grow: 1;
	margin: 0 20px;
}

header .search-bar input {
	width: 100%;
	padding: 10px;
	border: none;
	border-bottom: 2px solid #ccc;
	outline: none;
}

/* Form Layout */
.form-section {
	width: 60%;
	margin: 20px auto;
	font-size: 14px;
}

.form-section h2 {
	text-align: center;
	margin-bottom: 20px;
	font-size: 24px;
}

.form-item {
	margin-bottom: 20px; /* 아래 요소와의 간격 */
	position: relative;
}

.form-item label {
	display: block;
	font-size: 14px;
	margin-bottom: 5px;
}

.form-item input {
	width: 100%;
	padding: 5px 0;
	border: none;
	border-bottom: 2px solid #ccc;
	outline: none;
}

.form-item button {
	position: absolute;
	top: 10px;
	right: 0;
	padding: 5px 10px;
	background-color: #ccc;
	border: none;
	cursor: pointer;
	font-size: 12px;
}

/* 댓글 버튼 스타일 */
.comment-btn {
	margin-top: 10px; /* 버튼과 위 요소 간 간격 */
	text-align: right;
}

/* Image Grid for Stores and Goods */
.image-grid {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 10px;
	margin: 20px 0;
}

.image-item {
	position: relative;
	text-align: center;
}

.image-item img {
	width: 100%;
	height: auto;
	cursor: pointer;
}

.image-item button {
	position: absolute;
	top: 5px;
	right: 5px;
	background-color: red;
	color: white;
	border: none;
	cursor: pointer;
}

/* Button section */
.btn-section {
	display: flex;
	justify-content: space-between;
	margin: 30px 0;
}

/* Footer */
footer {
	text-align: center;
	margin: 40px 0;
}

/* Navigation Bar */
nav {
	position: fixed;
	bottom: 0;
	left: 0;
	width: 100%;
	background-color: #ccc;
	text-align: center;
}

nav a {
	margin: 10px;
	text-decoration: none;
	color: black;
}

#foundUserPwModal, #changeUserEmailModal, #changePhoneNumberModal {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	display: none;
	z-index: 1000;
	background-color: white;
	border-radius: 10px;
	padding: 20px;
}

/* 모달 창 컨텐츠 */
.modal-content {
	background-color: white;
	padding: 20px;
	width: 350px; /* 가로 크기 줄이기 */
	border-radius: 10px; /* 둥근 모서리 */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	text-align: center;
	position: relative; /* X 버튼 위치를 위한 상대적 위치 */
}

/* 모달 제목 */
.modal-title {
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 20px;
}

/* 모달 내부의 폼 */
.modal-body .form-group {
	margin-bottom: 15px;
}

/* 모달의 제출 버튼 */
.modal-footer {
	text-align: center;
}

/* 모달 안에 있는 input 박스 스타일링 */
.modal-input {
	width: calc(100% - 20px); /* 가로 크기 줄이기, padding을 고려 */
	height: 40px; /* 세로 크기 */
	padding: 10px; /* 내부 여백 */
	font-size: 16px; /* 글자 크기 */
	box-sizing: border-box; /* padding 포함하여 전체 크기 계산 */
	margin: 10px 0; /* 바깥 여백 추가 */
}

/* X 버튼 스타일링 */
.close {
	position: absolute;
	top: 10px;
	right: 10px; /* 오른쪽 여백 줄여서 안쪽으로 이동 */
	font-size: 24px;
	font-weight: bold;
	color: #aaa;
	cursor: pointer;
	transition: color 0.3s ease;
}

.close:hover {
	color: #000; /* 호버 시 색상 변경 */
}

/*인증코드를 전송중입니다 창  */
#customAlert {
	position: fixed;
	top: 10%;
	left: 50%;
	transform: translate(-50%, -50%);
	display: none;
	z-index: 1000;
	background-color: pink;
	border-radius: 30px;
	padding: 20px;
}

.slider-container {
	display: flex;
	align-items: center;
	position: relative;
}

.image-grid {
	display: flex;
	overflow: hidden;
	width: 100%; /* 또는 원하는 크기 */
}

.image-item {
	flex: 0 0 25%; /* 한 번에 4개 보이도록 설정 */
	box-sizing: border-box;
	padding: 10px;
}

.arrow {
	background-color: transparent;
	border: none;
	font-size: 2em;
	cursor: pointer;
	z-index: 1; /* 버튼이 이미지 위에 오도록 설정 */
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
}

.left {
	left: 10px; /* 좌측 화살표 위치 */
}

.right {
	right: 10px; /* 우측 화살표 위치 */
}
.userInterest {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
    z-index: 1000;
    padding: 20px;
}

.modal-background {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    z-index: 999;
}

.interestBox {
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    margin: 5px 0;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.interestBox.selected {
    background-color: #007bff; /* 선택된 박스 색상 */
    color: white; /* 선택된 박스 텍스트 색상 */
}

.confirm-button {
    background-color: #007bff; /* 확인 버튼 색상 */
    color: white; /* 확인 버튼 텍스트 색상 */
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.confirm-button:hover {
    background-color: #0056b3; /* 확인 버튼 호버 색상 */
}
</style>

</head>
<body>
	<header>
		<button class="home-btn">홈</button>
		<div class="search-bar">
			<input type="text" placeholder="검색">
		</div>
		<button class="search-btn">검색</button>
	</header>

	<div class="form-section">
		<h2>마이페이지</h2>

		<div class="form-item">
			<label for="userName">이름</label> <input type="text" id="userName"
				value="${userInfo.userName}" readonly>
		</div>

		<div class="form-item">
			<label for="userId">아이디</label> <input type="text" id="userId"
				value="${userInfo.userId}" readonly>
		</div>

		<div class="form-item">
			<label for="userPw">비밀번호</label> <input type="password" id="userPw"
				value="**********" readonly>
			<button type="button" class="btn btn-sec" id="newPasswordBtn">비밀번호
				변경</button>
		</div>

		<div class="form-item">
			<label for="userEmail">이메일</label> <input type="email" id="userEmail"
				value="${userInfo.userEmail}" readonly>
			<button type="button" class="btn btn-sec" id="newEmailBtn">이메일
				변경</button>
			<div id="customAlert">인증코드를 전송 중입니다.</div>
		</div>

		<div class="form-item">
			<label for="userNumber">전화번호</label> <input type="text"
				id="userNumber" value="${userInfo.userNumber}" readonly>
			<button type="button" class="btn btn-sec" id="newPhoneNumberBtn">전화번호
				변경</button>
		</div>

		<!--관심사 배열  -->
		<%-- 		<%
       	String[] interestNames = {
       		 "헬스/뷰티", 
             "게임", 
             "문화", 
             "쇼핑", 
             "문구", 
             "키즈", 
             "디자인", 
             "식품", 
             "인테리어", 
             "정책", 
             "캐릭터", 
             "체험", 
             "콜라보", 
             "방송"	
       	};
       %>  --%>




		<div class="form-item">
			<label for="userInterest">관심사</label>
			<c:if test="${userInterests.healthBeauty == 1}">
				<span>헬스/뷰티</span>
			</c:if>
			<c:if test="${userInterests.game == 1}">
				<span>게임</span>
			</c:if>
			<c:if test="${userInterests.culture == 1}">
				<span>문화</span>
			</c:if>
			<c:if test="${userInterests.shopping == 1}">
				<span>쇼핑</span>
			</c:if>
			<c:if test="${userInterests.supply == 1}">
				<span>문구</span>
			</c:if>
			<c:if test="${userInterests.kids == 1}">
				<span>키즈</span>
			</c:if>
			<c:if test="${userInterests.design == 1}">
				<span>디자인</span>
			</c:if>
			<c:if test="${userInterests.foods == 1}">
				<span>식품</span>
			</c:if>
			<c:if test="${userInterests.interior == 1}">
				<span>인테리어</span>
			</c:if>
			<c:if test="${userInterests.policy == 1}">
				<span>정책</span>
			</c:if>
			<c:if test="${userInterests.character == 1}">
				<span>캐릭터</span>
			</c:if>
			<c:if test="${userInterests.experience == 1}">
				<span>체험</span>
			</c:if>
			<c:if test="${userInterests.collaboration == 1}">
				<span>콜라보</span>
			</c:if>
			<c:if test="${userInterests.entertainment == 1}">
				<span>방송</span>
			</c:if>
			<button type="button" class="btn btn-sec" id="newInterestBtn">관심사
				변경</button>

		</div>

		<div class="comment-btn">
			<button type="button" class="btn btn-sec" id="userReplyBtn" onclick="goToMyReply()" >내
				댓글 보기</button>
		</div>

	</div>


	<div class="form-section">
		<h3>좋아요한 팝업스토어</h3>
		<input type="hidden" value="2" name="userNo" id="userNo"> 
		<div class="slider-container">
			<button class="arrow left" onclick="slideLeft('popupSlider')">❮</button>
			<div class="image-grid" id="popupSlider">
				<c:forEach var="popup" items="${pLikeList}">
					<div class="image-item" id="popup-${popup.psNo}">
						<img src="${popup.uploadPath}/${popup.uuid}_${popup.fileName}"
							alt="${popup.psName}" onclick="goToPopupDetail(${popup.psNo})">
						<button onclick="removePopup(${popup.psNo})">X</button>
					</div>
				</c:forEach>
			</div>
			<button class="arrow right" onclick="slideRight('popupSlider')">❯</button>
		</div>

		<h3>좋아요한 굿즈</h3>
		<div class="slider-container">
		<input type="hidden" value="2" name="userNo" id="userNo"> 
			<button class="arrow left" onclick="slideLeft('goodsSlider')">❮</button>
			<div class="image-grid" id="goodsSlider">
				<c:forEach var="goods" items="${gLikeList}">
					<div class="image-item" id="goods-${goods.gno}">
						<c:if test="${not empty goods.gname}">
							<img src="${goods.uploadPath}/${goods.uuid}_${goods.fileName}"
								alt="${goods.gname}" onclick="goToPopupDetail(${goods.gno})">
						</c:if>
						<button onclick="removePopup(${goods.gno})">X</button>
					</div>
				</c:forEach>
			</div>
			<button class="arrow right" onclick="slideRight('goodsSlider')">❯</button>
		</div>
		<div class="btn-section">
			<button type="button" class="btn btn-sec" id="goCartBtn">장바구니</button>
			<button type="button" class="btn btn-sec" id="paymentListBtn">내
				결제 목록</button>
			<button type="button" class="btn btn-sec" id="deleteIdBtn"
				style="background-color: red; color: white;">회원 탈퇴</button>
		</div>
	</div>

	<!-- 	<div class="image-item">
				<img src="popup1.jpg" alt="팝업스토어1" onclick="goToPopupDetail(1)">
				<button onclick="removePopup(1)">X</button>
			</div>
			<div class="image-item">
				<img src="popup2.jpg" alt="팝업스토어2" onclick="goToPopupDetail(2)">
				<button onclick="removePopup(2)">X</button>
			</div>
			<div class="image-item">
				<img src="popup3.jpg" alt="팝업스토어3" onclick="goToPopupDetail(3)">
				<button onclick="removePopup(3)">X</button>
			</div>
			<div class="image-item">
				<img src="popup4.jpg" alt="팝업스토어4" onclick="goToPopupDetail(4)">
				<button onclick="removePopup(4)">X</button>
			</div> -->



	<!-- 	<div class="image-item">
				<img src="goods1.jpg" alt="굿즈1" onclick="goToGoodsDetail(1)">
				<button onclick="removeGoods(1)">X</button>
			</div>
			<div class="image-item">
				<img src="goods2.jpg" alt="굿즈2" onclick="goToGoodsDetail(2)">
				<button onclick="removeGoods(2)">X</button>
			</div>
			<div class="image-item">
				<img src="goods3.jpg" alt="굿즈3" onclick="goToGoodsDetail(3)">
				<button onclick="removeGoods(3)">X</button>
			</div>
			<div class="image-item">
				<img src="goods4.jpg" alt="굿즈4" onclick="goToGoodsDetail(4)">
				<button onclick="removeGoods(4)">X</button>
			</div> -->

	<!-- 관심사 변경  -->





	<footer>footer</footer>

	<nav>
		<a href="#">팝업스토어 검색</a> <a href="#">굿즈 검색</a> <a href="#">내 주변</a> <a
			href="#">캘린더</a> <a href="#">로그인</a>
	</nav>


	<!--///////////////모달 창//////////////  -->


	<!--비밀번호 변경 모달-->
	<div id="foundUserPwModal" style="display: none;">
		<div class="modal-content">
			<!-- X 버튼 추가 -->
			<span class="close" onclick="closePwModal()">&times;</span>
			<form action="passwordChange?userNo=${userNo}" method="get"
				id="passwordChangeForm" onsubmit="return submitPwChange()">
				<div class="modal-body">
					<div class="form-group">
						<p>
							<input type="password" class="modal-input" name="oldPw"
								placeholder="기존 비밀번호 입력" required>
						</p>
					</div>
					<div class="form-group">
						<p>
							<input type="password" class="modal-input" name="newPw"
								placeholder="신규 비밀번호 입력" required>
						</p>
					</div>
					<div class="form-group">
						<span> <input type="password" class="modal-input"
							name="checkNewPw" placeholder="신규 비밀번호 확인" required>
						</span>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-sec">비밀번호 변경</button>
				</div>


			</form>
		</div>
	</div>
	<!--이메일 변경 모달  -->

	<div id="changeUserEmailModal" style="display: none;">
		<div class="modal-content">
			<!-- X 버튼 추가 -->
			<span class="close" onclick="closeEmailModal()">&times;</span>
			<form id="EmailChangeForm">
				<div class="modal-body">
					<div class="form-group">
						<!--userNo 히든 처리  -->
						<input type="hidden" value="5" name="userNo"> <span>
							<input type="number" class="modal-input" name="verifyCode"
							id="verifyCodeInput" placeholder="코드 입력" required>
						</span>
						<button type="button" id=sendEmailCode class="btn btn-sec"
							onclick="verifyEmailCode()">코드 확인</button>
					</div>
					<div class="form-group">
						<p>
							<input type="email" class="modal-input" name="newEmail"
								placeholder="신규 이메일 입력" required>
						</p>
					</div>
					<div class="form-group">
						<span> <input type="email" class="modal-input"
							name="checkNewEmail" placeholder="신규 이메일 확인" required>
						</span>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-sec"
						onclick="submitEmailChange()">이메일 변경</button>
				</div>


			</form>
		</div>
	</div>

	<!-- 전화번호 변경 모달 -->
	<div id="changePhoneNumberModal" style="display: none;">
		<div class="modal-content">
			<!-- X 버튼 추가 -->
			<span class="close" onclick="closePhoneNumModal()">&times;</span>
			<form action="phoneNumberChange?userNo=${userNo}" method="get"
				id="phoneNumberChange">
				<div class="modal-body">
					<input id="userNo" type="hidden" value="2" name="userNo">
					<div class="form-group">
						<p>
							<input type="text" class="modal-input" name="oldPhoneNumber"
								placeholder="기존 전화번호 입력">
						</p>
					</div>
					<div class="form-group">
						<p>
							<input type="text" class="modal-input" name="newPhoneNumber"
								placeholder="신규 전화번호 입력">
						</p>
					</div>
					<div class="form-group">
						<span> <input type="text" class="modal-input"
							name="checkNewPhoneNumber" placeholder="신규 전화번호 확인">
						</span>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-sec"
						onclick="return PhoneNumberChange()">전화번호 변경</button>
				</div>
			</form>
		</div>
	</div>


<div id="userInterestModal"  class="userInterest" style="display: none;">
    <div class="modal-background" onclick="closeModal()"></div>
    <div class="interestBoxContainer">
        <div>
            <p>관심사를 선택하세요(최소 3개 선택)</p>
        </div>
        <div class="interestBox" data-interest="헬스/뷰티">
            <label>헬스/뷰티</label>
        </div>
        <div class="interestBox" data-interest="게임">
            <label>게임</label>
        </div>
        <div class="interestBox" data-interest="문화">
            <label>문화</label>
        </div>
        <div class="interestBox" data-interest="쇼핑">
            <label>쇼핑</label>
        </div>
        <div class="interestBox" data-interest="문구">
            <label>문구</label>
        </div>
        <div class="interestBox" data-interest="키즈">
            <label>키즈</label>
        </div>
        <div class="interestBox" data-interest="디자인">
            <label>디자인</label>
        </div>
        <div class="interestBox" data-interest="식품">
            <label>식품</label>
        </div>
        <div class="interestBox" data-interest="인테리어">
            <label>인테리어</label>
        </div>
        <div class="interestBox" data-interest="정책">
            <label>정책</label>
        </div>
        <div class="interestBox" data-interest="캐릭터">
            <label>캐릭터</label>
        </div>
        <div class="interestBox" data-interest="체험">
            <label>체험</label>
        </div>
        <div class="interestBox" data-interest="콜라보">
            <label>콜라보</label>
        </div>
        <div class="interestBox" data-interest="방송">
            <label>방송</label>
        </div>
        <div>
            <button id="confirmButton" class="confirm-button" >확인</button>
        </div>
    </div>
</div>



	<script type="text/javascript" src="/resources/memberJs/myPage.js"></script>


</body>

</html>
