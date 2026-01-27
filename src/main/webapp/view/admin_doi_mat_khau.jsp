
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Đổi Mật Khẩu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin_doi_mat_khau.css">
</head>
<body>
<div class="admin-container">
    <!---------------- Thanh menu ------------------->
    <jsp:include page="base/admin_header.jsp" />

    <!---------------- Side Bar ------------------->
    <div class="main-wrapper">
        <jsp:include page="base/admin_sidebar.jsp">
            <jsp:param name="active" value="none"/>
        </jsp:include>

        <main class="content">
            <h2 class="page-title">Đổi Mật Khẩu</h2>

            <div class="password-container">

                <form class="password-change-form"
                      method="post"
                      action="${pageContext.request.contextPath}/admin-doi-mat-khau">

                    <div class="form-group">
                        <label>Mật Khẩu Hiện Tại:</label>
                        <input type="password" name="oldPassword" required>
                    </div>

                    <div class="form-group">
                        <label>Mật Khẩu Mới:</label>
                        <input type="password" name="newPassword" required>
                    </div>

                    <div class="form-group">
                        <label>Xác Nhận Mật Khẩu Mới:</label>
                        <input type="password" name="confirmPassword" required>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="message-area error">${error}</div>
                    </c:if>

                    <c:if test="${not empty success}">
                        <div class="message-area success">${success}</div>
                    </c:if>

                    <button type="submit" class="btn-update">Lưu Thay Đổi</button>
                </form>

            </div>
        </main>
    </div>
    <!------------------- PHẦN THÔNG BÁO ----------------->
    <div id="notification-panel" class="notification-panel">
        <div class="panel-header">
            <h3>Thông Báo Mới (3)</h3>
            <span class="close-panel-btn" onclick="toggleNotificationMenu()">&times;</span>
        </div>
        <div class="panel-content">
            <a href="#" class="notification-item unread">
                <i class="fas fa-shopping-cart"></i>
                <p>Đơn hàng mới #0012 vừa được tạo.</p>
            </a>
            <a href="#" class="notification-item unread">
                <i class="fas fa-exclamation-triangle"></i>
                <p>Tồn kho Thịt Bò Thăn Nội < 5kg.</p>
            </a>
            <a href="#" class="notification-item">
                <i class="fas fa-comment"></i>
                <p>Có 1 phản hồi mới cho sản phẩm Thịt Heo.</p>
            </a>
        </div>
    </div>
</div>
<div class="toast-container position-fixed top-0 start-50 p-3">
    <div id="appToast"
         class="toast align-items-center text-bg-info border-0"
         role="alert"
         aria-live="assertive"
         aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body" id="toastMessage">
            </div>
            <button type="button"
                    class="btn-close btn-close-white me-2 m-auto"
                    data-bs-dismiss="toast"
                    aria-label="Close"></button>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/JS/admin_doi_mat_khau.js"></script>
<c:if test="${not empty toastMessage}">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            showToast(
                "${fn:escapeXml(toastMessage)}",
                "${toastType}"
            );
        });
    </script>
</c:if>

</body>
</html>