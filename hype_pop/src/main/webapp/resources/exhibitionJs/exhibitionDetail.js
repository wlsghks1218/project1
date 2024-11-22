// 섹션 전환 이벤트 리스너 설정
document.getElementById('viewingInfoToggle').addEventListener('click', () => showSection('viewingInfo'));
document.getElementById('viewingDetailToggle').addEventListener('click', () => showSection('detailsSection'));
document.getElementById('replyToggle').addEventListener('click', () => showSection('replySection'));

document.addEventListener("DOMContentLoaded", (event) => {
	showSection('viewingInfo');
	 const scrollUpButton = document.getElementById("scrollUp");
	    const scrollDownButton = document.getElementById("scrollDown");

	    // 최상단으로 스크롤
	    function scrollToTop() {
	        window.scrollTo({ top: 0, behavior: 'smooth' });
	    }

	    // 최하단으로 스크롤
	    function scrollToBottom() {
	        window.scrollTo({ top: document.body.scrollHeight, behavior: 'smooth' });
	    }

	    // 스크롤 상태에 따라 버튼 보이기/숨기기 설정
	    function checkScrollPosition() {
	        if (window.scrollY === 0) {
	            scrollUpButton.style.display = 'none'; // 위 버튼 숨기기
	            scrollDownButton.style.display = 'block'; // 아래 버튼 보이기
	        } else if (window.innerHeight + window.scrollY >= document.body.offsetHeight) {
	            scrollUpButton.style.display = 'block'; // 위 버튼 보이기
	            scrollDownButton.style.display = 'none'; // 아래 버튼 숨기기
	        } else {
	            scrollUpButton.style.display = 'block'; // 위 버튼 보이기
	            scrollDownButton.style.display = 'block'; // 아래 버튼 보이기
	        }
	    }

	    // 버튼에 클릭 이벤트 리스너 추가
	    scrollUpButton.addEventListener("click", scrollToTop);
	    scrollDownButton.addEventListener("click", scrollToBottom);

	    // 버튼 호버 시 불투명도 변경
	    scrollUpButton.addEventListener("mouseenter", function() {
	        scrollUpButton.style.opacity = 1; // 호버 시 불투명도 1로 설정
	    });
	    scrollUpButton.addEventListener("mouseleave", function() {
	        if (window.scrollY !== 0) {
	            scrollUpButton.style.opacity = 0.5; // 호버를 떼면 불투명도 0.5로 설정
	        }
	    });

	    scrollDownButton.addEventListener("mouseenter", function() {
	        scrollDownButton.style.opacity = 1; // 호버 시 불투명도 1로 설정
	    });
	    scrollDownButton.addEventListener("mouseleave", function() {
	        if (window.innerHeight + window.scrollY < document.body.offsetHeight) {
	            scrollDownButton.style.opacity = 0.5; // 호버를 떼면 불투명도 0.5로 설정
	        }
	    });

	    // 페이지 로드 및 스크롤 시 버튼 상태 업데이트
	    window.addEventListener("scroll", checkScrollPosition);
	    checkScrollPosition(); // 초기 로딩 시 상태 설정
});

let userNoElement = document.getElementById("userNo");
let userNo = userNoElement ? userNoElement.value : null;
// 특정 섹션을 표시하고 나머지 섹션은 숨기기
function showSection(visibleSectionId) {
    const sections = ['viewingInfo', 'detailsSection', 'replySection'];
    sections.forEach(sectionId => {
        document.getElementById(sectionId).style.display = (sectionId === visibleSectionId) ? 'block' : 'none';
    });
}

