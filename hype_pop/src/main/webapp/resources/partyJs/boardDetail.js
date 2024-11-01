let name;
let ws;
const bno = new URLSearchParams(location.search).get('bno');
const url = `ws://localhost:9090/chatserver/${bno}`;
const userNo = 1;
const userId = "user1"; 
const userMap = {}; // userNo와 userId를 매핑하여 저장할 객체
let autoScrollEnabled = true; // 자동 스크롤 여부를 저장하는 변수

// 채팅방에 유저가 참여하고 있는지 확인하는 fetch
fetch(`/party/chkJoined/${bno}/${userNo}`)
.then(response => response.text())
.then(data => {
    console.log("Fetched data:", data);
    if (data === "채팅방에 진입했습니다.") {
        console.log("새로운 WebSocket을 연결합니다.");
    } else if (data === "채팅방에 이미 있는 유저입니다.") {
        console.log("이미 연결된 WebSocket입니다.");
    }
})
.catch(error => console.error("Error fetching data:", error));

// 참여 유저 목록 가져오기
fetch(`/party/getPartyUser/${bno}`)
.then(response => response.json())
.then(data => {
    const joinMemberDiv = document.querySelector('.joinMember');
    joinMemberDiv.innerHTML = '<h3>참여 유저 목록:</h3>';
    
    // 각 유저 ID와 번호를 joinMember 영역에 추가
    data.forEach(user => {
        userMap[user.userNo] = user.userId;
        console.log(user.userId);
        const userElement = document.createElement('div');
        userElement.textContent = `${user.userId}`;
        joinMemberDiv.appendChild(userElement);
    });
    fetchChatContents();
})
.catch(error => console.error("Error fetching party users:", error));

function fetchChatContents() {
    fetch(`/party/getAllChatContent/${bno}`)
        .then(response => response.json())
        .then(data => {
            data.forEach(message => {
                const senderId = userMap[message.userNo];
                const content = message.content || "";
                print(senderId, content,
                    message.userNo === userNo ? 'me' : 'other',
                    'msg', message.chatDate);
            });
        })
        .catch(error => console.error("Error fetching chat contents:", error));
}

// WebSocket 연결 함수
function connect() {
    window.name = userId;
    $('#header small').text(userId);  // 사용자 ID 표시

    // 초기 메시지 숨기기
    $('#chatArea .initial-message').remove();

    // WebSocket 연결
    ws = new WebSocket(url);

    ws.onopen = function(evt) {
        let message = {
            code: '1',
            bno: bno,
            userNo: userNo,
            userId: window.name,
            content: '',
            chatDate: getFormattedTime()
        };
        
        ws.send(JSON.stringify(message));
        print('', '대화방에 참여했습니다.', 'me', 'state', message.chatDate);
        $('#msg').focus();
    };

    ws.onmessage = function(evt) {
        let message = JSON.parse(evt.data);
        console.log(message);

        const senderId = userMap[message.userNo] || "알 수 없는 사용자"; // WebSocket 메시지에서도 userNo로 userId 찾기

        if (message.code === '1') {
            print('', `[${senderId}]님이 들어왔습니다.`, 'other', 'state', message.chatDate);
        } else if (message.code === '2') {
            print('', `[${senderId}]님이 나갔습니다.`, 'other', 'state', message.chatDate);
        } else if (message.code === '3') {
            // 다른 사용자가 보낸 메시지이므로 자동 스크롤을 일시적으로 비활성화
            autoScrollEnabled = false;
            print(senderId, message.content, 'other', 'msg', message.chatDate);
        }
    };
}

function scrollCheck() {
    const chatArea = $('#chatArea');
    autoScrollEnabled = (chatArea.scrollTop() + chatArea.innerHeight() >= chatArea[0].scrollHeight - 10);

    // 스크롤이 위로 올라가 있으면 버튼 표시
    if (!autoScrollEnabled) {
        $('#scrollToBottomButton').show();
    } else {
        $('#scrollToBottomButton').hide();
    }
}

// 메시지 출력 함수
function print(sender, msg, side, state, time) {
    const isMyMessage = sender === window.name;

    let temp = `
        <div class="message ${isMyMessage ? 'my-message' : 'other-message'}">
            ${isMyMessage ? `<span class="name">${sender}</span><span class="content">${msg}</span>`
                          : `<span class="content">${msg}</span><span class="name">${sender}</span>`}
        </div>`;
    
    $('#chatArea').append(temp);

    // 자신의 메시지일 경우에만 하단으로 자동 스크롤
    if (isMyMessage || autoScrollEnabled) {
        $('#chatArea').scrollTop($('#chatArea')[0].scrollHeight);
    }
}

// 스크롤 이벤트 리스너 추가
$('#chatArea').on('scroll', scrollCheck);

$('#scrollToBottomButton').on('click', function() {
    $('#chatArea').scrollTop($('#chatArea')[0].scrollHeight);
    autoScrollEnabled = true; // 자동 스크롤 재활성화
    $(this).hide(); // 버튼 숨기기
});

// 엔터 키로 메시지 전송
$('#msg').keydown(function(evt) {
    if (evt.keyCode === 13) {  // 엔터 키
        sendMessage();  // 메시지 전송 함수 호출
    }
});

// 입력 버튼 클릭 시 메시지 전송
$('#sendButton').click(function() {
    sendMessage();  // 메시지 전송 함수 호출
});

// 메시지 전송 함수
function sendMessage() {
    let messageContent = $('#msg').val() || '';  // msg가 null일 경우 빈 문자열로 처리

    let message = {
        code: '3',
        bno: bno,
        userNo: userNo,
        userId: window.name,
        content: messageContent,
        chatDate: getFormattedTime()
    };
    
    ws.send(JSON.stringify(message));  // 메시지 전송
    $('#msg').val('').focus();
    print(window.name, messageContent, 'me', 'msg', message.chatDate);
}

// 연결 해제 처리
$(window).on('beforeunload', function() {
    disconnect();
});

function disconnect() {
    if (ws) {
        let message = {
            code: '2',
            bno: bno,
            userNo: userNo,
            userId: window.name,
            content: '',
            chatDate: getFormattedTime()
        };
        
        ws.send(JSON.stringify(message));
        ws.close();
    }
}

// 페이지 로드 시 WebSocket 연결 및 채팅 입력란 표시
$(document).ready(function() {
    connect();  // WebSocket 연결 시작
    $('#chatInputContainer').show();  // 채팅 입력창 표시
});

// 날짜와 시간을 초 단위까지 포맷하는 함수
function getFormattedTime() {
    const now = new Date();
    return `${now.getFullYear()}. ${String(now.getMonth() + 1).padStart(2, '0')}. ${String(now.getDate()).padStart(2, '0')} ${now.getHours()}:${String(now.getMinutes()).padStart(2, '0')}:${String(now.getSeconds()).padStart(2, '0')}`;
}
