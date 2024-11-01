// 수정하기 버튼 클릭 시 동작
document.getElementById('updateNotice').addEventListener('click', function() {
    const titleInput = document.getElementById('cnTitle');
    const contentTextarea = document.querySelector('textarea[name="noticeContent"]');

    if (titleInput.hasAttribute('readonly')) {
        // readonly 속성이 있을 경우 제거
        titleInput.removeAttribute('readonly');
        contentTextarea.removeAttribute('readonly');
        titleInput.focus(); // 제목 입력 필드에 포커스
        this.value = '저장하기'; // 버튼 텍스트 변경
    } else {
        // 수정된 내용을 서버에 전송
        const form = titleInput.closest('form');
        form.submit(); // 폼 제출
    }
});

// 삭제하기 버튼 클릭 시 동작 (추가 기능)
document.getElementById('deleteNotice').addEventListener('click', function() {
    const confirmation = confirm("정말로 삭제하시겠습니까?");
    if (confirmation) {
        // 삭제 요청을 위한 폼 제출
        const form = document.querySelector('form');
        form.action = "/support/deleteNotice"; // 삭제 요청 URL
        form.method = "post"; // POST 방식
        form.submit(); // 폼 제출
    }
});