let selectedInterests = [];
const MIN_INTERESTS = 3;
// 비밀번호 변경 모달 열기
const newPasswordBtn = document.getElementById('newPasswordBtn');
const foundUserPwModal = document.getElementById('foundUserPwModal');

newPasswordBtn.addEventListener('click', function() {
    foundUserPwModal.style.display = 'block';
});

document.querySelectorAll('.image-goodsItem').forEach(item => {
    // data-file-name 속성에서 파일 이름을 가져옴
    const fileName = item.getAttribute('data-file-name');
    const imgElement = item.querySelector('img'); // 각 image-goodsItem 내부의 img 요소를 찾음

    // 이미지 파일이 존재할 경우에만 요청 수행
    if (fileName && imgElement) {
        fetch(`/member/api/goodsBannerImages/${encodeURIComponent(fileName)}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error("이미지를 불러오는 데 실패했습니다.");
                }
                return response.blob();
            })
            .then(blob => {
                const imageUrl = URL.createObjectURL(blob); // Blob을 URL로 변환
                imgElement.src = imageUrl; // img 태그의 src로 설정
                imgElement.style.width = "100px"; // 너비 설정
                imgElement.style.height = "100px"; // 높이 설정
            })
            .catch(error => {
                console.error("이미지 불러오기 오류:", error);
            });
    }
});

document.querySelectorAll('.image-popupItem').forEach(item => {
    // data-file-name 속성에서 파일 이름을 가져옴
    const fileName = item.getAttribute('data-file-name');
    const imgElement = item.querySelector('img'); // 각 image-goodsItem 내부의 img 요소를 찾음

    // 이미지 파일이 존재할 경우에만 요청 수행
    if (fileName && imgElement) {
        fetch(`/member/api/popupImages/${encodeURIComponent(fileName)}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error("이미지를 불러오는 데 실패했습니다.");
                }
                return response.blob();
            })
            .then(blob => {
                const imageUrl = URL.createObjectURL(blob); // Blob을 URL로 변환
                imgElement.src = imageUrl; // img 태그의 src로 설정
                imgElement.style.width = "100px"; // 너비 설정
                imgElement.style.height = "100px"; // 높이 설정
            })
            .catch(error => {
                console.error("이미지 불러오기 오류:", error);
            });
    }
});

document.querySelectorAll('.image-exhItem').forEach(item => {
    // data-file-name 속성에서 파일 이름을 가져옴
    const fileName = item.getAttribute('data-file-name');
    const imgElement = item.querySelector('img'); // 각 image-goodsItem 내부의 img 요소를 찾음

    // 이미지 파일이 존재할 경우에만 요청 수행
    if (fileName && imgElement) {
        fetch(`/member/api/exhImges/${encodeURIComponent(fileName)}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error("이미지를 불러오는 데 실패했습니다.");
                }
                return response.blob();
            })
            .then(blob => {
                const imageUrl = URL.createObjectURL(blob); // Blob을 URL로 변환
                imgElement.src = imageUrl; // img 태그의 src로 설정
                imgElement.style.width = "100px"; // 너비 설정
                imgElement.style.height = "100px"; // 높이 설정
            })
            .catch(error => {
                console.error("이미지 불러오기 오류:", error);
            });
    }
});





function submitPwChange() {
    const f = document.getElementById('passwordChangeForm');
    // const userPw = f.oldPw.value;
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
const newEmailModal = document.getElementById('changeUserEmailModal');
const sendEmailBtn = document.getElementById('sendEmailBtn');


//이메일 변경 모달 열기
newEmailBtn.addEventListener('click', function() {
    newEmailModal.style.display = 'block'; // 모달 표시
});

//이메일 전송 함수
sendEmailBtn.addEventListener('click', function() {
    const userEmail = document.getElementById('userEmail').value;

    if (!userEmail) {
        alert("이메일을 입력하세요.");
        return;
    }

    // 이메일 전송 함수 호출
    sendEmail(userEmail);
    
	customAlert.style.display = 'block';
	
	setTimeout(function(){
		customAlert.style.display = 'none';
	}, 2000);
});


function sendEmail() {
    const userEmail = document.getElementById('userEmail').value;
    
    // 버튼 비활성화
    newEmailBtn.disabled = true;
    fetch('/member/api/sendMail/' + userEmail)
    .then(response => response.text())
    .then(data => {
        if (data === 'ok') {
            alert('인증코드가 전송되었습니다.');
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
	
	
    const f = document.getElementById('EmailChangeForm');
    const newEmail = f.newEmail.value.trim(); // 불필요한 공백 제거
    const checkNewEmail = f.checkNewEmail.value.trim(); // 불필요한 공백 제거
	const userNoElement = document.getElementById("userNo");
	const userNo = userNoElement ? userNoElement.value : null;

    if (!newEmail) {
        alert("새 이메일을 입력하세요.");
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
    
    alert("이메일을 변경했습니다.");

   
    location.href=`/member/emailChange?userNo=${userNo}&newEmail=${newEmail}`;
   
}

function closeEmailModal() {
    const modal = document.getElementById('changeUserEmailModal');
    
    alert('이메일 변경을 취소하시겠습니까?');
    
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
// const userPw = f.oldPw.value;
const newPw = f.newPw.value;
const checkNewPw = f.checkNewPw.value;



function PhoneNumberChange() {
	const f = document.getElementById('phoneNumberChange');
	const userNumber = document.getElementById('userNumber').value;
    const oldPhoneNumber = f.oldPhoneNumber.value;
    const newPhoneNumber = f.newPhoneNumber.value;
    const checkNewPhoneNumber = f.checkNewPhoneNumber.value;
  //  const documentPhoneNum = console.log("oldPhoneNumber :" + oldPhoneNumber );
    
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
	changePhoneNumberModal.style.display = 'none'; // 모달 숨기기
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
	
	const userNoElement = document.getElementById("userNo");
	const userNo = userNoElement ? userNoElement.value : null;
	
    if (!confirm('정말로 삭제하시겠습니까?')) {
        return; // 사용자가 취소하면 함수를 종료
    }

    
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

function removeGoods(gno) {
	
	const userNoElement = document.getElementById("userNo");
	const userNo = userNoElement ? userNoElement.value : null;
	
    if (!confirm('정말로 삭제하시겠습니까?')) {
        return; // 사용자가 취소하면 함수를 종료
    }

    
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

function removeExh(exhNo) {
	
	const userNoElement = document.getElementById("userNo");
	const userNo = userNoElement ? userNoElement.value : null;

	
    if (!confirm('정말로 삭제하시겠습니까?')) {
        return; // 사용자가 취소하면 함수를 종료
    }

    
    fetch(`/member/api/removeExh/${exhNo}?userNo=${userNo}`, {
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
            const exhNoItem = document.querySelector(`#exh-${exhNo}`);
            if (exhNoItem) {
            	exhNoItem.remove(); // DOM에서 삭제
            }
        } else {
            alert('데이터 삭제에 실패했습니다. 다시 시도해주세요.');
        }
    })
    .catch(err => console.log(err));
}



