<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix = "sec" %>  
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="/resources/images/favicon.ico">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    /* 화면 전체 배경 색상 설정 */
    body {
        background-color: #fee7ed;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        height: 100vh;
        margin: 0;
    }

    /* 메인 로고 버튼 스타일 (상단 고정) */
    #mainLogoButton {
        background: none;
        border: none;
        cursor: pointer;
        padding: 0;
        position: relative;
        top: 60px; /* 화면 중앙보다 위에 위치 고정 */
    }

    /* 공통 이미지 스타일 */
    img {
        max-width: none; /* 이미지 크기 제한 해제 */
        height: auto; /* 비율 유지 */
    }

    /* 하위 로고들 애니메이션 초기 설정 */
    #logoContainer {
        margin-top: 10px;
        text-align: center; /* 이미지 수평 정렬 */
        opacity: 0;
        pointer-events: none; /* 초기 상태에서 클릭 불가 */
        transform: translateY(-20px); /* 위에서 아래로 내려오는 초기 위치 */
        transition: opacity 0.8s ease, transform 0.8s ease; /* 애니메이션 효과 */
    }

    /* 하위 로고가 나타날 때 애니메이션 */
    #logoContainer.show {
        opacity: 1;
        pointer-events: auto; /* 표시되면 클릭 가능 */
        transform: translateY(0); /* 원래 위치로 복원 */
    }

    /* 팝업 스토어 로고 */
    #popUpLogo {
        display: inline-block;
        width: 200px; /* 클릭 영역 너비 */
        height: 200px; /* 클릭 영역 높이 */
        margin: 10px; /* 간격 */
        position: relative; /* 위치 조정 가능 */
        top: 0; /* 수직 위치 */
        left: 0; /* 수평 위치 */
    }

    #popUpLogo img {
        width: 100%; /* 클릭 영역에 맞게 이미지 크기 */
        height: auto; /* 비율 유지 */
    }

    /* 굿즈 스토어 로고 */
    #goodsLogo {
        display: inline-block;
        width: 200px; /* 클릭 영역 너비 */
        height: 180px; /* 클릭 영역 높이 */
        margin: 10px;
        position: relative; /* 위치 조정 가능 */
        top: -5px;
        left: 0; /* 수평 위치 */
    }

    #goodsLogo img {
        width: 100%;
        height: auto;
    }

    /* 전시관 로고 */
    #exhibitionLogo {
  display: inline-block;
    width: 400px;
    height: 220px;
    margin: -7px;
    position: relative;
    top: 93px;
    left: 0;
    }

    #exhibitionLogo img {
        width: 100%;
        height: auto;
    }
</style>

</head>
<body>
    <!-- 메인 로고 버튼 -->
    <sec:authorize access="isAuthenticated()">
        <sec:authentication property="principal" var="pinfo"/>
        <input type="hidden" id="userNo" value="${pinfo.member.userNo}">
    </sec:authorize>
    <button id="mainLogoButton" onclick="showLogos()">
        <img src="/resources/images/mainLogo.png" alt="메인 로고">
    </button>

    <!-- 하위 로고들 컨테이너 -->
    <div id="logoContainer">
        <!-- 팝업 스토어 로고 -->
        <a href="/hypePop/popUpMain" id="popUpLogo">
            <img src="/resources/images/popUpLogo.png" alt="팝업 스토어">
        </a>
        <!-- 굿즈 스토어 로고 -->
        <a href="javascript:goToGoodsMain();" id="goodsLogo">
            <img src="/resources/images/goodsLogo.png" alt="굿즈 스토어">
        </a>
        <!-- 전시관 메인 로고 -->
        <a href="/exhibition/exhibitionMain" id="exhibitionLogo">
            <img src="/resources/images/exhibition.png" alt="전시관 메인">
        </a>
    </div>

    <!-- JavaScript 코드 -->
    <script>
        // 로고 컨테이너 보이기/숨기기 애니메이션 처리
        function showLogos() {
            var logoContainer = document.getElementById("logoContainer");
            logoContainer.classList.toggle("show"); // 'show' 클래스 토글로 애니메이션 적용
        }

        // 굿즈 스토어로 이동
        function goToGoodsMain() {
            let userNoElement = document.getElementById("userNo");
            let userNo = userNoElement ? parseInt(userNoElement.value) : null;
            if (userNo) {
                location.href = "/goodsStore/goodsMain?userNo=" + userNo;
            } else {
                location.href = "/goodsStore/goodsMain";
            }
        }
    </script>
</body>
</html>
