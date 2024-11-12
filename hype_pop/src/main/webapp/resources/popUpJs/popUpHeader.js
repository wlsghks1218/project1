// 페이지 로드 시 알림 목록 숨기기
document.addEventListener('DOMContentLoaded', () => {
	const notificationList = document.getElementById('notificationList');
	notificationList.style.display = 'none'; // 알림 목록 숨김
	
	// 웹소켓 연결 시 알림 체크
	const userNo = 5; // 실제 사용자 ID로 변경
	socket.send(JSON.stringify({ action: 'checkNotifications', userNo: userNo })); // 초기 알림 체크 요청
});

function showLogos() {
    var logoContainer = document.getElementById("logoContainer");
    var overlay = document.getElementById("overlay");

    // 슬라이드 메뉴 및 오버레이 표시
    logoContainer.classList.toggle("show");
    overlay.classList.toggle("show");

    // 오버레이 클릭 시 메뉴 숨기기
    overlay.onclick = function() {
        logoContainer.classList.remove("show");
        overlay.classList.remove("show");
    }
}

// 검색 버튼 클릭 이벤트
document.getElementById("searchBTN").addEventListener('click', () => {
    let inputText = document.getElementById("popUpSearchInput").value;

    if (inputText.trim() !== "") {
        location.href = "/hypePop/search?searchData=" + encodeURIComponent(inputText);
    } else {
        alert("검색어를 입력하세요.");
    }
});

// SockJS 연결
const socket = new SockJS('http://localhost:9010/alarm');

socket.onopen = function(event) {
    console.log('WebSocket 연결이 성공적으로 이루어졌습니다.');

    const userNo = 5; // 실제 사용자 ID로 변경
    socket.send(JSON.stringify({ action: 'checkNotifications', userNo: userNo }));
};

// 서버로부터 메시지를 수신했을 때의 처리
socket.onmessage = function(event) {
    console.log('서버로부터 받은 원본 데이터:', event.data);
    const notificationData = JSON.parse(event.data);

    // 디버깅: 수신한 데이터 출력
    console.log('수신한 알림 데이터:', notificationData);

    // 알림 데이터 처리
    if (notificationData.action === 'sendNotifications') {
        // 알림이 있을 때 UI 업데이트
        updateNotificationUI(notificationData.notifications);
    } else if (notificationData.action === 'deleteNotifications') {
        handleDeleteResponse(notificationData);
    } else if (notificationData.action === 'checkNotifications') {
        updateNotificationUI(notificationData.notifications);
    }
};

// 알림 UI 업데이트 함수
let existingNotifications = new Set(); // 기존 알림 ID를 저장하는 Set

function updateNotificationUI(notifications) {
    const alarmContent = document.getElementById('notificationList');
    const notificationDot = document.getElementById('notificationDot');
    
    // 알림 내용 초기화
    alarmContent.innerHTML = ''; 

    if (!notifications || notifications.length === 0) {
        notificationDot.style.display = 'none';
        alarmContent.innerHTML = '<div>알림이 없습니다.</div>';
        return;
    }

    let hasUnreadNotifications = false; // 읽지 않은 알림 여부를 추적하기 위한 변수

    notifications.forEach(notification => {
        if (existingNotifications.has(notification.notificationNo)) {
            return; // 중복된 알림 무시
        }

        existingNotifications.add(notification.notificationNo); // 새로운 알림 ID 추가

        const notificationElement = document.createElement('div');
        notificationElement.style.display = 'flex'; 
        notificationElement.style.justifyContent = 'space-between'; 
        notificationElement.style.alignItems = 'center'; 
        notificationElement.setAttribute('data-id', notification.notificationNo); // ID 추가

        // 날짜 포맷
        const notifyAtDate = new Date(notification.notifyAt);
        const formattedDate = notifyAtDate.toLocaleDateString('ko-KR', {
            year: 'numeric', 
            month: 'long', 
            day: 'numeric', 
            hour: '2-digit', 
            minute: '2-digit'
        });

        // 메시지 구성
        const message = `${notification.title} ${notification.psName} 스토어의 ${notification.message} <br> 전송날짜: ${formattedDate}`;

        // 메시지 요소
        const messageElement = document.createElement('span');
        messageElement.innerHTML = message; 

        // 읽음 여부 표시 요소
        const readStatus = document.createElement('span');
        readStatus.textContent = notification.isRead === 1 ? '읽음' : '읽지 않음'; // 수정
        readStatus.style.marginLeft = '10px'; 

        if (notification.isRead === 0) { // 0일 경우 읽지 않은 알림
            hasUnreadNotifications = true;
        }

        // 삭제 버튼 요소
        const deleteButton = document.createElement('button');
        deleteButton.textContent = '삭제';
        deleteButton.classList.add('delete-button'); 
        deleteButton.style.marginLeft = '10px'; 
        deleteButton.onclick = function() {
            handleDeleteNotification(notification.notificationNo); // 수정
        };

        notificationElement.appendChild(messageElement);
        notificationElement.appendChild(deleteButton);
        notificationElement.appendChild(readStatus);

        alarmContent.appendChild(notificationElement);
    });

    // 레드닷 표시 여부 설정
    notificationDot.style.display = hasUnreadNotifications ? 'block' : 'none';
}

// 알림 삭제 함수에서 userNo를 사용하도록 수정
function handleDeleteNotification(notificationId) {
    console.log(`알림 ID ${notificationId} 삭제됨.`);
    socket.send(JSON.stringify({ action: 'deleteNotifications', notificationNo: notificationId })); // 삭제 요청 전송
}

// 서버의 삭제 응답 처리 함수
function handleDeleteResponse(response) {
    console.log(response);

    if (response.message === "알림 삭제 성공") {
        refreshNotificationList(response.userNo); // userNo를 사용하여 알림 목록 갱신
    } else {
        console.error("알림 삭제 실패: ", response.message);
    }
}

// 알림 목록 새로 고침 함수
function refreshNotificationList(userNo) {
    socket.send(JSON.stringify({ action: 'checkNotifications', userNo: userNo })); // userNo를 인자로 전달
}

// 알림 버튼 클릭 처리 함수
function handleAlarmClick() {
    console.log("알림 버튼 클릭됨!");
    const alarmContent = document.getElementById('notificationList'); // ID를 수정
    alarmContent.style.display = (alarmContent.style.display === 'block') ? 'none' : 'block'; // 토글
}