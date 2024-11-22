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

    fetch(`/admin/qnaList?qnaType=${encodeURIComponent(qnaType)}&qnaAnswer=${encodeURIComponent(qnaAnswer)}`)
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
                const formattedDate = new Date(qna.qnaRegDate).toLocaleDateString();
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>
	                    <a href="http://localhost:9010/support/inquiryInfo?qnaNo=${qna.qnaNo}">
		                    ${qna.qnaNo}
		                </a>
                	</td>
                    <td>${qna.qnaType}</td>
                    <td>${qna.qnaTitle}</td>
                    <td>${formattedDate}</td>
                    <td>${qna.qnaAnswer ? '답변 완료' : '답변 미완료'}</td>`;
                tbody.appendChild(row);
            });
        })
        .catch(error => {
            console.error('Error fetching Q&A list:', error);
        });
}

// 초기 리스트 로드 (페이지 로드 시)
loadQnaList();