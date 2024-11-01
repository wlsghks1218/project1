<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>Insert title here</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .navBar {
            display: flex;
            justify-content: center;
            background-color: #333;
            padding: 10px;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        .navBar a {
            color: white;
            text-decoration: none;
            padding: 14px 20px;
            text-align: center;
        }
        .navBar a:hover {
            background-color: #575757;
            transition: background-color 0.3s;
        }
    </style>
</head>
<body>

    <div class="navBar">
        <a href="/hypePop/search/noData">팝업스토어 전체 보기</a>
        <a href="/goodsStore/goodsSearch" id="searchReset">굿즈 전체 보기</a>
        <a href="/goodsStore/goodsMain">굿즈 메인페이지</a>
        <a href="/hypePop/calendar">캘린더</a>
        <a href="/member/login">로그인</a>
        <a href="/member/myPage?userNo=1">마이페이지</a>
        <a href="/party/partyBoard">파티구하기</a>
    </div>
</body>
</html>