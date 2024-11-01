// 활성화된 탭을 추적하기 위한 변수
//{let activeTab = 'popUp';}

// form 객체 가져오기 (현재 사용안하고 있음)
//{const form = document.forms[0];}

// 파일 선택 여부
//let isFileSelected = false;

// **** 관리자 Header 영역 (공통) ****
// 탭 클릭 시 해당 기능 활성화
//document.getElementById('popUpManage').addEventListener('click', function() {
//    activeTab = 'popUp'; // 현재 활성화된 탭 업데이트
//    localStorage.setItem('activeTab', activeTab);  // 상태 저장
//    activatePopUpTab(); // 팝업 관리 기능 활성화
//    document.getElementById('registerBtn').style.visibility = 'visible'; // 등록 버튼 보이기
//});
//document.getElementById('storeManage').addEventListener('click', function() {
//    activeTab = 'store'; // 현재 활성화된 탭 업데이트
//    localStorage.setItem('activeTab', activeTab);  // 상태 저장
//    activateStoreTab(); // 쇼핑몰 관리 기능 활성화
//    document.getElementById('registerBtn').style.visibility = 'visible'; // 등록 버튼 보이기
//});
//document.getElementById('memberManage').addEventListener('click', function() {
//    activeTab = 'member'; // 현재 활성화된 탭 업데이트
//    localStorage.setItem('activeTab', activeTab);  // 상태 저장
//    activateMemberTab(); // 회원 관리 기능 활성화
//});

// **** 관리자 페이지 영역 ****
// **** 팝업스토어 영역 ****
// 팝업스토어 관리하기  활성화
//function activatePopUpTab() {
//    activeTab = 'popUp'; // 현재 활성화된 탭 업데이트
//    fetch('/admin/psList/')	
//        .then(response => {
//            if (!response.ok) {
//                throw new Error('리스트가 출력되지 않았습니다: ' + response.statusText);
//            }
//            return response.json();
//        })
//        .then(data => {
//            PopUpStoreLists(data);
//            console.log(data);
//        })
//        .catch(err => {
//            console.log(err);
//        });
//
//}

// 팝업스토어 관리하기 버튼 클릭 시 팝업 스토어 리스트 영역 출력
//function PopUpStoreLists(popUpStores) {
//    const adminMain = document.querySelector('.adminMain');
//    adminMain.innerHTML = '';
//
//    if (popUpStores.length === 0) {
//        adminMain.innerHTML = '<p>팝업 스토어가 없습니다.</p>';
//        return;
//    }
//
//    const list = document.createElement('div');
//
//    popUpStores.forEach(store => {
//    	const psList = document.createElement('p');
//
//    	// 팝업스토어 이름 클릭 시 링크로 이동
//        const link = document.createElement('a');
//        link.href = `popUpUpdate?psNo=${store.psNo}`;
//        link.textContent = store.psName; // 팝업스토어 이름에만 링크 걸리게 설정
//        link.style.color = 'black'; // 링크 색상 변경
//        link.style.textDecoration = 'none'; // 밑줄 제거
//
//        psList.appendChild(document.createTextNode(` ${store.psNo} `));
//        psList.appendChild(link); // p 태그에 a 태그 추가
//        psList.appendChild(document.createTextNode(` ${store.psStartDate} ${store.psEndDate}`)); // 나머지 텍스트 추가
//
//        list.appendChild(psList);
//    });
//
//    adminMain.appendChild(list);
//}

//**** 쇼핑몰(상품) 영역 ****
// 쇼핑몰 관리하기 활성화
//function activateStoreTab() {
// activeTab = 'store'; // 현재 활성화된 탭 업데이트
// fetch('/admin/gList/')
//     .then(response => {
//         if (!response.ok) {
//             throw new Error('리스트가 출력되지 않았습니다: ' + response.statusText);
//         }
//         return response.json();
//     })
//     .then(data => {
//         GoodsLists(data);
//         console.log(data);
//     })
//     .catch(err => {
//         console.log(err);
//     });
//}

// 쇼핑몰 관리하기 버튼 클릭 시 상품 리스트 영역 출력
//function GoodsLists(goods) {
//	const adminMain = document.querySelector('.adminMain');
//	adminMain.innerHTML = '';
//	
//	if (goods.length === 0) {
//		adminMain.innerHTML = '<p>상품이 없습니다.</p>';
//		return;
//	}
//	
//	const list = document.createElement('div');
//	
//	goods.forEach(store => {
//		const gsList = document.createElement('p');
//		
//		// 굿즈(상품) 이름 클릭 시 굿즈 정보 수정 페이지로 이동
//     const link = document.createElement('a');
//     link.href = `goodsUpdate?gNo=${store.gno}`;
//     link.textContent = store.gname; // 굿즈(상품) 이름에만 링크 걸리게 설정
//     link.style.color = 'black'; // 링크 색상 변경
//     link.style.textDecoration = 'none'; // 밑줄 제거
//    
//     gsList.appendChild(document.createTextNode(` ${store.gno} `));
//     gsList.appendChild(link); // p 태그에 a 태그 추가
//     gsList.appendChild(document.createTextNode(`${store.sellDate} ${store.gprice}`));
//
//     list.appendChild(gsList);
//	});
//	
//	adminMain.appendChild(list);
//}

