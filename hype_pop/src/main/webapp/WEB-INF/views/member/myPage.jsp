<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="/resources/images/favicon.ico">
<meta charset="UTF-8">
<title>마이페이지</title>
<style>
html {
   height: 80%;
   overflow-y: auto; /* 세로 스크롤 활성화 */
}

body {
   font-family: Arial, sans-serif;
   margin: 0;
   padding: 0;
   display: flex;
   flex-direction: column;
   align-items: center;
   margin: 0;
   overflow-y: hidden;
}

.container {
   max-width: 90%;
   width: 800px; /* 컨테이너 가로 길이 확장 */
   margin: 50px auto;
   background-color: rgba(255, 255, 255, 0.8);
   border-radius: 8px;
   max-height: 80vh; /* 화면의 높이를 넘지 않도록 설정 */
   padding: 10px; /* 상단, 하단 여백을 넉넉하게 설정 */
   box-sizing: border-box; /* padding이 요소 크기에 포함되도록 설정 */
   padding-top: 40px;
   padding-bottom: 80px;
   min-height: 1200px; /* 최소 세로 길이 지정 */
   margin-bottom: 30px; /* 여백 추가 */
   overflow-y: hidden;/* 내부에서 세로 스크롤 활성화 */
}

/* Form Layout */
.form-section {
   width: 60%;
   margin: 20px auto;
   font-size: 14px;
}

.form-section h2 {
   text-align: center;
   margin-bottom: 20px;
   font-size: 24px;
}

.form-item {
   margin-bottom: 20px; /* 아래 요소와의 간격 */
   position: relative;
}

.form-item label {
   display: block;
   font-size: 14px;
   margin-bottom: 5px;
}

.form-item input {
   width: 100%;
   padding: 5px 0;
   border: none;
   border-bottom: 2px solid #ccc;
   outline: none;
}

.form-item button {
   position: absolute;
   top: 10px;
   right: 0;
   padding: 5px 10px;
   background-color: #ccc;
   border: none;
   cursor: pointer;
   font-size: 12px;
}

/* 댓글 버튼 스타일 */
.comment-btn {
   margin-top: 10px; /* 버튼과 위 요소 간 간격 */
   text-align: right;
}

/* Image Grid for Stores and Goods */
.image-grid {
   display: grid;
   grid-template-columns: repeat(4, 1fr);
   gap: 10px;
   margin: 20px 0;
   overflow: hidden; /* 슬라이더의 콘텐츠가 넘치지 않도록 설정 */
   width: 100%; /* 부모의 너비를 가득 채움 */
}

.image-goodsItem img {
   width: 100%; /* 이미지가 부모의 너비를 넘지 않도록 설정 */
   height: auto; /* 비율을 유지하며 자동 크기 조정 */
   object-fit: cover; /* 이미지 비율을 유지하며 크기를 맞추기 */
}
/* Image items */
.image-goodsItem img, .image-popupItem img, .image-exhItem img {
   width: 100%;
   height: auto;
   object-fit: cover;
}

.image-item {
   position: relative;
   text-align: center;
}

.image-item img {
   width: 100%;
   height: auto;
   cursor: pointer;
}

.image-item button {
   position: absolute;
   top: 5px;
   right: 5px;
   background-color: red;
   color: white;
   border: none;
   cursor: pointer;
}

/* Button section */
.btn-section {
   display: flex;
   justify-content: space-between;
   align-items: center; /* 수직 중앙 정렬 */
   margin: 0 10px;
   margin-bottom: 200px;
   position: fixed;
   flex-wrap: wrap;
   bottom: 50px; /* 화면 하단에서 20px 떨어진 위치 */
   margin-top: 80px;
   padding-bottom: 30px;
}

/* Navigation Bar */
nav {
   position: fixed;
   bottom: 0;
   left: 0;
   width: 100%;
   background-color: #ccc;
   text-align: center;
   z-index: 1000; /* 버튼 섹션보다 위에 위치하도록 */
   padding: 10px 0; /* 수직 여백 추가 */
}

nav a {
   margin: 10px;
   text-decoration: none;
   color: black;
}

#foundUserPwModal, #changeUserEmailModal, #changePhoneNumberModal {
   position: fixed;
   top: 50%;
   left: 50%;
   transform: translate(-50%, -50%);
   display: none;
   z-index: 1000;
   background-color: white;
   border-radius: 10px;
}

/* 모달 창 컨텐츠 */
.modal-content {
   background-color: white;
   padding: 20px;
   width: 450px; /* 가로 크기 줄이기 */
   border-radius: 10px; /* 둥근 모서리 */
   box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
   text-align: center;
   position: relative; /* X 버튼 위치를 위한 상대적 위치 */
   padding: 50px;
}

/* 모달 제목 */
.modal-title {
   font-size: 18px;
   font-weight: bold;
   margin-bottom: 20px;
}

/* 모달 내부의 폼 */
.modal-body .form-group {
   margin-bottom: 15px;
}

