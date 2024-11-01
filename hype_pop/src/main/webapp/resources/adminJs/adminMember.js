function updateMemberList() {
    const form = document.getElementById("memberForm");
    const formDataObj = {};
    new FormData(form).forEach((value, key) => (formDataObj[key] = value));
    console.log(formDataObj);

    fetch("/admin/mUpdate", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(formDataObj)  // JSON 형식으로 변환
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('서버 오류: ' + response.statusText);
        }
        return response.json();
    })
    .then(data => {
        if (data.status === "success") {
            alert("멤버 정보가 성공적으로 업데이트되었습니다!");
            // window.location.href = "/mList";  // 수정 완료 후 이동
        } else {
            alert("업데이트에 실패했습니다: " + data.message);
        }
    })
    .catch(error => {
        console.error("Error:", error);
        alert("문제가 발생했습니다: " + error.message);
    });
}