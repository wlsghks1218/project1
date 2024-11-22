
loadBoard('popupComments');

//페이지 번호 업데이트
function updatePageNumbers(pageNum, totalCount, amount) {
    const totalPages = Math.ceil(totalCount / amount);  // 전체 페이지 수 계산
    const prevButton = document.querySelector('.prevInquiry');
    const nextButton = document.querySelector('.nextInquiry');

    prevButton.dataset.page = pageNum;
    nextButton.dataset.page = pageNum;

    // 이전/다음 버튼 활성화/비활성화
    prevButton.disabled = (pageNum <= 1);
    nextButton.disabled = (pageNum >= totalPages);
}

// 이전/다음 버튼 클릭 시 페이지 번호 조정
document.querySelector('.prevInquiry').addEventListener('click', function () {
    let currentPage = parseInt(this.dataset.page);
    if (currentPage > 1) {
        loadBoard('userInquiry', currentPage - 1); // 페이지 번호 감소
    }
});

document.querySelector('.nextInquiry').addEventListener('click', function () {
    let currentPage = parseInt(this.dataset.page);
    loadBoard('userInquiry', currentPage + 1); // 페이지 번호 증가
});

function updatePageNumbers2(pageNum, totalCount, amount) {
    const totalPages = Math.ceil(totalCount / amount);  // 전체 페이지 수 계산
    const prevButton = document.querySelector('.prevGoods');
    const nextButton = document.querySelector('.nextGoods');

    prevButton.dataset.page = pageNum;
    nextButton.dataset.page = pageNum;

    // 이전/다음 버튼 활성화/비활성화
    prevButton.disabled = (pageNum <= 1);
    nextButton.disabled = (pageNum >= totalPages);
}

// 이전/다음 버튼 클릭 시 페이지 번호 조정
document.querySelector('.prevGoods').addEventListener('click', function () {
    let currentPage = parseInt(this.dataset.page);
    if (currentPage > 1) {
        loadBoard('goodsComments', currentPage - 1); // 페이지 번호 감소
    }
});

document.querySelector('.nextGoods').addEventListener('click', function () {
    let currentPage = parseInt(this.dataset.page);
    loadBoard('goodsComments', currentPage + 1); // 페이지 번호 증가
});

function updatePageNumbers3(pageNum, totalCount, amount) {
    const totalPages = Math.ceil(totalCount / amount);  // 전체 페이지 수 계산
    const prevButton = document.querySelector('.prevPopup');
    const nextButton = document.querySelector('.nextPopup');

    prevButton.dataset.page = pageNum;
    nextButton.dataset.page = pageNum;

    // 이전/다음 버튼 활성화/비활성화
    prevButton.disabled = (pageNum <= 1);
    nextButton.disabled = (pageNum >= totalPages);
}

// 이전/다음 버튼 클릭 시 페이지 번호 조정
document.querySelector('.prevPopup').addEventListener('click', function () {
    let currentPage = parseInt(this.dataset.page);
    if (currentPage > 1) {
        loadBoard('popupComments', currentPage - 1); // 페이지 번호 감소
    }
});

document.querySelector('.nextPopup').addEventListener('click', function () {
    let currentPage = parseInt(this.dataset.page);
    loadBoard('popupComments', currentPage + 1); // 페이지 번호 증가
});

// 각 boardType에 맞는 버튼들을 숨기고 보이게 하는 함수
function togglePaginationButtons(boardType) {
    // 각 boardType에 맞는 버튼들만 보이게 하고, 나머지 버튼들은 숨깁니다.
    const inquiryPrev = document.querySelector('.prevInquiry');
    const inquiryNext = document.querySelector('.nextInquiry');
    const goodsPrev = document.querySelector('.prevGoods');
    const goodsNext = document.querySelector('.nextGoods');
    const popupPrev = document.querySelector('.prevPopup');
    const popupNext = document.querySelector('.nextPopup');

    // 모든 버튼을 숨기기
    inquiryPrev.style.display = 'none';
    inquiryNext.style.display = 'none';
    goodsPrev.style.display = 'none';
    goodsNext.style.display = 'none';
    popupPrev.style.display = 'none';
    popupNext.style.display = 'none';

    // 해당 boardType에 맞는 버튼만 보이게 하기
    if (boardType === 'userInquiry') {
        inquiryPrev.style.display = 'inline-block';
        inquiryNext.style.display = 'inline-block';
    } else if (boardType === 'goodsComments') {
        goodsPrev.style.display = 'inline-block';
        goodsNext.style.display = 'inline-block';
    } else if (boardType === 'popupComments') {
        popupPrev.style.display = 'inline-block';
        popupNext.style.display = 'inline-block';
    }
}




