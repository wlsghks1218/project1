 currentPage = 1;
 currentFilter = '';
 
// 베너 로드 함수
 function loadExhibitionBanners() {
	 
 }
 
// 전시회 필터링 함수
function filterExhibitions() {
    currentFilter = document.getElementById("filterSelect").value; // 선택한 필터 업데이트
    currentPage = 1; // 페이지 초기화
    loadExhibitions(); // 필터링된 전시회 로드
}

// 전시회를 로드하는 함수
function loadExhibitions() {
    fetch(`/exhibition/exhibitionPage?page=${currentPage}&filter=${currentFilter}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            const exhibitionList = document.getElementById("exhibition-list");
            const loadMoreButton = document.getElementById('load-more');

            if (currentPage === 1) {
                exhibitionList.innerHTML = ""; // 페이지 초기화
            }

            if (data && data.length > 0) {
                data.forEach(exhibition => {
                    const li = document.createElement("li");
                    li.className = "exhibition-info";

                    // 날짜 포맷팅
                    const startDate = formatDate(exhibition.exhStartDate);
                    const endDate = formatDate(exhibition.exhEndDate);

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
                            <div class="exhibition-banner-img"></div>
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
            } 

            // 버튼을 숨기는 부분을 수정
            if (!data || data.length === 0) {
                loadMoreButton.style.display = 'none';
            }

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

// 필터링 처리
function filterExhibitions() {
    currentFilter = document.getElementById("filterSelect").value; // 선택한 필터 업데이트
    currentPage = 1; // 페이지 초기화
    loadExhibitions(); // 필터링된 전시회 로드
}

// 초기 전시회 로드
document.addEventListener("DOMContentLoaded", () => {
    loadExhibitions();
    loadExhibitionBanners();
});