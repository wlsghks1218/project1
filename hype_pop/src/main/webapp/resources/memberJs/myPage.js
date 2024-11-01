//// 버튼 클릭 이벤트
//document.querySelectorAll('button').forEach(btn => {
//    btn.addEventListener('click', e => {
//        e.preventDefault();
//        let type = btn.getAttribute('id');  // 버튼의 ID 가져오기
//        
//        // 비밀번호 변경 버튼(모달)
//        if (type === 'newPasswordBtn') {
//            newPasswordModal();  
//        
//        //이메일 변경 버튼(모달)
//        } else if (type === 'newEmailBtn') {
//            sendEmail();  
//        
//        //전화번호 변경 버튼(모달)
//        } else if (type === 'newPhoneNumberBtn') {
//            newPhoneNumModal();
//        
//        //모달 취소 버튼(모달)	
//        } else if (type === 'closeModalBtn') {
//            closeModal();
//        
//        //관심사 변경 버튼(모달)
//        } else if (type === 'newInterestBtn') {
//            newInterestModal();
//
//        //내 댓글 보기 버튼(페이지)
//        } else if (type === 'userReplyBtn') {
//            location.href = '/member/userReply';
//        
//        //장바구니 버튼 클릭(페이지)
//        } else if (type === 'goCartBtn') {
//            location.href = '/member/myCart';
//        
//        //내 결제 목록 클릭(페이지)		
//        } else if (type === 'paymentListBtn') {
//            location.href = '/member/paymentList';
//        
//        //회원탈퇴 버튼 클릭(confirm)
//        } else if (type === 'deleteIdBtn') {
//            deleteId();
//        }		
//    });
//});

// 비밀번호 변경 모달 열기
const newPasswordBtn = document.getElementById('newPasswordBtn');
const foundUserPwModal = document.getElementById('foundUserPwModal');

newPasswordBtn.addEventListener('click', function() {
    foundUserPwModal.style.display = 'block';
});

function submitPwChange() {
    const f = document.getElementById('passwordChangeForm');
    const userPw = f.oldPw.value;
    const newPw = f.newPw.value;
    const checkNewPw = f.checkNewPw.value;

    if (!userPw) {
        alert("비밀번호를 입력하세요");
        return false;
    } else if (!newPw) {
        alert("새 비밀번호를 입력하세요");
        return false;
    } else if (checkNewPw !== newPw) {
        alert("비밀번호가 일치하지 않습니다.");
        return false;
    }
    return true;
}

function closePwModal() {
    foundUserPwModal.style.display = 'none'; // 모달 숨기기
}

// 마이페이지 이메일변경 버튼 클릭
const newEmailBtn = document.getElementById('newEmailBtn');
const customAlert = document.getElementById('customAlert');

// 클릭 이벤트를 중복으로 등록하지 않도록 함수로 감싸기
newEmailBtn.addEventListener('click', function() {
	customAlert.style.display = 'block';
	
	setTimeout(function(){
		customAlert.style.display = 'none';
	}, 2000);
	
	// 이메일 전송 함수 호출
	sendEmail();
});

function sendEmail() {
    const userEmail = document.getElementById('userEmail').value;
    
    // 버튼 비활성화
    newEmailBtn.disabled = true;
    console.log('sendEmail....');
    fetch('/member/api/sendMail/' + userEmail)
    .then(response => response.text())
    .then(data => {
        if (data === 'ok') {
            alert('인증코드가 전송되었습니다.');
            console.log(userEmail);
            // 모달 창 열기
            const modal = document.getElementById('changeUserEmailModal');
            modal.style.display = 'block';
        } else {
            alert('이메일 전송에 실패했습니다. 다시 시도해주세요');
        }
    })
    .catch(err => console.log(err));
}

function verifyEmailCode(){
	const inputCode = document.getElementById('verifyCodeInput').value;
	
	fetch('/member/api/verifyCode?code=' + inputCode)
	.then(response => response.text())
	.then(data => {
		if (data === 'ok') {
			alert('인증 성공! 이메일 변경을 진행하세요!');
		}else{
			alert('인증 코드가 잘못되었습니다.')
		}
	})
	.catch(err => console.log(err));
	
	}



function submitEmailChange() {
	
	
	console.log("submitEmailChange....");
    const f = document.getElementById('EmailChangeForm');
    console.log(f);
    const newEmail = f.newEmail.value.trim(); // 불필요한 공백 제거
    const checkNewEmail = f.checkNewEmail.value.trim(); // 불필요한 공백 제거
    const userNo = f.userNo.value;
    
    if (!newEmail) {
        alert("새 이메일을 입력하세요.");
        console.log("No new email input"); // 
        return false; // 이메일이 입력되지 않으면 전송 중지
    }

    if (!checkNewEmail) {
        alert("이메일을 입력하세요.");
        return false; // 확인 이메일이 입력되지 않으면 전송 중지
    }

    if (newEmail !== checkNewEmail) {
        alert("이메일이 일치하지 않습니다.");
        return false; // 이메일이 일치하지 않으면 전송 중지
    }

   
    location.href=`/member/emailChange?userNo=${userNo}&newEmail=${newEmail}`;
   
}

function closeEmailModal() {
    const modal = document.getElementById('changeUserEmailModal');
    modal.style.display = 'none'; // 모달 숨기기
    // 마이페이지 이메일변경 버튼 클릭
    const newEmailBtn = document.getElementById('newEmailBtn');
    newEmailBtn.disabled = false;
}


const newPhoneNumberBtn = document.getElementById('newPhoneNumberBtn');
const changePhoneNumberModal = document.getElementById('changePhoneNumberModal');

