 currentPage = 1;
 currentFilter = '';
 searchQuery = '';
 let banners = [];
 let currentBanner = 0;
 let intervalId;

 function loadPopularExhs() {
	    fetch('/exhibition/popularExhs')  
	        .then(response => {
	            if (!response.ok) {
	                throw new Error('Network response was not ok');
	            }
	            return response.json();  
	        })
	        .then(data => {
	            const bannerContainer = document.querySelector('.banner');
	            data.forEach((item, index) => {

	                const img = document.createElement('img');
	                img.src = `/exhibition/popularExhs/${item.uuid}_${encodeURIComponent(item.fileName)}`;
	                img.alt = `Exhibition Image ${index + 1}`;

	                img.style.width = '100%';
	                img.style.height = '100%';
	                img.style.objectFit = 'contain'; 

	                img.addEventListener('click', () => {
	                    goToDetailPage(item.exhNo);  
	                });

	                bannerContainer.appendChild(img);
	                banners.push(img);
	                img.style.display = 'none';  
	            });

	            if (banners.length > 0) {
	                showBannerByIndex(0);  // 첫 번째 배너 표시
	            }

	            const buttons = document.querySelectorAll('.banner-btn');
	            buttons.forEach((button, index) => {
	                button.addEventListener('click', () => {
	                    showBannerByIndex(index);  // 클릭한 배너로 이동
	                    restartInterval(index);  // 클릭한 위치에서부터 자동 배너 전환 시작
	                });
	            });

	            // 첫 번째 배너부터 자동 전환 시작
	            intervalId = setInterval(showNextBanner, 2500);
	        })
	        .catch(error => console.error('Error fetching data:', error));  // 오류
																			// 처리
	}


 function showNextBanner() {
	    if (banners.length === 0) return;

	    // 현재 배너와 버튼을 초기화
	    banners[currentBanner].style.display = 'none';
	    document.querySelectorAll('.banner-btn')[currentBanner].style.backgroundColor = 'skyblue';

	    // 다음 배너 설정
	    currentBanner = (currentBanner + 1) % banners.length;

	    // 새 배너와 버튼 스타일 적용
	    banners[currentBanner].style.display = 'block';
	    document.querySelectorAll('.banner-btn')[currentBanner].style.backgroundColor = 'pink';
}

function showBannerByIndex(index) {
	    if (banners.length === 0) return;

	    // 모든 배너와 버튼을 초기화
	    banners.forEach(banner => (banner.style.display = 'none'));
	    document.querySelectorAll('.banner-btn').forEach(button => (button.style.backgroundColor = 'skyblue'));

	    // 선택된 배너와 버튼 스타일 적용
	    banners[index].style.display = 'block';
	    document.querySelectorAll('.banner-btn')[index].style.backgroundColor = 'pink';
	    currentBanner = index;  // 현재 배너 인덱스 업데이트
	}

	function restartInterval(startIndex) {
	    clearInterval(intervalId);  // 기존 interval 중지
	    currentBanner = startIndex;  // 클릭된 배너로 설정
	    intervalId = setInterval(showNextBanner, 2500);  // 새로운 interval 시작
}


 function restartInterval(startIndex) {
     clearInterval(intervalId);  // 기존 setInterval 멈추기
     currentBanner = startIndex;  // 클릭한 배너의 위치로 currentBanner 설정
     intervalId = setInterval(showNextBanner, 2500);  // 클릭한 위치에서부터 자동 배너 전환
														// 시작
 }

// 전시회 필터링 함수
 function applyFilter() {
	    currentFilter = document.getElementById("filterSelect").value || '';
	    searchQuery = document.getElementById("exhibitionSearchInput").value || '';

	    currentPage = 1; 
	    loadExhibitions(); 
	    
	    const exhibitionList = document.getElementById("exhibition-list");
	    if (exhibitionList) {
	        exhibitionList.scrollIntoView({ behavior: "smooth", block: "start" });
	    }
	}

