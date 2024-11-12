// *** 전시회 등록 페이지 영역 ***
// 등록하기 버튼 클릭 시 전시회 등록     
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
            img.style.width = '150px'; // 이미지 크기 조절
            img.style.marginRight = '10px'; // 간격 조정
            uploadedExBannerImagesDiv.appendChild(img); // 미리보기 div에 추가
        };
        reader.readAsDataURL(file); // 파일을 Data URL로 읽기
    });
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
            img.style.width = '150px'; // 이미지 크기 조절
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