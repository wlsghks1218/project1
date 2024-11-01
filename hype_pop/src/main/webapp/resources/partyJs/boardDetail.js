let name;
let ws;
const bno = new URLSearchParams(location.search).get('bno');
const url = `ws://192.168.0.121:9090/chatserver.do?bno=${bno}`;
const userNo = 1;
const userId = "user1";
const userMap = {}; // userNo와 userId를 매핑하여 저장할 객체

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
                print(senderId, message.content,
                    message.userNo === userNo ? 'me' : 'other',
                    'msg', message.chatDate);
            });
        })
        .catch(error => console.error("Error fetching chat contents:", error));
}

// WebSocket 연결 함수
function connect() {
    if (ws && ws.readyState === WebSocket.OPEN) {
        console.log("WebSocket already connected.");
        return;
    }

    ws = new WebSocket(url);

    ws.onopen = function(evt) {
        console.log("WebSocket connection opened");
        let message = {
            code: '1',
            bno: bno,
            userNo: userNo,
            userId: userId,
            content: '',
            chatDate: getFormattedTime()
        };
        
        ws.send(JSON.stringify(message));
        print('', '대화방에 참여했습니다.', 'me', 'state', message.chatDate);
        $('#msg').focus();
    };

    ws.onmessage = function(evt) {
        let message = JSON.parse(evt.data);
        const senderId = userMap[message.userNo] || "알 수 없는 사용자";

        if (message.code === '1') {
            print('', `[${senderId}]님이 들어왔습니다.`, 'other', 'state', message.chatDate);
        } else if (message.code === '2') {
            print('', `[${senderId}]님이 나갔습니다.`, 'other', 'state', message.chatDate);
        } else if (message.code === '3' && message.userNo !== userNo) {  // 중복 방지
            print(senderId, message.content, 'other', 'msg', message.chatDate);
        }
    };

    ws.onclose = function(evt) {
        console.log("WebSocket connection closed");
    };
}

// 메시지 출력 함수
function print(sender, msg, side, state, time) {
    const isMyMessage = sender === userId;
    let temp = `
        <div class="message ${isMyMessage ? 'my-message' : 'other-message'}">
            ${isMyMessage ? `<span class="name">${sender}</span><span class="content">${msg}</span>`
                          : `<span class="content">${msg}</span><span class="name">${sender}</span>`}
        </div>`;
    $('#chatArea').append(temp);
    $('#chatArea').scrollTop($('#chatArea')[0].scrollHeight);
}

// 메시지 전송 함수
function sendMessage() {
    let messageContent = $('#msg').val() || '';
    let message = {
        code: '3',
        bno: bno,
        userNo: userNo,
        userId: userId,
        content: messageContent,
        chatDate: getFormattedTime()
    };
    
    // WebSocket이 OPEN 상태일 때만 메시지를 전송
    if (ws.readyState === WebSocket.OPEN) {
        ws.send(JSON.stringify(message));
        $('#msg').val('').focus();
        print(userId, messageContent, 'me', 'msg', message.chatDate);
    } else {
        console.error("WebSocket is not open. Cannot send message.");
    }
}

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
            userId: userId,
            content: '',
            chatDate: getFormattedTime()
        };
        ws.send(JSON.stringify(message));
        ws.close();
    }
}

// 페이지 로드 시 WebSocket 연결
$(document).ready(function() {
    connect(); 
    $('#chatInputContainer').show();
});

// 날짜와 시간을 초 단위까지 포맷하는 함수
function getFormattedTime() {
    const now = new Date();
    return `${now.getFullYear()}. ${String(now.getMonth() + 1).padStart(2, '0')}. ${String(now.getDate()).padStart(2, '0')} ${now.getHours()}:${String(now.getMinutes()).padStart(2, '0')}:${String(now.getSeconds()).padStart(2, '0')}`;
}
