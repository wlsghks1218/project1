// 이전 이미지 가져오기
window.onload = function() {
   const category = "popup";  // 예시로 'popup' 카테고리 지정
    const fileNameElement = document.querySelector('input[name="beforeFileName"]');
    
    if (fileNameElement) {
        const fileName = fileNameElement.value;
        fetchImage(category, fileName);
    }
};

//**** 팝업스토어 등록 페이지 영역 ****
// 등록하기 버튼 클릭 시 팝업스토어 등록
// 파일 미리보기
document.querySelector('#imageFile').addEventListener('input', function(event) {
    const files = event.target.files;
    const uploadedImagesDiv = document.getElementById('uploadedImages');

    // 기존의 이미지 미리보기를 초기화
    uploadedImagesDiv.innerHTML = '';
    
    let isFileSelected = files.length > 0;

    if (isFileSelected) {
        const formData = new FormData();

        // 새로 선택한 파일만 미리보기 생성
        Array.from(files).forEach(file => {
            if (!checkFile(file.name, file.size)) {
                return; // 파일 검증 실패 시 종료
            }
//            uploadFile = file;
            formData.append('uploadFile', file);

            // 이미지 미리보기 생성
            const reader = new FileReader();
            reader.onload = function(e) {
                const img = document.createElement('img');
                img.src = e.target.result; // 파일의 Data URL
                img.style.width = '300px'; // 이미지 크기 조절
                img.style.marginRight = '10px'; // 간격 조정
                uploadedImagesDiv.appendChild(img); // 미리보기 div에 추가
            };
            reader.readAsDataURL(file); // 파일을 Data URL로 읽기
        });

        // AJAX 요청을 보내기 전에 FormData 확인
        console.log(...formData.entries()); // FormData 내용 확인
        
        // 파일 업로드 함수 호출
//        uploadFiles(formData); // 선택된 파일들 업로드 함수 호출
    } else {
       console.error('파일이 선택되지 않았습니다.');
    }
});

// 파일 검증
// 이미지인것만 올릴 수 있도록 변경
const regex = new RegExp("(.*?)\\.(jpg|jpeg|png|gif|jfif|avif|webp)$");
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
 
// 팝업스토어 이미지 클릭 시 파일(이미지) 첨부 기능
document.querySelector('#popUpimg').addEventListener('click', function() {
   document.querySelector('#imageFile').click(); // 클릭 시 파일 선택 창 열기
});

// 팝업 스토어 등록 버튼 클릭 이벤트
function popStoreRegister(e){
   const form = document.forms[0];
   
   const formData = new FormData(form);
   const fileInput = formData.get('imageFile');
   
   // 파일 존재 등을 판단하는 방법
   console.log(form.imageFile.files);
   console.log(formData.has('imageFile'));
   console.log(fileInput);
   console.log(fileInput.size);
   
   // 예외처리
   // 체크박스
   const checkboxes = form.querySelectorAll('input[type="checkbox"][name^="psCat"]');
    const selectedCategories = Array.from(checkboxes).filter(checkbox => checkbox.checked);
    if (selectedCategories.length === 0) {
        alert('최소 한 개의 카테고리를 선택해야 합니다.');
        return;
    }
    if (selectedCategories.length > 3) {
        alert('최대 세 개의 카테고리만 선택할 수 있습니다.');
        return;
    }
   if(fileInput.size === 0){
      alert('대표 이미지를 선택하십시오.');
      return;
   }
   if (!form.latitude.value) {
       alert('위도를 입력해주세요');
       return; 
   }
   if (!form.longitude.value) {
       alert('경도를 입력해주세요');
       return; 
   }
   if (!form.psName.value) {
       alert('팝업스토어 이름을 입력해주세요');
       return; 
   }
   if (!form.psStartDate.value) {
       alert('시작일을 입력해주세요');
       return; 
   }
   if (!form.psEndDate.value) {
       alert('종료일을 입력해주세요');
        return; 
   }
   if (!form.psAddress.value) {
       alert('주소를 입력해주세요');
       return; 
   }
   if (!form.snsAd.value) {
       alert('SNS주소를 입력해주세요');
       return; 
   }
   if (!form.comInfo.value) {
       alert('주최사 정보를 입력해주세요');
       return; 
   }
   if (!form.transInfo.value) {
       alert('교통편을 입력해주세요');
       return; 
   }
   if (!form.parkingInfo.value) {
       alert('주차장정보를 입력해주세요');
       return; 
   }
   if (!form.psExp.value) {
       alert('설명글을 입력해주세요');
       return; 
   }
   
   form.submit();

}

