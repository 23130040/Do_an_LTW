<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--<div id="setting-content" class="tab-content hidden">--%>
<div class="setting-content header">
    <h1 class="txt big">NHỮNG THIẾT LẬP RIÊNG TƯ</h1>
</div>
<div class="setting-content body">
    <div class="setting-content left">
        <h3 class="txt small">Yêu cầu xóa tài khoản</h3>
    </div>
    <div class="setting-content right">
        <button class="setting-content" id="delete-btn">Xóa bỏ</button>
    </div>
</div>

<div id="delete-account-modal" class="modal">
    <div class="modal-content">
        <span class="close-btn" id="close-delete-account-modal">&times;</span>
        <div class="delete-account-form">
            <div class="message">
                <i class="fa-solid fa-circle-question"></i>
                <span class="txt">Bạn chắc chắn xóa tài khoản?</span>
            </div>
            <div class="btn-group">
                <button class="cancle-btn" id="cancle-delete-account-btn">Hủy</button>
                <button class="confirm-btn" id="confirm-delete-account-btn">Xác nhận</button>
            </div>
        </div>
    </div>
</div>

<div id="input-password-modal" class="modal">
    <div class="modal-content">
        <span class="close-btn" id="close-input-password-modal">&times;</span>
        <div class="password-form">
            <h2>Vui lòng nhập mật khẩu</h2>
            <div class="form-input">
                <label for="password" class="profile-form label"><i class="fa-solid fa-key"></i></label>
                <input type="password" id="password" class="profile-form input-field" placeholder="Nhập mật khẩu">
            </div>
            <div class="btn-group">
                <button class="cancle-btn" id="cancle-confirm-password-btn">Hủy</button>
                <button class="confirm-btn" id="confirm-delete-btn">Xóa tài khoản</button>
            </div>
        </div>
    </div>
</div>