document.addEventListener("DOMContentLoaded", function() {
    const exhNo = document.getElementById("exhNo").value;
    const userNo = localStorage.getItem("userNo");

    // 좋아요 상태 확인 요청
    const xhrLikeStatus = new XMLHttpRequest();
    xhrLikeStatus.open("GET", `/exhibition/likeStatus?exhNo=${exhNo}&userNo=${userNo}`, true);
    
    xhrLikeStatus.onload = function() {
        if (xhrLikeStatus.status === 200) {
            const isLiked = JSON.parse(xhrLikeStatus.responseText);
            const heartElement = document.querySelector(".heart"); // heart 클래스가 있는 요소 선택

            if (isLiked) {
                heartElement.classList.add("active"); // 좋아요가 눌려있으면 active 클래스 추가
            }
        } else {
            console.error("좋아요 상태 확인 실패");
        }
    };
    xhrLikeStatus.send();

    // 좋아요 개수 가져오기 요청
    const xhrLikeCount = new XMLHttpRequest();
    xhrLikeCount.open("GET", `/exhibition/likeCount?exhNo=${exhNo}`, true);

    xhrLikeCount.onload = function() {
        if (xhrLikeCount.status === 200) {
            const likeCount = xhrLikeCount.responseText; 
            document.getElementById("likeCount").innerText = `${likeCount}`; // 좋아요 개수 표시
        } else {
            console.error("좋아요 개수 가져오기 실패");
        }
    };
    xhrLikeCount.send();
});