// 내가 쓴 글 목록으로 가기
function goToMyReply() {
	const userNoElement = document.getElementById("userNo");
	const userNo = userNoElement ? userNoElement.value : null;

    location.href = `/member/userReply?userNo=${userNo}`;
}




// 장바구니로 가기
function goToMyCart(){
	const userNoElement = document.getElementById("userNo");
	const userNo = userNoElement ? userNoElement.value : null;
	location.href=`/purchase/goCart?userNo=${userNo}`;
}


// 내 결제 목록 가기
function getPayList(){
	const userNoElement = document.getElementById("userNo");
	const userNo = userNoElement ? userNoElement.value : null;
	
	location.href=`/purchase/getPayList?userNo=${userNo}`;

}









function deleteId() {
    const isConfirmed = confirm('회원을 탈퇴하시겠습니까?');
    if (isConfirmed) {
        alert("회원 탈퇴 요청을 처리합니다...");
    } else {
        alert("회원 탈퇴가 취소되었습니다.");
    }}


// 관심사 선택 모달 열기
function openInterestModal() {
    document.getElementById('userInterest').style.display = 'block';
    
 // 현재 선택된 관심사를 JavaScript에서 확인합니다.
    const selectedInterests = document.querySelectorAll('#userInterestDisplay span');
    const selectedInterestNames = Array.from(selectedInterests).map(span => span.textContent.trim());

 // 각 체크박스를 확인하여 선택된 관심사에 포함되면 checked 상태로 만듭니다.
    document.querySelectorAll('.interestBox input[type="checkbox"]').forEach(checkbox => {
        const interestName = checkbox.closest('.interestBox').getAttribute('data-interest');
        checkbox.checked = selectedInterestNames.includes(interestName);
    });
    
    // 알림 메시지 숨기기
    document.getElementById('limitMessage').style.display = 'none';
    
}



// 관심사 선택 모달 닫기
function closeInterestModal() {
    document.getElementById('userInterest').style.display = 'none';
}


//관심사 선택 제한 체크 함수
function checkInterestLimit() {
    const selectedCount = document.querySelectorAll('.interestBox input[type="checkbox"]:checked').length;
    const limitMessage = document.getElementById('limitMessage');

    if (selectedCount > 3) {
        limitMessage.style.display = 'block';
        limitMessage.textContent = '관심사는 최대 3개만 선택 가능합니다.';
    } else {
        limitMessage.style.display = 'none';
    }
}


