<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>


<html>
<head>
 <style>
/* 전체 레이아웃 설정 */
.container {
    display: flex;
    width: 100%;
    min-height: 600px;
    padding-top: 20px;
    box-sizing: border-box;
}

/* 상단 헤더 */
.header {
  text-align: center;
    background-color: #f0f0f0;
    padding: 10px 0;
    position: fixed;   /* 헤더 고정 */
    top: 0;
    width: 100%;
    z-index: 1000;     /* 다른 요소 위에 표시되도록 설정 */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);  /* 약간의 그림자 추가 */
}

.header .home-link {
    text-decoration: none;
    font-size: 20px;
    color: #007bff;
}

/* 왼쪽 메뉴 스타일 */
.left-menu {
  width: 200px;
    background-color: #f8f8f8;
    height: 100vh;
    position: fixed;  /* 고정하지 않고, 아래로 이동 */
    top: 100px;       /* 헤더와의 간격을 추가 */
    left: 0;
    padding: 20px;
    box-sizing: border-box;
    border-right: 1px solid #ddd;
    overflow-y: auto;  /* 메뉴가 너무 길어지면 스크롤 생성 */
}

.left-menu ul {
    list-style-type: none;
    padding: 0;
}

.left-menu ul li {
    margin-bottom: 15px;
}

.left-menu ul li a {
    display: block;
    padding: 10px;
    background-color: #fff;
    border: 1px solid #ccc;
    border-radius: 5px;
    text-align: center;
    text-decoration: none;
    color: #333;
    transition: background-color 0.3s;
}

.left-menu ul li a:hover {
    background-color: #e0e0e0;
}

/* 오른쪽 게시판 및 검색 */
.right-content {
    flex-grow: 1;
    padding: 20px;
    box-sizing: border-box;
    margin-left: 200px;
    padding-top: 70px; /* 헤더 공간 확보 */
}

/* 검색바 중앙 정렬 */
.search-bar {
    text-align: center;
    margin-bottom: 20px;
}

.search-bar input {
    padding: 8px;
    width: 250px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.search-bar button {
    padding: 8px 12px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.search-bar button:hover {
    background-color: #0056b3;
}

/* 게시판 목록 */
#boardContainer {
    margin-bottom: 20px;
}

.board-item {
    border-bottom: 1px solid #ccc;
    padding: 15px 0;
}

.board-item a {
    text-decoration: none;
    font-weight: bold;
    color: #007bff;
}

.board-item a:hover {
    text-decoration: underline;
}

/* 페이징 */
.pagination {
    text-align: center;
    margin-top: 20px;
}

.pagination button {
    padding: 8px 16px;
    margin: 0 5px;
    background-color: #f0f0f0;
    border: 1px solid #ccc;
    border-radius: 4px;
    cursor: pointer;
}

.pagination button:hover {
    background-color: #e0e0e0;
}

/* 하단 내비게이션 */
.footer-nav {
    position: fixed;
    bottom: 0;
    width: 100%;
    background-color: #f0f0f0;
    padding: 10px 0;
    text-align: center;
    border-top: 1px solid #ccc;
}

.footer-nav ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
}

.footer-nav ul li {
    margin: 0 15px;
}

.footer-nav ul li a {
    text-decoration: none;
    color: #333;
    font-size: 16px;
}

.footer-nav ul li a:hover {
    color: #007bff;
}

 
 </style>
</head>
<body>
<div class="header">
    <a href="/" class="home-link">홈</a>
</div>

<div class="container">
    <!-- 왼쪽 메뉴 -->
    <div class="left-menu">
        	 <input type="hidden" value="2" name="userNo" id="userNo"> 
        <ul>
            <li><a href="#" onclick="loadBoard('userInquiry')">1:1 문의 글</a></li>
            <li><a href="#" onclick="loadBoard('popupComments')">팝업스토어></li>
            <li><a href="#" onclick="loadBoard('goodsComments')">굿즈 댓글</a></li>
        </ul>
    </div>

    <!-- 오른쪽 검색 및 게시판 -->
    <div class="right-content">
        <!-- 검색 영역 (중앙 정렬) -->
        <div class="search-bar">
            <form action="/board/search" method="get">
                <input type="text" name="keyword" placeholder="검색어 입력">
                <button type="submit">검색</button>
            </form>
        </div>

     	<!-- 게시판 목록 -->
        <div id="boardContainer">
            <!-- AJAX로 게시판 목록이 로드될 영역 -->
       <!--       <div id="inquiryList"></div>
             <div id="popupReplyList"></div> -->
        </div>

        <!-- 페이징 영역 -->
        <div class="pagination">
            <button class="prev">이전</button>
            <button class="next">다음</button>
        </div>
    </div>
</div>
<!-- 하단 내비게이션 -->
<div class="footer-nav">
    <ul>
        <li><a href="/profile">프로필</a></li>
        <li><a href="/settings">설정</a></li>
        <li><a href="/logout">로그아웃</a></li>
    </ul>
</div>


	<script type="text/javascript" src="/resources/memberJs/myReply.js"></script>

</body>
</html>