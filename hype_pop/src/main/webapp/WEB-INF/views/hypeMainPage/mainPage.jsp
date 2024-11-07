<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
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
        top: -30px; /* 화면 중앙보다 위에 위치 고정 */
    }

    /* 하위 로고들 애니메이션 초기 설정 */
    #logoContainer {
        margin-top: 10px;
        text-align: center;
        opacity: 0;
        pointer-events: none;
        transform: translateY(-20px); /* 위에서 아래로 내려오는 초기 위치 */
        transition: opacity 0.8s ease, transform 0.8s ease; /* 투명도와 위치 이동 애니메이션 */
    }

    /* 하위 로고가 나타날 때 애니메이션 */
    #logoContainer.show {
        opacity: 1;
        pointer-events: auto;
        transform: translateY(0); /* 원래 위치로 내려옴 */
    }
</style>
</head>
<body>
    <!-- 메인 로고 버튼 -->
    <button id="mainLogoButton" onclick="showLogos()">
        <img src="/resources/images/mainLogo.png" alt="메인 로고">
    </button>

    <!-- 하위 로고들 컨테이너 -->
    <div id="logoContainer">
        <a href="/hypePop/popUpMain">
            <img src="/resources/images/popUpLogo.png" alt="팝업 스토어">
        </a>
        <a href="/goodsStore/goodsMain">
            <img src="/resources/images/goodsLogo.png" alt="굿즈 스토어">
        </a>
        <a href="/exhibition/exhibitionMain" id="exhibition">
            <img src="/resources/images/exhibition.png" alt="전시관 메인">
        </a>
    </div>

    <!-- JavaScript 코드 -->
    <script>
        function showLogos() {
            var logoContainer = document.getElementById("logoContainer");
            logoContainer.classList.toggle("show"); // 'show' 클래스 토글로 애니메이션 적용
        }
    </script>
</body>
</html>