//내가 쓴 글 목록 불러오기
function loadBoard(boardType, pageNum = 1) {
    const userNo = document.getElementById('userNo').value; // userNo 변수 선언
    const boardContainer = document.getElementById('boardContainer');
    console.log(boardContainer)
    boardContainer.innerHTML = ''; // 기존 내용 초기화

    if (!userNo) {
        console.error('User number is not defined.');
        return; // userNo가 없으면 함수 종료
    }

    
    
    // userInquiry 로드
    if (boardType === 'userInquiry') {
        fetch(`/support/userInquiry?userNo=${userNo}&pageNum=${pageNum}&amount=5`)
            .then((response) => {
                if (!response.ok) {
                    return response.text().then((text) => {
                        throw new Error(`Error: ${response.status} ${response.statusText}\nResponse: ${text}`);
                    });
                }
                return response.json();
            })
            .then((data) => {
                const inquiryList = data.inquiries;
                const totalCount = data.totalCount;  // 총 페이지 수
                if (inquiryList.length === 0) {
                    boardContainer.innerHTML = '<p>문의가 없습니다.</p>';
                } else {
                	let table = `
                        <table class="board-table">
                            <thead>
                                <tr>
                                    <th>문의 제목</th>
                                    <th>문의 내용</th>
                                    <th>문의 유형</th>
                                    <th>등록일</th>
                                </tr>
                            </thead>
                            <tbody>
                    `;

                    inquiryList.forEach((inquiry) => {
                        table += `
                            <tr>
                                <td><a href="/support/inquiryInfo?qnaNo=${inquiry.qnaNo}">${inquiry.qnaTitle}</a></td>
                                <td>${inquiry.qnaContext}</td>
                                <td>${inquiry.qnaType}</td>
                                <td>${new Date(inquiry.qnaRegDate).toLocaleDateString()}</td>
                            </tr>
                        `;
                    });

                    table += '</tbody></table>';
                    boardContainer.innerHTML = table;
                }
                
            
                updatePageNumbers(pageNum, totalCount, 5);
                togglePaginationButtons('userInquiry');
            })
            
            
            .catch((error) => console.error('Error fetching inquiry list:', error));
    } 
    // popupComments 로드
    else if (boardType === 'popupComments') {
        const userNo = document.getElementById('userNo').value; 
        fetch(`/reply/getMyPopupReply?userNo=${userNo}&pageNum=${pageNum}&amount=5`)
            .then(response => {
                if (!response.ok) {
                    throw new Error('서버 오류: ' + response.status);
                }
                return response.json();  // 응답을 JSON으로 받기
            })
            .then(data => {
            	 const replies = data.replies;
                 const totalCount = data.totalCount; 
                if (data.replies && data.replies.length === 0) {
                	
                    boardContainer.innerHTML = '<p>팝업 스토어 댓글 목록이 비어있습니다.</p>';
                }else {
                	let table = `
                        <table class="board-table">
                            <thead>
                                <tr>
                                    <th>댓글자</th>
                                    <th>댓글 내용</th>
                                    <th>등록일</th>
                                </tr>
                            </thead>
                            <tbody>
                    `;

                    data.replies.forEach(review => {
                        table += `
                            <tr>
                                <td>${review.psName}</td>
                                <td><a href="/hypePop/popUpDetails?storeName=${encodeURIComponent(review.psName)}">${review.psComment}</a></td>
                                <td>${new Date(review.psRegDate).toLocaleDateString()}</td>
                            </tr>
                        `;
                    });

                    table += '</tbody></table>';
                    boardContainer.innerHTML = table;
                }

                updatePageNumbers3(pageNum, totalCount, 5);
                togglePaginationButtons('popupComments'); 
            })
            .catch(error => {
                console.error('Fetch error:', error);
                boardContainer.innerHTML = `<p>오류 발생: ${error.message}</p>`; // 오류 메시지 출력
            });
    }else if (boardType === 'goodsComments') {
        const userNo = document.getElementById('userNo').value; 

        fetch(`/gReply/getGreplyReviews?userNo=${userNo}&pageNum=${pageNum}&amount=5`)
            .then((response) => {
                if (!response.ok) {
                    return response.text().then((text) => {
                        throw new Error(`Error: ${response.status} ${response.statusText}\nResponse: ${text}`);
                    });
                }
                return response.json();
            })
            .then(data => {
            	const greplies = data.greplies;
                const totalCount = data.totalCount; 
                if (data.greplies && data.greplies.length === 0) {
                    boardContainer.innerHTML = '<p>굿즈 댓글 목록이 비어있습니다.</p>';
                } else {
                    let table = `
                        <table>
                            <thead>
                                <tr>
                                    <th>제목</th>
                                    <th>댓글 내용</th>
                                    <th>날짜</th>
                                </tr>
                            </thead>
                            <tbody>
                    `;

                    data.greplies.forEach(greview => {
                        table += `
                            <tr>
                                <td>${greview.gname}</td>
                                <td><a href="/goodsStore/goodsDetails?gno=${greview.gno}">${greview.gcomment}</a></td>
                                <td>${new Date(greview.gregDate).toLocaleDateString()}</td>
                            </tr>
                        `;
                    });

                    table += '</tbody></table>';
                    boardContainer.innerHTML = table;
 
                    // Update pagination
                    updatePageNumbers2(pageNum, data.totalCount, 5);
                    togglePaginationButtons('goodsComments'); 
                }
            })
            .catch(error => {
                console.error('Fetch error:', error);
                boardContainer.innerHTML = `<p>오류 발생: ${error.message}</p>`;
            });
    }



//팝업디테일 페이지 가기
//document.querySelectorAll('.board-item').forEach(a => {
//     a.addEventListener('click', (event) => {
//       event.preventDefault();
//       
//       let storeName = review.psName.value;
//       
//       console.log(storeName);
//       
//        location.href = `/hypePop/popUpDetails?storeName=${encodeURIComponent(storeName)}`;
//     });
//   });
}
