let currentPage = 1;

function loadMoreExhibitions() {
    currentPage++;
    fetch(`/exhibition/exhibitionPage?page=${currentPage}`)
        .then(response => {
            // 응답이 JSON이 아닌 경우 처리
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            const exhibitionList = document.getElementById("exhibition-list");
            // 데이터를 확인하고 리스트가 비어있지 않은 경우에만 처리
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
                            <a href="#" style="text-decoration: none;">
                                <button style="background-color: #007BFF; color: white; border: none; padding: 5px 10px; border-radius: 5px;">
                                    상세페이지
                                </button>
                            </a>
                        </div>
                        <div class="exhibition-context" style="display: none;"> <!-- Initially hidden -->
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
            } else {
                console.log('더 이상 전시회가 없습니다.');
            }
        })
        .catch(error => {
            console.error('Error loading more exhibitions:', error);
        });
}

// 날짜 포맷팅 함수
function formatDate(dateString) {
    const date = new Date(dateString); // 날짜 문자열을 Date 객체로 변환
    const year = date.getFullYear(); // 연도 추출
    const month = String(date.getMonth() + 1).padStart(2, '0'); // 월 추출 (0부터 시작하므로 +1 해줘야 함)
    const day = String(date.getDate()).padStart(2, '0'); // 일 추출

    return `${year}-${month}-${day} `; // 'yyyy-mm-dd' 형식으로 반환
}

function toggleExhibitionContext(element) {
    // 모든 exhibition-context 요소를 숨기기
    const contexts = document.querySelectorAll('.exhibition-context');
    contexts.forEach(context => {
        if (context !== element.nextElementSibling) {
            context.style.display = 'none';
        }
    });

    // 클릭된 exhibition-context 토글
    const context = element.nextElementSibling;
    const isCurrentlyVisible = context.style.display === 'flex';
    context.style.display = isCurrentlyVisible ? 'none' : 'flex';

    // 클릭된 exhibition-schedule에 포커스
    if (!isCurrentlyVisible) {
        element.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
}

// 상세 페이지로 이동
function goToDetailPage(exhNo) {
    location.href = "/exhibition/exhibitionDetail?exhNo=" + exhNo;
}