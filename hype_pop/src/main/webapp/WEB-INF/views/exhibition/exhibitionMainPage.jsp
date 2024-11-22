<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="/resources/images/favicon.ico">
<meta charset="UTF-8">
<title>Exhibition Banners</title>
<style>
/* 기존 스타일 유지 */
/* banner-container의 스타일 */
.banner-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 450px;
  overflow: hidden;
  background-color: #fee7ed;
  padding: 20px;
  margin: 0 auto;
  width: 80%;
  border: none
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  position: relative; /* 버튼 컨테이너를 절대 위치로 배치할 수 있도록 설정 */
}
/* 배너를 화면 크기에 맞게 설정 */
.banner {
    width: 100%;
    height: 500px;
    overflow: hidden;
    position: relative;
}

/* 배너 이미지 */
.banner img {
    width: auto;
    height: 100%;
    display: block;
    margin: 0 auto;
    cursor: pointer;
}

/* button-container의 스타일 */
.button-container {
  position: absolute;
  bottom: 30px;
  display: flex;
  justify-content: center;
  gap: 10px;
  width: 100%;
}

/* banner-btn의 스타일 */
.banner-btn {
  width: 12px;
  height: 12px;
  background-color: #74b9ff; /* 하늘색 버튼 */
  border: none;
  border-radius: 50%;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

/* 호버 시 버튼 색상 변경 */
.banner-btn:hover {
  background-color: #f9f2f6; /* 하늘색의 다크 톤 */
}

/* filter */
.filter {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 60px;
  background-color: #f9f2f6; /* 핑크색 배경 */
  padding: 20px;
  margin: 0 auto;
  width: 800px;
  border: 2px solid #f1c6d8;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  border-bottom: none;
}

/* exhibition-info-container */
.exhibition-info-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  min-height: 400px;
  background-color: #f9f2f6; /* 핑크색 배경 */
  padding: 20px;
  margin: 0 auto;
  width: 800px;
  border: 2px solid #f1c6d8;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  font-size: 10px;
}

/* exhibition-info */
.exhibition-info {
  width: 100%;
  max-width: 800px; /* 최대 너비 설정 */
  padding: 15px;
  background-color: #ffffff;
  border-radius: 5px;
  margin: 0 auto 20px auto; /* 중앙 정렬 */
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  list-style-type: none;  /* 마커 제거 */
}

/* exhibition-schedule */
.exhibition-schedule {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%; /* 부모에 맞춰서 너비 조정 */
  max-width: 650px; /* 최대 너비 설정 */
  padding: 15px;
  background-color: #f6e6f1; /* 연한 핑크색 배경 */
  border: 1px solid #f1c6d8;
  border-radius: 5px;
  margin-bottom: 10px;
  cursor: pointer;
  height: 100px;
  margin: 0 auto; /* 중앙 정렬 */
}

/* exhibition-context */
.exhibition-context {
  display: none;
  width: 100%; /* 부모에 맞춰서 너비 조정 */
  max-width: 650px; /* 최대 너비 설정 */
  align-items: stretch;
  transition: height 0.3s ease;
  display: flex;
  flex-direction: column;
  margin: 0 auto; /* 중앙 정렬 */
}

/* exhibition-banner-img */
.exhibition-banner-img {
  width: 100%;
  max-width: 650px; /* 최대 너비 설정 */
  height: 400px;
  background-color: #74b9ff; /* 하늘색 배경 */
  background-size: cover;
  background-position: center;
  margin-bottom: 10px;
  margin: 0 auto; /* 중앙 정렬 */
}

/* 테이블 스타일 */
table {
  width: 100%;
  border-collapse: collapse;
  height: auto;
  margin: 0 auto; /* 중앙 정렬 */
}

th, td {
  padding: 10px;
  text-align: left;
  border: 1px solid #f1c6d8;
  font-size: 12px;
  min-height: 60px;
  max-height: 60px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

th {
  background-color: #f6e6f1; /* 연한 핑크색 */
}


/* #load-more 버튼 스타일 */
#load-more {
  display: block;
  margin: 20px auto;
  background-color: #74b9ff; /* 하늘색 */
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 5px;
  cursor: pointer;
  font-size: 16px;
  transition: background-color 0.3s;
}

#load-more:hover {
  background-color: #55a8e0; /* 다크 하늘색 */
}

/* filter */
.filter {
  display: flex;
  justify-content: flex-end;
  align-items: center;
}

/* select 스타일 */
.filter select {
  text-align: center;
  text-align-last: center;
}

