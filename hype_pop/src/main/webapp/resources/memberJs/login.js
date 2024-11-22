// 각종 아이디
const searchIdBtn = document.getElementById('searchIdBtn');
const customAlert = document.getElementById('customAlert');

document.getElementById('redirect').value = document.referrer;
const urlParams = new URLSearchParams(window.location.search);
if (urlParams.has('error')) {
    alert("아이디 또는 비밀번호가 잘못되었습니다.");
    window.location.href = "/member/login";
}


//로그페이지 아이디 찾기 버튼 클릭
searchIdBtn.addEventListener('click', function() {
   const searchIdModal = document.getElementById('searchIdModal');
   // 아이디 찾기 모달 창 오픈
   searchIdModal.style.display = 'block';
});

function closeSearchIdModal() {
	   const searchIdModal = document.getElementById('searchIdModal');
	
	   searchIdModal.style.display = 'none';
}

const sendEmailBtn = document.getElementById('sendEmailBtn');


// 이메일 전송 버튼 클릭
sendEmailBtn.addEventListener('click', function() {
   const userEmail = document.getElementById('userEmail').value;
   const userName = document.getElementById('userName').value;

   // 이메일 체크 비동기(post)
   fetch('/member/api/checkEmail', {
      method: 'POST',
      headers: {
         'Content-Type': 'application/json'
      },
      body: JSON.stringify({ userEmail: userEmail, userName: userName })
   })
   .then(response => response.text())
   .then(data => {
      if (data === 'exists') {
         customAlert.style.display = 'block';
        
           setTimeout(function(){
           customAlert.style.display = 'none';
        }, 2000);

        비동기
         return fetch('/member/api/sendMail/' + userEmail)
            .then(response => response.text())
            .then(result => {
               if (result === 'ok') {
                  
               } else {
                  alert('이메일 전송에 실패했습니다. 다시 시도해주세요');
               }
            });
      } else {
         alert('등록되지 않은 이메일입니다.');
      }
   })
   .catch(err => console.log(err));
});


function verifyEmailCode(){
   const inputCode = document.getElementById('verifyCodeInput').value;
   
   fetch('/member/api/verifyCode?code=' + inputCode)
   .then(response => response.text())
   .then(data => {
      if (data === 'ok') {
         alert('인증 성공!');
         customAlertId.style.display = 'block';
         setTimeout(function(){
            customAlertId.style.display = 'none';
         }, 2000);
         
      }else{
         alert('인증 코드가 잘못되었습니다.')
      }
   })
   .catch(err => console.log(err));
   
   }

//이메일 입력 검증 함수
function validateEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}


document.getElementById('checkMyId').addEventListener('click', function() {
    // 입력된 이름과 이메일 값 가져오기
    const userName = document.getElementById('userName').value;
    const userEmail = document.getElementById('userEmail').value;

    // 이름과 이메일이 비어있지 않은지 체크
    if (!userName || !userEmail) {
        alert("이름과 이메일을 모두 입력해주세요.");
        return;
    }  
    if (!validateEmail(userEmail)) {
        alert("올바른 이메일 형식을 입력해주세요.");
        return false;
    }


    // 서버로 보내는 URL 형식에 맞춰 이동
    location.href = "/member/checkMyId?userName=" + encodeURIComponent(userName) + "&userEmail=" + encodeURIComponent(userEmail);
});


let emailVerified = false;
let idVerified = false;

//비밀번호 찾기 버튼 클릭
const searchPwBtn = document.getElementById('searchPwBtn');
searchPwBtn.addEventListener('click', function() {
	const searchPwModal = document.getElementById('foundUserPwModal');
	// 비밀번호 찾기 모달 창 오픈
	searchPwModal.style.display = 'block';
});

function closeSearchPwModal() {

		const searchPwModal = document.getElementById('foundUserPwModal');
		// 비밀번호 찾기 모달 창 오픈
		searchPwModal.style.display = 'none';
};







document.getElementById('confirmId').addEventListener('click', function() {
   const userId = document.getElementById('userIdSearchPw').value;
   
    if (!userId) {
           alert("User ID를 입력해주세요.");
           return; // userId가 비어있으면 함수 종료
       }
   
   
    fetch(`/member/api/confirmId?userId=${userId}`, {
        method: 'GET',
    })
    .then(response => {
        return response.text();
    })
    .then(text => {
        alert(text); // 서버에서 받은 메시지를 알림으로 표시
    })
    .catch(err => {
        console.error('에러:', err);
        alert('오류가 발생했습니다.');
    });
});




//비밀번호 찾기 이메일 전송 버튼 클릭
document.getElementById('sendEmailBtnPw').addEventListener('click', function() {
   const userEmail = document.getElementById('userEmailPw').value;
   const userId= document.getElementById('userIdSearchPw').value;
   
   // 이메일 체크 비동기(post)
   fetch('/member/api/checkEmailSeachPw', {
      method: 'POST',
      headers: {
         'Content-Type': 'application/json'
      },
      body: JSON.stringify({ userEmail: userEmail, userId: userId })
   })
   .then(response => response.text())
   .then(data => {
      if (data === 'exists') {
         customAlert.style.display = 'block';
        
           setTimeout(function(){
           customAlert.style.display = 'none';
        }, 2000);

         // 이메일 전송 비동기
         return fetch('/member/api/sendMail/' + userEmail)
            .then(response => response.text())
            .then(result => {
               if (result === 'ok') {
                  
                  alert('이메일 전송이 완료되었습니다.');
               } else {
                  alert('이메일 전송에 실패했습니다. 다시 시도해주세요');
               }
            });
      } else {
         alert('등록되지 않은 이메일입니다.');
      }
   })
   .catch(err => console.log(err));
});

//인증 코드 확인 (비밀번호 찾기)
function verifyEmailCodePw() {
    const inputCode = document.getElementById('verifyCodeInputPw').value;

    fetch('/member/api/verifyCode?code=' + inputCode)
    .then(response => response.text())
    .then(data => {
        if (data === 'ok') {
            alert('인증 성공!');
            location.href='/member/pwChange';
        } else {
            alert('인증 코드가 잘못되었습니다.');
        }
    })
    .catch(err => console.log(err));
}

//비밀번호 찾기
function submitPwChange() {
    const f = document.getElementById('passwordChangeForm');
    const oldPw = f.oldPw.value;
    const newPw = f.newPw.value;
    const checkNewPw = f.checkNewPw.value;
    const pwRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;


    // 비밀번호 유효성 검사
    if (!oldPw) {
        alert("비밀번호를 입력하세요");
        return false; // 실패
    } else if (!newPw) {
        alert("새 비밀번호를 입력하세요");
        return false; // 실패
    } else if (checkNewPw !== newPw) {
        alert("비밀번호가 일치하지 않습니다.");
        return false; // 실패
    } else if (!idVerified) {
        alert("아이디 확인을 먼저 완료해주세요.");
        return false;
    } else if (!emailVerified) {
        alert("이메일 인증을 먼저 완료해주세요.");
        return false;
    } else if(!pwRegex.test(newPw)) {
        alert("비밀번호는 최소 8자 이상이며, 대문자, 소문자, 숫자, 특수문자를 포함해야 합니다.");
        return false;
    }
    
    return true; // 성공
}

document.getElementById('passwordChangeForm').onsubmit = submitPwChange;






