<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
        <a href="/hypePop/search/noData">팝업 스토어 검색</a>
        <a href="/goodsStore/goodsSearch">굿즈 검색</a>
        <a href="/#MapAPI">내 주변</a>
        <a href="/hypePop/calendar">캘린더</a>
        <a href="/member/login">로그인</a>
    </div>

</body>
</html>
