let map; // 지도 객체를 전역으로 선언
let currentLocationMarker; // 내 위치 마커 변수
let storeMarker; // 스토어 마커 변수
let currentInfoWindow; // 내 위치 정보창 변수
let storeInfoWindow; // 스토어 정보창 변수

// span 요소에서 storeInfo 데이터 가져오기
const spanElement = document.querySelector('span[data-storeInfo]');
let storeInfo = spanElement.getAttribute('data-storeInfo');

storeInfo = JSON.parse(storeInfo.replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&quot;/g, '"').replace(/&amp;/g, "&"));

// 페이지 로드 시 위치 정보 요청
if (navigator.geolocation) {
    if (localStorage.getItem("userLocation")) {
        const savedLocation = JSON.parse(localStorage.getItem("userLocation"));
        console.log("저장된 위치 사용:", savedLocation);
        initMap(savedLocation.latitude, savedLocation.longitude);
    } else {
        // 사용자 위치 정보 동의를 받지 않은 경우
        initMap(storeInfo.latitude, storeInfo.longitude); // 팝업스토어 위치만 사용
    }
} else {
    alert('Geolocation을 지원하지 않는 브라우저입니다.');
}

// 지도 초기화 함수
function initMap(latitude, longitude) {
    // storeInfo 객체에서 값 가져오기
    const storeLatitude = storeInfo.latitude;
    const storeLongitude = storeInfo.longitude;
    const storeName = storeInfo.psName;
    const storeStartDate = storeInfo.psStartDate;
    const storeEndDate = storeInfo.psEndDate;

    // 지도 설정
    var mapOptions = {
        center: new naver.maps.LatLng(storeLatitude, storeLongitude), // 팝업스토어 위치로 중심 설정
        zoom: 15
    };

    map = new naver.maps.Map('map', mapOptions); // 지도 객체 초기화
    addStoreMarker(storeLatitude, storeLongitude, storeName, storeStartDate, storeEndDate); // 스토어 마커 추가

    // 내 위치가 저장되어 있는 경우에만 내 위치 마커 추가
    if (localStorage.getItem("userLocation")) {
        const savedLocation = JSON.parse(localStorage.getItem("userLocation"));
        addCurrentLocationMarker(savedLocation.latitude, savedLocation.longitude); // 내 위치 마커 추가
    }

    // 내 위치 보기 버튼 생성
    createMyLocationButton();
}

// 내 위치 버튼 생성
function createMyLocationButton() {
    const button = document.createElement('button');
    button.textContent = '내 위치 보기';
    button.style.position = 'absolute';
    button.style.top = '10px';
    button.style.right = '10px';
    button.style.zIndex = 1000; // 버튼이 지도의 위에 표시되도록 설정
    button.onclick = focusOnCurrentLocation; // 버튼 클릭 시 함수 호출

    document.getElementById('map').appendChild(button); // 버튼을 지도에 추가
}

function focusOnCurrentLocation() {
    if (localStorage.getItem("userLocation")) {
        const savedLocation = JSON.parse(localStorage.getItem("userLocation"));
        const currentPosition = new naver.maps.LatLng(savedLocation.latitude, savedLocation.longitude);

        let currentCenter = map.getCenter();
        let startLat = currentCenter.lat();
        let startLng = currentCenter.lng();
        let endLat = currentPosition.lat();
        let endLng = currentPosition.lng();

        let steps = 300; // 이동 단계 수 (값이 클수록 이동이 부드러움)
        let step = 0;
        
        // 애니메이션을 위한 setInterval 사용
        let interval = setInterval(() => {
            step++;
            let lat = startLat + (endLat - startLat) * (step / steps);
            let lng = startLng + (endLng - startLng) * (step / steps);
            map.setCenter(new naver.maps.LatLng(lat, lng));
            
            // 마지막 단계에서 종료 및 정보창 열기
            if (step === steps) {
                clearInterval(interval);
                currentInfoWindow.open(map, currentLocationMarker);
            }
        }, 3); // 각 단계 사이의 시간 (10ms, 조절 가능)
    } else {
        alert('저장된 위치가 없습니다.');
    }
}


// 내 위치 마커 추가
function addCurrentLocationMarker(latitude, longitude) {
    var currentPosition = new naver.maps.LatLng(latitude, longitude);
    currentLocationMarker = new naver.maps.Marker({
        position: currentPosition,
        map: map,
        title: '내 위치',
        icon: {
            url: 'https://cdn-icons-png.flaticon.com/512/25/25613.png',
            scaledSize: new naver.maps.Size(40, 40),
            origin: new naver.maps.Point(0, 0),
            anchor: new naver.maps.Point(20, 40)
        }
    });

    // 내 위치 정보창 추가
    currentInfoWindow = new naver.maps.InfoWindow({
        content: `<div style="width:150px;text-align:center;padding:10px; color: black;">
                    <strong>내 위치</strong>
                  </div>`
    });

    // 내 위치 마커 클릭 시 정보창 열기
    naver.maps.Event.addListener(currentLocationMarker, 'click', function() {
        currentInfoWindow.open(map, currentLocationMarker);
    });
}

function addStoreMarker(latitude, longitude, storeName, startDate, endDate) {
    var storePosition = new naver.maps.LatLng(latitude, longitude);
    storeMarker = new naver.maps.Marker({
        position: storePosition,
        map: map,
        title: storeName,
        icon: {
            url: 'https://i.ibb.co/QXBkTXD/store-Marker.png',
            scaledSize: new naver.maps.Size(70, 40),
            size: new naver.maps.Size(60, 40),
            origin: new naver.maps.Point(0, 0),
            anchor: new naver.maps.Point(35, 40)
        }
    });

    // 스토어 정보창 생성
    storeInfoWindow = new naver.maps.InfoWindow({
        content: `<div style="width:150px;text-align:center;padding:10px; color: black;">
                    <strong>${storeName}</strong><br>
                    시작일: ${formatDate(startDate)}<br>
                    종료일: ${formatDate(endDate)}
                  </div>`
    });

    // 스토어 마커 클릭 시 정보창 열기
    naver.maps.Event.addListener(storeMarker, 'click', function() {
        storeInfoWindow.open(map, storeMarker);
    });

    // 초기 로드 시 스토어 정보창 열기
    storeInfoWindow.open(map, storeMarker);
}

// 날짜 포맷팅 함수
function formatDate(date) {
    const dateObject = new Date(date);
    return `${dateObject.getFullYear()}-${dateObject.getMonth() + 1}-${dateObject.getDate()}`;
}
