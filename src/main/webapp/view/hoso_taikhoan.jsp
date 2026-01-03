<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--<div id="profile-content" class="tab-content active">--%>
<div class="profile-content header">
    <h1 class="txt big">
        HỒ SƠ CỦA TÔI
    </h1>
</div>
<div class="profile-content body">
    <div class="profile-content profile">
        <form class="profile-form">
            <div class="profile-form group">
                <label for="name-input" class="profile-form label">Tên</label>
                <input type="text" id="name-input" name="name" value="Nguyễn Văn A"
                       class="profile-form input-field profile-form input-field editable">
            </div>
            <div class="profile-form group">
                <label class="profile-form label">Email</label>
                <div class="profile-form value-wrapper">
                    <span class="profile-form static-value">a****@gmail.com</span>
                    <a href="#" class="profile-form change-btn" id="open-change-email-modal">Thay
                        Đổi</a>
                </div>
            </div>
            <div class="profile-form group">
                <label class="profile-form label">Số điện thoại</label>
                <div class="profile-form value-wrapper">
                    <span class="profile-form static-value">(+84) 12*******9</span>
                    <a href="#" class="profile-form change-btn" id="open-change-phone-number">Thay
                        Đổi</a>
                </div>
            </div>
            <div class="profile-form group">
                <label class="profile-form label">Giới tính</label>
                <div class="profile-form value-wrapper profile-form value-wrapper-radio">
                    <input type="radio" id="gender-male" name="gender" value="male">
                    <label for="gender-male" class="profile-form radio-label">Nam</label>
                    <input type="radio" id="gender-female" name="gender" value="female">
                    <label for="gender-female" class="profile-form radio-label">Nữ</label>
                    <input type="radio" id="gender-other" name="gender" value="other" checked>
                    <label for="gender-other" class="profile-form radio-label">Khác</label>
                </div>
            </div>
            <div class="profile-form group">
                <label class="profile-form label">Ngày sinh</label>
                <div class="profile-form value-wrapper">
                    <span class="profile-form static-value">01/01/1999</span>
                    <a href="#" class="profile-form change-btn" id="open-change-birthday-btn">Thay
                        Đổi</a>
                </div>
            </div>
        </form>
        <div class="profile-form submit-row">
            <button type="submit" class="profile-form submit-btn" id="saveInfoBtn">Lưu</button>
        </div>
    </div>
    <div class="profile-content avatar">
        <div class="avatar-container">
            <img src="${pageContext.request.contextPath}/images/avatar.jpg" alt="avatar">
            <button class="choose-button">Chọn Ảnh</button>
        </div>
    </div>
</div>