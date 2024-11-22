<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix = "sec" %>   
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
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
        z-index: 100; /* 원하는 우선순위 값으로 설정 */
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
        <a href="/hypePop/search/noData">팝업 스토어 전체 보기</a>
        <a href="javascript:resetSearch();">굿즈 전체 보기</a>
        <a href="/exhibition/exhibitionMain">전시회 메인 페이지</a>
        <a href="/hypePop/popUpMain/#map">내 주변</a>
        <a href="/hypePop/calendar">캘린더</a>
        <a href="/party/partyBoard">파티구하기</a>
        <sec:authorize access="!isAuthenticated()">
        <a href="/member/login">로그인</a>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">
        <a href="/logout">로그아웃</a>
        <a href="/member/myPage?userNo=1">마이페이지</a>
        </sec:authorize>
        <a href="/hypePop/customerMain">고객센터</a>
    </div>
</body>
<script type="text/javascript">
function resetSearch() {
    localStorage.setItem('searchText', "");
    location.href = "/goodsStore/goodsSearch";
}
</script>
</html>