function loadExhibitionImages(exhNo) {
    const imageContainer = document.querySelector('.image-section');
    const likeContainer = document.querySelector('#likeContainer');  // likeContainer를 따로 선택하여 저장

    // 이미지 섹션에 있는 기존 이미지를 삭제하고 로딩 메시지 추가
    imageContainer.innerHTML = '';  
    imageContainer.appendChild(likeContainer);  // likeContainer를 다시 추가

    const loadingMessage = document.createElement('p');
    loadingMessage.textContent = '전시회 이미지를 로딩 중입니다...';
    imageContainer.appendChild(loadingMessage);

    // exhNo를 쿼리 파라미터로 포함하여 fetch 호출
    fetch(`/exhibition/exhImg?exhNo=${exhNo}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('서버 오류: ' + response.status);  // 응답이 정상적이지 않으면 오류 처리
            }
            return response.json();  // JSON으로 응답을 처리
        })
        .then(exhibitionData => {
            // 로딩 중 메시지 삭제
            imageContainer.innerHTML = '';  // 기존 로딩 메시지 삭제
            imageContainer.appendChild(likeContainer);  // likeContainer를 다시 추가

            if (exhibitionData.length === 0) {
                const noImageMessage = document.createElement('p');
                noImageMessage.textContent = '전시회 이미지가 없습니다.';
                imageContainer.appendChild(noImageMessage);
                return;
            }

            exhibitionData.forEach(item => {
                const img = document.createElement('img');

                // 다양한 해상도의 이미지를 제공
                img.srcset = ` 
                    /exhibition/exhibitionImages/${item.uuid}_${encodeURIComponent(item.fileName)} 1x, 
                    /exhibition/exhibitionImages/${item.uuid}_${encodeURIComponent(item.fileName.replace('.jpg', '-2x.jpg'))} 2x
                `;
                
                img.src = `/exhibition/exhibitionImages/${item.uuid}_${encodeURIComponent(item.fileName)}`;  // 기본 이미지
                img.alt = `Exhibition Image: ${item.fileName}`;
                img.loading = 'lazy';  // 이미지 로딩 최적화     

                img.onload = () => {
                    img.style.display = 'block';  // 이미지가 로드되면 보이게 설정
                };

                img.onerror = () => {
                    img.style.display = 'none';  // 오류 발생 시 이미지 숨기기
                    console.error('이미지 로드 오류:', img.src);
                };

                imageContainer.appendChild(img); // 이미지 컨테이너에 추가
            });

        })
        .catch(error => {
            console.error('전시회 정보 로드 에러:', error);
            imageContainer.innerHTML = '<p>전시회 이미지 로드에 실패했습니다. 다시 시도해 주세요.</p>';
        });
}


// 좋아요 표시 기능
function toggleHeart(element) {
    const exhNo = document.getElementById("exhNo").value;

    // userNo가 없으면 로그인 모달을 띄운다
    if (!userNo) {
        showLoginModal(); // 로그인 모달 표시
        return;
    }

    const isActive = element.classList.toggle("active");

    const xhr = new XMLHttpRequest();
    xhr.open("POST", "/exhibition/" + (isActive ? "addLike" : "removeLike"), true);
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

    xhr.onload = function() {
        if (xhr.status === 200) {

            // 좋아요 개수 업데이트
            const countChange = isActive ? 1 : -1;
            const likeCountElement = document.getElementById("likeCount");
            const currentCount = parseInt(likeCountElement.innerText.replace(/[^0-9]/g, ''), 10);
            likeCountElement.innerText = `${currentCount + countChange}`; // 좋아요 개수 업데이트
        } else {
            console.error(isActive ? "좋아요 등록 실패" : "좋아요 삭제 실패");
        }
    };

    const data = JSON.stringify({ exhNo: exhNo, userNo: userNo });
    xhr.send(data);
}


//별점 선택 함수
document.addEventListener("DOMContentLoaded", () => {
    const ratingStars = document.querySelectorAll("#newReviewStars span");
    const selectedRatingDisplay = document.querySelector("#selectedRating span"); // span 요소 선택

    // 별점 클릭 이벤트 처리
    ratingStars.forEach(star => {
        star.addEventListener("click", () => {
            const selectedRating = star.dataset.value; // 클릭한 별점 값
            selectedRatingDisplay.textContent = selectedRating; // 선택한 별점 표시
            updateStarRating(selectedRating); // 별점 업데이트
        });
    });

    // 선택한 별점에 따라 색칠 업데이트
    function updateStarRating(rating) {
        ratingStars.forEach((s, index) => {
            if (index < rating) {
                s.classList.add("active"); // 선택한 별까지 색칠
            } else {
                s.classList.remove("active"); // 나머지 별 색 제거
            }
        });
    }
});

document.addEventListener("DOMContentLoaded", function() {
    var exhNo = document.getElementById("exhNo").value;

    // 유저가 이미 댓글을 작성했는지 확인하는 AJAX 요청
    var xhrCheck = new XMLHttpRequest();
    xhrCheck.open("GET", "/exhibition/checkUserReview?exhNo=" + exhNo + "&userNo=" + userNo, true);
    xhrCheck.onreadystatechange = function() {
        if (xhrCheck.readyState === 4) {
            if (xhrCheck.status === 200) {
                var response = JSON.parse(xhrCheck.responseText);
                if (response.hasReview) {
                    // 유저가 이미 댓글을 작성했으면 폼 숨기기
                    document.getElementById("reviewForm").style.display = "none";
                } else {
                    // 유저가 댓글을 작성하지 않았다면 폼을 보여주기
                    document.getElementById("reviewForm").style.display = "block";
                }
            } 
        }
    };
    xhrCheck.send();
});

document.getElementById("addReply").onclick = function() {
    var reviewText = document.getElementById("reviewText").value;
    var selectedRating = document.querySelector("#selectedRating span").textContent; // 선택한 별점 값을 가져옴
    var exhNo = document.getElementById("exhNo").value;
    var reviewForm = document.getElementById("reviewForm");

    if (!userNo) {
    	showLoginModal();
        return;
    }

    // 유저가 이미 댓글을 작성했는지 확인하는 AJAX 요청
    var xhrCheck = new XMLHttpRequest();
    xhrCheck.open("GET", "/exhibition/checkUserReview?exhNo=" + exhNo + "&userNo=" + userNo, true);
    xhrCheck.onreadystatechange = function() {
        if (xhrCheck.readyState === 4) {
            if (xhrCheck.status === 200) {
                var response = JSON.parse(xhrCheck.responseText);
                if (response.hasReview) {
                    reviewForm.style.display = "none";
                    return;
                }
                // 댓글 등록
                registerReview(); // 매개변수 없이 호출
            } else {
                alert("댓글 등록 여부 확인에 실패했습니다.");
            }
        }
    };
    xhrCheck.send();
};

// 댓글 등록 함수 (매개변수 없이 호출)
function registerReview() {
    var reviewText = document.getElementById("reviewText").value;
    var selectedRating = document.querySelector("#selectedRating span").textContent;
    var exhNo = document.getElementById("exhNo").value;
    var reviewForm = document.getElementById("reviewForm");

    // 유효성 검사
    if (!reviewText) {
        alert("후기를 작성해주세요.");
        return;
    }
    if (!selectedRating) {
        alert("별점을 선택해주세요.");
        return; // 별점을 선택하지 않았을 경우 경고
    }

    // AJAX 요청
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "/exhibition/addReview", true);
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                alert("댓글이 등록되었습니다.");
                reviewForm.style.display = "none";
                resetReviewForm(); 
                fetchAndDisplayReviews(); 
            } else {
                alert("댓글 등록이 실패했습니다.");
            }
        }
    };

    var data = JSON.stringify({
        exhNo: exhNo,
        userNo: userNo,
        exhComment: reviewText,
        exhScore: selectedRating // 선택한 별점을 사용
    });

    xhr.send(data);
}

let currentPage = 1;  // 현재 페이지 추적을 위한 변수 추가
const pageSize = 5;   // 한 페이지에 표시할 리뷰 개수

function fetchAndDisplayReviews(exhNo, page = 1) {

    // Fetch 요청에 pageSize와 page를 포함시킴
    fetch(`/exhibition/userReviews?exhNo=${exhNo}&page=${page}&pageSize=${pageSize}`)
        .then(response => response.json())
        .then(data => {
            const reviewsList = document.getElementById('reviewsList');
            reviewsList.innerHTML = ''; // 기존 목록 초기화

            // data.reviews가 정의되고 배열일 경우만 처리
            if (Array.isArray(data.reviews) && data.reviews.length > 0) {  // reviews 배열이 존재하는지 확인
                data.reviews.forEach(reply => {
                    const listItem = document.createElement('li');
                    listItem.innerHTML = `
                        <div class="reply-container">
                            <div class="reply-header">
                                <input type="hidden" class="exhReplyNo" value="${reply.exhReplyNo}">
                                <input type="hidden" class="userNo" value="${reply.userNo}">
                                <strong class="user-no" id="user-no">유저번호: ${reply.userNo}</strong>
                                <div class="exh-score">
                                    ${generateStarIcons(reply.exhScore, true)}
                                    <input type="hidden" class="score-value" value="${reply.exhScore}">
                                </div>
                                <span class="exh-reg-date">등록 날짜: ${new Date(reply.exhRegDate).toLocaleDateString()}</span>
                            </div>
                            <textarea class="exh-comment" rows="10" cols="3" readonly>${reply.exhComment}</textarea>
                            <div class="button-container">
                                <input type="button" class="updateReply" value="수정하기">
                                <input type="button" class="updateReplySend" value="수정완료" style="display: none">
                                <input type="button" class="updateReplyCancel" value="수정취소" style="display: none">
                                <input type="button" class="deleteReply" value="삭제하기">
                            </div>
                        </div>
                    `;
                    
                    reviewsList.appendChild(listItem);
                    
                    const updateReplyBtn = listItem.querySelector('.updateReply');
                    const updateReplySendBtn = listItem.querySelector('.updateReplySend');
                    const updateReplyCancelBtn = listItem.querySelector('.updateReplyCancel');
                    const deleteReplyBtn = listItem.querySelector('.deleteReply');
                    const userNoInput = listItem.querySelector('.userNo'); 
                    const replyUserNo = userNoInput.value; 

                    if (userNo !== replyUserNo) {
                        updateReplyBtn.style.display = 'none';
                        updateReplySendBtn.style.display = 'none';
                        updateReplyCancelBtn.style.display = 'none';
                        deleteReplyBtn.style.display = 'none';
                    }
                });
                renderPaginationControls(data.totalPages);  // totalPages 값을 서버로부터 전달받아 처리
            } else {
                reviewsList.innerHTML = '<li>후기가 없습니다.</li>';
            }
        })
        .catch(error => {
            console.error('데이터를 가져오는 중 오류 발생:', error);
        });
}

function renderPaginationControls(totalPages) {
    const paginationContainer = document.getElementById('paginationControls');
    paginationContainer.innerHTML = '';
    
    for (let i = 1; i <= totalPages; i++) {
        const pageButton = document.createElement('button');
        pageButton.textContent = i;
        pageButton.classList.add('page-button');
        if (i === currentPage) {
            pageButton.classList.add('active');
        }
        pageButton.addEventListener('click', () => {
            currentPage = i;
            fetchAndDisplayReviews(document.getElementById("exhNo").value, currentPage);
        });
        paginationContainer.appendChild(pageButton);
    }
}

//이벤트 위임 설정
document.getElementById('reviewsList').addEventListener('click', function(event) {
    if (event.target.classList.contains('updateReply')) {
        handleUpdateClick(event.target);
    } else if (event.target.classList.contains('updateReplySend')) {
        handleUpdateSendClick(event.target);
    } else if (event.target.classList.contains('deleteReply')) {
        handleDeleteClick(event.target);
    } else if (event.target.classList.contains('updateReplyCancel')) {
        handleUpdateCancel(event.target);
    }
    
});

function handleUpdateClick(button) {
    const replyContainer = button.closest('.reply-container');
    const textarea = replyContainer.querySelector('.exh-comment');
    const updateReplySend = replyContainer.querySelector('.updateReplySend');
    const updateReplyCancel = replyContainer.querySelector('.updateReplyCancel');
    const stars = replyContainer.querySelectorAll('.fa-star');
    const scoreValueInput = replyContainer.querySelector('.score-value');

    // 원래 별점 값을 저장
    stars.forEach(star => {
        star.setAttribute('data-original-score', scoreValueInput.value);
        star.setAttribute('onclick', 'updateRating(this)'); // 클릭 이벤트 설정
    });

    textarea.removeAttribute('readonly'); // 텍스트 영역 수정 가능하도록 설정
    textarea.focus();
    updateReplySend.style.display = 'inline'; // 수정 완료 버튼 보이기
    updateReplyCancel.style.display = 'inline';
    button.style.display = 'none'; // 수정하기 버튼 숨기기
}

function handleUpdateSendClick(button) {
    const replyContainer = button.closest('.reply-container');
    const textarea = replyContainer.querySelector('.exh-comment');
    const exhReplyNo = replyContainer.querySelector('.exhReplyNo').value; // 후기 번호 가져오기
    const userNoText = replyContainer.querySelector('.user-no').textContent; // 유저번호 텍스트 가져오기
    const userNo = userNoText.split(': ')[1];
    const updatedComment = textarea.value;
    const exhScore = replyContainer.querySelector('.score-value').value; // 수정된 별점

    // 유효성 검사
    if (!updatedComment) {
        alert("수정 내용을 입력해 주세요.");
        return;
    }

    // AJAX 요청
    const xhr = new XMLHttpRequest();
    xhr.open("PUT", "/exhibition/updateReview", true); // PUT 요청으로 수정 처리
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                alert("후기가 수정되었습니다.");
                textarea.setAttribute('readonly', true); // 텍스트 영역 읽기 전용으로 변경
                button.style.display = 'none'; // 수정 완료 버튼 숨기기
                replyContainer.querySelector('.updateReplyCancel').style.display = 'none'; // 수정 취소 버튼 숨기기
                
                // 변경된 내용을 즉시 보여주기
                fetchAndDisplayReviews(); // 댓글 목록 새로 고침
                
                // 수정 날짜 업데이트
                const updateDateSpan = replyContainer.querySelector('.exh-reg-date'); // 등록 날짜 요소 가져오기
                const currentDate = new Date(); // 현재 날짜 가져오기
                updateDateSpan.textContent = `수정 날짜: ${currentDate.toLocaleDateString()}`; // 수정 날짜로 업데이트
                updateAverageStarRating();
            } else {
                alert("후기 수정이 실패했습니다.");
            }
        }
    };

    const data = JSON.stringify({
        exhReplyNo: exhReplyNo, // 후기 번호
        exhComment: updatedComment, // 수정된 후기 내용
        userNo: userNo, // 사용자 ID
        exhScore: exhScore // 수정된 별점
    });

    xhr.send(data);
}

function handleUpdateCancel(button) {
    const replyContainer = button.closest('.reply-container');
    const textarea = replyContainer.querySelector('.exh-comment');
    const updateReplyButton = replyContainer.querySelector('.updateReply');
    const updateReplySend = replyContainer.querySelector('.updateReplySend');
    const updateReplyCancel = replyContainer.querySelector('.updateReplyCancel');
    const stars = replyContainer.querySelectorAll('.fa-star');

    textarea.setAttribute('readonly', true);

    // 텍스트 내용 원래대로 되돌리기
    textarea.value = textarea.defaultValue;

    // 별점 원래대로 되돌리기
    const originalScore = stars[0].getAttribute('data-original-score');
    stars.forEach(star => {
        star.classList.remove('active');
        star.removeAttribute('onclick'); // 클릭 이벤트 제거로 수정 불가능하도록 설정
        if (star.getAttribute('data-value') <= originalScore) {
            star.classList.add('active');
        }
    });

    // hidden input의 별점 값도 원래대로 복원
    const scoreValueInput = replyContainer.querySelector('.score-value');
    scoreValueInput.value = originalScore;

    // 버튼 상태 변경
    updateReplySend.style.display = 'none';
    updateReplyCancel.style.display = 'none';
    updateReplyButton.style.display = 'inline';
}

function handleDeleteClick(button) {
    const replyContainer = button.closest('.reply-container');
    const userNo = replyContainer.querySelector('.user-no').textContent.split(': ')[1]; 
    const exhReplyNo = replyContainer.querySelector('.exhReplyNo').value;
    var reviewForm = document.getElementById("reviewForm");

    // 삭제 확인 대화상자 표시
    const isConfirmed = confirm('정말로 이 댓글을 삭제하시겠습니까?');
    
    if (isConfirmed) {
        fetch(`/exhibition/deleteComment?userNo=${userNo}&exhReplyNo=${exhReplyNo}`, {
            method: 'GET',
        })
        .then(response => {
            if (response.ok) {
                replyContainer.remove();
                alert('댓글이 삭제되었습니다.');
                reviewForm.style.display = "block";
                updateAverageStarRating();
            } else {
                alert('댓글 삭제에 실패했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('댓글 삭제 중 오류가 발생했습니다.');
        });
    }
}


function generateStarIcons(rating, editable = false) {
    let stars = '';
    for (let i = 1; i <= 5; i++) {
        stars += `<span class="fa fa-star ${i <= rating ? 'active' : ''}" data-value="${i}">★</span>`;
    }

    // 별점 아이콘을 추가한 후 이벤트 리스너 등록
    const starContainer = document.createElement('div'); // 별점을 위한 div 생성
    starContainer.innerHTML = stars;

    if (editable) {
        starContainer.querySelectorAll('.fa-star').forEach(star => {
            star.addEventListener('click', function() {
                updateRating(this);
            });
        });
    }

    return starContainer.innerHTML; // HTML 문자열로 반환
}

function updateRating(star) {
    const scoreContainer = star.parentElement; 
    const scoreValueInput = scoreContainer.querySelector('.score-value'); 
    const newRating = star.getAttribute('data-value'); 

    scoreValueInput.value = newRating; // hidden input에 새 별점 값 저장
    const stars = scoreContainer.querySelectorAll('.fa-star'); 

    stars.forEach(s => {
        s.classList.remove('active');
        if (s.getAttribute('data-value') <= newRating) {
            s.classList.add('active');
        }
    });
}

// 페이지가 로드될 때 댓글 목록을 가져옴
document.addEventListener('DOMContentLoaded', function() {
	fetchAndDisplayReviews(document.getElementById("exhNo").value, currentPage);
    updateAverageStarRating();
});

// 댓글 등록 후 폼 초기화 함수
function resetReviewForm() {
    document.getElementById("reviewText").value = ""; // 후기 텍스트 초기화
    document.querySelectorAll("#newReviewStars span").forEach(s => s.classList.remove("active")); // 별점 초기화
    document.querySelector("#selectedRating span").textContent = "0"; // 선택한 별점 표시 초기화
}

//평균 별점 가져오기
function updateAverageStarRating() {
    const exhNo = document.getElementById("exhNo").value;

    fetch(`/exhibition/getAverageRating?exhNo=${exhNo}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('서버 응답 실패');
            }
            return response.json();
        })
        .then(data => {
            let avgRating = data; // 서버에서 받은 평균 별점

            if (avgRating === null || isNaN(avgRating)) {
                avgRating = 0.0;  // null이거나 NaN일 경우 0.0으로 처리
            }

            const roundedRating = Math.round(avgRating);  // 평균 별점 반올림 처리
            const stars = document.querySelectorAll("#averageStarRating span"); // 별점 아이콘

            // 평균 별점 값 소수점 2자리까지 표시
            const formattedRating = avgRating.toFixed(1);  

            // 평균 별점 값 표시
            document.getElementById("averageRatingValue").textContent = formattedRating + "점";

            // 별점 아이콘을 채우거나 비우기
            stars.forEach((star, index) => {
                if (index < roundedRating) {
                    // 채워진 별 (filled)
                    star.classList.add("filled");
                    star.classList.remove("empty");
                } else {
                    // 빈 별 (empty)
                    star.classList.add("empty");
                    star.classList.remove("filled");
                }
            });
        })
        .catch(error => {
            console.error("평균 별점 불러오기 에러:", error);
        });
}


