
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Thông tin tài khoản Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin_thong_tin_tai_khoan.css">
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
                        <h4>${user.name}</h4>
                        <p>Email: <span>${user.email}</span></p>
                        <p>ID User: ${user.id}</p>
                        <span class="role-tag">${user.role}</span>

                    </div>
                </div>

                <h3>Thông Tin Cá Nhân</h3><br>
                <form method="post" class="update-form" id="update-form">
                    <div class="form-group">
                        <label for="fullname">Họ và Tên:</label>
                        <input type="text" name="name" id="fullname" value="Nguyễn Văn A" required>
                    </div>

                    <div class="form-group">
                        <label>Giới tính:</label>
                        <div class="gender-group">
                            <label>
                                <input type="radio" name="gender" value="Nam"
                                ${user.gender == 'Nam' ? 'checked' : ''}> Nam
                            </label>

                            <label>
                                <input type="radio" name="gender" value="Nữ"
                                ${user.gender == 'Nữ' ? 'checked' : ''}> Nữ
                            </label>

                            <label>
                                <input type="radio" name="gender" value="Khác"
                                ${user.gender == 'Khác' ? 'checked' : ''}> Khác
                            </label>

                        </div>
                    </div>

                    <div class="form-group">
                        <label for="dob">Ngày sinh:</label>
                        <input
                                type="date"
                                id="dob"
                                name="birthday"
                                value="${user.birthday}">
                    </div>

                    <div class="form-group">
                        <label for="phone">Số Điện Thoại:</label>
                        <input type="tel" id="phone" name="phone"
                               value="${user.phone}">

                    </div>

                    <div class="form-group email-verification-section">
                        <label for="email">Email:</label>
                        <div class="input-with-button">
                            <input type="email" id="email" name="email"
                                   value="${user.email}">
                            <button type="button" class="btn-send-otp">Gửi mã</button>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="otp">Mã xác thực OTP:</label>
                        <div class="input-with-button">
                            <input type="text" id="otp" placeholder="Nhập mã OTP">
                            <button type="button" class="btn-verify-otp">Xác nhận</button>
                        </div>
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
<script src="${pageContext.request.contextPath}/JS/admin_thong_tin_tai_khoan.js"></script>
</body>
</html>