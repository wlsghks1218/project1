let dataList = [];
let currentPage = 1;
const itemsPerPage = 10;
let userNoElement = document.getElementById("userNo");
let userNo = userNoElement ? userNoElement.value : null;
console.log(userNo);

const goInsertBoardBtn = document.getElementById("goInsertBoard");
if (goInsertBoardBtn) {
    goInsertBoardBtn.addEventListener('click', () => {
        if (userNo) {
            location.href = "/party/boardInsert";
        } else {
            document.getElementById("loginModal").style.display = "block";
        }
    });
}

fetch('/party/getAllParty')
    .then(response => response.json())
    .then(data => {
        if (data.length === 0) {
            displayNoPartyMessage();
        } else {
            dataList = data.sort((a, b) => new Date(b.regDate) - new Date(a.regDate));
            renderTable();
            renderPagination();
        }
    })
    .catch(error => console.error("Error fetching data:", error));

function renderTable() {
    let msg = "";
    const startIndex = (currentPage - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    const pageData = dataList.slice(startIndex, endIndex);

    pageData.forEach(vo => {
        const formattedDate = formatDate(vo.regDate);
        msg += `
            <tr class="partyTr" data-bno="${vo.bno}" data-current="${vo.currentUser}" data-max="${vo.maxUser}">
                <td>${vo.category}</td>
                <td>${vo.targetName}</td>
                <td>${vo.boardTitle}</td>
                <td>${formattedDate}</td>
                <td>${vo.currentUser}/${vo.maxUser}</td>
            </tr>
        `;
    });

    const tableBody = document.querySelector("table tbody");
    tableBody.innerHTML = "";
    tableBody.insertAdjacentHTML("beforeend", msg);

    document.querySelectorAll(".partyTr").forEach(row => {
        row.addEventListener('click', (e) => {
        	if(userNo){
            const currentBno = e.currentTarget.getAttribute("data-bno");
            const currentUser = parseInt(e.currentTarget.getAttribute("data-current"));
            const maxUser = parseInt(e.currentTarget.getAttribute("data-max"));

            fetch(`/party/chkJoinedOrNot/${currentBno}`)
                .then(response => response.json())
                .then(data => {
                    const isUserInRoom = data.some(room => room.userNo === parseInt(userNo));

                    if (currentUser === maxUser && !isUserInRoom) {
                        alert("풀방입니다");
                        return;
                    }
                    location.href = `/party/boardDetail?bno=${currentBno}`;
                })
                .catch(error => console.error("Error checking room status:", error));
        	}else{
                document.getElementById("loginModal").style.display = "block";
        	}
        });
    });
}

function renderPagination() {
    const pagination = document.getElementById("pagination");
    pagination.innerHTML = "";
    const totalPages = Math.ceil(dataList.length / itemsPerPage);
    for (let i = 1; i <= totalPages; i++) {
        const pageItem = document.createElement("span");
        pageItem.textContent = i;
        pageItem.classList.add("pageItem");
        if (i === currentPage) {
            pageItem.classList.add("active");
        }
        pageItem.addEventListener('click', () => {
            currentPage = i;
            renderTable();
            renderPagination();
        });
        pagination.appendChild(pageItem);
    }
}

function formatDate(dateString) {
    const date = typeof dateString === 'number' ? new Date(dateString) : new Date(Date.parse(dateString));
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
}

// 데이터가 없는 경우 표시할 메시지 함수
function displayNoPartyMessage() {
    const tableBody = document.querySelector("table tbody");
    tableBody.innerHTML = `
        <tr>
            <td colspan="5" style="text-align: center; font-weight: bold;">함께 갈 파티를 구해봐요</td>
        </tr>
    `;

    const pagination = document.getElementById("pagination");
    pagination.innerHTML = ""; // 페이지네이션 숨김
}

document.querySelector(".close").onclick = function() {
    document.getElementById("loginModal").style.display = "none";
};

window.onclick = function(event) {
    if (event.target == document.getElementById("loginModal")) {
        document.getElementById("loginModal").style.display = "none";
    }
};