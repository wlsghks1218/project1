<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet"> <!-- CSS 파일 링크 -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .header a {
            color: #007bff;
            text-decoration: none;
            font-size: 20px;
        }
        .container {
            max-width: 400px;
            margin: 0 auto;
            padding: 30px; /* 여백 추가 */
            background-color: #ffffff;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin: 10px 0 5px;
            color: #555;
        }
        input[type="text"],
        input[type="password"] {
            width: calc(100% - 20px); /* 양 옆에 공간 확보 */
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .checkbox-group {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .checkbox-group input {
            margin-right: 5px;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 10px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .link-group {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
            font-size: 14px;
        }
        .link-group a {
            color: #007bff;
            text-decoration: none;
        }
        .link-group a:hover {
            text-decoration: underline;
        }
        .social-login {
            margin-top: 20px;
            text-align: center;
        }
        .social-login button {
            width: 40px; /* 버튼 크기 */
            height: 40px; /* 버튼 크기 */
            border-radius: 50%; /* 동그라미 모양 */
            margin: 5px;
            background-color: #e0e0e0;
            color: #333;
            border: 1px solid #ccc;
            font-size: 20px; /* 글자 크기 */
        }
        .social-login button:hover {
            background-color: #d0d0d0;
        }
    </style>
</head>
<body>

    <div class="header">
        <a href="/">홈</a> <!-- 홈으로 가는 링크 추가 -->
    </div>

    <div class="container">
        <h1>로그인</h1>
        <form action="login" method="post">
            <label for="username">아이디</label>
            <input type="text" id="userId" name="userId" required placeholder="아이디를 입력하세요.">

            <label for="password">비밀번호</label>
            <input type="password" id="userPw" name="userPw" required placeholder="비밀번호를 입력하세요.">

            <div class="checkbox-group">
                <input type="checkbox" id="rememberMe" name="rememberMe">
                <label for="rememberMe">로그인 상태 유지</label>
            </div>

            <button type="submit" class="btn btn-sec" id="loginBtn">로그인</button>

        </form>

        <div class="link-group">
            <a href="#">비밀번호 찾기</a>
            <a href="#">아이디 찾기</a>
            <a href="join">회원가입</a>
        </div>

        <div class="social-login">
            <h3>소셜 로그인</h3>
            <button onclick="location.href='https://nid.naver.com/oauth2.0/authorize'">N</button> <!-- 네이버 -->
            <button onclick="location.href='https://accounts.google.com/o/oauth2/v2/auth'">G</button> <!-- 구글 -->
            <button onclick="location.href='https://kauth.kakao.com/oauth/authorize'">K</button> <!-- 카카오 -->
            <button onclick="location.href='https://www.instagram.com/accounts/login/'">I</button> <!-- 인스타그램 -->
        </div>
    </div>

</body>
   <script type="text/javascript" src="/resources/memberJs/login.js"></script>
</html>