//**** 회원 영역 ****
// 회원 관리하기 활성화
//function activateMemberTab() {
//	 activeTab = 'member'; // 현재 활성화된 탭 업데이트
//	 document.getElementById('registerBtn').style.visibility = 'hidden';  // 회원 관리 탭에서 등록 버튼 숨기기
//	 // 회원 관리 탭에서는 팝업스토어, 쇼핑 리스트 검색 불가능
//	 fetch('/admin/mList/')
//		    .then(response => {
//		    	if (!response.ok) {
//		    		throw new Error('리스트가 출력되지 않았습니다: ' + response.statusText);
//		    	}
//		    	return response.json();
//		    })
//		    .then(data => {
//		    	MemberLists(data);
//		    })
//		    .catch(err => {
//		    	console.error(err);
//		    });
//}

// 회원 관리하기 버튼 클릭 시 회원 리스트 출력
//function MemberLists(members) {
//	console.log(members);
// const adminMain = document.querySelector('.adminMain');
// adminMain.innerHTML = '';
//
// if (members.length === 0) {
//     adminMain.innerHTML = '<p>회원이 없습니다.</p>';
//     return;
// }
//
// const list = document.createElement('div');
//
// members.forEach(member => {
//     const mList = document.createElement('p');
//    
// 	// 회원아이디 클릭 시 회원 정보 수정 페이지로 이동
//     const link = document.createElement('a');
//     link.href = `memberUpdate?userId=${member.userNo}`;
//     link.textContent = member.userId; // 회원 아이디에만 링크 걸리게 설정
//     link.style.color = 'black'; // 링크 색상 변경	
//     link.style.textDecoration = 'none'; // 밑줄 제거
//    
//     const formattedDate = member.lastLoginDate ?
//     		new Date(member.lastLoginDate).toLocaleDateString('ko-KR') : '날짜 없음';
//     		
//     mList.appendChild(document.createTextNode(` ${member.userNo} `));
//     mList.appendChild(link); // p 태그에 a 태그 추가
//     mList.appendChild(document.createTextNode(` ${member.userEmail} ${formattedDate} ${member.enabled} ${member.auth}`));
//    
//     list.appendChild(mList);
// });
//
// adminMain.appendChild(list);
//}

//gpt 코드 (팝업스토어 등록하기)
//document.getElementById('psRegisterBtn').addEventListener('click', popStoreRegister);
//
//function popStoreRegister(event) {
//    event.preventDefault(); // 기본 제출 동작 방지
//
//    const form = event.target.form; // 폼 요소 가져오기
//    const selectedCategories = Array.from(form.psCat.selectedOptions).map(option => option.value);
//
//    if (selectedCategories.length === 0) {
//        alert('하나 이상의 카테고리를 선택해주세요');
//        return false;
//    }	
//
//    const categories = selectedCategories.join(',');
//    const fileInput = document.getElementById('imageFile'); // 파일 입력 요소 ID
//
//    console.log('파일 개수:', fileInput.files.length);
//
//   
//    if (fileInput.files.length == 0) {
//        alert('파일을 선택해주세요.');
//        return false;
//    }
//
//    const uploadFile = fileInput.files[0]; // 선택된 파일
//    const formData = new FormData(form);
////    formData.append('psCat', categories);
//    formData.append('uploadFile', uploadFile); // 수정된 부분
//
//    console.log('폼 데이터 전송:', ...formData.entries());
//
//    // fetch를 사용하여 폼 데이터 전송
//    fetch(form.action, {
//        method: 'POST',
//        body: formData,
//    })
//    .then(response => {
//        if (!response.ok) {
//            throw new Error('전송 실패: ' + response.statusText);
//        }
//        return response.text(); // 필요에 따라 JSON으로 파싱할 수도 있음
//    })
//    .then(data => {
//        console.log('전송 성공:', data);
//        // 성공 처리 로직 추가
//        window.location.href = 'admin/adminMain'; // 페이지 리다이렉트
//    })
//    .catch(error => {
//        console.error('오류 발생:', error);
//        alert('전송 중 오류가 발생했습니다.');
//    });
//
//    return true;
//}