/* 모달의 제출 버튼 */
.modal-footer {
   text-align: center;
}

/* 모달 안에 있는 input 박스 스타일링 */
.modal-input {
   width: calc(100% - 20px); /* 가로 크기 줄이기, padding을 고려 */
   height: 40px; /* 세로 크기 */
   padding: 5px; /* 내부 여백 */
   font-size: 16px; /* 글자 크기 */
   box-sizing: border-box; /* padding 포함하여 전체 크기 계산 */
   margin: 10px; /* 바깥 여백 추가 */
   border: 1px solid #ccc;
   flex: 1;
}

/* X 버튼 스타일링 */
.close {
   position: absolute;
   top: 10px;
   right: 10px; /* 오른쪽 여백 줄여서 안쪽으로 이동 */
   font-size: 24px;
   font-weight: bold;
   color: #aaa;
   cursor: pointer;
   transition: color 0.3s ease;
}

/* 닫기 버튼 스타일 */
.close-interest {
   position: absolute; /* 절대 위치로 설정 */
   top: 5px; /* 상단에서 10px */
   right: 10px; /* 오른쪽에서 10px */
   font-size: 28px;
   font-weight: bold;
   cursor: pointer;
   color: black; /* 글자 색상 */
   z-index: 9999; /* 다른 요소보다 위로 올리기 */
}

.close:hover, .close-interest {
   color: #000; /* 호버 시 색상 변경 */
}

/*인증코드를 전송중입니다 창  */
#customAlert {
   position: fixed;
   top: 10%;
   left: 50%;
   transform: translate(-50%, -50%);
   display: none;
   z-index: 1000;
   background-color: rgba(255, 255, 255, 0.8); /* 흰색 배경에 불투명도 추가 */
   padding: 20px;
   box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 약간의 그림자 추가 */
   color: black; /* 글씨 색상 검정 */
}

.slider-container {
   display: flex;
   align-items: center;
   position: relative;
   max-height: 300px;
   padding: 0 10px;
}

.image-grid {
   display: flex;
   overflow: hidden;
   width: 100%; /* 또는 원하는 크기 */
}

.image-item {
   flex: 0 0 25%; /* 한 번에 4개 보이도록 설정 */
   box-sizing: border-box;
   padding: 10px;
   text-align: center; /* 이미지와 이름을 중앙 정렬 */
   position: relative;
}

.image-item img {
   width: 100%; /* 이미지가 컨테이너 너비에 맞게 조정됨 */
   height: auto;
}

.store-name {
   margin-top: 10px; /* 이미지와 이름 사이의 여백 */
   font-size: 14px; /* 글씨 크기 조정 */
   color: #333; /* 글씨 색상 */
   white-space: normal; /* 텍스트가 줄 바꿈 되도록 설정 */
   word-wrap: break-word; /* 단어가 길어지면 자동으로 줄 바꿈 */
   overflow-wrap: break-word; /* 단어가 길어지면 자동으로 줄 바꿈 */
}

.arrow {
   background-color: transparent;
   border: none;
   font-size: 2em;
   cursor: pointer;
   z-index: 1; /* 버튼이 이미지 위에 오도록 설정 */
   position: absolute;
   top: 50%;
   transform: translateY(-50%);
}

.left {
   left: -40px; /* 좌측 화살표 위치 */
}

.right {
   right: -40px; /* 우측 화살표 위치 */
}

/* 모달 배경 */
.modal-background {
   position: fixed;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   background: rgba(0, 0, 0, 0.5);
   z-index: 999;
}

.userInterest {
   position: fixed;
   top: 50%;
   left: 50%;
   transform: translate(-50%, -50%);
   background-color: white;
   border-radius: 8px;
   box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
   z-index: 1000;
   padding: 20px;
   width: 80%;
   max-width: 600px;
   overflow-y: auto;
   text-align: center; /* 추가: 내용 가운데 정렬 */
}

.interestBoxContainer {
   text-align: center; /* 확인 버튼을 가운데 정렬 */
   position: fixed;
   top: 50%;
   left: 50%;
   transform: translate(-50%, -50%);
   background-color: white;
   border-radius: 8px;
   box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
   border: 2px solid #ddd; /* 테두리 추가 */
   z-index: 1000;
   padding: 20px;
   width: 80%;
   max-width: 600px;
   overflow-y: auto;
   text-align: center;
   position: absolute; /* .crest 버튼 기준 */
}

.interestmodal {
   position: fixed;
   top: 50%;
   left: 50%;
   transform: translate(-50%, -50%);
   background-color: white;
   border-radius: 8px;
   box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
   border: 2px solid #ddd; /* 테두리 추가 */
   z-index: 1000;
   padding: 20px;
   width: 80%;
   max-width: 600px;
   overflow-y: auto;
   text-align: center;
   position: relative; /* .crest 버튼 기준 */
}

