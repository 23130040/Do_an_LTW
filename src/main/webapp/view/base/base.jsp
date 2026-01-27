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
    <style>
    .modal-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        display: flex;
        justify-content: center;
        align-items: center;
        z-index: 9999;
    }

    .custom-modal {
        width: 450px;
        background: #fff;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        animation: fadeInDown 0.3s ease; /* Hiệu ứng hiện ra */
    }

    .modal-header-custom {
        background-color: #ffc107;
        padding: 15px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .modal-title-custom {
        font-weight: bold;
        color: #333;
        font-size: 18px;
    }

    .close-modal-custom {
        font-size: 24px;
        cursor: pointer;
        color: #333;
        line-height: 1;
    }

    .modal-body-custom {
        padding: 30px 20px;
        color: #333;
        font-size: 16px;
        background: #fff;
    }

    @keyframes fadeInDown {
        from { opacity: 0; transform: translateY(-20px); }
        to { opacity: 1; transform: translateY(0); }
    }</style>

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
<script>
    function addToCart(itemId) {
        fetch('${pageContext.request.contextPath}/them-vao-gio', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: 'itemId=' + itemId
        })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    const badge = document.getElementById('count-item');
                    if (badge) {
                        badge.innerText = data.totalQuantity;
                    }
                }
            })
            .catch(err => console.error(err));
    }
</script>
</body>
</html>
