
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="header">
    <div class="logo-placeholder">
        <img src="${pageContext.request.contextPath}/images/logoCleanmeat.png">
    </div>

    <div class="header-icons">
        <div class="notification-wrapper" onclick="toggleNotificationMenu()">
            <i class="fa-solid fa-bell notification-icon"></i>
            <span class="notification-badge">3</span>
        </div>

        <div class="user-dropdown">
            <i class="fas fa-user-circle user-logo" onclick="toggleUserMenu()"></i>

            <div id="userMenuContent" class="dropdown-content">
                <a href="../admin_thong_tin_tai_khoan.jsp"> Thông tin tài khoản</a>
                <a href="../admin_doi_mat_khau.jsp"> Đổi mật khẩu</a>
                <div class="dropdown-divider"></div>
                <a href="trang_chu_chua_login.jsp" class="logout-link"> Đăng xuất</a>
            </div>
        </div>
    </div>
</div>

