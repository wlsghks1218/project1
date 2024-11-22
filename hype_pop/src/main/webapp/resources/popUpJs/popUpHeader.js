// 페이지 로드 시 알림 목록 숨기기
document.addEventListener('DOMContentLoaded', () => {
    const userNoElement = document.getElementById("userNo");
    const userIdElement = document.getElementById("userId");
    const userNo = userNoElement ? userNoElement.value : null;
    const userId = userIdElement ? userIdElement.value : null;
    document.getElementById("goodsLogo").addEventListener('click', function() {
        if (userNo) {
            location.href = `/goodsStore/goodsMain?userNo=${userNo}`;
        } else {
            location.href = "/goodsStore/goodsMain";
        }
    });

    const notificationList = document.getElementById('notificationList');
    notificationList.style.display = 'none'; // 알림 목록 숨김


});

// 이미 socket 객체가 존재하는지 체크
let socket = window.socket;  // 전역 소켓 객체 사용

if (!socket || socket.readyState === WebSocket.CLOSED) {
    // 소켓이 존재하지 않거나 닫혀 있으면 새로 생성
    socket = new SockJS('http://localhost:9010/alarm');
    window.socket = socket;  // 전역 소켓 객체로 저장

    // 웹소켓 연결 설정
    socket.onopen = function(event) {
        const userNo = document.getElementById("userNo") ? document.getElementById("userNo").value : null;
        socket.send(JSON.stringify({ action: 'checkNotifications', userNo: userNo }));
    };
}

// 서버로부터 메시지를 수신했을 때의 처리
socket.onmessage = function(event) {
    const notificationData = JSON.parse(event.data);


    // 알림 데이터 처리
    if (notificationData.action === 'sendNotifications') {
        updateNotificationUI(notificationData.notifications);
    } else if (notificationData.action === 'deleteNotifications') {
        handleDeleteResponse(notificationData);
    } else if (notificationData.action === 'checkNotifications') {
        updateNotificationUI(notificationData.notifications);
    } else if (notificationData.action === 'markAsRead') {
        console.log('알림이 읽음 상태로 업데이트되었습니다.');
    }
};

//알림 UI 업데이트 함수
let existingNotifications = new Set(); // 기존 알림 ID를 저장하는 Set

//알림 UI 업데이트 함수
function updateNotificationUI(notifications) {

    const alarmContent = document.getElementById('notificationList');
    const notificationDot = document.getElementById('notificationDot');

    // 알림 내용 초기화
    alarmContent.innerHTML = '';

    if (!notifications || notifications.length === 0) {
        notificationDot.style.display = 'none';
        alarmContent.innerHTML = '<div style="color: black;">알림이 없습니다.</div>'; // 색상 검정으로 설정
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
        let message = "";
        switch (notification.type) {
            case 'psNo':
                message = `${notification.title} ${notification.psName}의 스토어 종료까지 5일 남았습니다.<br>전송날짜: ${formattedDate}`;
                break;
            case 'exhNo':
                message = `${notification.title} ${notification.exhName}의 전시회 종료까지 5일 남았습니다.<br>전송날짜: ${formattedDate}`;
                break;
            case 'gNo':
                message = `${notification.title} ${notification.goodsName} 상품의 판매 종료까지 5일 남았습니다.<br>전송날짜: ${formattedDate}`;
                break;
            case 'noticeNo':
                message = `${notification.title} ${notification.noticeTitle}<br>전송날짜: ${formattedDate}`;
                break;
            case 'qNo':
                message = `${notification.title} ${notification.qnaTitle}${notification.message}<br>전송날짜: ${formattedDate}`;
                break;
            default:
                message = `${notification.title}<br>전송날짜: ${formattedDate}`;
        }

        // 메시지 요소
        const messageElement = document.createElement('span');
        messageElement.innerHTML = message;
        const messageId = `message-${notification.notificationNo}`; // 고유 id 생성
        messageElement.setAttribute('id', messageId); // id를 메시지에 추가

        // 스타일 적용 (글씨 색 검정으로 설정)
        messageElement.style.color = 'black';

        // 읽음 여부 표시 요소
        const readStatus = document.createElement('span');
        readStatus.textContent = notification.isRead === 1 ? '읽음' : '읽지 않음';
        readStatus.style.marginLeft = '10px'; 
        readStatus.style.color = 'black';  // 읽음 상태 글씨 색 검정으로 설정

        // 삭제 버튼 요소
        const deleteButton = document.createElement('button');
        deleteButton.textContent = '삭제';
        deleteButton.classList.add('delete-button'); 
        deleteButton.style.marginLeft = '10px'; 
        deleteButton.onclick = function() {
            handleDeleteNotification(notification.notificationNo);
        };

        notificationElement.appendChild(messageElement);
        notificationElement.appendChild(deleteButton);
        notificationElement.appendChild(readStatus);

        alarmContent.appendChild(notificationElement);

        // 읽지 않은 알림이 있을 때 레드닷 표시
        if (notification.isRead === 0) {
            hasUnreadNotifications = true;
        }
    });

    // 레드닷 표시 여부 설정
    notificationDot.style.display = hasUnreadNotifications ? 'block' : 'none';
}
function handleDeleteNotification(notificationId) {
    socket.send(JSON.stringify({ action: 'deleteNotifications', notificationNo: notificationId })); // notificationNo만 전달
}

