<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--<div id="password-content" class="tab-content hidden">--%>
<div class="password-content header">
    <h1 class="txt big">
        ĐỔI MẬT KHẨU
    </h1>
</div>
<div class="password-content body">
    <form class="password-form">
        <div class="profile-form group">
            <label for="current-password" class="profile-form label">Mật khẩu hiện tại</label>
            <input type="password" id="current-password" name="currentPassword"
                   class="profile-form input-field" placeholder="Nhập mật khẩu hiện tại">
        </div>

        <div class="profile-form group">
            <label for="new-password" class="profile-form label">Mật khẩu mới</label>
            <input type="password" id="new-password" name="newPassword" class="profile-form input-field"
                   placeholder="Nhập mật khẩu mới">
        </div>

        <div class="profile-form group">
            <label for="confirm-password" class="profile-form label">Xác nhận mật khẩu mới</label>
            <input type="password" id="confirm-password" name="confirmPassword"
                   class="profile-form input-field" placeholder="Nhập lại mật khẩu mới">
        </div>
    </form>
    <div class="profile-form submit-row">
        <button type="submit" class="profile-form submit-btn" id="save-password-btn">Lưu Mật Khẩu
        </button>
    </div>
</div>