/* 관심사 박스 스타일 */
.interestBox {
   display: inline-flex;
   padding: 0;
   box-sizing: border-box;
   cursor: pointer;
   margin: 10px;
   border-radius: 4px;
   transition: background-color 0.3s ease;
   width: calc(33% - 20px); /* 세 개씩 가로로 나열 */
   text-align: center;
   justify-content: center; /* 자식 요소 가로 중앙 정렬 */
   align-items: center; /* 자식 요소 세로 중앙 정렬 */
   font-size: 14px;
   height: 40px; /* 높이를 고정해서 div와 label 크기를 일치시킴 */
}

.interestBox.selected {
   background-color: #e89ef0;
   color: #fff;
   border: 1px solid #007bff;
}

.interestBox:hover {
   background-color: #f0f0f0;
}

/* 체크박스를 체크했을 때 색깔을 변경 */
.interestBox input[type="checkbox"]:checked+label {
   background-color: #e89ef0; /* 체크된 상태에서 배경색 변경 */
   color: white; /* 글자 색 변경 */
}

/* 체크박스에 마우스를 올렸을 때 배경 색을 변경 */
.interestBox:hover label {
   background-color: #f0f0f0;
}

/* 체크박스 기본 상태에서 배경색 */
.interestBox label {
   display: flex;
   padding: 0;
   font-size: 14px; /* 글자 크기 조정 */
   padding-left: 10px;
   margin: 0; /* 마진 제거 */
   border-radius: 4px;
   border: 1px solid #ddd;
   cursor: pointer;
   transition: background-color 0.3s;
   align-items: center; /* 세로 중앙 정렬 */
   justify-content: center; /* 가로 중앙 정렬 */
   height: 100%; /* 부모 div의 높이에 맞추기 */
   cursor: pointer;
   display: flex; /* Flex 사용 */
   align-items: center; /* 세로 중앙 정렬 */
   justify-content: center; /* 가로 중앙 정렬 */
   height: 100%; /* 부모 div의 높이에 맞추기 */
   width: 100%; /* 부모 div의 너비에 맞추기 */
}

/* 체크박스 라벨에 스타일을 추가해서, 체크박스를 더 직관적으로 만들어줌 */
.interestBox input[type="checkbox"] {
   display: none; /* 체크박스를 보이지 않게 숨기고 */
   transform: scale(0.9); /* 체크박스 크기 키우기 */
   margin-right: 10px;
}

.interestBox input[type="checkbox"]:checked+label:before {
   margin-right: 8px;
}

/* 확인 버튼 */
.confirm-button {
   background-color: #6c757d;
   color: white;
   border: none;
   padding: 10px 20px;
   border-radius: 5px;
   cursor: pointer;
   margin-top: 10px;
   transition: background-color 0.3s ease;
}

.confirm-button:hover {
   background-color: #5a6268;
}

/* 닫기 버튼 */
.close {
   color: #aaa;
   font-size: 28px;
   font-weight: bold;
   cursor: pointer;
}

.close:hover, .close:focus {
   color: black;
}

/* 관심사 선택 3개 제한 메시지 */
.limitMessage {
   color: red;
   font-size: 14px;
}

#userInterestDisplay {
   white-space: nowrap; /* 한 줄로 표시되고 공백을 유지 */
   display: inline-block; /* 인라인 요소처럼 처리 */
}

.btn-sec {
   background-color: #495057; /* 기본 배경색 (회색) */
   color: white; /* 텍스트 색상 */
   font-size: 14px; /* 글자 크기 */
   font-weight: 600; /* 글자 두께 */
   padding: 12px 24px; /* 상하좌우 패딩 */
   border: none; /* 테두리 제거 */
   cursor: pointer; /* 마우스 포인터를 손 모양으로 */
   transition: all 0.3s ease; /* 부드러운 효과 */
   flex: 1;
   max-width: 200px; /* 버튼의 최대 너비 설정 */
   margin: 5px; /* 버튼 사이에 여백 추가 */
   margin-top: 10px;
}

.btn-sec:hover {
   background-color: #5a6268; /* 호버 시 배경색 변경 (더 어두운 회색) */
   transform: translateY(-2px); /* 살짝 위로 올라가는 효과 */
}

.btn-sec:active {
   background-color: #343a40; /* 클릭 시 배경색 더 어두워짐 (진한 회색) */
   transform: translateY(2px); /* 클릭 시 눌리는 효과 */
}

.btn-sec:focus {
   outline: none; /* 포커스 시 외곽선 제거 */
   box-shadow: 0 0 0 2px rgba(108, 117, 125, 0.5); /* 회색 테두리 추가 */
}

.form-group-inline {
   display: flex;
   align-items: center; /* 수직 정렬 */
   gap: 10px; /* 입력 필드와 버튼 사이의 간격 */
}