//서버의 삭제 응답 처리 함수
function handleDeleteResponse(response) {

    if (response.message === "알림 삭제 성공") {
        // 삭제 후, 전체 알림 목록을 다시 가져와서 UI 갱신
        const userNo = document.getElementById("userNo") ? document.getElementById("userNo").value : null;
        refreshNotificationList(userNo); // 전체 알림 목록 요청
    } else {
        console.error("알림 삭제 실패: ", response.message);
    }
}
// 알림 목록 새로 고침 함수
function refreshNotificationList(userNo) {
    // 알림 목록을 새로 갱신할 때 기존 목록을 초기화
    existingNotifications.clear(); // 기존 알림 ID를 초기화

    socket.send(JSON.stringify({ action: 'checkNotifications', userNo: userNo })); // userNo를 인자로 전달
}
// 알림 버튼 클릭 처리 함수
function handleAlarmClick() {
    const alarmContent = document.getElementById('notificationList');
    alarmContent.style.display = (alarmContent.style.display === 'block') ? 'none' : 'block';

    // 알림창을 열었을 때만 읽지 않은 알림을 읽음으로 표시
    if (alarmContent.style.display === 'block') {
        const userNo = document.getElementById("userNo") ? document.getElementById("userNo").value : null;
        
        // 서버에 읽음 상태 업데이트 요청 전송
        socket.send(JSON.stringify({ action: 'markNotificationsAsRead', userNo: userNo }));

        // UI 업데이트: 모든 알림을 읽음 처리
        Array.from(alarmContent.children).forEach(notificationElement => {
            const readStatus = notificationElement.querySelector('span:nth-child(3)');
            if (readStatus) readStatus.textContent = '읽음';
        });

        // 레드닷 숨김
        document.getElementById('notificationDot').style.display = 'none';
    }
}

window.showLogos = function() {
    const logoContainer = document.getElementById("logoContainer");
    const overlay = document.getElementById("overlay");

    // 슬라이드 메뉴 및 오버레이 표시
    logoContainer.classList.toggle("show");
    overlay.classList.toggle("show");

    // 오버레이 클릭 시 메뉴 숨기기
    overlay.onclick = function() {
        logoContainer.classList.remove("show");
        overlay.classList.remove("show");
    }
};

document.getElementById("searchBTN").addEventListener('click', () => {
    let inputText = document.getElementById("popUpSearchInput").value;

    if (inputText.trim() !== "") {
        location.href = "/hypePop/search?searchData=" + encodeURIComponent(inputText);
    } else {
        alert("검색어를 입력하세요.");
    }
});
