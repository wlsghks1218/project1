// 결제 수단 체크박스 이벤트
document.getElementById('bankTransfer').addEventListener('change', function() {
   const bankSelect = document.getElementById('bankSelect');
   if (this.checked) {
      bankSelect.style.display = 'block';
   } else {
      bankSelect.style.display = 'none';
   }
});

// 결제하기 버튼 클릭 이벤트
document.getElementById('paymentButton').addEventListener('click', function() {
   const buyerName = document.getElementById('userName').value;
   const buyerEmail = document.getElementById('userEmail').value;
   const buyerPhone = document.getElementById('userNumber').value;
   const deliveryAddress = document.getElementById('deliveryAddress').value;
   const detailedAddress = document.getElementById('detailedAddress').value;
   const deliveryRequest = document.getElementById('deliveryRequest').value;

   const bankTransfer = document.getElementById('bankTransfer').checked;
   const creditCard = document.getElementById('creditCard').checked;
   const mobilePayment = document.getElementById('mobilePayment').checked;
   const virtualAccount = document.getElementById('virtualAccount').checked;

   // 결제 정보 확인
   console.log("구매자 이름: ", userName);
   console.log("이메일: ", userEmail);
   console.log("전화번호: ", userNumber);
   console.log("배송지 주소: ", deliveryAddress);
   console.log("상세 주소: ", detailedAddress);
   console.log("배송 요청 사항: ", deliveryRequest);
   console.log("계좌이체: ", bankTransfer);
   console.log("신용/체크카드: ", creditCard);
   console.log("휴대폰: ", mobilePayment);
   console.log("무통장입금(가상계좌): ", virtualAccount);

   alert("결제가 완료되었습니다!"); // 결제 완료 메시지
});

//배송지 주소 api
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}



////결제하기 버튼 이벤트
//document.getElementById('kakaopay').addEventListener('click', function() {
//    fetch("/purchase/api/kakaopay.cls", {
//        method: 'POST',
//        headers: {
//            'Content-Type': 'application/json'
//        },
//    })
//    .then(response => response.json()) // JSON 형식으로 응답 처리
//    .then(data => {
//        if(data.status === 'success') { // 응답의 status 확인
//            console.log("카카오페이 결제 성공");
//            alert(data.tid); // tid가 포함되어 있어야 함
//        } else {
//            console.log("카카오페이 결제 실패");
//        }
//    })
//    .catch(err => console.log(err));
//});