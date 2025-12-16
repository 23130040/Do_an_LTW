
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cấu hình hệ thống</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="CSS/admin_cau_hinh_he_thong.css">

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
            <h2 class="page-title">Cấu Hình Hệ Thống</h2>

            <div id="store-settings" class="tab-content active-tab">
                <div class="setting-card">
                    <form class="setting-form">
                        <div class="form-row">
                            <div class="form-group">
                                <label>Tên Cửa Hàng:</label>
                                <input type="text" value="Clean Meat" required>
                            </div>
                            <div class="form-group">
                                <label>Email Liên Hệ:</label>
                                <input type="email" value="contact@cleanmeat.com" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Hotline:</label>
                                <input type="tel" value="090-123-4567">
                            </div>
                            <div class="form-group">
                                <label>Mã Số Thuế/Kinh Doanh:</label>
                                <input type="text" value="0312345678">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Facebook :</label>
                                <input type="tel" value="https://www.facebook.com/cleanmeat">
                            </div>
                            <div class="form-group">
                                <label>Instagram:</label>
                                <input type="tel" value="https://www.instagram.com/cleanmeat">
                            </div>
                        </div>

                        <label>Địa Chỉ Chi Tiết (Hiển thị trên website):</label>
                        <textarea rows="3" placeholder="Số nhà, đường, Phường/Xã, Quận/Huyện, Tỉnh/Thành phố">123 Đường Nguyễn Văn Linh, Phường 1, Quận 7, TP.HCM</textarea>

                        <label>Logo Hiện Tại:</label>
                        <div class="logo-preview-box">
                            <img src="images/logoCleanmeat.png" alt="Logo" class="logo-preview">
                            <button type="button" class="btn btn-primary btn-sm"><i class="fas fa-cloud-upload-alt"></i> Thay đổi Logo</button>
                        </div>
                        <button type="submit" class="btn btn-primary submit-btn">Lưu Cấu Hình Cửa Hàng</button>
                    </form>
                </div>
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
<script src="JS/admin_cau_hinh_he_thong.js"></script>
</body>
</html>