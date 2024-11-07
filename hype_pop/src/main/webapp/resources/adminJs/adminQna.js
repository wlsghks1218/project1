// 문의 유형 선택 시 리스트 로드
document.getElementById('qnaType').addEventListener('change', loadQnaList);
// 체크박스 상태 변경 시에도 호출
document.getElementById('qnaAnswer').addEventListener('change', loadQnaList);

// 리스트 로드 함수
function loadQnaList() {
	
    // 선택된 문의 유형 가져오기
    const qnaType = document.getElementById('qnaType').value;
    // 답변 완료된 문의 가져오기 ;
    const qnaAnswer = document.getElementById('qnaAnswer').value;
        
    console.log("선택된 문의 유형 : " + qnaType);
    console.log("선택된 답변 유형 : " + qnaAnswer);

//    fetch(`/admin/qnaList?qnaType=${encodeURIComponent(qnaType)}&qnaAnswer=${encodeURIComponent(qnaAnswer)}`)
    fetch(`/admin/qnaList?qnaType=${qnaType}&qnaAnswer=${qnaAnswer}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            const tbody = document.querySelector('#qnaListCat tbody');
            tbody.innerHTML = ''; // 기존 데이터 초기화

            // 필터링된 데이터 출력
            data.forEach(qna => {
            	console.log("필터링 데이터 출력하기 : " + qna)
                if (!qnaAnswer || (qnaAnswer && qna.qnaAnswer)) {
                    const formattedDate = new Date(qna.qnaRegDate).toLocaleDateString(); // 날짜 포맷 변환
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td>${qna.qnaNo}</td>
                        <td>${qna.qnaType}</td>
                        <td>${qna.qnaTitle}</td>
                        <td>${formattedDate}</td>
                        <td>${qna.qnaAnswer ? '답변 완료' : '답변 미완료'}</td>
                    `;
                    tbody.appendChild(row);
                }
            });
        })
        .catch(error => {
            console.error('Error fetching Q&A list:', error);
        });
}

// 초기 리스트 로드 (페이지 로드 시)
loadQnaList();

//function hideQnaInfo() {
//    // 폼 숨기기
//    const qnaTypeBox = document.querySelector('#qnaTypeBox'); // 특정 ID로 폼 선택
//    if (qnaTypeBox) {
//    	qnaTypeBox.style.display = 'none'; // 폼 숨기기
//    }
//
//    // 테이블 숨기기
//    const qnaListCat = document.querySelector('#qnaListCat'); 
//
//    if (qnaListCat) {
//    	qnaListCat.style.display = 'none'; // 취소 버튼 숨기기
//    }
//
//}

//// 페이징 처리
//let currentQnaPage = 1; // 현재 페이지
//const amountQna = 10; // 한 페이지당 출력 개수
//let totalQnaCount = 0; // 전체 아이템 수
//let totalQnaPages = 0; // 총 페이지 수
//
//// 문의 리스트 로드 함수
//function loadQnaList(pageNum = 1) {
//    const qnaType = document.getElementById('qnaType').value;
//
//    // API 요청
//    fetch(`/admin/qnaList?qnaType=${encodeURIComponent(qnaType)}&answerStatus=${answerStatus}&pageNum=${pageNum}&amount=${amountQna}`)
//        .then(response => {
//            if (!response.ok) {
//                throw new Error('리스트가 출력되지 않았습니다: ' + response.statusText);
//            }
//            return response.json();
//        })
//        .then(data => {
//            if (data.list && data.total) {
//                // 테이블 업데이트
//                updateQnaTable(data.list);
//
//                totalQnaCount = data.total; // 전체 아이템 수 저장
//                totalQnaPages = Math.ceil(totalQnaCount / amountQna); // 총 페이지 수 계산
//
//                // 페이지네이션 생성
//                createQnaPagination(totalQnaPages);
//            } else {
//                throw new Error('잘못된 데이터 구조입니다. 데이터: ' + JSON.stringify(data));
//            }
//        })
//        .catch(err => {
//            console.error('오류:', err);
//        });
//}
//// 페이지네이션 생성 함수
//function createQnaPagination(totalPages) {
//    const paginationContainer = document.getElementById('pagination');
//    paginationContainer.innerHTML = ''; // 기존 내용 제거
//
//    for (let i = 1; i <= totalPages; i++) {
//        const pageLink = document.createElement('a');
//        pageLink.href = '#';
//        pageLink.textContent = i;
//        pageLink.addEventListener('click', (e) => {
//            e.preventDefault();
//            currentQnaPage = i; // 현재 페이지 업데이트
//            loadQnaList(currentQnaPage); // 클릭된 페이지 번호로 데이터 로드
//        });
//
//        paginationContainer.appendChild(pageLink);
//    }
//}