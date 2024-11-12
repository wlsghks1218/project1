let selectedInterests = [];
const MIN_INTERESTS = 3;
// 비밀번호 변경 모달 열기
const newPasswordBtn = document.getElementById('newPasswordBtn');
const foundUserPwModal = document.getElementById('foundUserPwModal');

newPasswordBtn.addEventListener('click', function() {
    foundUserPwModal.style.display = 'block';
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

// 클릭 이벤트를 중복으로 등록하지 않도록 함수로 감싸기
newEmailBtn.addEventListener('click', function() {
   customAlert.style.display = 'block';
   
   setTimeout(function(){
      customAlert.style.display = 'none';
   }, 2000);
   
   newEmailModal.style.display = 'block';
   
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
    
    alert("이메일을 변경했습니다.");

   
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
// const userPw = f.oldPw.value;
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

function removeGoods(gno) {
   
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






// 내가 쓴 글 목록으로 가기
function goToMyReply() {
   location.href="/member/userReply?userNo=2";
}

// 장바구니 가기
// document.getElementById('goCartBtn').addEventListener('click', function() {
// location.href = "member/purchase/goCart;" // 실제 장바구니 페이지 URL로 교체
// });


// 장바구니로 가기
function goToMyCart(){
   
   
   location.href="/purchase/goCart?userNo=2";
}


// 내 결제 목록 가기
function getPayList(userNo){
   
   location.href=`/purchase/getPayList?userNo=${userNo}`;

}

// 마이페이지 굿즈 스토어 이미지 가져오기
// function setBackgroundImage(item) {
// const fileNameAndUuid = item.getAttribute('data-file-name'); // 각 아이템의
// data-file-name에서 가져오기
// const [uuid, fileName] = fileNameAndUuid.split('_');
//    
// console.log(`UUID: ${uuid}, File Name: ${fileName}`);
//
// // Use the uuid and fileName in the fetch URL
// fetch(`/goodsStore/images/${encodeURIComponent(fileNameAndUuid)}`)
// .then(response => response.blob())
// .then(blob => {
// const imageUrl = URL.createObjectURL(blob);
// item.style.backgroundImage = `url(${imageUrl})`;
// item.style.backgroundSize = "cover";
// item.style.backgroundPosition = "center center";
// item.style.backgroundRepeat = "no-repeat";
// })
// .catch(error => {
// console.error("이미지를 불러오는 중 오류 발생: ", error);
// });
// }




//이미지 배경을 fetch로 가져오기
function setBackgroundImage(item) {
    const fileNameAndUuid = item.getAttribute("data-file-name");

       // 파일명과 UUID를 분리
       const [uuid, fileName] = fileNameAndUuid.split('_');

       // UUID와 파일명을 포함시켜 보낼 파일명 생성
       const combinedFileName = `${uuid}_${fileName}`;

       console.log(`UUID: ${uuid}, File Name: ${fileName}, Combined File Name: ${combinedFileName}`);

       // 서버에서 이미지를 비동기적으로 불러오기
       fetch(`/goodsStore/images/${encodeURIComponent(combinedFileName)}`)

        .then(response => response.blob())  // 이미지를 Blob 형태로 받음
        .then(blob => {
            const imageUrl = URL.createObjectURL(blob);  // Blob을 URL로 변환
            item.style.backgroundImage = `url(${imageUrl})`;  // 배경이미지로 설정
            item.style.backgroundSize = "cover";  // 배경 이미지 사이즈 설정
            item.style.backgroundPosition = "center center";  // 배경 이미지 위치 설정
            item.style.backgroundRepeat = "no-repeat";  // 배경 이미지 반복 설정
        })
        .catch(error => {
            console.error("이미지를 불러오는 중 오류 발생: ", error);
        });
}

// 마이페이지 굿즈 이미지를 로드할 때 호출
//document.querySelectorAll('.image-item').forEach(item => {
//    setBackgroundImage(item.querySelector('.image'));  // 각 아이템에 대해 이미지 로드
//});




function deleteId() {
    const isConfirmed = confirm('회원을 탈퇴하시겠습니까?');
    if (isConfirmed) {
        alert("회원 탈퇴 요청을 처리합니다...");
    } else {
        alert("회원 탈퇴가 취소되었습니다.");
    }}

// //최소 3개 선택을 확인하는 함수
// function validateSelectedInterests() {
// const checkboxes = document.querySelectorAll('.interestBox
// input[type="checkbox"]');
// const selectedCount = Array.from(checkboxes).filter(checkbox =>
// checkbox.checked).length;
//
// if (selectedCount < 3) {
// document.getElementById('limitMessage').style.display = 'block';
// return false;
// } else {
// document.getElementById('limitMessage').style.display = 'none';
// return true;
// }
// }

// 관심사 선택 모달 열기
function openInterestModal() {
    document.getElementById('userInterest').style.display = 'block';
}

// 관심사 선택 모달 닫기
function closeInterestModal() {
    document.getElementById('userInterest').style.display = 'none';
}
function saveInterests() {
      const formData = new FormData();

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
           alert("관심사 3개를 선택해주세요.");
           return; // 서버로 전송하지 않음
       }
       
       // 서버로 POST 요청
       fetch('/member/api/updateUserInterests?userNo=2', {
           method: 'POST',
           body: formData
       })
       .then(response => response.json())
       .then(data => {
           console.log("관심사 업데이트 결과:", data);
           
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



// let selectedInterests = []; // 전역에서 배열을 정의
// const MIN_INTERESTS = 3; // 최소 관심사 수
//
// // 모달 표시 함수
// function openInterestModal() {
// const interestModal = document.getElementById('userInterest');
// interestModal.style.display = 'flex'; // 모달 표시
// }
//
// // 모달 닫기 함수
// function closeModal() {
// const interestModal = document.getElementById('userInterest');
// interestModal.style.display = 'none'; // 모달 숨기기
// }
//
// // 관심사 선택 이벤트
// document.querySelectorAll('.interestBox').forEach((box) => {
// box.addEventListener('click', e => {
// const interBox = e.currentTarget; // div 내에 속한 요소들을 눌러도 div 요소를 찾도록
// const ckBox = interBox.querySelector('input[type="checkbox"]'); // div 요소 내의
// checkbox 찾기
//
// // 최소 3개 이상 선택 체크
// if (selectedInterests.length >= MIN_INTERESTS &&
// !interBox.classList.contains('selectedBox')) {
// alert("최소 3개를 선택해야 합니다.");
// return;
// }
//
// // 체크박스 상태 업데이트
// if (!interBox.classList.contains('selectedBox')) {
// interBox.classList.add('selectedBox'); // div 요소에 스타일 부여
// ckBox.checked = true;
// selectedInterests.push(ckBox.name); // 선택한 관심사 배열에 추가
// } else {
// interBox.classList.remove('selectedBox'); // div 요소에 스타일 해제
// ckBox.checked = false;
// selectedInterests = selectedInterests.filter(item => item !== ckBox.name); //
// 선택한 관심사 제외
// }
//
// console.log("현재 선택된 관심사:", selectedInterests); // 배열 상태 확인
// });
// });
//
// // 관심사 저장 함수
// function saveInterests() {
// if (selectedInterests.length < MIN_INTERESTS) {
// document.getElementById('limitMessage').style.display = 'block'; // 최소 3개 선택
// 메시지 표시
// return;
// }
//
// // 선택된 관심사 배열을 서버로 전송하는 로직
// console.log("선택된 관심사:", selectedInterests);
// closeModal(); // 모달 닫기
// }