#userReplyBtn {
   background-color: #6c757d; /* 기본 배경색 (회색) */
   color: white; /* 텍스트 색상 */
   font-size: 12px; /* 글자 크기 */
   font-weight: 600; /* 글자 두께 */
   padding: 10px 20px; /* 상하좌우 패딩 */
   border: none; /* 테두리 제거 */
   cursor: pointer; /* 마우스 포인터를 손 모양으로 */
   transition: all 0.3s ease; /* 부드러운 효과 */
   margin-top: 10px;
}

.removePopupBtn, .removeGoodsBtn, .removeExhBtn {
   position: absolute;
   top: 5px; /* 이미지 상단에서 5px만큼 떨어진 위치 */
   right: 5px; /* 이미지 우측에서 5px만큼 떨어진 위치 */
   background-color: #696969;
   color: white;
   border: none;
   font-size: 1em; /* 버튼 글자 크기 조정 */
   width: 13px; /* 버튼 크기 조정 */
   height: 13px; /* 버튼 크기 조정 */
   display: flex;
   justify-content: center;
   align-items: center;
   cursor: pointer;
   z-index: 2;
   padding: 0; /* 패딩 제거 */
}

.image-popupItem, .image-goodsItem, .image-exhItem {
   position: relative; /* 버튼을 위해서 부모 요소에 position을 상대적으로 설정 */
   margin-bottom: 50px; /* 이미지 아래에 여백 추가 */
}

.button-container {
   display: flex;
   flex-direction: row; /* 세로로 버튼 배치 */
   justify-content: center; /* 세로로 중앙 정렬 */
   align-items: center; /* 가로로 중앙 정렬 */
   margin-top: 30px; /* 위쪽에 여백 추가 */
   gap: 15px; /* 버튼 사이 간격 */
}
/* 헤더 스타일 */
.popUpHeader {
   width: 100%;
   display: flex;
   align-items: center;
   padding: 5px 20px;
   background-color: #fee7ed;
   position: relative;
   z-index: 1002;
}

/* 메인 로고 및 햄버거 버튼 역할 */
#mainLogoButton {
   background: none;
   border: none;
   cursor: pointer;
   display: flex;
   align-items: center;
   margin-right: 20px; /* 로고와 검색창 사이의 간격 */
   z-index: 1002;
}

#mainLogo img {
   max-height: 35px;
   width: auto;
}

/* 검색 및 알림 스타일 */
#popUpSearchBox {
   display: flex;
   align-items: center;
   justify-content: center;
   position: absolute; /* 부모의 relative에 대해 절대 위치 */
   left: 50%; /* 수평 중앙 정렬 */
   transform: translateX(-50%); /* 정확한 가운데 정렬 */
   flex-grow: 1;
   margin: 0 20px;
}

#popUpSearchBox input {
   padding: 12px 20px; /* 패딩을 약간 증가시켜 높이 조정 */
   width: 600px; /* 크기 두 배 증가 */
   border: 1px solid #ccc;
   border-radius: 25px; /* 끝부분 둥글게 */
   outline: none;
   text-align: center; /* 텍스트 중앙 정렬 */
   font-size: 16px;
   margin-right: 10px; /* 검색 버튼과의 간격 */
}

#popUpSearchClick, #noticeDiv {
   cursor: pointer;
}

/* 알림 버튼 */
#noticeDiv {
   margin-left: 20px; /* 검색창과 알림 버튼 사이의 간격 */
}

/* 슬라이드 메뉴 */
#logoContainer {
   position: absolute; /* 고정된 위치 대신 절대 위치로 변경 */
   top: calc(100% + 5px);
   left: 0;
   height: auto;
   width: 150px;
   background-color: #fee7ed;
   transform: translateX(-100%); /* 기본적으로 숨겨짐 */
   transition: transform 0.3s ease;
   display: flex;
   flex-direction: column;
   align-items: center;
   padding-top: 60px;
   box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
   z-index: 999;
   margin-top: 40px;
}

#logoContainer.show {
   transform: translateX(0); /* 메뉴 표시 시 슬라이드 효과 */
}

#logoContainer div {
   padding: 15px;
   cursor: pointer;
   width: 100%;
   text-align: center;
   transition: background-color 0.3s;
   top: 100px;
   padding-top: 60px;
}

#logoContainer div:hover {
   background-color: #f0f0f0;
}

#logoContainer img {
   max-height: 50px;
   width: auto;
}

/* 오버레이 */
.overlay {
   position: fixed;
   top: 0;
   left: 0;
   right: 0;
   bottom: 0;
   background-color: rgba(0, 0, 0, 0.5);
   display: none;
   z-index: 999;
}

.overlay.show {
   display: block;
   top: 100px;
   padding-top: 60px;
}

/* 오버레이에서 메인 로고와 슬라이더 제외 */
.noOverlay {
   z-index: 1003; /* 최상위로 올려서 슬라이더보다 위에 표시 */
   position: relative;
}