// 전시회를 로드하는 함수
 function loadExhibitions() {
     fetch(`/exhibition/exhibitionPage?page=${currentPage}&filter=${currentFilter}&query=${encodeURIComponent(searchQuery)}`)
         .then(response => response.json())
         .then(exhibitionData => {
             const exhibitionList = document.getElementById("exhibition-list");
             const loadMoreButton = document.getElementById('load-more');

             if (currentPage === 1) {
                 exhibitionList.innerHTML = ""; // 페이지 초기화
             }

             // 전시회 데이터로 리스트 생성
             if (exhibitionData && exhibitionData.length > 0) {
                 exhibitionData.forEach(exhibition => {
                     const li = document.createElement("li");
                     li.className = "exhibition-info";

                     const startDate = formatDate(exhibition.exhStartDate);
                     const endDate = formatDate(exhibition.exhEndDate);

                     // 전시회 정보 표시
                     li.innerHTML = `
                         <div class="exhibition-schedule" onclick="toggleExhibitionContext(this)">
                             <p style="margin: 0;">${exhibition.exhName}</p>
                             <p style="margin: 0;">${startDate} ~ ${endDate}</p>
                             <a href="#" style="text-decoration: none;" onclick="goToDetailPage(${exhibition.exhNo})">
                                 <button style="background-color: #007BFF; color: white; border: none; padding: 5px 10px; border-radius: 5px;">
                                     상세페이지
                                 </button>
                             </a>
                         </div>
                         <div class="exhibition-context" style="display: none;">
                             <div class="exhibition-banner-img" id="banner-${exhibition.exhNo}" style="height: 200px; background-size: contain;"></div>
                             <table>
                                 <tbody>
                                     <tr><th>전시회 이름</th><td>${exhibition.exhName}</td></tr>
                                     <tr><th>전시회 기간</th><td>${startDate} ~ ${endDate}</td></tr>
                                     <tr><th>전시회 장소</th><td>${exhibition.exhLocation}</td></tr>
                                 </tbody>
                             </table>
                         </div>`;
                     exhibitionList.appendChild(li);
                 });

                 // '더보기' 버튼 표시 여부
                 loadMoreButton.style.display = 'block'; // 데이터가 있으면 표시
             } else {
                 // 전시회 데이터가 없을 경우 메시지 표시
                 const noExhibitionMessage = document.createElement("p");
                 noExhibitionMessage.textContent = "전시회가 없습니다.";
                 noExhibitionMessage.style.textAlign = "center"; // 중앙 정렬
                 noExhibitionMessage.style.marginTop = "20px"; // 여백 추가
                 exhibitionList.appendChild(noExhibitionMessage);

                 // '더보기' 버튼 숨김
                 loadMoreButton.style.display = 'none';
             }

             // 배너 이미지 가져오기
             fetch('/exhibition/exhbannerImg')
                 .then(response => response.json())
                 .then(bannerData => {
                     bannerData.forEach(banner => {
                         const exhibitionElement = document.getElementById(`banner-${banner.exhNo}`);
                         if (exhibitionElement) {
                             // 배너 이미지 URL을 uuid_fileName 형식으로 설정
                             const encodedImgUrl = encodeURIComponent(`${banner.uuid}_${banner.fileName}`);
                             exhibitionElement.style.backgroundImage = `url('/exhibition/exhibitionsBannerImages/${encodedImgUrl}')`;
                         }
                     });
                 })
                 .catch(error => {
                     console.error('Error loading banner images:', error);
                 });
         })
         .catch(error => {
             console.error('Error loading exhibitions:', error);
         });
 }




// 더 많은 전시회를 로드하는 함수
function loadMoreExhibitions() {
    currentPage++; // 페이지 증가
    loadExhibitions(); // 전시회 로드
}

// 날짜 포맷팅 함수
function formatDate(dateString) {
    const date = new Date(dateString);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');

    return `${year}-${month}-${day}`;
}

// 전시회 컨텍스트 토글 함수
function toggleExhibitionContext(element) {
    const contexts = document.querySelectorAll('.exhibition-context');
    contexts.forEach(context => {
        if (context !== element.nextElementSibling) {
            context.style.display = 'none';
        }
    });

    const context = element.nextElementSibling;
    const isCurrentlyVisible = context.style.display === 'flex';
    context.style.display = isCurrentlyVisible ? 'none' : 'flex';

    if (!isCurrentlyVisible) {
        element.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
}

// 상세 페이지로 이동
function goToDetailPage(exhNo) {
    location.href = "/exhibition/exhibitionDetail?exhNo=" + exhNo;
}

// 초기 전시회 로드
document.addEventListener("DOMContentLoaded", () => {
    loadExhibitions();
    loadPopularExhs();
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