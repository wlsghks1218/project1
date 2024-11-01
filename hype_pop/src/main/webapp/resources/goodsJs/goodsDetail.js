const rs = replyService;

document.addEventListener("DOMContentLoaded", function () {
    let currentPage = 1;
    const pageSize = 5;
    const goodsBanner = document.getElementById("goodsBanner");
    const goodsDetailImg = document.querySelector(".goodsDetailImg");
    const fileNameBanner = document.getElementById("fileNameBanner").value;
    const fileNameDetail = document.getElementById("fileNameDetail").value;

    showReplyList(currentPage);
    displayAvgStars();
    chkReplied();
    
    function displayAvgStars() {
        const avgStarsContainer = document.getElementById('avgStarsContainer');
        const avgStarString = document.querySelector('.avgStarString');
        const gno = new URLSearchParams(location.search).get('gno');
        let stars = '';

        fetch('/gReply/avgStars/' + gno)
        .then(response => response.json())
        .then(result => {
            const avgScore = parseFloat(result);
            for (let i = 1; i <= 5; i++) {
                stars += i <= avgScore ? '<span style="color: gold;">★</span>' : '<span style="color: gray;">★</span>';
            }
            avgStarsContainer.innerHTML = stars;
            avgStarString.innerHTML = "평균 별점 : " + avgScore.toFixed(1);
        })
        .catch(err => console.error('Error:', err));
    }

    function setBackgroundImage(item, path, fileName) {
        fetch(`/${path}/${encodeURIComponent(fileName)}`)
            .then(response => response.blob())
            .then(blob => {
                const imageUrl = URL.createObjectURL(blob);
                item.style.backgroundImage = `url(${imageUrl})`;
                item.style.backgroundSize = "cover";
                item.style.backgroundPosition = "center center";
                item.style.backgroundRepeat = "no-repeat";
            })
            .catch(error => console.error('Error:', error));
    }

    // 사용 예
    setBackgroundImage(goodsBanner, "goodsStore/goodsBannerImages", fileNameBanner);
    setBackgroundImage(goodsDetailImg, "goodsStore/goodsDetailImages", fileNameDetail);

    // 수량 조절
    const decreaseBtn = document.getElementById('decreaseBtn');
    const increaseBtn = document.getElementById('increaseBtn');
    const quantityInput = document.getElementById('quantity');
    const totalPriceDisplay = document.getElementById('totalPrice');
    const goodsPrice = parseFloat(document.getElementById('goodsPrice').textContent.replace(/[^0-9]/g, ''));

    decreaseBtn.addEventListener('click', () => {
        let quantity = parseInt(quantityInput.value);
        if (quantity > 1) {
            quantity--;
            quantityInput.value = quantity;
            totalPriceDisplay.textContent = (quantity * goodsPrice).toLocaleString() + ' 원';
        }
    });

    increaseBtn.addEventListener('click', () => {
        let quantity = parseInt(quantityInput.value);
        quantity++;
        quantityInput.value = quantity;
        totalPriceDisplay.textContent = (quantity * goodsPrice).toLocaleString() + ' 원';
    });

    totalPriceDisplay.textContent = (1 * goodsPrice).toLocaleString() + ' 원';

    const starRating = document.querySelectorAll('#newReviewStars span');
    const ratingInput = document.getElementById('rating');
    const selectedRating = document.getElementById('selectedRating');

    starRating.forEach(star => star.style.color = 'gray');

    starRating.forEach((star, index) => {
        star.addEventListener('mouseover', function () {
            for (let i = 0; i <= index; i++) {
                starRating[i].style.color = 'gold';
            }
            selectedRating.textContent = `선택한 별점: ${index + 1}`;
        });

        star.addEventListener('mouseout', function () {
            starRating.forEach(s => s.style.color = 'gray');
            const selectedValue = parseInt(ratingInput.value);
            for (let i = 0; i < selectedValue; i++) {
                starRating[i].style.color = 'gold';
            }
            selectedRating.textContent = `선택한 별점: ${selectedValue}`;
        });

        star.addEventListener('click', function () {
            const rating = this.getAttribute('dataValue');
            ratingInput.value = rating;
            selectedRating.textContent = `선택한 별점: ${rating}`;

            starRating.forEach(s => s.style.color = 'gray');
            for (let i = 0; i < rating; i++) {
                starRating[i].style.color = 'gold';
            }
        });
    });

    function chkReplied() {
        const userNo = 1;
        const gno = new URLSearchParams(location.search).get('gno');
        fetch(`/gReply/chkReplied/${userNo}/${gno}`)
            .then(response => response.text())
            .then(result => {
                const reviewForm = document.getElementById("reviewForm");
                const reviewText = reviewForm.querySelector("#reviewText");
                const ratingInput = reviewForm.querySelector("#newReviewStars");
                const selectedRating = document.getElementById("selectedRating");
                if (result === '1') {
                    reviewForm.style.display = 'none';
                } else {
                    reviewForm.style.display = 'block';
                    reviewText.value = '';
                    ratingInput.value = '0';
                    selectedRating.textContent = '선택한 별점: 0';
                    document.querySelectorAll('#newReviewStars span').forEach(star => {
                        star.style.color = 'gray';
                    });
                    starRating.forEach((star, index) => {
                        star.addEventListener('mouseover', function () {
                            for (let i = 0; i <= index; i++) {
                                starRating[i].style.color = 'gold';
                            }
                            selectedRating.textContent = `선택한 별점: ${index + 1}`;
                        });

                        star.addEventListener('mouseout', function () {
                            starRating.forEach(s => s.style.color = 'gray');
                            const selectedValue = parseInt(ratingInput.value);
                            for (let i = 0; i < selectedValue; i++) {
                                starRating[i].style.color = 'gold';
                            }
                            selectedRating.textContent = `선택한 별점: ${selectedValue}`;
                        });

                        star.addEventListener('click', function () {
                            const rating = this.getAttribute('dataValue');
                            ratingInput.value = rating;
                            selectedRating.textContent = `선택한 별점: ${rating}`;

                            starRating.forEach(s => s.style.color = 'gray');
                            for (let i = 0; i < rating; i++) {
                                starRating[i].style.color = 'gold';
                            }
                        });
                    });
                }
            })
            .catch(error => console.error('Error:', error));
    }
    
    document.getElementById('addReply').addEventListener('click', function (event) {
        event.preventDefault();
        const rating = document.getElementById('rating').value;
        const reviewText = document.getElementById('reviewText').value;
        const gno = new URLSearchParams(location.search).get('gno');
        const userId = "유저ID입니다.";
        const userNo = 1;

        rs.add({
            gno: gno,
            userNo: 1,
            gcomment: reviewText,
            gscore: rating,
            userId: userId
        }, function (result) {
            if (result === "success") {
                showReplyList(currentPage);
                chkReplied();
            } else {
                alert("댓글 등록 실패");
            }
        })
    });

    function showReplyList(page) {
        const gno = new URLSearchParams(location.search).get('gno');
        const userNo = 1;

        rs.getList(gno, userNo, currentPage, pageSize, function (data) {
            const replyUlMine = document.querySelector(".myChat");
            const replyUlAll = document.querySelector(".allChat");
            replyUlMine.innerHTML = "";
            replyUlAll.innerHTML = "";

            // 댓글 목록 초기화
            let myReplyMsg = '';
            let allReplyMsg = '';

            // 내 댓글 추가
            const myReply = data.myReply;
            if (myReply) {
                myReplyMsg += `<li dataRno=${myReply.greplyNo} class="myChat">`;
                myReplyMsg += `<div class="chatHeader">`;
                myReplyMsg += `<div class="userRating"></div>`;
                myReplyMsg += `<strong class="primaryFont">내 댓글: ${myReply.userId}</strong>`;
                myReplyMsg += `<small class="pullRight">${displayTime(myReply.gupdateDate)}</small>`;
                myReplyMsg += `<div class="kebabMenu">⋮</div>`;
                myReplyMsg += `<div class="menuOptions" style="visibility: hidden;">`;
                myReplyMsg += `<button class="editBtn">수정하기</button>`;
                myReplyMsg += `<button class="deleteBtn">삭제하기</button>`;
                myReplyMsg += `</div></div>`;
                myReplyMsg += `<p>${myReply.gcomment}</p>`;
                myReplyMsg += `</li>`;
            }

            // 전체 댓글 추가
            const allReplies = data.replyList;
            allReplies.forEach(vo => {
                allReplyMsg += `<li dataRno=${vo.greplyNo}>`;
                allReplyMsg += `<div class="chatHeader">`;
                allReplyMsg += `<div class="userRating"></div>`;
                allReplyMsg += `<strong class="primaryFont">${vo.userId}</strong>`;
                allReplyMsg += `<small class="pullRight">${displayTime(vo.gupdateDate)}</small>`;
                allReplyMsg += `<p>${vo.gcomment}</p>`;
                allReplyMsg += `</li>`;
            });

            replyUlMine.innerHTML = myReplyMsg;
            replyUlAll.innerHTML = allReplyMsg;

            displayPagingButtons(data.totalReplies);
            displayStarsForReplies(myReply, allReplies);
            bindEditDeleteEvents();
            bindKebabMenuEvents();
            displayAvgStars();
        });
    }

    function bindEditDeleteEvents() {
        // 수정 버튼 이벤트
        document.querySelectorAll('.editBtn').forEach(editBtn => {
            editBtn.addEventListener('click', function () {
                const commentLi = editBtn.closest('li.myChat');
                const commentP = commentLi.querySelector('p');
                const originalComment = commentP.textContent;
                const userRatingDiv = commentLi.querySelector('.userRating');
                const originalRating = parseInt(userRatingDiv.getAttribute('data-value'));
                let newGscore = originalRating;
                const dataRno = commentLi.getAttribute('dataRno'); // 댓글의 고유 ID (data-rno)

                // 댓글 수정
                const editInput = document.createElement('input');
                editInput.classList.add('editCommentInput');
                editInput.type = 'text';
                editInput.value = originalComment;
                commentP.replaceWith(editInput);

                // 별점 선택란으로 변경
                const newRatingDiv = document.createElement('div');
                newRatingDiv.classList.add('editRating');
                let stars = '';
                for (let i = 1; i <= 5; i++) {
                    stars += `<span data-value="${i}" style="color: ${i <= originalRating ? 'gold' : 'gray'};">★</span>`;
                }
                newRatingDiv.innerHTML = stars;
                userRatingDiv.replaceWith(newRatingDiv);

                const saveBtn = document.createElement('button');
                saveBtn.textContent = '수정 완료';
                saveBtn.classList.add('styledButton', 'saveEditBtn');
                const cancelBtn = document.createElement('button');
                cancelBtn.textContent = '수정 취소';
                cancelBtn.classList.add('styledButton', 'cancelEditBtn');
                commentLi.append(saveBtn, cancelBtn);

                // 별점 선택 기능 추가
                newRatingDiv.querySelectorAll('span').forEach((star, index) => {
                    star.addEventListener('mouseover', () => {
                        newRatingDiv.querySelectorAll('span').forEach((s, i) => {
                            s.style.color = i <= index ? 'gold' : 'gray';
                        });
                    });

                    star.addEventListener('mouseout', () => {
                        newRatingDiv.querySelectorAll('span').forEach((s, i) => {
                            s.style.color = i < newGscore ? 'gold' : 'gray';
                        });
                    });

                    star.addEventListener('click', () => {
                        const rating = index + 1;
                        newRatingDiv.querySelectorAll('span').forEach((s, i) => {
                            s.style.color = i < rating ? 'gold' : 'gray';
                        });
                        newGscore = rating;
                    });
                });

                cancelBtn.addEventListener('click', () => {
                    editInput.replaceWith(commentP);
                    newRatingDiv.replaceWith(userRatingDiv); // 원래 별점으로 복원
                    saveBtn.remove();
                    cancelBtn.remove();
                });

                saveBtn.addEventListener('click', () => {
                    const newComment = editInput.value;
                    fetch('/gReply/updateReply/', {
                        method: 'PUT',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({
                            gno: new URLSearchParams(location.search).get('gno'),
                            userNo: 1,
                            gcomment: newComment,
                            gscore : newGscore
                        }),
                    })
                    .then(response => response.text())
                    .then(result => {
                        if (result === "success") {
                            showReplyList(currentPage);
                            displayAvgStars();
                        } else {
                            alert("댓글 수정 실패");
                        }
                    })
                    .catch(err => console.error('Error:', err));
                });
            });
        });

        // 삭제 버튼 이벤트
        document.querySelectorAll('.deleteBtn').forEach(deleteBtn => {
            deleteBtn.addEventListener('click', function () {
                const gno = new URLSearchParams(location.search).get('gno');
                const userNo = 1;

                fetch(`/gReply/deleteReply/${gno}/${userNo}`, { method: 'DELETE' })
                    .then(response => response.json())
                    .then(result => {
                        if (result === 1) {
                            showReplyList(currentPage);
                            chkReplied();
                        } else {
                            alert("댓글 삭제 실패");
                        }
                    })
                    .catch(err => console.error('Error:', err));
            });
        });
    }

    function bindKebabMenuEvents() {
        // 케밥 메뉴 버튼 이벤트
        document.querySelectorAll('.kebabMenu').forEach(kebab => {
            kebab.addEventListener('click', function () {
                const menu = this.nextElementSibling;
                if (menu.style.visibility === 'hidden' || menu.style.visibility === '') {
                    menu.style.visibility = 'visible';
                } else {
                    menu.style.visibility = 'hidden';
                }
            });
        });
    }

    function displayStarsForReplies(myReply, allReplies) {
        if (myReply) {
            const myUserRatingContainer = document.querySelector('.myChat .userRating');
            displayStars(myReply.gscore, myUserRatingContainer);
        }

        allReplies.forEach(vo => {
            const userRatingContainer = document.querySelector(`li[dataRno="${vo.greplyNo}"] .userRating`);
            displayStars(vo.gscore, userRatingContainer);
        });
    }

    function displayPagingButtons(totalReplies) {
        const totalPages = Math.ceil(totalReplies / pageSize);
        const paginationDiv = document.querySelector(".pagination");
        paginationDiv.innerHTML = "";

        for (let i = 1; i <= totalPages; i++) {
            const pageBtn = document.createElement("button");
            pageBtn.textContent = i;
            pageBtn.classList.add("pageBtn");
            if (i === currentPage) pageBtn.classList.add("active");
            pageBtn.addEventListener("click", function () {
                currentPage = i;
                showReplyList(i);
            });
            paginationDiv.appendChild(pageBtn);
        }
    }

    function displayStars(score, container) {
        let stars = '';
        for (let i = 1; i <= 5; i++) {
            stars += `<span data-value="${i}" style="color: ${i <= score ? 'gold' : 'gray'};">★</span>`;
        }
        container.setAttribute('data-value', score);
        container.innerHTML = stars;
    }
    function displayTime(unixTimeStamp) {
        const myDate = new Date(unixTimeStamp);
        const y = myDate.getFullYear();
        const m = String(myDate.getMonth() + 1).padStart(2, '0');
        const d = String(myDate.getDate()).padStart(2, '0');
        return `${y}-${m}-${d}`;
    }

    function likeBtnChange() {
        const gno = new URLSearchParams(location.search).get('gno');
        const userNo = 1;

        fetch(`/goodsStore/chkLike/${gno}/${userNo}`)
            .then(response => response.json())
            .then(result => {
                const likeIcon = document.getElementById("likeIcon");
                likeIcon.src = result === 0 ? "/resources/images/emptyHeart.png" : "/resources/images/fullHeart.png";
            })
            .catch(err => console.error('Error:', err));
    }

    document.querySelector("#chkLike").addEventListener('click', () => {
        const gno = new URLSearchParams(location.search).get('gno');
        const userNo = 1;

        fetch(`/goodsStore/changeLike/${gno}/${userNo}`)
            .then(response => response.json())
            .then(() => likeBtnChange())
            .then(() => fetch(`/goodsStore/getLikeCount/${gno}`))
            .then(response => response.json())
            .then(likeCount => {
                document.querySelector("#goodsLike").textContent = `좋아요: ${likeCount}회`;
            })
            .catch(err => console.error('Error:', err));
    });
    likeBtnChange();
    
    document.getElementById("moveToStore").addEventListener('click', ()=>{
        const gno = new URLSearchParams(location.search).get('gno');
    	location.href=`/goodsStore/goodsToPopup?gno=${gno}`;
    })
});