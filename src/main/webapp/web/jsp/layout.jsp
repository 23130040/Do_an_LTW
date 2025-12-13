<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Clean Meat - <c:out value="${requestScope.pageTitle} "></c:out> </title>
</head>
<body>
<nav class="main-nav">
    <jsp:include page=""></jsp:include>
</nav>

<main class="main-content">
    <c:choose>
        <c:when test="${not empty requestScope.mainContent}">
            <jsp:include page="${requestScope.mainContent}"/>
        </c:when>
        <c:otherwise>
            <h1>Chưa có dữ liệu</h1>
        </c:otherwise>
    </c:choose>
</main>

<footer class="main-footer">
    <jsp:include page="../view/footer.jsp"></jsp:include>
</footer>

<script src="js/main.js"></script>
</body>
</html>
