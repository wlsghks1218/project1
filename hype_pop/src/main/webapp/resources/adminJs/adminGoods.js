// *** 상품 상태 조회 페이지 영역 ***
//function formatDate(dateString) {
//    const date = new Date(dateString);
//    const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
//    return date.toLocaleDateString('ko-KR', options); // 한국 날짜 형식으로 변환
//}
//
//function fetchPurchaseList() {
//    fetch('/admin/getPurchaseList')
//        .then(response => {
//            if (!response.ok) {
//                throw new Error('Network response was not ok: ' + response.statusText);
//            }
//            return response.json();
//        })
//        .then(data => {
//        	
//            renderPurchaseList(data); // 데이터 렌더링 함수 호출
//        })
//        .catch(error => {
//            console.error('Error fetching purchase list:', error);
//        });
//}
//
//function renderPurchaseList(purchaseList) {
//    const goodsListBody = document.getElementById('goodsListBody');
//    goodsListBody.innerHTML = ''; // 기존 내용 초기화
//
//    purchaseList.forEach(purchase => {
//        const row = document.createElement('tr');
//        row.innerHTML = `
//            <td>${purchase.gno}</td>
//            <td>${purchase.gamount}</td>
//            <td>${purchase.gprice}</td>
//            <td>${formatDate(purchase.gbuyDate)}</td> <!-- 날짜 포맷 적용 -->
//            <td>
//                <select id="goodsSts">
//                    <option value="구매완료">구매완료</option>
//                    <option value="배송중">배송중</option>
//                    <option value="배송완료">배송완료</option>
//                </select>
//            </td>
//        `;
//        goodsListBody.appendChild(row);
//    });
//}
//
//// 페이지 로드 후 호출
//window.onload = fetchPurchaseList;


// *** 상품(굿즈) 등록 페이지 영역 ***
// 등록하기 버튼 클릭 시 상품(굿즈) 등록
// psNo 가져오기
document.getElementById('storeList').addEventListener('change', updatePsNo);

function updatePsNo() {
    const storeList = document.getElementById("storeList");
    const selectedOption = storeList.options[storeList.selectedIndex];
    console.log('모든 팝업스토어 출력: ', selectedOption); // 선택된 psNo 출력
    const psno = selectedOption.getAttribute("data-psno"); // data-psno 속성에서 psNo 가져오기
    console.log('선택된 psNo 출력: ', psno); // 선택된 psNo 출력
    document.querySelector('input[name="psno"]').value = psNo; // 가져온 psNo를 hidden input에 설정
}

// 파일 미리보기
document.querySelector('#gImageFile').addEventListener('input', function(event) {
    const files = event.target.files;
    const uploadedGImagesDiv = document.getElementById('uploadedGImages');

    // 기존의 이미지 미리보기를 초기화
    uploadedGImagesDiv.innerHTML = '';

    let isFileSelected = files.length > 0;

    if (isFileSelected) {
        const formData = new FormData();

        // 새로 선택한 파일만 미리보기 생성
        Array.from(files).forEach(file => {
            if (!checkFile(file.name, file.size)) {
                return; // 파일 검증 실패 시 종료
            }
            formData.append('imageFiles', file); // 'imageFiles'로 변경

            // 이미지 미리보기 생성
            const reader = new FileReader();
            reader.onload = function(e) {
                const img = document.createElement('img');
                img.src = e.target.result; // 파일의 Data URL
                img.style.width = '300px'; // 이미지 크기 조절
                img.style.marginRight = '10px'; // 간격 조정
                uploadedGImagesDiv.appendChild(img); // 미리보기 div에 추가
            };
            reader.readAsDataURL(file); // 파일을 Data URL로 읽기
        });

        // AJAX 요청을 보내기 전에 FormData 확인
        console.log(...formData.entries()); // FormData 내용 확인

    } else {
        console.error('파일이 선택되지 않았습니다.');
    }
});

// 파일 검증
const regex = new RegExp("(.*?)\\.(jpg|jpeg|png|gif)$");
const MAX_SIZE = 5242880; // 5MB

function checkFile(fileName, fileSize) {
    if (fileSize >= MAX_SIZE) {
        alert("파일 사이즈가 너무 큽니다.");
        return false;
    }
    if (!regex.test(fileName)) {
        alert("잘못된 파일 확장자입니다.");
        return false;
    }
    return true;
}

// 상품(굿즈) 이미지 클릭 시 파일(이미지) 첨부 기능
document.querySelector('#gImg').addEventListener('click', function() {
    document.querySelector('#gImageFile').click(); // 클릭 시 파일 선택 창 열기
});

// 상품(굿즈) 등록 버튼 클릭 이벤트
function goodsRegister(e) {
    const form = document.forms[0];
    
    console.log("psNo: " + form.psno.value);
    console.log("gname: " + form.gname.value);
    console.log("gprice: " + form.gprice.value);
    console.log("gexp: " + form.gexp.value);
    const files = form.imageFiles.files;
    console.log("imageFiles0: " + files[0].name);
    console.log("imageFiles1: " + files[1].name);

    // FormData 객체 생성
    const formData = new FormData(form);

    // 예외처리
    if (!form.gname.value) {
        alert('상품 이름을 입력해주세요');
        return;
    }
    if (!form.gprice.value) {
        alert('상품 가격을 입력해주세요');
        return;
    }
    if (!form.sellDate.value) {
        alert('상품 판매 종료일을 입력해주세요');
        return;
    }
    if (!form.gexp.value) {
        alert('설명글을 입력해주세요');
        return;
    }

    // 폼 제출
    form.submit();
}