document.addEventListener("DOMContentLoaded", function () {
	

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
	function parseXMLToJSON(xml) {
	    // XML을 JSON으로 변환하는 함수
	    let obj = {};
	    const parser = new DOMParser();
	    const xmlDoc = parser.parseFromString(xml, "text/xml");

	    // XML에서 <pImgVO> 태그의 하위 요소를 읽어 JSON 형식으로 변환
	    const uuid = xmlDoc.getElementsByTagName("uuid")[0].textContent;
	    const filename = xmlDoc.getElementsByTagName("fileName")[0].textContent;

	    obj.uuid = uuid;
	    obj.filename = filename;

	    return obj;
	}

	function getImageData(psNo) {
	    return new Promise((resolve, reject) => {
	        fetch(`/hypePop/getImageData?psNo=${psNo}`)
	            .then(response => {
	                if (!response.ok) {
	                    throw new Error('이미지 데이터를 가져오는 데 실패했습니다.');
	                }
	                return response.text(); // XML 형식으로 응답 받기
	            })
	            .then(xml => {
	                try {
	                    // XML을 JSON으로 변환
	                    const imageData = parseXMLToJSON(xml);
	                    
	                    // 변환된 데이터 확인 후 반환
	                    if (imageData && imageData.uuid && imageData.filename) {
	                        resolve(imageData);  // 이미지 데이터를 반환
	                    } else {
	                        reject('유효하지 않은 이미지 데이터');
	                    }
	                } catch (error) {
	                    reject('XML 파싱 오류: ' + error.message);
	                }
	            })
	            .catch(error => {
	                reject(error);
	            });
	    });
	}
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

        // 기존 더보기 버튼이 있으면 삭제
        if (loadMoreBtn) {
            loadMoreBtn.remove();
        }

        // 새로운 더보기 버튼을 생성
        loadMoreBtn = document.createElement("button");
        loadMoreBtn.textContent = "더보기";
        loadMoreBtn.classList.add("load-more-btn");

        // 스타일 직접 설정 (CSS와 동일)
        loadMoreBtn.style.backgroundColor = "#00aff0"; // 주요 색상
        loadMoreBtn.style.color = "#ffffff"; // 흰색 텍스트
        loadMoreBtn.style.border = "none";
        loadMoreBtn.style.padding = "10px 20px";
        loadMoreBtn.style.borderRadius = "5px"; // 버튼의 모서리를 둥글게
        loadMoreBtn.style.cursor = "pointer";
        loadMoreBtn.style.transition = "background-color 0.3s"; // 부드러운 색상 변화
        loadMoreBtn.style.margin = "20px 0"; // 여백 추가
        loadMoreBtn.style.display = "block"; // 블록 요소로 변경
        loadMoreBtn.style.marginLeft = "auto"; // 왼쪽 여백 자동
        loadMoreBtn.style.marginRight = "auto"; // 오른쪽 여백 자동

        loadMoreBtn.onmouseover = function() {
            loadMoreBtn.style.backgroundColor = "#0082b3"; // 호버 색상
        };

        loadMoreBtn.onmouseout = function() {
            loadMoreBtn.style.backgroundColor = "#00aff0"; // 기본 색상
        };

        loadMoreBtn.onclick = function () {
            loadMoreStores(filteredStores);
        };

        // 더보기 버튼을 추가하고, 조건에 맞으면 표시
        if (displayedItems < filteredStores.length) {
            storeContainer.appendChild(loadMoreBtn);
            loadMoreBtn.style.display = "block";  // 버튼 표시
        } else {
            loadMoreBtn.style.display = "none"; // 버튼 숨기기
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
                <img src="/resources/images/hamburger.png" alt="팝업스토어 배너 이미지"> <!-- 기존 이미지 -->
            </div>
            <div class="store-info">
                <div class="header">
                    <h2 class="storeName"><span class="storeName">${store.name}</span></h2>
                    <span class="likeCount">❤️ ${store.likeCount}</span>
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

     // 이미지 동적으로 변경하는 코드
        const imageElement = storeCard.querySelector(".store-image img");
        if (imageElement) {
            const psNo = store.psNo; // psNo를 사용하여 이미지 데이터를 가져오는 비동기 함수 호출

            getImageData(psNo).then(imageData => {
                const imageUuid = imageData.uuid;
                const imageFilename = imageData.filename;

                // uuid와 filename을 합쳐서 fileName 생성
                const fileName = `${imageUuid}_${imageFilename}`;  // 합쳐서 fileName을 만듦

                // 합쳐진 fileName을 사용하여 이미지 경로 설정
                const imageUrl = `/hypePop/images/${fileName}`;  // 서버의 이미지 경로

                imageElement.src = imageUrl;  // 동적으로 이미지 경로 설정
            }).catch(error => {
                console.error("이미지 데이터 로딩 실패:", error);
                // 기본 이미지 표시 또는 사용자에게 오류 메시지 표시
                imageElement.src = '/path/to/default-image.jpg';  // 기본 이미지 설정 (옵션)
            });
        } else {
            console.error("이미지 엘리먼트가 존재하지 않습니다.");
        }
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