<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="icon" href="/resources/images/favicon.ico">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 변경 성공</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fc;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 40px;
            text-align: center;
            width: 100%;
            max-width: 400px;
        }

        .title {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }

        .message {
            margin: 20px 0;
            font-size: 16px;
            color: #555;
        }

        .btn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .back-btn {
            background-color: #ccc;
        }

        .back-btn:hover {
            background-color: #999;
        }

    </style>
</head>
<body>

    <div class="container">
        <div class="title">비밀번호 변경 성공</div>
        
        <!-- 성공 메시지 -->
        <div class="message">
            <p>새로운 비밀번호가 성공적으로 적용되었습니다.<br>이제 안전하게 로그인하세요.</p>
        </div>

        <!-- 버튼 -->
        <button class="btn" onclick="location.href='/member/login'">로그인 페이지로 이동</button>
    </div>

</body>
</html>
