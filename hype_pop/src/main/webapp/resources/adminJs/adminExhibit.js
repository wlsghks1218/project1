window.onload = function() {
    // 예시로 두 카테고리와 이미지 파일명을 설정
    const category1 = "exhibitionBanner"; // 전시회 배너 이미지
    const category2 = "exhibitionDetail"; // 전시회 상세 이미지
    
    const fileName1Element = document.querySelector('input[name="beforeFileName1"]');
    if (fileName1Element) {
        const fileName1 = fileName1Element.value;
        fetchImage(category1, fileName1, "beforeImg1");
    }

    // 'beforeFileName2' input 요소가 존재하는 경우에만 파일명을 가져오고 이미지 불러오기
    const fileName2Element = document.querySelector('input[name="beforeFileName2"]');
    if (fileName2Element) {
        const fileName2 = fileName2Element.value;
        fetchImage(category2, fileName2, "beforeImg2");
    }    
};

function fetchImage(category, fileName, imgElementId) {
	const encodedFileName = encodeURIComponent(fileName);
    const imageUrl = `/admin/getImages/${encodedFileName}/${category}/`;  
//    const imageUrl = `/admin/getImages/${fileName}/${category}/`;    

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
            document.getElementById(imgElementId).src = imageObjectURL;
//            document.getElementById("beforeImg1").src = imageObjectURL; // 해당 ID의 이미지에 표시
//            document.getElementById("beforeImg2").src = imageObjectURL; // 해당 ID의 이미지에 표시
        })
        .catch(error => {
            console.error('이미지 로딩 실패:', error);
        });
}

// *** 전시회 등록 페이지 영역 ***
// 등록하기 버튼 클릭 시 전시회 등록     
// 파일 검증
// 이미지인것만 올릴 수 있도록 변경
const regex = new RegExp("(.*?)\\.(jpg|jpeg|png|gif|jfif|avif|webp)$");
const MAX_SIZE = 10485760; 

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
document.querySelector('#exhBannerImg').addEventListener('click', function() {
    document.querySelector('#exhBannerImageFile').click(); // 클릭 시 파일 선택 창 열기
});

// 상세 이미지 클릭 시 파일 선택
document.querySelector('#exhDetailImg').addEventListener('click', function() {
    document.querySelector('#exhDetailImageFile').click(); // 클릭 시 파일 선택 창 열기
});

// 배너 이미지 파일 미리보기 및 검증
document.querySelector('#exhBannerImageFile').addEventListener('input', function(event) {
    const files = event.target.files;
    const uploadedExBannerImagesDiv = document.getElementById('uploadedExBannerImages');

 // 요소가 존재하는지 확인
    if (uploadedExBannerImagesDiv) {
        // 기존 이미지 미리보기를 초기화
        uploadedExBannerImagesDiv.innerHTML = '';

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
                img.style.maxWidth = '400px'; // 이미지 크기 조절
                img.style.marginRight = '10px'; // 간격 조정
                uploadedExBannerImagesDiv.appendChild(img); // 미리보기 div에 추가
            };
            reader.readAsDataURL(file); // 파일을 Data URL로 읽기
        });
    } else {
        console.log("uploadedExBannerImages...");
    }
});

// 상세 이미지 파일 미리보기 및 검증
document.querySelector('#exhDetailImageFile').addEventListener('input', function(event) {
    const files = event.target.files;
    const uploadedExDetailImagesDiv = document.getElementById('uploadedExDetailImages');

    // 기존 이미지 미리보기를 초기화
    uploadedExDetailImagesDiv.innerHTML = '';

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
            img.style.maxWidth = '400px'; // 이미지 크기 조절
            img.style.marginRight = '10px'; // 간격 조정
            uploadedExDetailImagesDiv.appendChild(img); // 미리보기 div에 추가
        };
        reader.readAsDataURL(file); // 파일을 Data URL로 읽기
    });
});