//**** 팝업스토어 등록 페이지 영역 ****
// 등록하기 버튼 클릭 시 팝업스토어 등록
// 에러 발생 중이라 주석 처리
// AdminController의 psRegister로 전송
//document.getElementById('psRegisterBtn').addEventListener('click', popStoreRegister);
//let formData;
//let uploadFile;
//function popStoreRegister(f) {
//
// // 선택된 카테고리 값 가져오기
// const selectedCategories = Array.from(f.psCat.selectedOptions).map(option => option.value);
//
// // 카테고리가 선택되지 않았을 때 에러 처리
// if (selectedCategories.length === 0) {
//     alert('하나 이상의 카테고리를 선택해주세요');
//     return false;
// }
//
// // 카테고리 정보를 객체로 변환
// const categories = selectedCategories.join(',');
//
// // FormData 수집
// formData = new FormData(f);
// formData.append('psCat', categories); // 카테고리 정보 추가
// formData.set('uploadFile', uploadFile); // 파일 정보 추가
//
//
// console.log('폼 데이터 전송:', ...formData.entries());
//
//  return true;
//}

//
// 팝업스토어 이미지 클릭 시 파일(이미지) 첨부 기능
//document.querySelector('#popUpimg').addEventListener('click', function() {
//	document.querySelector('#imageFile').click(); // 클릭 시 파일 선택 창 열기
//});

// 파일 미리보기
//document.querySelector('#imageFile').addEventListener('input', function(event) {
//    const files = event.target.files;
//    const uploadedImagesDiv = document.getElementById('uploadedImages');
//
//    // 기존의 이미지 미리보기를 초기화
//    uploadedImagesDiv.innerHTML = '';
//    
//    let isFileSelected = files.length > 0;
//
//    if (isFileSelected) {
//        const formData = new FormData();
//
//        // 새로 선택한 파일만 미리보기 생성
//        Array.from(files).forEach(file => {
//            if (!checkFile(file.name, file.size)) {
//                return; // 파일 검증 실패 시 종료
//            }
////            uploadFile = file;
//            formData.append('uploadFile', file);
//
//            // 이미지 미리보기 생성
//            const reader = new FileReader();
//            reader.onload = function(e) {
//                const img = document.createElement('img');
//                img.src = e.target.result; // 파일의 Data URL
//                img.style.width = '300px'; // 이미지 크기 조절
//                img.style.marginRight = '10px'; // 간격 조정
//                uploadedImagesDiv.appendChild(img); // 미리보기 div에 추가
//            };
//            reader.readAsDataURL(file); // 파일을 Data URL로 읽기
//        });
//
//        // AJAX 요청을 보내기 전에 FormData 확인
//        console.log(...formData.entries()); // FormData 내용 확인
//        
//        // 파일 업로드 함수 호출
////        uploadFiles(formData); // 선택된 파일들 업로드 함수 호출
//    } else {
//    	console.error('파일이 선택되지 않았습니다.');
//    }
//});

// 업로드된 이미지 클릭 시 파일 선택 창 열기
//document.getElementById('uploadedImages').addEventListener('click', function() {
//    document.querySelector('#imageFile').click(); // 클릭 시 파일 선택 창 열기
//});

// 파일 업로드 함수
//function uploadFiles(formData) {
//    fetch('/admin/uploadAsyncAction', {
//        method: 'POST',
//        body: formData
//    })
//    .then(response => {
//        if (response.ok) {
//            return response.json(); // JSON으로 변환
//        } else {
//            throw new Error('파일 업로드 실패: ' + response.statusText);
//        }
//    })
//    .then(fileInfo => {
//        document.querySelector('#imageFile').value = ''; // 파일 선택 초기화
//        // 업로드가 성공적으로 완료되면 '팝업스토어 이미지'텍스트 사라짐
//        document.querySelector('#popUpimg').textContent = '';
//    })
//    .catch(error => {
//        console.error('Error during upload:', error);
//    });
//}

// 파일 검증
//const regex = new RegExp("(.*?)\\.(exe|sh|zip|alz)$");
//const MAX_SIZE = 5242880; // 5MB
//
//function checkFile(fileName, fileSize) {
//    if (fileSize >= MAX_SIZE) {
//        alert("파일 사이즈가 너무 큽니다.");
//        return false;
//    }
//    if (regex.test(fileName)) {
//        alert("잘못된 파일 확장자입니다.");
//        return false;
//    }
//    return true;
//}

//**** 팝업스토어 수정/삭제 페이지 영역 ****
// 에러 발생 중이라 주석 처리
//document.querySelector('#psDelete').addEventListener('click', popupDelete);
//
//function popupDelete() {
//	if (confirm('정말로 삭제하시겠습니까?')) {
//		// 카테고리 정보를 가져오기 (예시)
//        const psCat = document.querySelector('input[name="psCat"]').value;
//
//        // 카테고리 정보를 hidden input에 추가
//        document.querySelector('input[name="psCat"]').value = psCat;
//
//        // 이미지 UUID를 가져와서 hidden input에 추가
//        const imageUuid = document.querySelector('input[name="imageUuid"]').value;
//
//        // 제출할 폼에 추가 정보 설정
//        document.querySelector('input[name="imageUuid"]').value = imageUuid;
//
//        // 폼 제출
//        document.querySelector('#deleteForm').submit();
//    }
//}