#alarmDiv {
   display: inline-block; /* 버튼이 세로로 쌓이지 않게 */
   margin-left: 20px; /* 검색창과 알림 버튼 사이의 간격 */
   position: relative; /* 절대 위치를 기준으로 하기 위해 relative로 설정 */
}

/* 알림 목록 스타일 */
#notificationList {
   display: none;
   position: absolute;
   top: 70px;
   right: 20px;
   background-color: white;
   border: 1px solid #ccc;
   border-radius: 5px;
   box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
   z-index: 1000;
   padding: 15px;
   width: 500px; /* 너비 증가 */
   max-height: 400px; /* 최대 높이 설정 */
   overflow-y: auto; /* 스크롤 추가 */
}

#notificationList div {
   margin: 5px 0; /* 여백 */
   padding: 5px; /* 여백 */
   border-bottom: 1px solid #eee; /* 구분선 */
}

#notificationList div:last-child {
   border-bottom: none; /* 마지막 아이템의 구분선 제거 */
}

.notification-dot {
   position: absolute; /* 아이콘에 겹치게 하기 위해 절대 위치 설정 */
   bottom: 8px; /* 알림 버튼 아래 위치 */
   right: 28px; /* 알림 버튼 오른쪽 위치 */
   width: 10px; /* 점의 너비 */
   height: 10px; /* 점의 높이 */
   background-color: red; /* 빨간색 */
   border-radius: 50%; /* 둥글게 만들기 */
   z-index: 1003; /* 알림 아이콘 위에 표시 */
   display: none;
}

.delete-button {
   background-color: transparent; /* 배경 투명 */
   border: none; /* 테두리 없음 */
   color: #00aff0; /* 버튼 색상 */
   cursor: pointer; /* 커서 포인터로 변경 */
   transition: color 0.3s; /* 색상 변화에 애니메이션 추가 */
}

.delete-button:hover {
   color: #ff0000; /* 호버 시 색상 변경 */
}

#searchBTN {
   background-color: #00aff0; /* 버튼 배경색 */
   color: white; /* 버튼 텍스트 색상 */
   padding: 12px 20px; /* 검색창과 동일한 패딩 */
   border: none; /* 테두리 제거 */
   border-radius: 25px; /* 검색창과 동일한 둥근 모서리 */
   font-size: 16px; /* 텍스트 크기 */
   text-align: center; /* 텍스트 중앙 정렬 */
   cursor: pointer; /* 클릭 가능한 포인터 커서 */
   display: inline-block; /* 검색창과 같은 블록 형태 */
   transition: background-color 0.3s ease; /* 배경색 전환 효과 */
   margin-left: 10px; /* 검색창과 버튼 사이 간격 */
}

#searchBTN:hover {
   background-color: #007acc; /* 호버 시 색상 변경 */
}

.footer-container {
   padding: 20px;
   background-color: #f8f8f8;
   border-top: 1px solid #ccc;
   text-align: center;
   margin-bottom: 40px;
   width: 100%;
}

.footer-contact h4 {
   margin-bottom: 10px;
   padding: 5px;
   color: black;
}
</style>