function saveInterests() {
	
	
	
		
	   const formData = new FormData();
		const userNoElement = document.getElementById("userNo");
		const userNo = userNoElement ? userNoElement.value : null;
	

	    // 관심사 데이터 수집 후 FormData에 추가
	    formData.append("healthBeauty", document.querySelector('input[name="userInterest.healthBeauty"]').checked ? 1 : 0);
	    formData.append("game", document.querySelector('input[name="userInterest.game"]').checked ? 1 : 0);
	    formData.append("culture", document.querySelector('input[name="userInterest.culture"]').checked ? 1 : 0);
	    formData.append("shopping", document.querySelector('input[name="userInterest.shopping"]').checked ? 1 : 0);
	    formData.append("supply", document.querySelector('input[name="userInterest.supply"]').checked ? 1 : 0);
	    formData.append("kids", document.querySelector('input[name="userInterest.kids"]').checked ? 1 : 0);
	    formData.append("design", document.querySelector('input[name="userInterest.design"]').checked ? 1 : 0);
	    formData.append("foods", document.querySelector('input[name="userInterest.foods"]').checked ? 1 : 0);
	    formData.append("interior", document.querySelector('input[name="userInterest.interior"]').checked ? 1 : 0);
	    formData.append("policy", document.querySelector('input[name="userInterest.policy"]').checked ? 1 : 0);
	    formData.append("character", document.querySelector('input[name="userInterest.character"]').checked ? 1 : 0);
	    formData.append("experience", document.querySelector('input[name="userInterest.experience"]').checked ? 1 : 0);
	    formData.append("collaboration", document.querySelector('input[name="userInterest.collaboration"]').checked ? 1 : 0);
	    formData.append("entertainment", document.querySelector('input[name="userInterest.entertainment"]').checked ? 1 : 0);

	    
	    
	    // 개별적으로 선택된 체크박스의 개수를 셈
	    let selectedCount = 0;
	    const interestNames = [
	        "healthBeauty", "game", "culture", "shopping", "supply", "kids", 
	        "design", "foods", "interior", "policy", "character", "experience", 
	        "collaboration", "entertainment"
	    ];

	    // 각 체크박스를 돌면서 선택된 개수를 셈
	    interestNames.forEach(name => {
	        const checkbox = document.querySelector(`input[name="userInterest.${name}"]`);
	        if (checkbox && checkbox.checked) {
	            selectedCount++;
	        }
	    });

	    // 선택된 체크박스가 3개가 아니면 전송하지 않음
	    if (selectedCount !== 3) {
	       
	        document.getElementById('limitMessage').style.display = 'block';
	        return; // 서버로 전송하지 않음
	    }
	    

	    
	    // 서버로 POST 요청
	    fetch(`/member/api/updateUserInterests?userNo=${userNo}`, {
	        method: 'POST',
	        body: formData
	    })
	    .then(response => response.json())
	    .then(data => {
	        
	     // 관심사 업데이트 후, 해당 HTML 요소를 업데이트
	        updateInterestDisplay(data.updatedInterests); 
	        alert('관심사를 변경하시겠습니까?');
	        closeInterestModal();
	        
	    })
	    .catch(error => {
	        console.error("업데이트 중 에러 발생:", error);
	    });
	};
	
	
// 관심사 항목을 HTML에 업데이트
function updateInterestDisplay(updatedInterests) {
	    const interestList = [
	        { key: 'healthBeauty', label: '헬스/뷰티 ' },
	        { key: 'game', label: '게임 ' },
	        { key: 'culture', label: '문화 ' },
	        { key: 'shopping', label: '쇼핑 ' },
	        { key: 'supply', label: '문구 ' },
	        { key: 'kids', label: '키즈 ' },
	        { key: 'design', label: '디자인 ' },
	        { key: 'foods', label: '식품 ' },
	        { key: 'interior', label: '인테리어 ' },
	        { key: 'policy', label: '정책 ' },
	        { key: 'character', label: '캐릭터 ' },
	        { key: 'experience', label: '체험 ' },
	        { key: 'collaboration', label: '콜라보 ' },
	        { key: 'entertainment', label: '방송 ' }
	    ];


	    let updatedHTML = '';
	    interestList.forEach(interest => {
	        if (updatedInterests[interest.key] == 1) {
	            updatedHTML += `<span>${interest.label}</span>`;
	        }
	    });

	    // 관심사 영역에 업데이트된 HTML을 삽입
	    document.getElementById('userInterestDisplay').innerHTML = updatedHTML;
	}


//회원 탈퇴

function deleteUserData(userNo) {
    fetch(`/member/api/deleteUserData/${userNo}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(response => response.json())
    .then(result => {
        if (result.success) {
            alert('회원 탈퇴가 완료되었습니다.');
            // 리다이렉트하거나 다른 화면으로 이동
            window.location.href = '/member/goodBye';
        } else {
            alert('회원 탈퇴 중 오류가 발생했습니다. 다시 시도해 주세요.');
        }
    })
    .catch(error => {
        alert('회원 탈퇴 처리 중 문제가 발생했습니다.');
        console.error('Error:', error);
    });
}
