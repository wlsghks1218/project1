partyBoard.js
let dataList = [];
let currentPage = 1;
const itemsPerPage = 10;
let userNo = localStorage.getItem('userNo');

document.getElementById("goInsertBoard").addEventListener('click', () => {
    location.href = "/party/boardInsert";
});

fetch('/party/getAllParty')
    .then(response => response.json())
    .then(data => {
    	dataList = data.sort((a, b) => new Date(b.regDate) - new Date(a.regDate));
        renderTable();
        renderPagination();
    })
    .catch(error => console.error("Error fetching data:", error));

function renderTable() {
    let msg = "";  // HTML 문자열을 누적할 변수
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

    // 테이블 전체 행을 초기화하고 새로운 데이터를 추가
    const tableBody = document.querySelector("table tbody");
    tableBody.innerHTML = "";  // 기존 행 모두 제거
    tableBody.insertAdjacentHTML("beforeend", msg);
    
    document.querySelectorAll(".partyTr").forEach(row => {
        row.addEventListener('click', (e) => {
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
    return `${year}-${month}-${day}`;  // YYYY-MM-DD 형식
}