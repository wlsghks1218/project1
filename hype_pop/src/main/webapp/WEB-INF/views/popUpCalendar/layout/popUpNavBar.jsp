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
        <a href="/hypePop/search/noData">팝업 스토어 검색</a>
        <a href="/goodsStore/goodsSearch">굿즈 검색</a>
        <a href="/hypePop/popUpMain#MapAPI">내 주변</a>
        <a href="/hypePop/calendar">캘린더</a>
        <a href="/member/login">로그인</a>
        <a href="#" onclick="logout()" >로그아웃</a>
        <a href="/member/myPage?userNo=2">마이페이지</a>
        
        
    <!--     익명 사용자의 경우(로그인을 하지 않은 경우도 해당) 
      <sec:authorize access="isAnonymous()">
         <a href="member/login">로그인</a>
      </sec:authorize>
      인증된 사용자 
      <sec:authorize access="isAuthenticated()">
         <a href="member/myPage">마이페이지</a>
      </sec:authorize> -->
        
        
        
        
    </div>
    

</body>
<script type="text/javascript">
    function logout(){
       // localStorage에서 userNo 삭제
       localStorage.removeItem('userNo');
       
    // 페이지 리로드
       location.reload();

    }
</script>
</html>