newPhoneNumberBtn.addEventListener('click', function() {
    changePhoneNumberModal.style.display = 'block'; // 모달 표시
}); // 여기에 닫는 중괄호와 세미콜론 추가

const f = document.getElementById('phoneNumberChange');
const userPw = f.oldPw.value;
const newPw = f.newPw.value;
const checkNewPw = f.checkNewPw.value;



function PhoneNumberChange() {
	const f = document.getElementById('phoneNumberChange');
	const userNumber = document.getElementById('userNumber').value;
 	console.log("phoneNumberChange:"+f);
    const oldPhoneNumber = f.oldPhoneNumber.value;
    const newPhoneNumber = f.newPhoneNumber.value;
    const checkNewPhoneNumber = f.checkNewPhoneNumber.value;
    const documentPhoneNum = 
    console.log("oldPhoneNumber :" + oldPhoneNumber );
    
    if (!oldPhoneNumber) {
        alert("전화번호를 입력하세요");
        return false; // 함수 종료
    }else if (userNumber!==oldPhoneNumber) {
    	alert("기존의 전화번호와 일치하지 않습니다.");
    	return false; // 함수 종료
    } else if (!newPhoneNumber) {
        alert("새 전화번호를 입력하세요");
        return false; // 함수 종료
    } else if (checkNewPhoneNumber !== newPhoneNumber) {
        alert("전화번호가 일치하지 않습니다.");
        return false; // 함수 종료
    }
    return true; // 모든 확인 통과 시 true 반환
}


function closePhoneNumModal() {
	changePhoneNumberModal .style.display = 'none'; // 모달 숨기기
}

function slideLeft(sliderId) {
    const slider = document.getElementById(sliderId);
    const lastItem = slider.lastElementChild; // 마지막 아이템을 가져옴
    slider.insertBefore(lastItem, slider.firstChild); // 마지막 아이템을 첫 번째로 이동
}

function slideRight(sliderId) {
    const slider = document.getElementById(sliderId);
    const firstItem = slider.firstElementChild; // 첫 번째 아이템을 가져옴
    slider.appendChild(firstItem); // 첫 번째 아이템을 마지막으로 이동
}


function removePopup(psNo) {
	
	const userNo = document.getElementById('userNo').value;
	
    if (!confirm('정말로 삭제하시겠습니까?')) {
        return; // 사용자가 취소하면 함수를 종료
    }

    console.log('removePopup...');
    console.log(psNo);
    
    fetch(`/member/api/removePopup/${psNo}?userNo=${userNo}`, {
        method: 'DELETE', // DELETE 메서드 사용
        headers: {
            'Content-Type': 'application/json' // 요청 본문이 JSON 형식임을 명시
        }
    })
    .then(response => response.text())
    .then(data => {
        if (data === 'ok') {
            alert('데이터가 삭제됩니다.');
            console.log(psNo);
           
            // 삭제된 팝업스토어를 화면에서 제거
            const popupItem = document.querySelector(`#popup-${psNo}`);
            if (popupItem) {
                popupItem.remove(); // DOM에서 삭제
            }
        } else {
            alert('데이터 삭제에 실패했습니다. 다시 시도해주세요.');
        }
    })
    .catch(err => console.log(err));
}

function removePopup(gno) {
	
	const userNo = document.getElementById('userNo').value;
	
    if (!confirm('정말로 삭제하시겠습니까?')) {
        return; // 사용자가 취소하면 함수를 종료
    }

    console.log('removePopup...');
    console.log(gno);
    
    fetch(`/member/api/removeGoods/${gno}?userNo=${userNo}`, {
        method: 'DELETE', // DELETE 메서드 사용
        headers: {
            'Content-Type': 'application/json' // 요청 본문이 JSON 형식임을 명시
        }
    })
    .then(response => response.text())
    .then(data => {
        if (data === 'ok') {
            alert('데이터가 삭제됩니다.');
         
           
            // 삭제된 팝업스토어를 화면에서 제거
            const goodsItem = document.querySelector(`#goods-${gno}`);
            if (goodsItem) {
            	goodsItem.remove(); // DOM에서 삭제
            }
        } else {
            alert('데이터 삭제에 실패했습니다. 다시 시도해주세요.');
        }
    })
    .catch(err => console.log(err));
}




// 모달 열기
document.getElementById('newInterestBtn').addEventListener('click', function() {
    document.getElementById('userInterestModal').style.display = 'block';
});

// 모달 닫기
function closeModal() {
    document.getElementById('userInterestModal').style.display = 'none';
}

// 관심사 박스 클릭 시 색상 변경
const interestBoxes = document.querySelectorAll('.interestBox');

interestBoxes.forEach(box => {
    box.addEventListener('click', function() {
        // 선택된 박스에 클래스 토글
        this.classList.toggle('selected');
    });
});

// 확인 버튼 클릭 시 처리
document.getElementById('confirmButton').addEventListener('click', function() {
    const selectedInterests = Array.from(interestBoxes)
        .filter(box => box.classList.contains('selected'))
        .map(box => box.dataset.interest);

    // 선택된 관심사로 처리할 로직 추가
    console.log(selectedInterests);
    closeModal(); // 모달 닫기
});


//내가 쓴 글 목록으로 가기
function goToMyReply() {
	location.href="/member/userReply?userNo=2";
}








function deleteId() {
    const isConfirmed = confirm('회원을 탈퇴하시겠습니까?');
    if (isConfirmed) {
        alert("회원 탈퇴 요청을 처리합니다...");
    } else {
        alert("회원 탈퇴가 취소되었습니다.");
    }
}



