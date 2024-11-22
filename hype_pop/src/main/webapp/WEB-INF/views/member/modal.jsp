<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="/resources/images/favicon.ico">
<meta charset="UTF-8">
<title>Insert title here</title>

	<link rel="stylesheet" type="text/css" href="/resources/css/joinPage.css">
</head>
<body>

	<!--개인정보 처리 방침 동의 모달  -->
	<div id="privacyModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal('privacyPolicyModal')">&times;</span>
			 <div id="modalContent">
			<h1>개인정보 처리방침</h1>
			<p>시행일자 : 2024년 10월 18일</p>
			<p>㈜hype pop(이하 "회사")이 운영하는 hype pop은 정보통신망 이용촉진 및 정보보호 등에 관한 법률,
				개인정보보호법, 통신비밀보호법 등 정보통신서비스 제공자가 준수하여야 할 관련 법령상의 개인정보보호 규정을 준수하며, 관련
				법령에 의거한 개인정보처리방침을 정하여 이용자 권익 보호에 최선을 다하고 있습니다. 본 개인정보처리방침은 회사에서 제공하는
				서비스에 적용되며 다음과 같은 내용을 담고 있습니다.</p>

			<h2>1. 개인정보 수집 및 이용 목적</h2>
			<table>
				<tr>
					<th>구분</th>
					<th>이용 목적</th>
				</tr>
				<tr>
					<td>서비스 제공</td>
					<td>- 주문상품의 배송에 대한 정확한 배송정보 확보<br> - 상품구매에 대한 결제 및 환불<br>
						- 개인별 맞춤 서비스 제공 자료
					</td>
				</tr>
				<tr>
					<td>회원가입 및 관리</td>
					<td>- 회원제서비스 이용에 따른 본인식별 및 성인여부<br> - 부정회원 이용방지, 불만사항 등
						민원 처리, 고지사항 전달<br> - 신상품, 신규서비스, 행사안내, 청구서 등 쇼핑”(주)hype pop”
						고지사항 전달<br> - 각종 프로모션 당첨결과 전달
					</td>
				</tr>
				<tr>
					<td>마케팅 및 광고에의 활용</td>
					<td>- 이벤트 및 광고성 정보 제공 및 참여기회 제공<br> - 고객 대상 설문조사<br>
						- 서비스 및 상품 안내<br> - 인구통계학적 마케팅 분석 자료
					</td>
				</tr>
			</table>

			<h2>2. 개인정보 수집 항목 및 방법</h2>
			<h3>가. 개인정보 수집 항목</h3>
			<table>
				<tr>
					<th>구분</th>
					<th>이용항목</th>
					<th>보유기간</th>
				</tr>
				<tr>
					<td>회원 가입 시 수집하는 정보</td>
					<td>아이디, 비밀번호, 이름, 생년월일, 휴대전화번호, 이메일</td>
					<td>회원탈퇴 후 30일 이내 파기</td>
				</tr>
				<tr>
					<td>사업자</td>
					<td>사업장 형태, 상호명, 사업자등록번호, 사업자 등록증, 대표자 성명, 주문자명, 주문자 이메일, 주문자
						휴대전화, 기본주소</td>
					<td></td>
				</tr>
			</table>

			<h3>2) 서비스 제공(계약 이행/요금정산)</h3>
			<table>
				<tr>
					<th>구분</th>
					<th>이용항목</th>
					<th>보유기간</th>
				</tr>
				<tr>
					<td>이벤트 당첨 결과 안내 및 경품 배송</td>
					<td>아이디, 이름, 휴대전화번호, 주소, 이메일</td>
					<td>3년</td>
				</tr>
				<tr>
					<td>물품 배송</td>
					<td>주문자명, 주소, 전화번호, 휴대폰번호, 이메일주소, 아이디/비밀번호(회원 경우), 희망배송일(선택),
						결제기록, 수령자명, 수령자주소, 수령자전화번호, 수령자휴대폰번호</td>
					<td>불법, 편법 행위 방지 및 대응의 목적으로 최대 5년 보관</td>
				</tr>
				<tr>
					<td>구매 및 요금 결제</td>
					<td>아이디, 성명, 결제수단, 카드종류, 승인번호, 할부유형, 결제금액, 할인수단, PG거래번호</td>
					<td></td>
				</tr>
				<tr>
					<td>계좌입금자 환불처리</td>
					<td>계좌번호, 은행명, 예금주명</td>
					<td></td>
				</tr>
				<tr>
					<td>상담 및 불편사항 접수 서비스</td>
					<td>대량구매시 - 업체명, 담당자명, 연락처, 이메일주소<br>불편사항접수 - 고객명(작성자),
						전화번호 또는 휴대폰번호, 이메일주소
					</td>
					<td></td>
				</tr>
			</table>

			<h3>3) 서비스 이용과정에서 생성되는 정보</h3>
			<p>IP Address, 쿠키, 방문 일시, 서비스 이용 기록, 기기정보 등, 모바일 서비스 이용시 모바일
				기기정보(고유기기식별정보, OS 버전)</p>

			<h3>4) 기타 법정 의무 수집 정보 등</h3>
			<table>
				<tr>
					<th>관련 법률</th>
					<th>이용목적</th>
					<th>수집항목</th>
					<th>보유기간</th>
				</tr>
				<tr>
					<td>통신비밀보호법</td>
					<td>수사기관 제공 (법원 영장 등 정당한 절차의 경우에 제공)</td>
					<td>로그기록, IP 등</td>
					<td>3개월</td>
				</tr>
				<tr>
					<td>전자상거래 등에서의 소비자보호에 관한 법률</td>
					<td>소비자의 불만 또는 분쟁처리에 관한 기록</td>
					<td>소비자 식별정보, 분쟁처리 기록 등</td>
					<td>3년</td>
				</tr>
				<tr>
					<td></td>
					<td>대금결제 및 재화 등의 공급에 관한 기록</td>
					<td>소비자 식별정보, 계약/청약철회 기록 등</td>
					<td>5년</td>
				</tr>
				<tr>
					<td></td>
					<td>계약 또는 청약철회 등에 관한 기록</td>
					<td></td>
					<td></td>
				</tr>
			</table>

			<h3>나. 개인정보 수집 방법</h3>
			<p>홈페이지(로그분석), 전자우편, 모사전송(팩스)</p>

			<h2>3. 개인정보 보유 및 이용기간</h2>
			<p>회원의 개인정보는 회원가입을 하는 시점부터 서비스를 제공하는 기간 동안에만 제한적으로 이용되며 회원탈퇴 후
				30일 이내 파기됩니다. 단, 다음의 정보에 대하여는 아래의 사유로 명시한 기간 동안 보존합니다.</p>
			<table>
				<tr>
					<th>목적</th>
					<th>보존 기간</th>
					<th>보존 근거</th>
				</tr>
				<tr>
					<td>계약 또는 청약철회 등에 관한 기록</td>
					<td>5년</td>
					<td>전자상거래 등에서의 소비자보호에 관한 법률</td>
				</tr>
				<tr>
					<td>대금결제 및 재화 등의 공급에 관한 기록</td>
					<td>5년</td>
					<td>전자상거래 등에서의 소비자보호에 관한 법률</td>
				</tr>
				<tr>
					<td>소비자의 불만 또는 분쟁처리에 관한 기록</td>
					<td>3년</td>
					<td>전자상거래 등에서의 소비자보호에 관한 법률</td>
				</tr>
				<tr>
					<td>로그기록, IP 등</td>
					<td>3개월</td>
					<td>통신비밀보호법</td>
				</tr>
			</table>

			<h2>4. 개인정보 제3자 제공</h2>
			<p>회사는 개인정보를 제3자에게 제공하지 않으며, 다만 다음의 경우에는 예외로 합니다.</p>
			<ul>
				<li>이용자의 동의가 있는 경우</li>
				<li>법률에 특별한 규정이 있는 경우</li>
				<li>서비스 제공을 위하여 필요할 경우(상품 배송 등)</li>
			</ul>

			<h2>5. 개인정보 처리 위탁</h2>
			<p>회사는 서비스 제공에 필요한 업무를 외부 업체에 위탁할 수 있으며, 위탁업체는 다음과 같습니다.</p>
			<table>
				<tr>
					<th>업체명</th>
					<th>업무내용</th>
					<th>보유 및 이용기간</th>
				</tr>
				<tr>
					<td>NHN(주)</td>
					<td>결제처리</td>
					<td>상시</td>
				</tr>
				<tr>
					<td>세금계산서</td>
					<td>세금계산서 발행 및 수신업무</td>
					<td>상시</td>
				</tr>
				<tr>
					<td>기타 고객관리</td>
					<td>고객 관리 및 사후 관리</td>
					<td>상시</td>
				</tr>
			</table>

			<h2>6. 이용자 및 법정대리인의 권리와 의무</h2>
			<p>이용자는 언제든지 등록된 개인정보를 열람, 수정, 삭제할 수 있으며, 요청 시에는 즉시 처리가 이루어집니다.
				만약 개인정보가 변경되었을 경우 이용자는 반드시 회원정보를 수정하여야 하며, 이를 이행하지 않을 경우 발생하는 문제에
				대하여 회사는 책임을 지지 않습니다.</p>
			<p>법정대리인은 대리인의 요청 시 다음의 서류를 제출하여 개인정보 열람, 정정, 삭제를 요구할 수 있습니다.</p>
			<ul>
				<li>법정대리인임을 증명할 수 있는 서류</li>
				<li>신청서(소정양식)</li>
			</ul>

			<h2>7. 개인정보의 파기절차 및 파기방법</h2>
			<p>회사는 개인정보 보유기간의 경과 또는 처리 목적 달성 등의 이유로 개인정보가 불필요하게 되었을 경우에는 즉시
				해당 개인정보를 파기합니다. 파기 절차 및 방법은 다음과 같습니다.</p>
			<h3>가. 파기절차</h3>
			<p>개인정보는 보유기간의 경과 후 지체 없이 파기합니다.</p>
			<h3>나. 파기방법</h3>
			<p>전자적 파일 형태의 개인정보는 기록을 재생할 수 없는 방법으로 영구 삭제합니다. 종이에 출력된 개인정보는
				분쇄기로 분쇄하여 파기합니다.</p>

			<h2>8. 개인정보 안전성 확보조치</h2>
			<p>회사는 개인정보의 안전성을 확보하기 위해 다음과 같은 조치를 취하고 있습니다.</p>
			<ul>
				<li>개인정보 접근 제한 조치</li>
				<li>개인정보 암호화 조치</li>
				<li>접속기록 보관 및 위조 방지 조치</li>
				<li>취급 직원의 최소화 및 교육</li>
			</ul>

			<h2>9. 개인정보 보호책임자 및 연락처</h2>
			<p>회사는 개인정보 보호와 관련된 업무를 담당하는 책임자를 두고 있습니다. 개인정보 보호 책임자와 연락처는 아래와
				같습니다.</p>
			<table>
				<tr>
					<th>이름</th>
					<td>홍길동</td>
				</tr>
				<tr>
					<th>직위</th>
					<td>개인정보 보호 책임자</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>전화: 1234-5678<br>이메일: hypepop@hypepop.com
					</td>
				</tr>
			</table>

			<h2>10. 개인정보 처리방침의 변경</h2>
			<p>본 개인정보 처리방침은 변경될 수 있으며, 변경 시 홈페이지를 통해 공지합니다.</p>
			</div>
			<button onclick="closePolicyModal()">닫기</button>
		</div>
	</div>
	
	
	
	<!--위치기반서비스 동의 모달  -->
	<div id="locationModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal('privacyPolicyModal')">&times;</span>
			 <div id="modalContent">
			 <h1>위치기반 서비스 이용약관</h1>
    
    <h2>제 1 조 (목적)</h2>
    <p>이 약관은 네이버 주식회사 (이하 “회사”)가 제공하는 위치기반서비스와 관련하여 회사와 개인위치정보주체와의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.</p>

    <h2>제 2 조 (약관 외 준칙)</h2>
    <p>이 약관에 명시되지 않은 사항은 위치정보의 보호 및 이용 등에 관한 법률, 개인정보보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 전기통신기본법, 전기통신사업법 등 관계법령과 회사의 이용약관 및 개인정보처리방침, 회사가 별도로 정한 지침 등에 의합니다.</p>

    <h2>제 3 조 (서비스 내용 및 요금)</h2>
    <ol>
        <li>회사는 위치정보사업자로부터 위치정보를 전달받아 아래와 같은 위치기반서비스를 제공합니다.
            <ol>
                <li>GeoTagging 서비스: 게시물 또는 이용자가 저장하는 콘텐츠에 포함된 개인위치정보주체 또는 이동성 있는 기기의 위치정보가 게시물과 함께 저장됩니다. 저장된 위치정보는 별도의 활용없이 보관되거나, 또는 장소를 기반으로 콘텐츠를 분류하거나 검색할 수 있는 기능이 제공될 수도 있습니다.</li>
                <li>위치정보를 활용한 검색결과 및 콘텐츠 제공: 정보 검색을 요청하거나 개인위치정보주체 또는 이동성 있는 기기의 위치정보를 제공 시 본 위치정보를 이용한 검색결과, 주변결과(맛집, 주변업체, 교통수단 등), 번역결과를 제시합니다.</li>
                <li>이용자 위치를 활용한 광고정보 제공: 검색결과 또는 기타 서비스 이용 과정에서 개인위치정보주체 또는 이동성 있는 기기의 위치를 이용하여 광고소재를 제시합니다.</li>
                <li>이용자 보호 및 부정 이용 방지: 개인위치정보주체 또는 이동성 있는 기기의 위치를 이용하여 권한없는 자의 비정상적인 서비스 이용 시도 등을 차단합니다.</li>
                <li>길 안내 등 생활편의 서비스 제공: 교통정보와 길 안내 등 최적의 경로를 지도로 제공하며, 주변 시설물 찾기, 뉴스/날씨 등 생활정보, 긴급구조 서비스, 주소 자동 입력 등 다양한 운전 및 생활 편의 서비스를 제공합니다.</li>
            </ol>
        </li>
        <li>제1항 위치기반서비스의 이용요금은 무료입니다.</li>
    </ol>

    <h2>제 4 조 (개인위치정보주체의 권리)</h2>
    <ol>
        <li>개인위치정보주체는 개인위치정보 수집 범위 및 이용약관의 내용 중 일부 또는 개인위치정보의 이용ㆍ제공 목적, 제공받는 자의 범위 및 위치기반서비스의 일부에 대하여 동의를 유보할 수 있습니다.</li>
        <li>개인위치정보주체는 개인위치정보의 수집ㆍ이용ㆍ제공에 대한 동의의 전부 또는 일부를 철회할 수 있습니다.</li>
        <li>개인위치정보주체는 언제든지 개인위치정보의 수집ㆍ이용ㆍ제공의 일시적인 중지를 요구할 수 있습니다. 이 경우 회사는 요구를 거절하지 아니하며, 이를 위한 기술적 수단을 갖추고 있습니다.</li>
        <li>개인위치정보주체는 회사에 대하여 아래 자료의 열람 또는 고지를 요구할 수 있고, 당해 자료에 오류가 있는 경우에는 그 정정을 요구할 수 있습니다. 이 경우 회사는 정당한 이유 없이 요구를 거절하지 아니합니다.
            <ol>
                <li>개인위치정보주체에 대한 위치정보 수집ㆍ이용ㆍ제공사실 확인자료</li>
                <li>개인위치정보주체의 개인위치정보가 위치정보의 보호 및 이용 등에 관한 법률 또는 다른 법령의 규정에 의하여 제3자에게 제공된 이유 및 내용</li>
            </ol>
        </li>
        <li>회사는 개인위치정보주체가 동의의 전부 또는 일부를 철회한 경우에는 지체 없이 수집된 개인위치정보 및 위치정보 수집ㆍ이용ㆍ제공사실 확인자료를 파기합니다. 단, 동의의 일부를 철회하는 경우에는 철회하는 부분의 개인위치정보 및 위치정보 수집ㆍ이용ㆍ제공사실 확인자료에 한합니다.</li>
        <li>개인위치정보주체는 제1항 내지 제4항의 권리행사를 위하여 이 약관 제13조의 연락처를 이용하여 회사에 요구할 수 있습니다.</li>
    </ol>

    <h2>제 5 조 (법정대리인의 권리)</h2>
    <ol>
        <li>회사는 만14세 미만 아동으로부터 개인위치정보를 수집ㆍ이용 또는 제공하고자 하는 경우에는 만14세 미만 아동과 그 법정대리인의 동의를 받아야 합니다.</li>
        <li>법정대리인은 만14세 미만 아동의 개인위치정보를 수집ㆍ이용ㆍ제공에 동의하는 경우 동의유보권, 동의철회권 및 일시중지권, 열람ㆍ고지요구권을 행사할 수 있습니다.</li>
    </ol>

    <h2>제 6 조 (위치정보 이용ㆍ제공사실 확인자료 보유근거 및 보유기간)</h2>
    <p>회사는 위치정보의 보호 및 이용 등에 관한 법률 제16조 제2항에 근거하여 개인위치정보주체에 대한 위치정보 수집ㆍ이용ㆍ제공사실 확인자료를 위치정보시스템에 자동으로 기록하며, 6개월 이상 보관합니다.</p>

    <h2>제 7 조 (서비스의 변경 및 중지)</h2>
    <ol>
        <li>회사는 위치기반서비스사업자의 정책변경 등과 같이 회사의 제반 사정 또는 법률상의 장애 등으로 서비스를 유지할 수 없는 경우, 서비스의 전부 또는 일부를 제한, 변경하거나 중지할 수 있습니다.</li>
        <li>제1항에 의한 서비스 중단의 경우에는 회사는 사전에 인터넷 등에 공지하거나 개인위치정보주체에게 통지합니다.</li>
    </ol>

    <h2>제 8 조 (개인위치정보 제3자 제공 시 즉시 통보)</h2>
    <ol>
        <li>회사는 개인위치정보주체의 동의 없이 당해 개인위치정보주체의 개인위치정보를 제3자에게 제공하지 아니하며, 제3자 제공 서비스를 제공하는 경우에는 제공받는 자 및 제공목적을 사전에 개인위치정보주체에게 고지하고 동의를 받습니다.</li>
        <li>회사는 개인위치정보를 개인위치정보주체가 지정하는 제3자에게 제공하는 경우에는 개인위치정보를 수집한 당해 통신단말장치로 매회 개인위치정보주체에게 제공받는 자, 제공일시 및 제공목적을 즉시 통보합니다.</li>
        <li>다만, 아래에 해당하는 경우에는 개인위치정보주체가 미리 특정하여 지정한 통신단말장치 또는 전자우편주소 등으로 통보합니다.
            <ol>
                <li>개인위치정보를 수집한 당해 통신단말장치가 문자, 음성 또는 영상의 수신기능을 갖추지 아니한 경우</li>
                <li>개인위치정보주체가 개인위치정보를 수집한 당해 통신단말장치 외의 통신단말장치 또는 전자우편주소 등으로 통보할 것을 미리 요청한 경우</li>
            </ol>
        </li>
    </ol>

    <h2>제 9 조 (분쟁의 해결)</h2>
    <p>회사는 개인위치정보주체와 위치기반서비스에 관한 분쟁이 발생한 경우에는 해당 개인위치정보주체가 제기하는 분쟁에 대해 지체없이 원만하게 해결하기 위해 노력합니다.</p>

    <h2>제 10 조 (면책)</h2>
    <p>회사는 천재지변 또는 이에 준하는 불가항력으로 인하여 위치기반서비스를 제공할 수 없는 경우에는 그로 인한 손해를 배상하지 않습니다.</p>

    <h2>제 11 조 (약관의 변경)</h2>
    <ol>
        <li>회사는 필요한 경우 이 약관을 변경할 수 있습니다.</li>
        <li>약관을 변경하는 경우에는 변경내용을 명시하여 그 변경사항이 적용되는 날로부터 7일 이전에 인터넷 홈페이지에 공지합니다.</li>
    </ol>

    <h2>제 12 조 (관할법원)</h2>
    <p>이 약관에 관한 분쟁에 대해서는 서울중앙지방법원을 관할법원으로 합니다.</p>

    <h2>제 13 조 (연락처)</h2>
    <p>회사의 연락처는 아래와 같습니다.<br>
    회사명: hype pop주식회사<br>
    전화번호: 1234-5678<br>
    이메일: hypepop@hypepop.com</p>

    <h2>부칙</h2>
    <p>이 약관은 2024년 10월 18일부터 시행합니다.</p>
		</div>
		</div>
	</div>

	
	<!--마케팅 알림 수신 동의 안내  -->
	
	<div id="notificationModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal('privacyPolicyModal')">&times;</span>
			 <div id="modalContent">
			 <h1>마케팅 알림 수신 동의 안내</h1>
    
			    <p>주식회사 브레이브모바일(이하 “회사”)은 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 관계 법령에 따라, 마케팅 알림을 전송하기 위해 수신자(이하 “귀하”)의 사전 수신 동의를 받고 있습니다.</p>
			
			    <p>귀하가 마케팅 알림 수신에 동의한 경우, 회사는 SMS/LMS/MMS 메시지, 앱 푸시 알림, 이메일을 통하여 마케팅 알림을 발송할 수 있으며, 이용안내 등 서비스 이용에 필수적으로 안내되어야 하는 정보성 내용은 본 수신 동의 여부와 무관하게 제공됩니다.</p>
			
			    <p>귀하는 마케팅 알림 수신을 원하지 않을 경우 회사에 대해 전자우편(hypepop@hypepop.com)을 전송하여 광고성 정보 수신 동의의 철회를 요청하실 수 있습니다.</p>
			
			    <p>귀하가 본 마케팅 알림 수신에 동의하지 않으셔도 서비스 이용이 가능합니다. 다만, 동의를 거부할 경우 혜택 알림 서비스 등을 원활히 이용할 수 없습니다.</p>
				
			</div>
		</div>
	</div>
	
	
	








	<!--아이디 찾기 모달  -->
	<div id="foundUserIdModal">
		<div class="modal-content">
			<div class="modal-title">
				<a>아이디 찾기</a>
			</div>
			<hr>
			<div class="modal-body">
				<ul class="chat">

					<div>
						<p>
							<input type="text" name="name" placeholder="이름 입력">
						</p>
					</div>
					<div>
						<span> <input type="email" name="email"
							placeholder="이메일 입력"></span>
						<button type="button" class="btn btn-sec" id="submitEmail">전송</button>
					</div>
					<div>
						<span> <input type="number" name="verifyCode"
							placeholder="인증코드 입력"></span>
						<button type="button" class="btn btn-sec" id="submitCode">확인</button>
					</div>
				</ul>
			</div>
		</div>
	</div>


	<br>
	<br>
	<br>


	<!--비밀번호 찾기 모달  -->
	<div id="foundUserPwModal">
		<div class="modal-content">
			<div class="modal-title">
				<a>비밀번호 찾기</a>
			</div>
			<hr>
			<div class="modal-body">
				<ul class="chat">

					<div>
						<p>
							<input type="text" name="name" placeholder="이름 입력">
						</p>
					</div>
					<div>
						<span> <input type="email" name="email"
							placeholder="이메일 입력"></span>
						<button type="button" class="btn btn-sec" id="submitEmail">전송</button>
					</div>
					<div>
						<span> <input type="number" name="verifyCode"
							placeholder="인증코드 입력"></span>

						<button type="button" class="btn btn-sec" id="submitCode">확인</button>
					</div>
				</ul>
			</div>
		</div>
	</div>



	<br>
	<br>
	<br>



	<!--비밀번호 변경 모달  -->
	<div id="foundUserPwModal">
		<div class="modal-content">
			<div class="modal-title">
				<a>비밀번호 변경</a>
			</div>
			<hr>
			<div class="modal-body">
				<ul class="chat">

					<div>
						<p>
							<input type="password" name="oldPassword"
								placeholder="기존 비밀번호 입력">
						</p>
					</div>
					<div>
						<p>
							<input type="password" name="newPassword"
								placeholder="신규 비밀번호 입력">
						</p>
					</div>
					<div>
						<span> <input type="number" name="verifyCode"
							placeholder="인증코드 입력"></span>
					</div>
				</ul>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-sec" id="submitPwChange">비밀번호
					변경</button>
			</div>
		</div>
	</div>


	<br>
	<br>
	<br>


	<!--이메일 변경 모달  -->
	<div id="newEmailModal">
		<div class="modal-content">
			<div class="modal-title">
				<a>이메일 변경</a>
			</div>
			<hr>
			<div class="modal-body">
				<ul class="chat">

					<div>
						<p>
							<input type="email" name="oldEmail" placeholder="기존 이메일 입력">
						</p>
					</div>
					<div>
						<p>
							<input type="email" name="newEmail" placeholder="신규 이메일 입력">
						</p>
					</div>
					<div>
						<span> <input type="number" name="verifyCode"
							placeholder="인증코드 입력"></span>
					</div>
				</ul>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-sec" id="submitNewEmail">이메일
					변경</button>
			</div>
		</div>
	</div>


	<br>
	<br>
	<br>


	<!--전화번호 변경 모달  -->
	<div id="newPhoneNumberModal">
		<div class="modal-content">
			<div class="modal-title">
				<a>전화번호 변경</a>
			</div>
			<hr>
			<div class="modal-body">
				<ul class="chat">

					<div>
						<p>
							<input type="nember" name="oldPhoneNum" placeholder="기존 전화번호 입력">
						</p>
					</div>
					<div>
						<p>
							<input type="number" name="newPhoneNum" placeholder="신규 전화번호 입력">
						</p>
					</div>
					<div>
						<span> <input type="number" name="verifyCode"
							placeholder="인증코드 입력"></span>
					</div>
				</ul>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-sec" id="submitNewPhoneNum">전화번호변경</button>
			</div>
		</div>
	</div>


	<br>
	<br>
	<br>








	<script type="text/javascript" src="/resources/memberJs/joinPage.js"></script>

</body>
</html>