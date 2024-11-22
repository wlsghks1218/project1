// 날짜 형식 변환
function formatDate(dateString) {
    // 날짜 형식 변환
    const dateParts = dateString.split('/');
    if (dateParts.length === 3) {
        return `${dateParts[2]}-${dateParts[1]}-${dateParts[0]}`; // YYYY-MM-DD
    }
    return dateString; // 이미 올바른 형식인 경우 그대로 반환
}

// 회원 정보 수정
// 수정 완료 버튼
function updateMemberList() {
    const form = document.getElementById("memberForm");
    const formDataObj = {};
    
    // 날짜 형식 변환
    const lastLoginDateField = document.querySelector('input[name="lastLoginDate"]');
    if (lastLoginDateField) {
        formDataObj['lastLoginDate'] = formatDate(lastLoginDateField.value);
    }
    
    // 날짜 있을 떄 
    new FormData(form).forEach((value, key) => {
        if (key !== "lastLoginDate") { // 날짜는 위에서 처리
            formDataObj[key] = value;
        }
    });
//    new FormData(form).forEach((value, key) => (formDataObj[key] = value));  // 날짜 없을 때 
//    console.log("formData를 출력합니다 : " + JSON.stringify(formDataObj));

    fetch("/admin/mUpdate", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
            "Accept": "application/json" 
        },
        body: JSON.stringify(formDataObj)  // JSON 형식으로 변환
    })
    .then(response => {
        if (!response.ok) {
           console.log("서버오류입니다!");
            throw new Error('서버 오류: ' + response.statusText);
        }
        return response.json();
    })
    .then(data => {
       console.log("성공햇나요?!");
        if (data.status === "success") {
            alert("멤버 정보가 성공적으로 업데이트되었습니다!");
             window.location.href = "/admin/adminPage";  // 수정 완료 후 이동
        } else {
            alert("업데이트에 실패했습니다: " + data.message);
        }
    })
    .catch(error => {
        console.error("Error:", error);
        alert("문제가 발생했습니다: " + error.message);
    });
}

// 취소 및 리스트로 돌아가기 버튼
function backtoMList() {
//   window.location.href = "/admin/adminPage"; 
   loadMembersStores(currentPageForMembers);
}