<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>공지사항 정보</title>
    <style>
        /* cnContext 스타일 */
        .ciContext {
            max-width: 800px;
            margin: 0 auto;
            padding: 30px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        /* 제목 및 날짜 스타일 */
        .title-date {
            display: flex;
            align-items: center; /* 수직 정렬 */
            margin-bottom: 20px;
        }

        /* 텍스트 필드 스타일 */
        #Title {
            flex-grow: 1;
            margin-right: 10px;
            padding: 10px;
            font-size: 16px;
        }

        /* 내용 입력 필드 스타일 */
        textarea {
            width: 100%;
            height: 300px;
            padding: 10px;
            margin-bottom: 20px;
            resize: none;
            font-size: 16px;
        }

        /* 셀렉트박스 스타일 */
        select {
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            margin-left: 10px; /* 여백 추가 */
        }

        /* 버튼 스타일 */
        .button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
            margin-left: 10px; /* 버튼 간격 추가 */
        }

        .button:hover {
            background-color: #0056b3;
        }

        /* 버튼 컨테이너 스타일 */
        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .modal {
            display: none; /* 기본적으로 숨김 */
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0, 0, 0);
            background-color: rgba(0, 0, 0, 0.4);
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .tab {
            display: flex; /* Flexbox를 사용하여 수평 배치 */
            gap: 20px; /* 각 탭 사이의 간격 */
            margin-bottom: 20px; /* 탭 아래 여백 */
            justify-content: center; /* 가운데 정렬 */
        }

        .tab div {
            padding: 10px 20px; /* 패딩 추가로 클릭 영역 확장 */
            background-color: #f0f0f0; /* 기본 배경 색상 */
            border-radius: 5px; /* 모서리 둥글게 */
            cursor: pointer; /* 마우스 커서를 포인터로 변경 */
            transition: background-color 0.3s; /* 배경 색상 변화 효과 */
        }
    </style>
</head>

<body>
    <jsp:include page="layout/popUpHeader.jsp" />

    <br>

    <div class="tab">
        <div id="tab-announcement" onclick="goToNotice()">공지사항</div>
        <div id="tab-inquiry" onclick="goToInquiry()">1:1 문의</div>
        <div id="tab-faq" onclick="goToFaq()">FAQ</div>
    </div>

    <div class="ciContext">
        <form id="deleteForm" action="/support/deleteInquiry" method="post">
            <input type="hidden" name="qnaNo" id="qnaNo" value="${inquiryInfo.qnaNo}">
            <input type="hidden" name="qnaAnswer" id="qnaAnswer" value="${inquiryInfo.qnaAnswer}">

            <div class="title-date">
                <input type="text" id="title" name="title" value="${inquiryInfo.qnaTitle}" readonly>
                <input type="text" id="type" name="type" value="${inquiryInfo.qnaType}" readonly>
            </div>

            <div>
                <textarea rows="10" cols="30" name="content" readonly>${inquiryInfo.qnaContext}</textarea>
            </div>

            <c:if test="${not empty inquiryInfo.qnaAnswer}">
                <div>
                    <textarea rows="4" cols="30" name="answer" readonly style="height: 150px;">${inquiryInfo.qnaAnswer}</textarea>
                </div>
            </c:if>

            <div class="button-container">
                <input type="button" id="goBack" class="button" onclick="window.history.back()" value="돌아가기">
                <input type="button" id="deleteInquiry" class="button" value="문의삭제">
                <input type="button" id="qnaAnswer" class="button" value="문의답변" onclick="openModal()">
            </div>
        </form>

    </div>

    <br>

    <div id="answerModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2>답변 입력</h2>
            <br>
            <textarea id="answerContent" rows="4" placeholder="답변을 입력하세요..."></textarea>
            <div class="button-container">
                <input type="button" class="button" value="답변" onclick="submitResponse()">
            </div>
        </div>
    </div>

    <jsp:include page="layout/popUpFooter.jsp" />
    <jsp:include page="layout/popUpNavBar.jsp" />
    <script type="text/javascript" src="/resources/customerServiceJs/inquiryInfo.js"></script>
    <script type="text/javascript" src="/resources/popUpJs/popUpMain.js"></script>
    <script type="text/javascript" src="/resources/customerServiceJs/menu.js"></script>
</body>

</html>