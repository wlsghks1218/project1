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
document.getElementById('storeList').addEventListener('change', setStorePsNo);

function setStorePsNo() {
    const storeList = document.getElementById("storeList");
    const selectedOption = storeList.options[storeList.selectedIndex];
    console.log('모든 팝업스토어 출력: ', selectedOption); // 선택된 psNo 출력
    const psNo = selectedOption.getAttribute("data-psno"); // data-psno 속성에서 psNo 가져오기
    console.log('선택된 psNo 출력: ', psNo); // 선택된 psNo 출력
    document.querySelector('input[name="psno"]').value = psNo;  // psNo를 readonly input에 설정
}

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

// 배너 이미지 클릭 시 파일 선택
document.querySelector('#gBannerImg').addEventListener('click', function() {
    document.querySelector('#gBannerImageFile').click(); // 클릭 시 파일 선택 창 열기
});

// 상세 이미지 클릭 시 파일 선택
document.querySelector('#gDetailImg').addEventListener('click', function() {
    document.querySelector('#gDetailImageFile').click(); // 클릭 시 파일 선택 창 열기
});

// 배너 이미지 파일 미리보기 및 검증
document.querySelector('#gBannerImageFile').addEventListener('input', function(event) {
    const files = event.target.files;
    const uploadedBannerImagesDiv = document.getElementById('uploadedBannerImages');

    // 기존 이미지 미리보기를 초기화
    uploadedBannerImagesDiv.innerHTML = '';

    // 최대 한 개의 배너 이미지 파일만 선택하도록 제한
    Array.from(files).slice(0, 1).forEach((file) => {
        if (!checkFile(file.name, file.size)) {
            return; // 파일 검증 실패 시 종료
        }

        // 이미지 미리보기 생성
        const reader = new FileReader();
        reader.onload = function(e) {
            const img = document.createElement('img');
            img.src = e.target.result; // 파일의 Data URL
            img.style.width = '150px'; // 이미지 크기 조절
            img.style.marginRight = '10px'; // 간격 조정
            uploadedBannerImagesDiv.appendChild(img); // 미리보기 div에 추가
        };
        reader.readAsDataURL(file); // 파일을 Data URL로 읽기
    });
});

// 상세 이미지 파일 미리보기 및 검증
document.querySelector('#gDetailImageFile').addEventListener('input', function(event) {
    const files = event.target.files;
    const uploadedDetailImagesDiv = document.getElementById('uploadedDetailImages');

    // 기존 이미지 미리보기를 초기화
    uploadedDetailImagesDiv.innerHTML = '';

    // 최대 두 개의 상세 이미지 파일만 선택하도록 제한
    Array.from(files).slice(0, 2).forEach((file) => {
        if (!checkFile(file.name, file.size)) {
            return; // 파일 검증 실패 시 종료
        }

        // 이미지 미리보기 생성
        const reader = new FileReader();
        reader.onload = function(e) {
            const img = document.createElement('img');
            img.src = e.target.result; // 파일의 Data URL
            img.style.width = '150px'; // 이미지 크기 조절
            img.style.marginRight = '10px'; // 간격 조정
            uploadedDetailImagesDiv.appendChild(img); // 미리보기 div에 추가
        };
        reader.readAsDataURL(file); // 파일을 Data URL로 읽기
    });
});

// 상품(굿즈) 등록 버튼 클릭 이벤트
function goodsRegister() {
	const form = document.forms[0];
	
	// FormData 객체 생성
    const formData = new FormData(form);

    // 예외처리
    // 체크박스
    const checkboxes = form.querySelectorAll('input[type="checkbox"][name^="gcat"]');
    const selectedCategories = Array.from(checkboxes).filter(checkbox => checkbox.checked);
    
    const gBannerImageFile = document.getElementById('gBannerImageFile');
    const gDetailImageFile = document.getElementById('gDetailImageFile');

    
    if (gBannerImageFile.files.length === 0) {
    	alert('상품 배너 이미지를 입력해주세요');
    	return;
    }
    if (gDetailImageFile.files.length === 0) {
    	alert('상품 상세 이미지를 입력해주세요');
    	return;
    }
    if (selectedCategories.length === 0) {
        alert('최소 한 개의 카테고리를 선택해야 합니다.');
        return;
    }
    if (selectedCategories.length > 3) {
        alert('최대 세 개의 카테고리만 선택할 수 있습니다.');
        return;
    }
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

