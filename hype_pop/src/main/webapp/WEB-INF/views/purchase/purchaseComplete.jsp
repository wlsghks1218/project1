<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>구매 완료</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
            background-color: #f9f9f9;
        }

        .container {
            text-align: center;
            padding: 30px;
            border: 2px solid #ddd;
            border-radius: 15px;
            background-color: #ffffff;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 400px;
        }

        h1 {
            font-size: 24px;
            color: #333;
            margin-bottom: 10px;
        }

        .emoji {
            font-size: 40px;
            margin: 10px 0;
        }

        p {
            font-size: 16px;
            color: #666;
            margin-bottom: 20px;
        }

        .button-container {
            display: flex;
            justify-content: space-around;
        }

        .button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .button-primary {
            background-color: #007bff;
        }
        .button-secondary {
            background-color: #28a745;
        }

        .button-primary:hover {
            background-color: #0056b3;
        }
        .button-secondary:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>구매가 완료되었습니다! 🎉</h1>
    <div class="emoji">👏👏👏</div>
    <p>구매해 주셔서 감사합니다. 구매 내역을 확인하시거나 쇼핑을 계속해 보세요!</p>
    <div class="button-container">
        <a  class="button button-primary">구매목록으로 가기</a>
        <a  class="button button-secondary">쇼핑 계속하기</a>
    </div>
</div>

</body>
</html>