#search {
  display: flex;
  align-items: center;
  margin-right: 10px;
}

#searchExh {
  height: 25px;
  padding: 5px;
  font-size: 16px;
  border: 1px solid #f1c6d8;
  border-radius: 4px;
}

#searchBtn {
  width: 30px;
  height: 25px;
  margin-left: 5px;
  cursor: pointer;
}
.scroll-btn {
   position: fixed;
   bottom: 10vh;
   right: 2vw;
   display: flex;
   flex-direction: column; /* 버튼들이 위에서 아래로 정렬되게 설정 */
   gap: 0.625rem;
   z-index: 20;
}

.scroll-btn button {
   background-color: #00aff0; /* 배경색을 #00aff0로 변경 */
   color: white;
   padding: 1rem;
   border: none;
   border-radius: 10px; /* 모서리 둥글게 설정 */
   font-size: 0; /* 텍스트는 보이지 않도록 설정 */
   cursor: pointer;
   transition: background-color 0.3s, opacity 0.3s;
   display: flex;
   justify-content: center;
   align-items: center;
   width: 3rem; /* 버튼 크기 */
   height: 3rem; /* 버튼 크기 */
   position: relative; /* 삼각형을 위한 relative 위치 지정 */
   opacity: 0.5; /* 기본적으로 불투명 상태 */
}

.scroll-btn button:hover {
   background-color: #0092c4; /* 호버 시 색상 변경 */
   opacity: 1; /* 호버 시 불투명도 1로 설정 */
}


.scroll-btn button::before {
   content: "";
   position: absolute;
   width: 0;
   height: 0;
   border-left: 0.6rem solid transparent; /* 삼각형 크기 조정 */
   border-right: 0.6rem solid transparent; /* 삼각형 크기 조정 */
   left: 50%; /* 수평 중앙 정렬 */
   transform: translateX(-50%); /* 정확한 중앙 정렬 */
}

#scrollUp::before {
   border-bottom: 1.2rem solid white; /* 위로 화살표 크기 조정 */
   top: 50%; /* 버튼 중앙에 삼각형을 배치 */
   transform: translateY(-50%) translateX(-50%); /* 삼각형을 정확히 중앙에 맞추기 위한 변환 */
}

#scrollDown::before {
   border-top: 1.2rem solid white; /* 아래로 화살표 크기 조정 */
   bottom: 50%; /* 버튼 중앙에 삼각형을 배치 */
   transform: translateY(50%) translateX(-50%); /* 삼각형을 정확히 중앙에 맞추기 위한 변환 */
}

.scroll-btn button:hover {
   background-color: #0092c4; /* 호버 시 색상 변경 */
}

button:disabled {
   cursor: not-allowed;
   opacity: 0.5;
}

/* ul 또는 ol의 기본 점 제거 */
</style>
</head>
<body>
   <jsp:include page="layout/exhibitionHeader.jsp" />

   <br>

   <div class="banner-container">
         <div class="banner">
         
         </div>
         <div class="button-container">
            <button class="banner-btn" data-index="0"></button>
            <button class="banner-btn" data-index="1"></button>
            <button class="banner-btn" data-index="2"></button>
            <button class="banner-btn" data-index="3"></button>
            <button class="banner-btn" data-index="4"></button>
            <button class="banner-btn" data-index="5"></button>
            <button class="banner-btn" data-index="6"></button>
            <button class="banner-btn" data-index="7"></button>
         </div>
   </div>

   <br>

   <div class="filter">
      <select id="filterSelect" onchange="applyFilter()">
         <option value="latest">시작일순</option>
         <option value="dueSoon">마감순</option>
         <option value="lowerPrice">낮은가격순</option>
         <option value="higherPrice">높은가격순</option>
         <option value="earlyBird">얼리버드</option>
      </select>
   </div>

   <div class="exhibition-info-container" id="exhibition-list">
      
   </div>

   <button id="load-more" onclick="loadMoreExhibitions()">더보기</button>

   <br>
   <hr>
   <br>
   <div class="scroll-btn">
    <button id="scrollUp" aria-label="위로 이동"></button>
    <button id="scrollDown" aria-label="아래로 이동"></button>
</div>

   <jsp:include page="layout/exhibitionFooter.jsp" />
   <script type="text/javascript" src="/resources/popUpJs/popUpMain.js"></script>
   <script type="text/javascript"
      src="/resources/exhibitionJs/exhibitionMain.js"></script>

</body>
</html>
