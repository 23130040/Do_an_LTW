
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Thông tin tài khoản Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="CSS/admin_thong_tin_tai_khoan.css">
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
            <h2 class="page-title">Thông Tin Tài Khoản</h2>

            <div class="profile-container">

                <div class="profile-info-section">
                    <div class="profile-avatar-wrapper">
                        <img src="https://i.pinimg.com/736x/42/95/40/42954010d373d2ff80627b20ecce2c1f.jpg" alt="Avatar Admin" class="profile-avatar-large">

                        <div class="avatar-overlay" onclick="document.getElementById('avatar-file-top').click()">
                            <i class="fas fa-camera"></i>
                            <span>Thay đổi</span>
                        </div>

                        <input type="file" id="avatar-file-top" accept="image/*" style="display: none;">
                    </div>

                    <div class="profile-details">
                        <h4>Nguyễn Văn A (Admin)</h4>
                        <p>Email: <span style="font-weight: 500;">admin.a@cleanmeat.com</span></p>
                        <p>ID User: #ADMIN001</p>
                        <span class="role-tag">Quản trị viên Chính</span>
                    </div>
                </div>

                <h3>Thông Tin Cá Nhân</h3><br>
                <form class="update-form">
                    <div class="form-group">
                        <label for="fullname">Họ và Tên:</label>
                        <input type="text" id="fullname" value="Nguyễn Văn A" required>
                    </div>

                    <div class="form-group">
                        <label for="phone">Số Điện Thoại:</label>
                        <input type="tel" id="phone" value="098-123-4567">
                    </div>

                    <div class="form-group">
                        <label for="email">Email (Không thể thay đổi):</label>
                        <input type="email" id="email" value="admin.a@cleanmeat.com" disabled>
                    </div>


                    <button type="submit" class="btn-update"><i class="fas fa-save"></i> Lưu Cập Nhật</button>
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
<script src="JS/admin_thong_tin_tai_khoan.js"></script>
</body>
</html>