<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<div id="profile-content" class="tab-content active">--%>
<div class="profile-content header">
    <h1 class="txt big">
        HỒ SƠ CỦA TÔI
    </h1>
</div>
<div class="profile-content body">
    <div class="profile-content profile">
        <form class="profile-form" action="${pageContext.request.contextPath}/ho-so" method="get">
            <div class="profile-form group">
                <label for="name-input" class="profile-form label">Tên</label>
                <input type="text" id="name-input" name="name" value="${user.name}"
                       class="profile-form input-field profile-form input-field editable">
            </div>
            <div class="profile-form group">
                <label class="profile-form label">Email</label>
                <div class="profile-form value-wrapper">
                    <span class="profile-form static-value">${user.email}</span>
                    <a href="#" class="profile-form change-btn" id="open-change-email-modal">Thay
                        Đổi</a>
                </div>
            </div>
            <div class="profile-form group">
                <label class="profile-form label">Số điện thoại</label>
                <div class="profile-form value-wrapper">
                    <span class="profile-form static-value">(+84) ${user.phone}</span>
                    <a href="#" class="profile-form change-btn" id="open-change-phone-number">Thay
                        Đổi</a>
                </div>
            </div>
            <div class="profile-form group">
                <label class="profile-form label">Giới tính</label>
                <div class="profile-form value-wrapper profile-form value-wrapper-radio">
                    <input type="radio" id="gender-male" name="gender"
                           value="male" ${user.gender == 'Nam' ? 'checked' : ''}>
                    <label for="gender-male" class="profile-form radio-label">Nam</label>
                    <input type="radio" id="gender-female" name="gender"
                           value="female" ${user.gender == 'Nữ' ? 'checked' : ''}>
                    <label for="gender-female" class="profile-form radio-label">Nữ</label>
                    <input type="radio" id="gender-other" name="gender"
                           value="other" ${user.gender == null ? 'checked' : ''}>
                    <label for="gender-other" class="profile-form radio-label">Khác</label>
                </div>
            </div>
            <div class="profile-form group">
                <label class="profile-form label">Ngày sinh</label>
                <div class="profile-form value-wrapper">
                    <span class="profile-form static-value">${birthday}</span>
                    <a href="#" class="profile-form change-btn" id="open-change-birthday-btn">Thay Đổi</a>
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

<!--Các modal-->
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

<script>
    document.addEventListener("DOMContentLoaded", () => {
        //mở modal thay đổi email
        const changeEmailbtn = document.getElementById("open-change-email-modal");
        changeEmailbtn.addEventListener("click", () => {
            openModal("change-email");
        });

        //đóng modal thay đổi email
        const closeEmailModal = document.getElementById("close-change-email-modal");
        closeEmailModal.addEventListener("click", () => {
            closeModal("change-email");
        });

        //mở modal thay đổi sdt
        const changePhonebtn = document.getElementById("open-change-phone-number");
        changePhonebtn.addEventListener("click", () => {
            openModal("change-phone-number");
        });

        //đóng modal thay đổi sdt
        const closePhoneModal = document.getElementById("close-change-phone-number-modal");
        closePhoneModal.addEventListener("click", () => {
            closeModal("change-phone-number");
        });

        //mở modal thay đổi ngày sinh
        const changeBirthDaybtn = document.getElementById("open-change-birthday-btn");
        changeBirthDaybtn.addEventListener("click", () => {
            openModal("change-birthday");
        });

        //đóng modal thay đổi email
        const closeBirthdayModal = document.getElementById("close-change-birthday-modal");
        closeBirthdayModal.addEventListener("click", () => {
            closeModal("change-birthday");
        });

        //đóng modal khi click ra ngoài
        window.addEventListener("click", (e) => {
            if (e.target === document.getElementById("change-email")) {
                closeModal("change-email");
            }
            if (e.target === document.getElementById("change-phone-number")) {
                closeModal("change-phone-number");
            }
            if (e.target === document.getElementById("change-birthday")) {
                closeModal("change-birthday");
            }
        });
    });

    function openModal(id) {
        document.getElementById(id).style.display = "block";
    }

    function closeModal(id) {
        document.getElementById(id).style.display = "none";
    }
</script>