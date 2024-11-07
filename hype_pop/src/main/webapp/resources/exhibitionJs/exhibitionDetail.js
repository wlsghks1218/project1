document.getElementById('viewingInfoToggle').addEventListener('click', () => showSection('viewingInfo'));
document.getElementById('viewingDetailToggle').addEventListener('click', () => showSection('detailsSection'));
document.getElementById('replyToggle').addEventListener('click', () => showSection('replySection'));

// 특정 섹션을 표시하고 나머지 섹션은 숨기기
function showSection(visibleSectionId) {
    const sections = ['viewingInfo', 'detailsSection', 'replySection'];
    sections.forEach(sectionId => {
        document.getElementById(sectionId).style.display = (sectionId === visibleSectionId) ? 'block' : 'none';
    });
}

document.addEventListener("DOMContentLoaded", function() {
    const exhNo = document.getElementById("exhNo").value;
    const userNo = 2; // 현재 사용자 ID (실제로는 로그인한 사용자 ID로 설정해야 함)

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

// 좋아요 표시 기능
function toggleHeart(element) {
    const exhNo = document.getElementById("exhNo").value;
    const userNo = 2; // 현재 사용자 ID (실제로는 로그인한 사용자 ID로 설정해야 함)
    const isActive = element.classList.toggle("active");

    const xhr = new XMLHttpRequest();
    xhr.open("POST", "/exhibition/" + (isActive ? "addLike" : "removeLike"), true);
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

    xhr.onload = function() {
        if (xhr.status === 200) {
            console.log(isActive ? "좋아요가 등록되었습니다." : "좋아요가 삭제되었습니다.");

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

//댓글 등록 함수
document.getElementById("addReply").onclick = function() {
    var reviewText = document.getElementById("reviewText").value;
    var selectedRating = document.querySelector("#selectedRating span").textContent; // 선택한 별점 값을 가져옴
    var exhNo = document.getElementById("exhNo").value;
    var userNo = 2; // 예시로 userNo를 1로 설정, 실제로는 로그인 사용자 ID로 대체

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
                resetReviewForm(); // 댓글 등록 후 폼 초기화
                fetchAndDisplayReviews(); // 댓글 목록 새로 고침
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
};
// 댓글 목록을 렌더링할 때 수정하기 버튼에 클릭 이벤트 추가
function fetchAndDisplayReviews() {
    fetch('/exhibition/userReviews')
        .then(response => response.json())
        .then(data => {
            const reviewsList = document.getElementById('reviewsList');
            reviewsList.innerHTML = ''; // 기존 목록 초기화
            if (data.length > 0) {
                data.forEach(reply => {
                    const listItem = document.createElement('li');
                    listItem.innerHTML = `
                        <div class="reply-container">
                    		<div class="reply-header">
                    			<input type="hidden" class="exhReplyNo" value="${reply.exhReplyNo}">
                    			<strong class="user-no" id="user-no">유저번호: ${reply.userNo}</strong>
                    			<div class="exh-score">
                    			${generateStarIcons(reply.exhScore, true)}
                    			<input type="hidden" class="score-value" value="${reply.exhScore}"> <!-- 별점 값을 저장하는 hidden input -->
                    			</div>
                    			<span class="exh-reg-date">등록 날짜: ${new Date(reply.exhRegDate).toLocaleDateString()}</span>               			
                    		</div>
                    		<textarea class="exh-comment" rows="10" cols="3" readonly>${reply.exhComment}</textarea>
                    		<div class="button-container">
                    			<input type="button" class="updateReply" value="수정하기"> <!-- 수정 -->
                    			<input type="button" class="updateReplySend" value="수정완료" style="display: none">                    			
                    			<input type="button" class="updateReplyCancel" value="수정취소" style="display: none">                    			
                    			<input type="button" class="deleteReply" value="삭제하기">
                    		</div>
                    	</div>
                    `;
                    reviewsList.appendChild(listItem);
                });
            } else {
                reviewsList.innerHTML = '<li>후기가 없습니다.</li>';
            }
        })
        .catch(error => {
            console.error('데이터를 가져오는 중 오류 발생:', error);
        });
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

    // 텍스트 영역을 다시 읽기 전용으로 설정
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
    const userNo = replyContainer.querySelector('.user-no').textContent.split(': ')[1]; // 유저번호 추출
    const exhReplyNo = replyContainer.querySelector('.exhReplyNo').value; // 전시회 댓글 번호 추출

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
document.addEventListener('DOMContentLoaded', fetchAndDisplayReviews);

// 댓글 등록 후 폼 초기화 함수
function resetReviewForm() {
    document.getElementById("reviewText").value = ""; // 후기 텍스트 초기화
    document.querySelectorAll("#newReviewStars span").forEach(s => s.classList.remove("active")); // 별점 초기화
    document.querySelector("#selectedRating span").textContent = "0"; // 선택한 별점 표시 초기화
}

