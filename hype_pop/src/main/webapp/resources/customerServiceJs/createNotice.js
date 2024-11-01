// 현재 날짜를 yy/mm/dd 형식으로 가져오는 함수
function setCurrentDate() {
   const today = new Date();
   const year = String(today.getFullYear()).slice(-2); // 연도의 마지막 2자리
   const month = String(today.getMonth() + 1).padStart(2, '0'); // 월 (0부터
                                                   // 시작하므로 +1)
   const day = String(today.getDate()).padStart(2, '0'); // 일

   const formattedDate = `${year}/${month}/${day}`;
   document.getElementById('currentDate').value = formattedDate; // 입력 필드에 현재
                                                   // 날짜 설정
}

// 페이지 로드 시 현재 날짜 설정
window.onload = setCurrentDate;