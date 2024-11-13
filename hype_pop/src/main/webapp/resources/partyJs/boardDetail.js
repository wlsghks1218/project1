let name;
let ws;
const bno = new URLSearchParams(location.search).get('bno');
const url = `ws://192.168.0.121:9010/chatserver.do?bno=${bno}`;
const userNoElement = document.getElementById("userNo");
const userIdElement = document.getElementById("userId");
const userNo = userNoElement ? userNoElement.value : null;
const userId = userIdElement ? userIdElement.value : null;
const userMap = {}; // userNo와 userId를 매핑하여 저장할 객체

console.log(userNo);
console.log(userId);
console.log(userMap);

// chat_tbl에 bno, userNo를 전송하여 count값이 1,0으로 확인하여 진입여부 확인
fetch(`/party/chkJoined/${bno}/${userNo}`)
    .then(response => response.text())
    .then(data => {
        console.log("Fetched data:", data);
        if (data === "채팅방에 진입했습니다.") {
            console.log("새로운 WebSocket을 연결합니다.");
            fetchPartyUserList(); // 참여 후 목록 갱신
            fetchPartyUserCount();
        } else if (data === "채팅방에 이미 있는 유저입니다.") {
            console.log("이미 연결된 WebSocket입니다.");
            fetchPartyUserList(); // 이미 참여 중이라도 목록을 불러옴
            fetchPartyUserCount();
        }
    })
    .catch(error => console.error("Error fetching data:", error));

function fetchPartyUserCount(){
    fetch(`/party/partyUserCount/${bno}`)
    .then(response => response.json())
    .then(data => {
        const currentUser = data.currentUser;
        const maxUser = data.maxUser;
        const memberCountDiv = document.querySelector(".memberCount");
        memberCountDiv.innerHTML = currentUser + '/' + maxUser;
    });
}

// sign_in_info_tbl(유저 정보 VO)를 받아오는 곳
function fetchPartyUserList() {
    fetch(`/party/getPartyUser/${bno}`)
        .then(response => response.json())
        .then(data => {
            const joinMemberDiv = document.querySelector('.joinMember');
            joinMemberDiv.innerHTML = '<h3>참여 유저 목록:</h3>';
            data.forEach(user => {
                userMap[user.userNo] = user.userId;
                const userElement = document.createElement('div');
                userElement.textContent = `${user.userId}`;
                joinMemberDiv.appendChild(userElement);
            });
        })
        .catch(error => console.error("Error fetching party users:", error));
}

// WebSocket 연결 함수
function connect() {
    if (ws && ws.readyState === WebSocket.OPEN) {
        console.log("WebSocket already connected.");
        return;
    }

    ws = new WebSocket(url);

    ws.onopen = function(evt) {
        let message = {
            code: '1',  // 진입 코드
            bno: bno,
            userNo: userNo,
            userId: userId,
            content: '',
            chatDate: getFormattedTime()
        };

        ws.send(JSON.stringify(message));
        print('', '대화방에 참여했습니다.', 'me', 'state', '', message.chatDate);

        // 채팅창 스크롤을 최하단으로 조정
        const chatArea = $('#chatArea')[0];
        chatArea.scrollTop = chatArea.scrollHeight;

        $('#msg').focus();

        // 유저 목록 및 카운트 가져오기
        fetchPartyUserList();
        fetchPartyUserCount();
    };

    ws.onmessage = function(evt) {
        let message = JSON.parse(evt.data);
        const senderId = userMap[message.userNo] || "알 수 없는 사용자";

        console.log("Received WebSocket message:", message);

        if (message.userNo !== userNo) {
            if (message.code === '1') { 
                console.log(`[${senderId}] 입장 메시지 수신`);
                print('', `[${senderId}]님이 들어왔습니다.`, 'other', 'state', '', message.chatDate);
                fetchPartyUserList();
                fetchPartyUserCount();
            } else if (message.code === '2') {
                console.log(`[${senderId}] 퇴장 메시지 수신`);
                print('', `[${senderId}]님이 나갔습니다.`, 'other', 'state', '', message.chatDate);
                fetchPartyUserList();
                fetchPartyUserCount();
            } else if (message.code === '3') {
                console.log(`[${senderId}] 일반 메시지 수신`);
                print(senderId, message.content || "", 'other', 'msg', '', message.chatDate);
            }
        }
    };

    ws.onclose = function(evt) {
        console.log("WebSocket connection closed");
    };
}

// 메시지 출력 함수
function print(sender, msg, side, type, additionalClass = '', time) {
    let temp;

    if (type === 'state') {
        temp = `<div class="state-message ${side} ${additionalClass}">${msg}</div>`;
        
        if (additionalClass === 'read-marker') {
            temp += `<button id="scrollToBottomButton" onclick="scrollToBottom()" style="display: block; margin-top: 5px;">채팅 하단으로 이동</button>`;
        }
    } else {
        const isMyMessage = sender === userId;
        temp = `
            <div class="message ${isMyMessage ? 'my-message' : 'other-message'}">
                ${isMyMessage 
                    ? `<span class="content">${msg}</span><span class="name">${sender}</span>` 
                    : `<span class="name">${sender}</span><span class="content">${msg}</span>`}
            </div>`;
    }

    $('#chatArea').append(temp);
    
    const chatArea = $('#chatArea')[0];
    chatArea.scrollTop = chatArea.scrollHeight;
}

// "채팅 하단으로 이동" 버튼 클릭 시 하단으로 스크롤
$('#scrollToBottomButton').click(function() {
    const chatArea = $('#chatArea')[0];
    chatArea.scrollTop = chatArea.scrollHeight;
    $(this).hide();
});

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

    console.log("Sending message:", message);  // 메시지 전송 로그

    ws.send(JSON.stringify(message));
    $('#msg').val('').focus();
    print(userId, messageContent, 'me', 'msg', '', message.chatDate);
}

// 엔터 키로 메시지 전송
$('#msg').keydown(function(evt) {
    if (evt.keyCode === 13) {
        sendMessage();
    }
});

// 입력 버튼 클릭 시 메시지 전송
$('#sendButton').click(function() {
    sendMessage();
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
        
        fetch(`/party/updateLeftTime/${bno}/${userNo}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error("Network response was not ok");
                }
                return response.json();
            })
            .then(result => {
                console.log("Left time updated:", result);
                ws.send(JSON.stringify(message));
                ws.close();
            })
            .catch(error => console.error("Error updating left time:", error));
    }
}

// 페이지 로드 시 WebSocket 연결
$(document).ready(function() {
    connect();
    ws.onerror = function(evt) {
        console.error("WebSocket error observed:", evt);
    };
    $('#chatInputContainer').show();
    $('#scrollToBottomButton').hide();
});

// 채팅 하단으로 이동
function scrollToBottom() {
    const chatArea = $('#chatArea')[0];
    chatArea.scrollTop = chatArea.scrollHeight;
    $('#scrollToBottomButton').hide();
}

function getFormattedTime() {     
	const now = new Date();     
	return `${now.getFullYear()}. ${String(now.getMonth() + 1).padStart(2, '0')}. ${String(now.getDate()).padStart(2, '0')} ${now.getHours()}:${String(now.getMinutes()).padStart(2, '0')}:${String(now.getSeconds()).padStart(2, '0')}`; 
}