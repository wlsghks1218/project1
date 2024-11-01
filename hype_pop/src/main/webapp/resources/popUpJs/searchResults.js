document.addEventListener("DOMContentLoaded", function () {
    const storeCards = document.querySelectorAll(".store-card");
    let popUpResults = [];
    let filteredPopUps = [];
    let currentPage = 1;
    const itemsPerPage = 10;
    let displayedItems = 0;
    let selectedInterests = [];
    let userLocation = {
        latitude: null,
        longitude: null
    };

    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition((position) => {
            userLocation.latitude = position.coords.latitude;
            userLocation.longitude = position.coords.longitude;
            console.log("사용자 위치:", userLocation);
            loadPageAgain(popUpResults);
        }, (error) => {
            console.error("위치 정보 가져오기 실패:", error);
        });
    } else {
        console.error("이 브라우저는 Geolocation을 지원하지 않습니다.");
    }

    storeCards.forEach((card) => {
        const storeInfo = {
            name: card.querySelector(".storeName").textContent,
            likeCount: parseInt(card.querySelector(".likeCount").textContent.replace(/[^0-9]/g, "")),
            psNo: card.querySelector(".psNo").value,
            address: card.querySelector("h3").textContent.replace("주소: ", ""),
            interest: card.querySelector(".popUpCat").textContent,
            rating: parseFloat(card.querySelector(".rating").value),
            psStartDate: card.querySelector(".date-info span:nth-child(1)").textContent.replace("시작일: ", "").trim(),
            psEndDate: card.querySelector(".date-info span:nth-child(2)").textContent.replace("종료일: ", "").trim(),
            latitude: parseFloat(card.querySelector(".latitude").value),
            longitude: parseFloat(card.querySelector(".longitude").value)
        };
        popUpResults.push(storeInfo);
    });

    function loadPageAgain(storesArray) {
        currentPage = 1;
        displayedItems = 0;
        selectedInterests = []; // 관심사 초기화
        filteredPopUps = [...storesArray]; // 전체 목록 복사
        displayStores(filteredPopUps); // 전체 스토어 표시
    }

    function filterPopUpsBySearchAndCategory(storesArray) {
        if (selectedInterests.length === 0) {
            filteredPopUps = [...storesArray]; // 전체 목록 복사
        } else {
            filteredPopUps = storesArray.filter(store => {
                const storeInterests = store.interest.split(",").map(s => s.trim()).filter(Boolean);
                const hasMatchingInterest = storeInterests.some(storeInterest => selectedInterests.includes(storeInterest));
                return hasMatchingInterest;
            });
        }

        console.log("필터링된 스토어:", filteredPopUps);
        displayStores(filteredPopUps); // 필터링된 스토어만 표시
    }

    function displayStores(filteredStores) {
        const storeContainer = document.querySelector(".searchResultStore");

        if (!storeContainer) {
            console.error("storeContainer 요소를 찾을 수 없습니다.");
            return;
        }

        storeContainer.innerHTML = ""; // 전체 스토어 카드 지우기
        const initialStores = filteredStores.slice((currentPage - 1) * itemsPerPage, currentPage * itemsPerPage);

        if (initialStores.length === 0) {
            const noResultMessage = document.createElement("div");
            noResultMessage.textContent = "조건에 맞는 스토어가 없습니다.";
            storeContainer.appendChild(noResultMessage);
            return;
        }

        initialStores.forEach((store) => {
            const storeCard = createStoreCard(store);
            storeContainer.appendChild(storeCard);
        });

        displayedItems += initialStores.length;
        addLoadMoreButton(storeContainer, filteredStores);
    }

    function addLoadMoreButton(storeContainer, filteredStores) {
        let loadMoreBtn = document.querySelector(".load-more-btn");
        if (!loadMoreBtn) {
            loadMoreBtn = document.createElement("button");
            loadMoreBtn.textContent = "더보기";
            loadMoreBtn.classList.add("load-more-btn");
            loadMoreBtn.onclick = function () {
                loadMoreStores(filteredStores);
            };
        }

        if (displayedItems < filteredStores.length) {
            storeContainer.appendChild(loadMoreBtn);
            loadMoreBtn.style.display = "block";
        } else {
            loadMoreBtn.style.display = "none";
        }
    }

    function loadMoreStores(filteredStores) {
        const storeContainer = document.querySelector(".searchResultStore");

        const nextStores = filteredStores.slice(displayedItems, displayedItems + itemsPerPage);
        nextStores.forEach((store) => {
            const storeCard = createStoreCard(store);
            storeContainer.appendChild(storeCard);
        });

        displayedItems += nextStores.length;
        addLoadMoreButton(storeContainer, filteredStores);
    }

    function createStoreCard(store) {
        const storeCard = document.createElement("div");
        storeCard.classList.add("store-card");

        const interestsArray = store.interest.split(",").map(s => s.trim());

        storeCard.innerHTML = `
            <div class="store-image">
                <img src="/resources/images/hamburger.png" alt="팝업스토어 배너 이미지">
            </div>
            <div class="store-info">
                <div class="header">
                    <h2 class="storeName"><span class="storeName">${store.name}</span></h2>
                    <span class="likeCount">좋아요 수: ${store.likeCount}</span>
                    <input type="hidden" class="psNo" value="${store.psNo}">
                    <input type="hidden" class="rating" value="${store.rating}">
                    <input type="hidden" class="latitude" value="${store.latitude}">
                    <input type="hidden" class="longitude" value="${store.longitude}">
                </div>
                <h3>주소: ${store.address}</h3>
                <div class="date-info">
                    <span>시작일: ${store.psStartDate}</span>
                    <span>종료일: ${store.psEndDate}</span>
                </div>
                <div class="popUpCat">
                    ${interestsArray.map(interest => `<span class="interest-tag">${interest}</span>`).join("")}
                </div>
            </div>
        `;
        
        // 이름 클릭 시 상세 페이지로 이동하는 이벤트 추가
        const storeNameElement = storeCard.querySelector('.storeName');
        storeNameElement.addEventListener('click', (event) => {
            event.preventDefault();
            const storeName = store.name;
            console.log(storeName);
            location.href = `/hypePop/popUpDetails?storeName=${encodeURIComponent(storeName)}`;
        });

        return storeCard;
    }

    document.getElementById("selectInterestsBtn").onclick = function () {
        const interestButtons = document.getElementById("interestButtons");
        interestButtons.style.display = interestButtons.style.display === "none" ? "block" : "none";
    };

    document.querySelectorAll("#interestButtons button").forEach((interest) => {
        interest.addEventListener("click", (event) => {
            const selInterest = interest.textContent;
            toggleInterest(selInterest, interest);
            if (selectedInterests.length > 0) {
                filterPopUpsBySearchAndCategory(popUpResults);
            } else {
                loadPageAgain(popUpResults);
            }
        });
    });

    function toggleInterest(interest, buttonElement) {
        if (selectedInterests.includes(interest)) {
            selectedInterests = selectedInterests.filter((item) => item !== interest);
            buttonElement.classList.remove("selected");
        } else {
            selectedInterests.push(interest);
            buttonElement.classList.add("selected");
        }
        console.log(selectedInterests);
    }

    document.querySelectorAll(".searchConditions span").forEach((option) => {
        option.addEventListener("click", (event) => {
            event.preventDefault();

            const isSelected = option.classList.contains("selected");

            // 모든 버튼 선택 해제
            document.querySelectorAll(".searchConditions span").forEach((btn) => {
                btn.classList.remove("selected");
            });

            if (isSelected) {
                // 이미 선택된 상태에서 클릭했을 경우 선택 해제
                console.log(`선택 해제: ${option.id}`);
                option.classList.remove("selected");

                // 선택 해제 시 전체 스토어 목록을 다시 로드
                loadPageAgain(popUpResults); // 전체 스토어 다시 로드
            } else {
                // 새로운 버튼 선택
                option.classList.add("selected");
                let sortBy = option.id;

                console.log(`정렬 기준: ${sortBy}`);

                // 정렬 기준에 따라 스토어 정렬
                if (sortBy === "arrayByDis") {
                    console.log("거리순 정렬");
                    sortPopUpsByDistance();
                } else if (sortBy === "arrayByLike") {
                    console.log("좋아요순 정렬");
                    sortPopUpsByLike();
                } else if (sortBy === "arrayByLatest") {
                    console.log("최신순 정렬");
                    sortPopUpsByLatest();
                } else if (sortBy === "arrayByRating") {
                    console.log("별점 순 정렬");
                    sortPopUpsByRating();
                }
                displayStores(filteredPopUps); // 정렬 후 스토어 표시
            }
        });
    });

    function sortPopUpsByDistance() {
        if (userLocation.latitude && userLocation.longitude) {
            filteredPopUps.sort((a, b) => {
                const distanceA = calculateDistance(userLocation.latitude, userLocation.longitude, a.latitude, a.longitude);
                const distanceB = calculateDistance(userLocation.latitude, userLocation.longitude, b.latitude, b.longitude);
                return distanceA - distanceB;
            });
        }
        console.log("거리순 정렬 완료");
    }

    function sortPopUpsByLike() {
        filteredPopUps.sort((a, b) => b.likeCount - a.likeCount);
        console.log("좋아요순 정렬 완료");
    }

    function sortPopUpsByLatest() {
        filteredPopUps.sort((a, b) => new Date(b.psStartDate) - new Date(a.psStartDate));
        console.log("최신순 정렬 완료");
    }

    function sortPopUpsByRating() {
        filteredPopUps.sort((a, b) => b.rating - a.rating);
        console.log("별점순 정렬 완료");
    }

    function calculateDistance(lat1, lon1, lat2, lon2) {
        const R = 6371; // 지구의 반지름 (km)
        const dLat = (lat2 - lat1) * Math.PI / 180;
        const dLon = (lon2 - lon1) * Math.PI / 180;
        const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                  Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
                  Math.sin(dLon / 2) * Math.sin(dLon / 2);
        const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return R * c; // 거리 (km)
    }
});

document.getElementById("resetBtn").addEventListener("click", function() {
	window.location.href = "/hypePop/search/noData";
});