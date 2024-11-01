// 페이징 처리(아직미적용)
//function loadQnaList() {
//    const criteria = {
//        pageNum: 1, // 원하는 페이지 번호
//        amount: 10,  // 한 페이지에 보여줄 항목 수
//    };
//    
//    const searchMs = ''; // 검색어를 여기에 설정
//
//    // Fetch API를 사용한 Ajax 요청
//    fetch(`/admin/qnaList?pageNum=${criteria.pageNum}&amount=${criteria.amount}&searchMs=${searchMs}`)
//        .then(response => {
//            if (!response.ok) {
//                throw new Error('Network response was not ok');
//            }
//            return response.json(); // JSON 응답을 반환
//        })
//        .then(data => {
//            const qnaList = data.list;
//            const tbody = document.querySelector('#qnaListCat tbody');
//            tbody.innerHTML = ''; // 기존 데이터를 비움
//
//            qnaList.forEach(qna => {
//                const row = document.createElement('tr');
//                row.innerHTML = `
//                    <td>${qna.qnaNo}</td>
//                    <td>${qna.qnaType}</td>
//                    <td>${qna.qnaTitle}</td>
//                    <td>${qna.qnaRegDate}</td>
//                    <td>${qna.qnaAnswer ? '답변 완료' : '답변 미완료'}</td>
//                `;
//                tbody.appendChild(row); // 새로운 행 추가
//            });
//        })
//        .catch(error => {
//            console.error('Error fetching Q&A list:', error);
//        });
//}
//
//// 페이지 로드 시 호출
//document.addEventListener('DOMContentLoaded', function() {
//    loadQnaList();
//});

// 답변 유무 체크박스의 체크 유무에 따라 출력하기
function loadQnaList() {
    fetch('/admin/qnaList')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            const tbody = document.querySelector('#qnaListCat tbody');
            tbody.innerHTML = ''; // 기존 데이터 초기화

            // 데이터 출력
            data.forEach(qna => {
                const formattedDate = new Date(qna.qnaRegDate).toLocaleDateString(); // 날짜 포맷 변환
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${qna.qnaNo}</td>
                    <td>${qna.qnaType}</td>
                    <td>${qna.qnaTitle}</td>
                    <td>${formattedDate}</td> <!-- 변환된 날짜 사용 -->
                    <td>${qna.qnaAnswer ? '답변 완료' : '답변 미완료'}</td>
                `;
                tbody.appendChild(row);
            });
        })
        .catch(error => {
            console.error('Error fetching Q&A list:', error);
        });
}

// 체크박스 이벤트 리스너 추가
document.getElementById('answerStatus').addEventListener('change', function () {
    const isChecked = this.checked;
    
    fetch('/admin/qnaList')
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
                if (!isChecked || (isChecked && qna.qnaAnswer)) {
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
});

// 페이징 처리
//function loadQnalist(qnaType, pageNum = 1) {
//    const qnaNo = document.getElementById('qnaNo').value; // userNo 변수 선언
//    const qnaContainer = document.getElementById('qnaList');
//    console.log(qnaContainer)
//    qnaContainer.innerHTML = ''; // 기존 내용 초기화
//
//    if (!qnaNo) {
//        console.error('ask is not defined.');
//        return; // qnaNo가 없으면 함수 종료
//    }
//
//    // userAsk 로드
//    if (qnaType === 'userAsk') {
//        fetch(`/admin/qnaList?qnaNo=${qnaNo}&pageNum=${pageNum}&amount=10`)
//            .then((response) => {
//                if (!response.ok) {
//                    return response.text().then((text) => {
//                        throw new Error(`Error: ${response.status} ${response.statusText}\nResponse: ${text}`);
//                    });
//                }
//                return response.json();
//            })
//            .then((data) => {
//                const qnaList = data.inquiries;
//                if (qnaList.length === 0) {
//                   qnaContainer.innerHTML = '<p>문의가 없습니다.</p>';
//                } else {
//                   
//                   qnaList.forEach((qna) => {
//                       qnaContainer.innerHTML += `
//                            <div class="qna-item">
//                                <a href="/admin/qnaList?qnaNo=${qna.qnaNo}">
//                                    ${qna.qnaTitle}
//                                </a>
//                            </div>
//                        `;
//                    });
//                }
//                updatePageNumbers(pageNum);
//            })
//            .catch((error) => console.error('Error fetching inquiry list:', error));
//    } 
//}

// DOMContentLoaded 이벤트에 loadQnaList 함수 추가
document.addEventListener('DOMContentLoaded', loadQnaList);
