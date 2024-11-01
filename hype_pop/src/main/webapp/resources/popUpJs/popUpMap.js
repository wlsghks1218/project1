let map; // 지도 객체를 전역으로 선언
let currentLocationMarker; // 내 위치 마커 변수
let currentInfoWindow; // 내 위치 정보창 변수
let storeInfoWindow; // 스토어 정보창 변수

// 페이지 로드 시 위치 정보 요청
if (navigator.geolocation) {
    // 이전에 저장된 위치가 있으면 사용
    if (localStorage.getItem("userLocation")) {
        const savedLocation = JSON.parse(localStorage.getItem("userLocation"));
        console.log("저장된 위치 사용:", savedLocation);

        // 필요한 작업: 저장된 위치로 지도 설정
        initMap(savedLocation.latitude, savedLocation.longitude);
        fetchNearbyStores(savedLocation.latitude, savedLocation.longitude); // 주변 스토어 가져오기
    } else {
        // 위치 정보 요청
        if (confirm("위치 정보 제공에 동의하시겠습니까?")) {
            navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
        }
    }
} else {
    alert('Geolocation을 지원하지 않는 브라우저입니다.');
}

function successCallback(position) {
    const latitude = position.coords.latitude; // 위도
    const longitude = position.coords.longitude;

    // 위치 정보를 로컬 스토리지에 저장
    const userLocation = {
        latitude: latitude,
        longitude: longitude
    };
    localStorage.setItem("userLocation", JSON.stringify(userLocation));

    console.log("현재 위치 저장됨: ", userLocation);

    // 지도 초기화 및 주변 스토어 가져오기
    initMap(latitude, longitude);
    fetchNearbyStores(latitude, longitude);
}

function errorCallback(error) {
    console.error("위치 정보를 가져오는 중 에러 발생:", error);
}

// 지도 초기화 함수
function initMap(latitude, longitude) {
    // 지도 설정
    var mapOptions = {
        center: new naver.maps.LatLng(latitude, longitude),
        zoom: 15
    };

    map = new naver.maps.Map('map', mapOptions); // 지도 객체 초기화
    addCurrentLocationMarker(latitude, longitude); // 내 위치 마커 추가
}

// 주변 스토어 가져오기
function fetchNearbyStores(latitude, longitude) {
    fetch(`/map/nearby?latitude=${latitude}&longitude=${longitude}`)
        .then(response => {
            if (!response.ok) {
                throw new Error("네트워크 응답이 좋지 않습니다.");
            }

            // 204 No Content일 경우 빈 배열로 처리
            if (response.status === 204) {
                return []; // 빈 배열 반환
            }

            return response.json(); // 응답을 JSON으로 받기
        })
        .then(data => {
            // 데이터가 비어 있는 경우 처리
            if (data.length === 0) {
                console.log("주변에 스토어가 없습니다.");
            } else {
                data.forEach(store => {
                    addMarker(store);
                });
            }
        })
        .catch(error => {
            console.error("오류 발생:", error);
            alert("주변 스토어를 가져오는 중 오류가 발생했습니다.");
        });
}


//스토어 마커 추가
//스토어 마커 추가
function addMarker(store) {
    var storePosition = new naver.maps.LatLng(store.latitude, store.longitude);
    var marker = new naver.maps.Marker({
        position: storePosition,
        map: map,
        title: store.psName, // 스토어 이름
        icon: {
            url: 'https://i.ibb.co/QXBkTXD/store-Marker.png', // 새로운 마커 이미지 URL
            scaledSize: new naver.maps.Size(70, 40), // 가로 크기를 늘림 (좌우로 늘어나게 설정)
            size: new naver.maps.Size(60, 40),
            origin: new naver.maps.Point(0, 0),
            anchor: new naver.maps.Point(35, 40) // 마커의 중심점을 조정
        }
    });

    // 정보창 생성
    var infoWindow = new naver.maps.InfoWindow({
        content: `<div id="infoWindow-${store.psName}" style="width:150px;text-align:center;padding:10px; cursor: pointer;">
                    <strong>${store.psName}</strong><br>
                    시작일: ${formatDate(store.psStartDate)}<br>
                    종료일: ${formatDate(store.psEndDate)}
                  </div>`
    });

    // 스토어 마커 클릭 시 정보창 열기
    naver.maps.Event.addListener(marker, 'click', function() {
        // 내 위치 정보창 닫기
        if (currentInfoWindow) {
            currentInfoWindow.close(); // 내 위치 정보창 닫기
        }

        // 새로운 스토어 정보창 열기
        infoWindow.open(map, marker);
        
        // 정보를 기반으로 클릭 이벤트 추가
        setTimeout(() => {
            const infoWindowElement = document.getElementById(`infoWindow-${store.psName}`);
            if (infoWindowElement) {
                infoWindowElement.addEventListener('click', function() {
                    console.log(store.psName); // store.psName 사용

                    // 상세 페이지로 이동
                    location.href = `/hypePop/popUpDetails?storeName=${encodeURIComponent(store.psName)}`;
                });
            }
        }, 0); // DOM이 완전히 로드된 후에 이벤트 리스너를 추가
    });
}


// 내 위치 마커 추가
function addCurrentLocationMarker(latitude, longitude) {
    var currentPosition = new naver.maps.LatLng(latitude, longitude);
    currentLocationMarker = new naver.maps.Marker({
        position: currentPosition,
        map: map,
        title: '내 위치',
        icon: {
            url: 'https://cdn-icons-png.flaticon.com/512/25/25613.png', // 마커 이미지 URL
            scaledSize: new naver.maps.Size(40, 40), // 이미지 크기 조정
            origin: new naver.maps.Point(0, 0),
            anchor: new naver.maps.Point(20, 40) // 마커의 중심점을 조정
        }
    });

    // 내 위치 정보창 추가
    currentInfoWindow = new naver.maps.InfoWindow({
        content: `<div style="width:150px;text-align:center;padding:10px;">
                    <strong>내 위치</strong>
                </div>`
    });

    // 내 위치 정보창 열기
    currentInfoWindow.open(map, currentLocationMarker); // 초기 로드 시 정보창 열기

    // 내 위치 마커 클릭 시 정보창 열기
    naver.maps.Event.addListener(currentLocationMarker, 'click', function() {
        currentInfoWindow.open(map, currentLocationMarker); // 내 위치 정보창 열기
    });
}

// 날짜 포맷팅 함수
function formatDate(date) {
    const dateObject = new Date(date);
    return `${dateObject.getFullYear()}-${dateObject.getMonth() + 1}-${dateObject.getDate()}`;
}
