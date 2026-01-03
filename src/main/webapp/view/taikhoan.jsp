<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="container">
    <div id="sidebar">
        <div class="sidebar header">
            <img src="${pageContext.request.contextPath}/images/avatar.jpg" alt="avatar">
            <h3 class="username">Nguyễn Văn A</h3>
        </div>
        <div class="sidebar menu">
            <a href="${pageContext.request.contextPath}/ho-so" class="default-link">Hồ sơ</a>
            <a href="${pageContext.request.contextPath}/dia-chi">Địa chỉ</a>
            <a href="${pageContext.request.contextPath}/doi-mat-khau">Đổi mật khẩu</a>
            <a href="${pageContext.request.contextPath}/cai-dat">Những thiết lập riêng tư</a>
        </div>
    </div>

    <div class="main-content">
        <div id="${requestScope.idContent}">
            <jsp:include page="${requestScope.pageContent}"/>
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
</div>