</head>
<body>


   <jsp:include page="layout/popUpHeader.jsp" />


   <div class="container">


      <div class="form-section">
         <h2>마이페이지</h2>

         <div class="form-item">
            <label for="userName">이름</label> <input type="text" id="userName"
               value="${userInfo.userName}" readonly>
         </div>

         <div class="form-item">
            <label for="userId">아이디</label> <input type="text" id="userId"
               value="${userInfo.userId}" readonly>
         </div>

         <div class="form-item">
            <label for="userPw">비밀번호</label> <input type="password" id="userPw"
               value="**********" readonly>
            <button type="button" class="btn btn-sec" id="newPasswordBtn">비밀번호
               변경</button>
         </div>

         <div class="form-item">
            <label for="userEmail">이메일</label> <input type="email"
               id="userEmail" value="${userInfo.userEmail}" readonly>
            <button type="button" class="btn btn-sec" id="newEmailBtn">이메일
               변경</button>
            <div id="customAlert">인증코드를 전송 중입니다.</div>
         </div>

         <div class="form-item">
            <label for="userNumber">전화번호</label> <input type="text"
               id="userNumber" value="${userInfo.userNumber}" readonly>
            <button type="button" class="btn btn-sec" id="newPhoneNumberBtn">전화번호
               변경</button>
         </div>





         <div class="form-item">
            <label for="userInterest">관심사</label>
            <div class="interest-container">
               <div id="userInterestDisplay">
                  <!-- JavaScript로 업데이트된 관심사들이 여기에 표시됩니다 -->

                  <c:if test="${userInterests.healthBeauty == 1}">
                     <span>헬스/뷰티 </span>
                  </c:if>
                  <c:if test="${userInterests.game == 1}">
                     <span>게임 </span>
                  </c:if>
                  <c:if test="${userInterests.culture == 1}">
                     <span>문화 </span>
                  </c:if>
                  <c:if test="${userInterests.shopping == 1}">
                     <span>쇼핑 </span>
                  </c:if>
                  <c:if test="${userInterests.supply == 1}">
                     <span>문구 </span>
                  </c:if>
                  <c:if test="${userInterests.kids == 1}">
                     <span>키즈 </span>
                  </c:if>
                  <c:if test="${userInterests.design == 1}">
                     <span>디자인 </span>
                  </c:if>
                  <c:if test="${userInterests.foods == 1}">
                     <span>식품 </span>
                  </c:if>
                  <c:if test="${userInterests.interior == 1}">
                     <span>인테리어 </span>
                  </c:if>
                  <c:if test="${userInterests.policy == 1}">
                     <span>정책 </span>
                  </c:if>
                  <c:if test="${userInterests.character == 1}">
                     <span>캐릭터 </span>
                  </c:if>
                  <c:if test="${userInterests.experience == 1}">
                     <span>체험 </span>
                  </c:if>
                  <c:if test="${userInterests.collaboration == 1}">
                     <span>콜라보 </span>
                  </c:if>
                  <c:if test="${userInterests.entertainment == 1}">
                     <span>방송 </span>
                  </c:if>
               </div>
               <button type="button" class="btn btn-sec" id="newInterestBtn"
                  onclick="openInterestModal()">관심사 변경</button>
            </div>
         </div>

         <!-- 모달 창  -->
         <div id="userInterest" class="interestModal" style="display: none;">
            <!-- <div class="modal-background" onclick="closeModal()"></div>-->
            <!-- 배경 클릭 시 모달 닫기 -->


            <div class="interestBoxContainer">
               <span class="close-interest" onclick="closeInterestModal()">&times;</span>
               <p>관심사를 선택하세요(3개를 선택해 주세요!)</p>
               <form id="interestForm">
                  <!-- 관심사 박스 -->
                  <div class="interestBox" data-interest="헬스/뷰티">
                     <input type="checkbox" id="healthBeauty"
                        name="userInterest.healthBeauty" value="1"> <label
                        for="healthBeauty" class="interestBoxDiv">헬스/뷰티</label>
                  </div>

                  <div class="interestBox" data-interest="게임">
                     <input type="checkbox" id="game" name="userInterest.game"
                        value="1"> <label for="game" class="interestBoxDiv">게임</label>
                  </div>

                  <div class="interestBox" data-interest="문화">
                     <input type="checkbox" id="culture" name="userInterest.culture"
                        value="1"> <label for="culture" class="interestBoxDiv">문화</label>
                  </div>

                  <div class="interestBox" data-interest="쇼핑">
                     <input type="checkbox" id="shopping" name="userInterest.shopping"
                        value="1"> <label for="shopping" class="interestBoxDiv">쇼핑</label>
                  </div>

                  <div class="interestBox" data-interest="문구">
                     <input type="checkbox" id="supply" name="userInterest.supply"
                        value="1"> <label for="supply" class="interestBoxDiv">문구</label>
                  </div>

                  <div class="interestBox" data-interest="키즈">
                     <input type="checkbox" id="kids" name="userInterest.kids"
                        value="1"> <label for="kids" class="interestBoxDiv">키즈</label>
                  </div>

                  <div class="interestBox" data-interest="디자인">
                     <input type="checkbox" id="design" name="userInterest.design"
                        value="1"> <label for="design" class="interestBoxDiv">디자인</label>
                  </div>

                  <div class="interestBox" data-interest="식품">
                     <input type="checkbox" id="foods" name="userInterest.foods"
                        value="1"> <label for="foods" class="interestBoxDiv">식품</label>
                  </div>

                  <div class="interestBox" data-interest="인테리어">
                     <input type="checkbox" id="interior" name="userInterest.interior"
                        value="1"> <label for="interior" class="interestBoxDiv">인테리어</label>
                  </div>

                  <div class="interestBox" data-interest="정책">
                     <input type="checkbox" id="policy" name="userInterest.policy"
                        value="1"> <label for="policy" class="interestBoxDiv">정책</label>
                  </div>

                  <div class="interestBox" data-interest="캐릭터">
                     <input type="checkbox" id="character"
                        name="userInterest.character" value="1"> <label
                        for="character" class="interestBoxDiv">캐릭터</label>
                  </div>

                  <div class="interestBox" data-interest="체험">
                     <input type="checkbox" id="experience"
                        name="userInterest.experience" value="1"> <label
                        for="experience" class="interestBoxDiv">체험</label>
                  </div>

                  <div class="interestBox" data-interest="콜라보">
                     <input type="checkbox" id="collaboration"
                        name="userInterest.collaboration" value="1"> <label
                        for="collaboration" class="interestBoxDiv">콜라보</label>
                  </div>

                  <div class="interestBox" data-interest="방송">
                     <input type="checkbox" id="entertainment"
                        name="userInterest.entertainment" value="1"> <label
                        for="entertainment" class="interestBoxDiv">방송</label>
                  </div>

                  <p id="limitMessage" class="limitMessage"
                     style="display: none; color: red;">관심사는 3개를 선택해 주세요!</p>



               </form>
               <button class="confirm-button" onclick="saveInterests()">확인</button>

            </div>

         </div>



         <div class="comment-btn">
            <button type="button" id="userReplyBtn" onclick="goToMyReply()">내가
               쓴 글 보기</button>
         </div>
         <!--       <button type="button" class="btn btn-sec" id="goCartBtn" onclick="goToMyCart">장바구니</button>
 -->

      </div>


      <div class="form-section">
         <h3>좋아요한 팝업스토어</h3>
         <div class="slider-container">
          <sec:authorize access="isAuthenticated()">
      <sec:authentication property="principal" var="pinfo"/>
         <input type="hidden" id="userNo" value="${pinfo.member.userNo}">
         <input type="hidden" id="userId" value="${pinfo.member.userId}">
   </sec:authorize>
            <button class="arrow left" onclick="slideLeft('popupStoreSlider')">❮</button>
            <div class="image-grid" id="popupStoreSlider">
               <c:forEach var="popup" items="${pLikeList}">
                  <div class="image-popupItem" id="popup-${popup.psNo}"
                     data-file-name="${popup.uuid}_${popup.fileName}">
                     <c:if test="${not empty popup.psName}">
                        <img alt="${popup.psName}" id="popupStoreImg"
                           onclick="window.location.href='/hypePop/popUpDetails?storeName=${popup.psName}'" />
                        <div class="store-name">${popup.psName}</div>
                     </c:if>
                     <button class="removePopupBtn"
                        onclick="removePopup(${popup.psNo})">X</button>
                  </div>
               </c:forEach>
               <button class="arrow right"
                  onclick="slideRight('popupStoreSlider')">❯</button>
            </div>
         </div>
         <h3>좋아요한 굿즈</h3>
         <div class="slider-container">
             <sec:authorize access="isAuthenticated()">
      <sec:authentication property="principal" var="pinfo"/>
         <input type="hidden" id="userNo" value="${pinfo.member.userNo}">
         <input type="hidden" id="userId" value="${pinfo.member.userId}">
   </sec:authorize>
            <button class="arrow left" onclick="slideLeft('goodsSlider')">❮</button>
            <div class="image-grid" id="goodsSlider">
               <c:forEach var="goods" items="${gLikeList}">
                  <input id="goodsImageFileName" type="hidden"
                     value="${goods.uuid}_${goods.fileName}">
                  <div class="image-goodsItem" id="goods-${goods.gno}"
                     data-file-name="${goods.uuid}_${goods.fileName}">
                     <c:if test="${not empty goods.gname}">
                        <img alt="${goods.gname}" id="goodsBannerImg1"
                           onclick="window.location.href='/goodsStore/goodsDetails?gno=${goods.gno}'" />
                        <div class="store-name">${goods.gname}</div>
                     </c:if>
                     <button class="removeGoodsBtn"
                        onclick="removeGoods(${goods.gno})">X</button>
                  </div>
               </c:forEach>
               <button class="arrow right" onclick="slideRight('goodsSlider')">❯</button>

            </div>
         </div>
         <h3>좋아요한 전시</h3>
         <div class="slider-container">
             <sec:authorize access="isAuthenticated()">
      <sec:authentication property="principal" var="pinfo"/>
         <input type="hidden" id="userNo" value="${pinfo.member.userNo}">
         <input type="hidden" id="userId" value="${pinfo.member.userId}">
   </sec:authorize>
            <button class="arrow left" onclick="slideLeft('exhibitionSlider')">❮</button>
            <div class="image-grid" id="exhibitionSlider">
               <c:forEach var="exh" items="${eLikeList}">
                  <input id="exhImageFileName" type="hidden"
                     value="${exh.uuid}_${exh.fileName}">
                  <div class="image-exhItem" id="exh-${exh.exhNo}"
                     data-file-name="${exh.uuid}_${exh.fileName}">
                     <c:if test="${not empty exh.exhName}">
                        <img alt="${exh.exhName}" id="exhImg"
                           onclick="window.location.href='/exhibition/exhibitionDetail?exhNo=${exh.exhNo}'" />
                        <div class="store-name">${exh.exhName}</div>
                     </c:if>
                     <button class="removeExhBtn" onclick="removeExh(${exh.exhNo})">X</button>
                  </div>
               </c:forEach>
               <button class="arrow right"
                  onclick="slideRight('exhibitionSlider')">❯</button>

            </div>
         </div>

         <div class="button-container">
            <button type="button" class="btn btn-sec" id="goCartBtn"
               onclick="goToMyCart()">장바구니</button>
             <sec:authorize access="isAuthenticated()">
      <sec:authentication property="principal" var="pinfo"/>
         <input type="hidden" id="userNo" value="${pinfo.member.userNo}">
         <input type="hidden" id="userId" value="${pinfo.member.userId}">
   </sec:authorize>
            <button type="button" class="btn btn-sec" id="paymentListBtn"
               onclick="getPayList()">내결제 목록</button>
            <button type="button" class="btn btn-sec" id="deleteUserData"
               onclick="deleteUserData()"
               style="background-color: red; color: white;">회원 탈퇴</button>
         </div>


      </div>
   </div>








   <!-----------------모달 창------------------------>


   <!--비밀번호 변경 모달-->
   <div id="foundUserPwModal" style="display: none;">
      <div class="modal-content">
         <!-- X 버튼 추가 -->
         <span class="close" onclick="closePwModal()">&times;</span>
         <form action="passwordChange?userNo=${userNo}" method="post"
            id="passwordChangeForm" onsubmit="return submitPwChange()">
            <div class="modal-body">
               <div class="form-group">
                  <p>
                     <input type="password" class="modal-input" name="oldPw"
                        placeholder="기존 비밀번호 입력" required>
                  </p>
               </div>
               <div class="form-group">
                  <p>
                     <input type="password" class="modal-input" name="newPw"
                        placeholder="신규 비밀번호 입력" required>
                  </p>
               </div>
               <div class="form-group">
                  <span> <input type="password" class="modal-input"
                     name="checkNewPw" placeholder="신규 비밀번호 확인" required>
                  </span>
               </div>
            </div>
            <div class="modal-footer">
               <button type="submit" class="btn btn-sec">비밀번호 변경</button>
            </div>


         </form>
      </div>
   </div>
   <!--이메일 변경 모달  -->

   <div id="changeUserEmailModal" style="display: none;">
      <div class="modal-content">
         <!-- X 버튼 추가 -->
         <span class="close" onclick="closeEmailModal()">&times;</span>
         <form id="EmailChangeForm">
            <div class="modal-body">
               <!-- 이메일 전송 필드 -->
               <div class="form-group form-group-inline">
                  <input type="email" class="modal-input" id="userEmail2"
                     value="${userInfo.userEmail}">
                  <button type="button" id="sendEmailBtn" class="btn btn-sec"
                     onclick="verifyEmailSend()">이메일 전송</button>
               </div>

               <!-- 코드 입력 및 확인 버튼 -->
               <div class="form-group form-group-inline">
                  <input type="number" class="modal-input" name="verifyCode"
                     id="verifyCodeInput" placeholder="코드 입력" required>
                  <button type="button" id="sendEmailCode" class="btn btn-sec"
                     onclick="verifyEmailCode()">코드 확인</button>
               </div>

               <!-- 신규 이메일 입력 -->
               <div class="form-group">
                  <input type="email" class="modal-input" name="newEmail"
                     placeholder="신규 이메일 입력" required>
               </div>

               <!-- 신규 이메일 확인 -->
               <div class="form-group">
                  <input type="email" class="modal-input" name="checkNewEmail"
                     placeholder="신규 이메일 확인" required>
               </div>
            </div>

            <div class="modal-footer">
               <button type="button" class="btn btn-sec"
                  onclick="submitEmailChange()">이메일 변경</button>
            </div>
         </form>
      </div>
   </div>

   <!-- 전화번호 변경 모달 -->
   <div id="changePhoneNumberModal" style="display: none;">
      <div class="modal-content">
         <!-- X 버튼 추가 -->
         <span class="close" onclick="closePhoneNumModal()">&times;</span>
         <form action="phoneNumberChange?userNo=67" method="get"
            id="phoneNumberChange">
            <div class="modal-body">
                <sec:authorize access="isAuthenticated()">
      <sec:authentication property="principal" var="pinfo"/>
         <input type="hidden" id="userNo" value="${pinfo.member.userNo}">
         <input type="hidden" id="userId" value="${pinfo.member.userId}">
   </sec:authorize>
               <div class="form-group">
                  <p>
                     <input type="text" class="modal-input" name="oldPhoneNumber"
                        placeholder="기존 전화번호 입력">
                  </p>
               </div>
               <div class="form-group">
                  <p>
                     <input type="text" class="modal-input" name="newPhoneNumber"
                        placeholder="신규 전화번호 입력">
                  </p>
               </div>
               <div class="form-group">
                  <span> <input type="text" class="modal-input"
                     name="checkNewPhoneNumber" placeholder="신규 전화번호 확인">
                  </span>
               </div>
            </div>
            <div class="modal-footer">
               <button type="submit" class="btn btn-sec"
                  onclick="return PhoneNumberChange()">전화번호 변경</button>
            </div>
         </form>
      </div>
   </div>

   <jsp:include page="layout/popUpFooter.jsp" />
   <jsp:include page="layout/popUpNavBar.jsp" />



   <script type="text/javascript" src="/resources/memberJs/myPage.js"></script>
   <script type="text/javascript" src="/resources/purchaseJs/myCart.js"></script>
</body>


</html>
