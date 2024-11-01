<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.footer-container {
	    display: flex;
	    justify-content: space-between; /* 요소 간의 간격을 균등하게 */
	    padding: 20px; /* 원하는 패딩 추가 */
	    margin: auto;
	    z-index: 1000;
	}
	
	.footer-links,
	.footer-contact,
	.footer-social {
	    flex: 1; /* 각 요소가 같은 비율로 공간을 차지하도록 */
	    margin: 0 10px; /* 요소 간의 마진 추가 */
	    text-align: center;
	}
	
	.footer-bottom {
	    text-align: center; /* 하단 텍스트를 가운데 정렬 */
	    padding: 10px 0; /* 하단 패딩 추가 */
	}
</style>
   <div class="footer-container">
        <div class="footer-links">
            <h4>링크</h4>
            <ul>
                <li id="aboutLink" type="none">회사 소개</li>
                <li id="servicesLink" type="none">서비스</li>
                <li id="contactLink" type="none">연락처</li>
                <li id="privacyLink" type="none">개인정보 처리방침</li>
                <li id="termsLink" type="none">이용 약관</li>
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
                <li id="facebookLink" type="none">Facebook</li>
                <li id="twitterLink" type="none">Twitter</li>
                <li id="instagramLink" type="none">Instagram</li>
            </ul>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2024 Your Company Name. 모든 권리 보유.</p>
    </div>
</html>