//전시회 상세 이미지 로드 함수
function loadExhibitionDetailImages(exhNo) {
    const detailedImageContainer = document.getElementById('detailedImageContainer');
    detailedImageContainer.innerHTML = '';  // 기존 이미지 삭제

    // 로딩 중 메시지 표시
    const loadingMessage = document.createElement('p');
    loadingMessage.textContent = '전시회 이미지를 로딩 중입니다...';
    detailedImageContainer.appendChild(loadingMessage);

    // exhNo를 쿼리 파라미터로 포함하여 fetch 호출
    fetch(`/exhibition/exhDetailImg?exhNo=${exhNo}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('서버 오류: ' + response.status);  // 응답이 정상적이지 않으면 오류 처리
            }
            return response.json();  // JSON으로 응답을 처리
        })
        .then(exhibitionData => {
            // 로딩 중 메시지 삭제
            detailedImageContainer.innerHTML = '';  

            if (exhibitionData.length === 0) {
                const noImageMessage = document.createElement('p');
                noImageMessage.textContent = '전시회 이미지가 없습니다.';
                detailedImageContainer.appendChild(noImageMessage);
                return;
            }

            exhibitionData.forEach(item => {
                const img = document.createElement('img');

                // 다양한 해상도의 이미지를 제공
                img.srcset = `
                    /exhibition/exhibitionDetailImages/${item.uuid}_${encodeURIComponent(item.fileName)} 1x, 
                    /exhibition/exhibitionDetailImages/${item.uuid}_${encodeURIComponent(item.fileName.replace('.jpg', '-2x.jpg'))} 2x
                `;
                
                img.src = `/exhibition/exhibitionDetailImages/${item.uuid}_${encodeURIComponent(item.fileName)}`;  // 기본 이미지
                img.alt = `Exhibition Image: ${item.fileName}`;
                img.loading = 'lazy';  // 이미지 로딩 최적화     

                // 이미지 로딩 완료 후 보여주기
                img.onload = () => {
                    img.style.display = 'block';  // 이미지가 로드되면 보이게 설정
                };

                img.onerror = () => {
                    img.style.display = 'none';  // 오류 발생 시 이미지 숨기기
                    console.error('이미지 로드 오류:', img.src);
                };

                img.addEventListener('click', () => {
                    goToDetailPage(item.exhNo);  // 전시회 상세 페이지로 이동
                });

                detailedImageContainer.appendChild(img);
            });

        })
        .catch(error => {
            console.error('전시회 정보 로드 에러:', error);
            detailedImageContainer.innerHTML = '<p>전시회 이미지 로드에 실패했습니다. 다시 시도해 주세요.</p>';
        });
}


document.addEventListener('DOMContentLoaded', function() {
    const exhNo = document.getElementById("exhNo").value;  
    loadExhibitionDetailImages(exhNo);
    loadExhibitionImages(exhNo);
});

//로그인 모달을 표시하는 함수
function showLoginModal() {
    var modal = document.getElementById("loginModal");
    modal.style.display = "block";

    // 로그인 페이지로 이동하는 버튼 클릭 시
    document.getElementById("goToLogin").onclick = function() {      
            location.href = "/member/login"; 
    }

    // 모달 닫기 버튼 클릭 시 모달 숨기기
    document.querySelector(".close").onclick = function() {
        modal.style.display = "none";
    };

    // 모달 외부 클릭 시 모달 숨기기
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    };
}