// fetch로 이미지를 가져와서 출력하는 예시
function fetchImage(category, fileName) {
    const imageUrl = `/admin/getImages/${fileName}/${category}/`;

    fetch(imageUrl)
        .then(response => {
            if (response.ok) {
                return response.blob(); // 이미지 파일을 blob 형태로 받음
            } else {
                throw new Error('이미지를 불러오는 데 실패했습니다.');
            }
        })
        .then(blob => {
            const imageObjectURL = URL.createObjectURL(blob);
            document.getElementById("beforeImg").src = imageObjectURL; // 이미지 표시
        })
        .catch(error => {
            console.error('이미지 로딩 실패:', error);
        });
}

//**** 팝업스토어 수정/삭제 페이지 영역 ****
// 수정하기 버튼 클릭 시 업데이트
// 신규 이미지 선택 시 미리보기
document.getElementById("imageFile").addEventListener("change", function(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const preview = document.getElementById("uploadedImages");
            preview.src = e.target.result;
            preview.style.display = "block";
        };
        reader.readAsDataURL(file);
    }
});

// 팝업스토어 수정
function popStoreUpdate() {
   const f = document.forms[0];   
   
   const formData = new FormData(f);
   
   const fileInput = formData.get('imageFile');
   
   console.log(fileInput);
   // 예외처리
   const checkboxes = f.querySelectorAll('input[type="checkbox"][name^="psCat"]');
    const selectedCategories = Array.from(checkboxes).filter(checkbox => checkbox.checked);
    if (selectedCategories.length === 0) {
        alert('최소 한 개의 카테고리를 선택해야 합니다.');
        return;
    }
    if (selectedCategories.length > 3) {
        alert('최대 세 개의 카테고리만 선택할 수 있습니다.');
        return;
    }
    if(fileInput.size === 0){
      alert('대표 이미지를 선택하십시오.');
      return;
   }
   if(f.psName.value == ''){
      alert('팝업스토어 이름을 입력해주세요');
      return;
   }
   if(f.psStartDate.value == ''){
      alert('시작일을 입력해주세요');
      return;
   }
   if(f.psEndDate.value == ''){
      alert('종료일을 입력해주세요');
      return;      
   }
   if(f.psAddress.value == ''){
      alert('주소를 입력해주세요');
      return;
   }
   if(f.snsAd.value == ''){
      alert('SNS주소를 입력해주세요');
      return;      
   }
   if(f.comInfo.value == ''){
      alert('주최사 정보를 입력해주세요');
      return;
   }
   if(f.transInfo.value == ''){
      alert('교통편을 입력해주세요');
      return;      
   }
   if(f.psExp.value == ''){
      alert('설명글을 입력해주세요');
      return;
   }
   
   document.getElementById("psUpdateDeleteForm").action = "/admin/psUpdate";  // 수정 요청 경로
    document.getElementById("psUpdateDeleteForm").submit();  // 폼 제출
}

// 팝업스토어 삭제
function popStoreDelete () {
   if (confirm("정말 삭제하시겠습니까?")) {
        // 삭제 작업을 위한 폼 액션 설정
        document.getElementById("psUpdateDeleteForm").action = "/admin/psDelete";  // 삭제 요청 경로
        document.getElementById("psUpdateDeleteForm").submit();  // 폼 제출
    }
}

// 취소 및 리스트로 돌아가기 버튼 클릭시 메인페이지로 이동
function backtoPsList() {
//   window.location.href = "/admin/adminPage";
   loadPopUpStores(currentPageForPopUp);
}