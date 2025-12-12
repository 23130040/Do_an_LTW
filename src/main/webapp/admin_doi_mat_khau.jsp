
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Đổi Mật Khẩu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="CSS/admin_doi_mat_khau.css">
</head>
<body>
<div class="admin-container">
    <!---------------- Thanh menu ------------------->
    <jsp:include page="admin_header.jsp" />

    <!---------------- Side Bar ------------------->
    <div class="main-wrapper">
        <jsp:include page="admin_sidebar.jsp">
            <jsp:param name="active" value="config"/>
        </jsp:include>

        <main class="content">
            <h2 class="page-title">Đổi Mật Khẩu</h2>

            <div class="password-container">

                <form class="password-change-form">
                    <p style="margin-bottom: 25px; color: #777;">Vui lòng nhập mật khẩu hiện tại và mật khẩu mới để bảo mật tài khoản của bạn.</p>

                    <div class="form-group">
                        <label for="current-password"><i class="fas fa-key"></i> Mật Khẩu Hiện Tại:</label>
                        <input type="password" id="current-password" required placeholder="Nhập mật khẩu hiện tại của bạn">
                    </div>

                    <div class="form-group">
                        <label for="new-password"><i class="fas fa-lock"></i> Mật Khẩu Mới:</label>
                        <input type="password" id="new-password" required pattern=".{6,}" title="Mật khẩu phải có ít nhất 6 ký tự" placeholder="Mật khẩu phải có ít nhất 6 ký tự">
                    </div>

                    <div class="form-group">
                        <label for="confirm-password"><i class="fas fa-redo-alt"></i> Xác Nhận Mật Khẩu Mới:</label>
                        <input type="password" id="confirm-password" required placeholder="Nhập lại mật khẩu mới">
                    </div>

                    <div id="password-message" class="message-area"></div>

                    <button type="submit" class="btn-update"><i class="fas fa-save"></i> Lưu Thay Đổi Mật Khẩu</button>
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
<script src="JS/admin_doi_mat_khau.js"></script>
</body>
</html>