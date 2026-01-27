<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="vi">
<head>
    <meta charset="UTF-8">

    <title>
        Clean Meat - <c:out value="${requestScope.pageTitle}"/>
    </title>

    <!-- ===== CSS HEADER ===== -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/CSS/header.css">

    <!-- ===== CSS NỘI DUNG ===== -->
    <c:if test="${not empty requestScope.pageCss}">
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}${requestScope.pageCss}">
    </c:if>

    <!-- ===== CSS FOOTER ===== -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/CSS/footer.css">

    <!-- ===== FONT ICON ===== -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>

<body class="${requestScope.pageClass}" id="${requestScope.pageId}">

<!-- ===== HEADER ===== -->
<header>
    <jsp:include page="header.jsp"/>
</header>

<!-- ===== MAIN ===== -->
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

<!-- ===== FOOTER ===== -->
<footer class="main-footer">
    <jsp:include page="footer.jsp"/>
</footer>

<!-- ===== JS ===== -->
<script src="${pageContext.request.contextPath}${requestScope.pageJS}"></script>
<script src="${pageContext.request.contextPath}/JS/main.js"></script>
</body>
</html>
