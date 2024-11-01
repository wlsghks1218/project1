<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HYPE POP</title>
 <link rel="stylesheet" type="text/css" href="/resources/css/popUpMain.css">
</head>
<body>

    <!-- 헤더 include -->
    <jsp:include page="layout/popUpHeader.jsp"/>

    <!-- 메인 컨텐츠 -->
    <jsp:include page="popUpMain.jsp"/>

    <!-- 푸터 include -->
    <jsp:include page="layout/popUpFooter.jsp"/>

 <script type="text/javascript" src="/resources/popUpJs/popUpMap.js"></script>
 <script type="text/javascript" src="/resources/popUpJs/popUpMain.js"></script>
</body>
</html>
