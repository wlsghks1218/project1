document.addEventListener('DOMContentLoaded', () => {
    console.log("DOM fully loaded and parsed");
    loadImageSources();
    initializeLoadMoreButton();
});

// 이미지 소스를 설정하는 함수
function loadImageSources() {
    const itemImages = document.querySelectorAll('.item-image');

    if (itemImages.length === 0) {
        console.warn("No '.item-image' elements found in the DOM.");
        return;
    }

    itemImages.forEach(item => {
        const fileName = item.dataset.fileName || item.querySelector('input[type="hidden"]').value;
        console.log(fileName);

        if (fileName) {
            setImageSource(item.querySelector('img'), fileName);
        } else {
            console.warn(`File name not found for item: ${item.id}`);
        }
    });
}

// 이미지 소스를 설정하는 유틸리티 함수
function setImageSource(imgElement, fileName) {
    if (!imgElement) return;

    const encodedFileName = encodeURIComponent(fileName);
    const imageUrl = `/goodsStore/goodsBannerImages/${encodedFileName}`;

    imgElement.src = imageUrl;
    imgElement.style.width = "100px";
    imgElement.style.height = "100px";

    // 로딩 실패 시 대체 이미지 설정
    imgElement.onerror = () => {
        console.error(`Failed to load image: ${imageUrl}`);
        imgElement.src = '/path/to/placeholder-image.jpg';
    };
}

// "더보기" 버튼 초기화 함수
function initializeLoadMoreButton() {
    const loadMoreBtn = document.getElementById("loadMoreBtn");
    if (!loadMoreBtn) {
        console.warn("Load more button not found.");
        return;
    }

    loadMoreBtn.addEventListener("click", () => {
        const page = parseInt(loadMoreBtn.getAttribute("data-page")) || 1;
        const userNo = 67; // 사용자 번호 (실제 값으로 대체)

        loadMoreItems(page, userNo, loadMoreBtn);
    });
}

// "더보기" 기능 구현
function loadMoreItems(page, userNo, loadMoreBtn) {
    // 로딩 상태 표시
    loadMoreBtn.disabled = true;
    loadMoreBtn.innerText = '로딩 중...';

    fetch(`/purchase/api/loadMoreItems?userNo=${userNo}&page=${page}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('서버 응답이 정상적이지 않습니다.');
            }
            return response.json();
        })
        .then(data => {
            if (data.length === 0) {
                loadMoreBtn.style.display = 'none';
                return;
            }

            appendPurchaseItems(data);
            loadMoreBtn.setAttribute("data-page", page + 1);
            loadMoreBtn.disabled = false;
            loadMoreBtn.innerText = '더보기';
        })
        .catch(error => {
            console.error("Error loading more items:", error);
            alert("아이템을 불러오는 데 오류가 발생했습니다. 다시 시도해 주세요.");
            loadMoreBtn.disabled = false;
            loadMoreBtn.innerText = '더보기';
        });
}

// 구매 목록에 데이터를 추가하는 함수
function appendPurchaseItems(data) {
    const container = document.getElementById("purchase-list-container");
    if (!container) {
        console.error("Purchase list container not found.");
        return;
    }

    let lastOrderId = null;

    data.forEach(item => {
        if (lastOrderId !== item.orderId) {
            const orderDiv = document.createElement("div");
            orderDiv.classList.add("purchase-order");
            orderDiv.innerHTML = `<div class="order-id-box">주문 번호: ${item.orderId}</div>`;
            container.appendChild(orderDiv);
            lastOrderId = item.orderId;
        }

        const itemDiv = document.createElement("div");
        itemDiv.classList.add("purchase-item");
        itemDiv.innerHTML = `
            <div class="item-image" data-file-name="${item.fileName}">
                <img alt="${item.gname}" />
            </div>
            <div class="item-details">
                <h3 class="item-name">상품명: ${item.gname}</h3>
                <p class="item-quantity">수량: ${item.camount}</p>
                <p class="item-price">가격: ${item.gprice}원</p>
                <p class="item-date">구매 날짜: ${item.gbuyDate}</p>
                <p class="item-status">상품 현황: ${item.gsituation}</p>
            </div>
        `;

        container.lastChild.appendChild(itemDiv);

        // 새로 추가된 이미지의 소스 설정
        setImageSource(itemDiv.querySelector('img'), item.fileName);
    });
}
