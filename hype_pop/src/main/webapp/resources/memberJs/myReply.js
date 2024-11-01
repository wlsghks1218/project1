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
                if (inquiryList.length === 0) {
                    boardContainer.innerHTML = '<p>문의가 없습니다.</p>';
                } else {
                   
                    inquiryList.forEach((inquiry) => {
                        boardContainer.innerHTML += `
                            <div class="board-item">
                                <a href="/support/inquiryInfo?qnaNo=${inquiry.qnaNo}">
                                    ${inquiry.qnaTitle}
                                </a>
                            </div>
                        `;
                    });
                }
                updatePageNumbers(pageNum);
            })
            .catch((error) => console.error('Error fetching inquiry list:', error));
    } 
 // popupComments 로드
    else if (boardType === 'popupComments') {
        const userNo = document.getElementById('userNo').value; 
        fetch(`/reply/getMyPopupReply?userNo=${userNo}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error('서버 오류: ' + response.status);
                }
                return response.json();  // 응답을 JSON으로 받기
            })
            .then(data => {
                if (data.replies && data.replies.length === 0) {
                    boardContainer.innerHTML = '<p>문의가 없습니다.</p>';
                }else {
                    data.replies.forEach(review => {
                        boardContainer.innerHTML +=`
                            <div class="board-item">
                                <span>${review.psName}</span>
                        <a href="/hypePop/popUpDetails?storeName=${encodeURIComponent(review.psName)}">                                    
                        <span>${review.psComment}</span>
                                </a>
                                <span>${new Date(review.psRegDate).toLocaleDateString()}</span>
                            </div>
                        `;
                    });
                }
            }) 
            .catch(error => {
                console.error('Fetch error:', error);
                boardContainer.innerHTML = `<p>오류 발생: ${error.message}</p>`; // 오류 메시지 출력
            });
    }else if (boardType === 'goodsComments') {
         const userNo = document.getElementById('userNo').value; 

          fetch(`/gReply/getGreplyReviews?userNo=${userNo}`)
              .then((response) => {
                if (!response.ok) {
                    return response.text().then((text) => {
                        throw new Error(`Error: ${response.status} ${response.statusText}\nResponse: ${text}`);
                    });
                }
                return response.json();
            })
            .then(data => {
               if (data.greplies && data.greplies.length === 0) {
                    boardContainer.innerHTML = '<p>문의가 없습니다.</p>';
                }else {
                    data.greplies.forEach(greview => {
                        boardContainer.innerHTML +=`
                            <div class="board-item">
                                <span>${greview.gname}</span>
                        <a href="/goodsStore/goodsDetails?gno=${greview.gno}">                                    
                        <span>${greview.psComment}</span>
                                </a>
                                <span>${new Date(greview.gregDate).toLocaleDateString()}</span>
                            </div>
                        `;
                    });
                }
            }) 
            .catch(error => {
                console.error('Fetch error:', error);
                boardContainer.innerHTML = `<p>오류 발생: ${error.message}</p>`; // 오류 메시지 출력
            });
}   

// 팝업 리뷰 로드 함수
function loadPopupReviews(reviews) {
    const reviewList = document.getElementById('popupReplyList');
    reviewList.innerHTML = ''; // 기존 목록 초기화
    reviews.forEach(review => {
        const reviewItem = document.createElement('div');
        reviewItem.className = 'board-item';
        reviewItem.innerHTML = `
            <strong>${review.psName}</strong><br>
            ${review.psComment}<br>
            <small>${review.psUpdateDate}</small>
        `;
        reviewList.appendChild(reviewItem);
    });
}

// 페이지 번호 업데이트
function updatePageNumbers(pageNum) {
    document.querySelector('.prev').dataset.page = pageNum;
    document.querySelector('.next').dataset.page = pageNum;
}

// 이전/다음 버튼 클릭 시 페이지 번호 조정
document.querySelector('.prev').addEventListener('click', function () {
    let currentPage = parseInt(this.dataset.page);
    if (currentPage > 1) {
        loadBoard('userInquiry', currentPage - 1);
    }
});

document.querySelector('.next').addEventListener('click', function () {
    let currentPage = parseInt(this.dataset.page);
    loadBoard('userInquiry', currentPage + 1);
});

document.querySelectorAll('.board-item').forEach(a => {
     a.addEventListener('click', (event) => {
       event.preventDefault();
       
       let storeName = review.psName.value;
       
       console.log(storeName);
       
        location.href = `/hypePop/popUpDetails?storeName=${encodeURIComponent(storeName)}`;
     });
   });
}
