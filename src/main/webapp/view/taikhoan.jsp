<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="container">
    <div id="sidebar">
        <div class="sidebar header">
            <img src="../images/avatar.jpg" alt="avatar">
            <h3 class="username">Nguyễn Văn A</h3>
        </div>
        <div class="sidebar menu">
            <a href="#profile-content">Hồ sơ</a>
            <a href="#address-content">Địa chỉ</a>
            <a href="#password-content">Đổi mật khẩu</a>
            <a href="#setting-content">Những thiết lập riêng tư</a>
        </div>
    </div>
    <div class="main-content">
        <div id="profile-content" class="tab-content active">
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
                        <img src="../images/avatar.jpg" alt="avatar">
                        <button class="choose-button">Chọn Ảnh</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="address-content" class="tab-content hidden">
            <div class="address-content header">
                <div class="header-left">
                    <h1 class="txt big">ĐỊA CHỈ CỦA TÔI</h1>
                </div>
                <div class="header-right">
                    <button class="add-address-button" id="open-add-address-modal">+ Thêm địa chỉ mới</button>
                </div>
            </div>
            <div class="address-content body">
                <div class="address-content content">
                    <div class="address default">
                        <p class="address-detail">
                            56/12/34 Đường Võ Văn Kiệt, Phường 2, Quận 5, TP. Hồ Chí Minh, Việt Nam
                        </p>
                        <button id="setDefaultBtn1">Đặt mặc định</button>
                        <span class="trash"><i class="fa-solid fa-trash"></i></span>
                        <span class="edit open-change-address-modal"><i
                                class="fa-solid fa-pen-to-square"></i></span>
                    </div>
                    <div class="address">
                        <p class="address-detail">
                            108 Đường Nguyễn Văn Bá, Phường Trường Thọ, Thủ Đức, TP. Hồ Chí Minh, Việt Nam
                        </p>
                        <button id="setDefaultBtn2">Đặt mặc định</button>
                        <span class="trash"><i class="fa-solid fa-trash"></i></span>
                        <span class="edit open-change-address-modal"><i
                                class="fa-solid fa-pen-to-square"></i></span>
                    </div>
                </div>
            </div>
        </div>
        <div id="password-content" class="tab-content hidden">
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
        </div>
        <div id="setting-content" class="tab-content hidden">
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
        </div>
    </div>
</div>
<div id="confirm-save-info" class="modal">
    <div class="modal-content">
        <span class="close-btn" id="close-confirm-save-info-modal">&times;</span>
        <div class="confirm-form">
            <div class="message">
                <i class="fa-solid fa-circle-check"></i>
                <span id="info-confirm">Lưu thông tin thành công</span>
            </div>

            <span class="confirm-btn">
                    <button id="confirm-save-info-btn">OK</button>
                </span>
        </div>
    </div>
</div>
<div id="confirm-save-password" class="modal">
    <div class="modal-content">
        <div class="confirm-form">
            <div class="message-container">
                <div class="message">
                    <i class="fa-solid fa-circle-check"></i>
                    <span id="password-confirm">Đổi mật khẩu thành công!</span>
                </div>
                <span class="txt">Vui lòng đăng nhập lại.</span>
            </div>
            <div class="confirm-btn">
                <button id="confirm-save-password-btn">OK</button>
            </div>
        </div>
    </div>
</div>
<div id="change-email" class="modal">
    <div class="modal-content">
        <span class="close-btn" id="close-change-email-modal">&times;</span>
        <div class="email-form">
            <div class="form-input">
                <label for="email" class="profile-form label"><i class="fa-solid fa-envelope"></i></label>
                <input type="email" id="email" name="email" class="profile-form input-field"
                       placeholder="Nhập địa chỉ Email mới">
            </div>
            <span class="confirm-btn">
                    <button id="save-email-btn">Lưu</button>
                </span>
        </div>

    </div>
</div>
<div id="change-phone-number" class="modal">
    <div class="modal-content">
        <span class="close-btn" id="close-change-phone-number-modal">&times;</span>
        <div class="phone-form">
            <div class="form-input">
                <label for="phone-number" class="profile-form label"><i class="fa-solid fa-phone"></i></label>
                <input type="text" id="phone-number" name="phoneNumber" class="profile-form input-field"
                       placeholder="Nhập số điện thoại mới">
            </div>
            <span class="confirm-btn">
                    <button id="save-phone-number-btn">Lưu</button>
                </span>
        </div>
    </div>
</div>
<div id="change-birthday" class="modal">
    <div class="modal-content">
        <span class="close-btn" id="close-change-birthday-modal">&times;</span>
        <div class="day-form">
            <div class="form-input">
                <label for="birthDay" class="profile-form label"><i class="fa-regular fa-calendar-days"></i></label>
                <input type="date" id="birthDay" name="birthDay" class="profile-form input-field"
                       placeholder="dd/mm/yyyy">
            </div>
            <span class="confirm-btn">
                    <button id="save-birthday-btn">Lưu</button>
                </span>
        </div>

    </div>
</div>
<div id="address-modal" class="modal">
    <div class="modal-content">
        <span class="close-btn" id="close-change-address-modal">&times;</span>
        <div class="address-form">
            <h2 id="header-address"></h2>
            <div class="form-row">
                <div class="form-group half-width">
                    <label for="province">Tỉnh/Thành phố (*)</label>
                    <select id="province" required>
                        <option value="">Chọn Tỉnh/Thành phố</option>
                        <option value="hcm">TP Hồ Chí Minh</option>
                        <option value="hn">Hà Nội</option>
                    </select>
                </div>
                <div class="form-group half-width">
                    <label for="district">Quận/Huyện (*)</label>
                    <select id="district" required>
                        <option value="">Chọn Quận/Huyện</option>
                    </select>
                </div>
                <div class="form-group half-width">
                    <label for="ward">Phường/Xã (*)</label>
                    <select id="ward" required>
                        <option value="">Chọn Phường/Xã</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="address-detail">Địa chỉ chi tiết (*)</label>
                    <textarea id="address-detail" rows="3"
                              placeholder="Ví dụ: 123/45 Đường Quang Trung, gần chợ ABC"
                              required></textarea>
                </div>
            </div>
            <button type="submit" id="submit-btn">Lưu Địa Chỉ</button>
        </div>
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