// 전시회 등록 버튼 클릭 이벤트
function exhRegister() {
	const form = document.forms[0];
	
	// FormData 객체 생성
    const formData = new FormData(form);

    // 예외처리
    const exhBannerImageFile = document.getElementById('exhBannerImageFile');
    const exhDetailImageFile = document.getElementById('exhDetailImageFile');    
    
    if (exhBannerImageFile.files.length === 0) {
    	alert('전시회 배너 이미지를 입력해주세요');
    	return;
    }
    if (exhDetailImageFile.files.length === 0) {
    	alert('전시회 상세 이미지를 입력해주세요');
    	return;
    }
    if (!form.exhName.value) {
        alert('전시회 이름을 입력해주세요');
        return;
    }
    if (!form.exhLocation.value) {
    	alert('전시회 주소를 입력해주세요');
    	return;
    }
    if (!form.exhStartDate.value) {
    	alert('전시회 시작일을 입력해주세요');
    	return;
    }
    if (!form.exhEndDate.value) {
    	alert('전시회 종료일을 입력해주세요');
    	return;
    }
    if (!form.exhWatchTime.value) {
    	alert('전시회 러닝타임을 입력해주세요');
    	return;
    }
    if (!form.exhWatchAge.value) {
    	alert('전시회 연렁대를 입력해주세요');
    	return;
    }
    if (!form.exhPrice.value) {
    	alert('전시회 가격을 입력해주세요');
    	return;
    }
    if (!form.exhInfo.value) {
        alert('설명글을 입력해주세요');
        return;
    }
	    
    // 폼 제출
    form.submit();
}

// **** 전시회 수정/삭제 페이지 영역 ****
// 수정하기 버튼 클릭 시 업데이트
// 신규 이미지 선택 시 미리보기
document.getElementById("exhBannerImageFile").addEventListener("change", function(event) {
	const file = event.target.files[0];
	if (file) {
	  const reader = new FileReader();
	  reader.onload = function(e) {
	 	 const previewContainer = document.getElementById("uploadedBannerImages");
	      previewContainer.innerHTML = ''; // 이전 미리보기 내용 초기화
	      const img = document.createElement('img');
	      img.src = e.target.result;
	      img.width = 400; // 이미지 크기 조정 (필요시)
	      img.height = 500; // 이미지 크기 조정 (필요시)
	      previewContainer.appendChild(img); // 새로운 이미지 요소 추가
	  };
	  reader.readAsDataURL(file);
	}
});

document.getElementById("exhDetailImageFile").addEventListener("change", function(event) {
	const file = event.target.files[0];
	if (file) {
		const reader = new FileReader();
     reader.onload = function(e) {
         const previewContainer = document.getElementById("uploadedDetailImages");
         previewContainer.innerHTML = ''; // 이전 미리보기 내용 초기화
         const img = document.createElement('img');
         img.src = e.target.result;
         img.width = 400; // 이미지 크기 조정 (필요시)
         img.height = 500; // 이미지 크기 조정 (필요시)
         previewContainer.appendChild(img); // 새로운 이미지 요소 추가
     };
		reader.readAsDataURL(file);
	}
});

function exhUpdate() {
	
	const f = document.forms[0];
	
	const formData = new FormData(f);
		
    const exhBannerImageFile = document.getElementById('exhBannerImageFile');
    const exhDetailImageFile = document.getElementById('exhDetailImageFile');
    
	// 예외처리
    if (exhBannerImageFile.files.length === 0) {
        alert('상품 배너 이미지를 입력해주세요');
        return;  // 배너 이미지가 없으면 폼 제출하지 않음
    }
    
    if (exhDetailImageFile.files.length === 0) {
        alert('상품 상세 이미지를 입력해주세요');
        return;  // 상세 이미지가 없으면 폼 제출하지 않음
    }
    if (f.exhName.value == '') {
        alert('전시회 이름을 입력해주세요');
        return;
    }
    if (f.exhLocation.value == '') {
        alert('전시회 주소를 입력해주세요');
        return;
    }
    if (f.exhStartDate.value == '') {
        alert('전시회 시작일을 입력해주세요');
        return;
    }
    if (f.exhEndDate.value == '') {
        alert('전시회 종료일을 입력해주세요');
        return;
    }
    if (f.exhWatchTime.value == '') {
    	alert('전시회 러닝타임을 입력해주세요');
    	return;
    }
    if (f.exhWatchAge.value == '') {
    	alert('전시회 연령가를 입력해주세요');
    	return;
    }
    if (f.exhPrice.value == '') {
    	alert('전시회 가격을 입력해주세요');
    	return;
    }
    if (f.exhInfo.value == '') {
    	alert('전시회 설명글을 입력해주세요');
    	return;
    }
    
    document.getElementById("exhForm").action = "/admin/exhUpdate";  // 수정 요청 경로
    document.getElementById("exhForm").submit();  // 폼 제출
	
}

// 삭제하기 버튼 클릭 시 업데이트
function exhDelete() {
	if (confirm("정말 삭제하시겠습니까?")) {
     // 삭제 작업을 위한 폼 액션 설정
     document.getElementById("exhForm").action = "/admin/exhDelete";  // 삭제 요청 경로
     document.getElementById("exhForm").submit();  // 폼 제출
	}
}

// 취소 및 리스트로 돌아가기 버튼 클릭시 메인페이지로 이동
function backtoExhList() {
	loadExhibitions(currentPageForExh);
}