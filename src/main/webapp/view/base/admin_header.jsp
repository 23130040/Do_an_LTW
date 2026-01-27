
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="header">
    <div class="logo-placeholder">
        <img src="${pageContext.request.contextPath}/${applicationScope.globalConfig.logo_url}"
             alt="Logo"
             class="logo">

    </div>

    <div class="header-icons">
        <div class="notification-wrapper" onclick="toggleNotificationMenu()">
            <i class="fa-solid fa-bell notification-icon"></i>
            <span class="notification-badge">3</span>
        </div>

        <div class="user-dropdown">
            <i class="fas fa-user-circle user-logo" onclick="toggleUserMenu()"></i>

            <div id="userMenuContent" class="dropdown-content">
                <a href="${pageContext.request.contextPath}/admin-thong-tin-tai-khoan"> Thông tin tài khoản</a>
                <a href="${pageContext.request.contextPath}/admin-doi-mat-khau"> Đổi mật khẩu</a>
                <div class="dropdown-divider"></div>
                <a href="${pageContext.request.contextPath}/dang-xuat?from=admin" class="logout-link"> Đăng xuất</a>
            </div>
        </div>
    </div>
</div>

