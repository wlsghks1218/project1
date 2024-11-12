<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>푸터 예제</title>
    <style>
        /* 전체 요소에 대한 기본 스타일 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box; /* 레이아웃 안정성을 위해 box-sizing 설정 */
        }

        /* 푸터 컨테이너 스타일 */
        .footer-container {
            display: flex; /* 유연한 레이아웃을 위한 flexbox 사용 */
            justify-content: space-between; /* 요소 간 간격을 동일하게 분배 */
            padding: 20px; /* 여백 설정 */
            background-color: #f8f8f8; /* 배경 색상 설정 */
            border-top: 1px solid #ccc; /* 상단 테두리 추가 */
        }

        /* 푸터 링크 스타일 */
        .footer-links {
            flex: 1; /* 남은 공간을 균등하게 사용 */
        }

        .footer-links h4 {
            margin-bottom: 10px; /* 제목과 링크 간 간격 설정 */
        }

        .footer-links ul {
            list-style-type: none; /* 리스트 스타일 제거 */
        }

        .footer-links li {
            padding: 5px 0; /* 리스트 아이템 패딩 설정 */
            cursor: pointer; /* 포인터 커서 설정 */
        }

        /* 푸터 연락처 스타일 */
        .footer-contact {
            flex: 1; /* 남은 공간을 균등하게 사용 */
        }

        .footer-contact h4 {
            margin-bottom: 10px; /* 제목과 내용 간 간격 설정 */
        }

        /* 푸터 소셜 미디어 스타일 */
        .footer-social {
            flex: 1; /* 남은 공간을 균등하게 사용 */
        }

        .footer-social h4 {
            margin-bottom: 10px; /* 제목과 링크 간 간격 설정 */
        }

        .footer-social ul {
            list-style-type: none; /* 리스트 스타일 제거 */
        }

        .footer-social li {
            padding: 5px 0; /* 리스트 아이템 패딩 설정 */
            cursor: pointer; /* 포인터 커서 설정 */
        }

        /* 푸터 바닥 스타일 */
        .footer-bottom {
            text-align: center; /* 가운데 정렬 */
            padding: 10px; /* 여백 설정 */
            background-color: #f0f0f0; /* 배경 색상 설정 */
            border-top: 1px solid #ccc; /* 상단 테두리 추가 */
        }
    </style>
</head>
<body>

    <!-- 푸터 내용 -->
    <div class="footer-container">
        <div class="footer-links">
            <h4>링크</h4>
            <ul>
                <li id="aboutLink">회사 소개</li>
                <li id="servicesLink">서비스</li>
                <li id="contactLink">연락처</li>
                <li id="privacyLink">개인정보 처리방침</li>
                <li id="termsLink">이용 약관</li>
            </ul>
        </div>
        <div class="footer-contact">
            <h4>연락처</h4>
            <p>전화: 123-456-7890</p>
            <p>이메일: info@example.com</p>
        </div>
        <div class="footer-social">
            <h4>소셜 미디어</h4>
            <ul>
                <li id="facebookLink">Facebook</li>
                <li id="twitterLink">Twitter</li>
                <li id="instagramLink">Instagram</li>
            </ul>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2024 Your Company Name. 모든 권리 보유.</p>
    </div>

    <!-- 네비게이션 바 -->
    <jsp:include page="popUpNavBar.jsp"/>

</body>
</html>