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
                    <span class="profile-form static-value" id="email">${user.email}</span>
                    <a href="#" class="profile-form change-btn" id="open-change-email-modal">Thay
                        Đổi</a>
                </div>
            </div>
            <div class="profile-form group">
                <label class="profile-form label">Số điện thoại</label>
                <div class="profile-form value-wrapper">
                    <span class="profile-form static-value" id="phone">${user.phone}</span>
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
                    <span class="profile-form static-value" id="birthday">${birthday}</span>
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
                <span class="info-confirm">Lưu thông tin thành công</span>
            </div>
            <span class="confirm-btn">
                    <button id="confirm-save-info-btn">OK</button>
                </span>
        </div>
    </div>
</div>
<div id="confirm-change-email" class="modal">
    <div class="confirm-form">
        <div class="message">
            <i class="fa-solid fa-exclamation"></i>
            <span class="info-confirm">Email có sự thay đổi. Bạn vui lòng xác thực địa chỉ email mới và đăng nhập lại.</span>
            <span class="info-confirm italic">Link xác thực đã được gửi đến địa chỉ email <span
                    id="new-email"></span></span>
        </div>
        <span class="confirm-btn">
            <button id="confirm-save-info-btn">OK</button>
        </span>
    </div>
</div>
<div id="change-email" class="modal">
    <form class="modal-content">
        <span class="close-btn" id="close-change-email-modal">&times;</span>
        <form class="day-form" action="${pageContext.request.contextPath}/tai-khoan?action=update-emal" method="post">
            <div class="form-input">
                <label for="newEmail" class="profile-form label"><i class="fa-solid fa-envelope"></i></label>
                <input type="email" id="newEmail" name="newEmail" class="profile-form input-field"
                       placeholder="Nhập địa chỉ Email mới">
            </div>
            <div class="error-message" id="email-error"></div>
            <span class="confirm-btn">
                <button id="save-email-btn">Lưu</button>
            </span>
        </form>
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

        const originalEmail = "${user.email}";
        const tempUser = {
            name: "${user.name}",
            email: "${user.email}",
            phone: "${user.phone}",
            gender: "${user.gender}",
            birthday: "${birthday}"
        };

        document.getElementById("name-input")?.addEventListener("input", e => {
            tempUser.name = e.target.value.trim();
        });

        document.getElementById("save-email-btn")?.addEventListener("click", e => {
            e.preventDefault();
            const emailInput = document.getElementById("newEmail");
            const errorBox = document.getElementById("email-error");
            const email = emailInput.value.trim();
            if (!email) {
                errorBox.innerText = "Email không được để trống";
                return;
            }
            errorBox.innerText = "";
            fetch("${pageContext.request.contextPath}/tai-khoan?action=check-email", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ email })
            })
                .then(res => res.json())
                .then(data => {
                    if (!data.success) {
                        errorBox.innerText = data.message;
                        return;
                    }
                    tempUser.email = email;
                    document.getElementById("email").innerText = email;
                    closeModal("change-email");
                })
                .catch(() => {
                    errorBox.innerText = "Không thể kiểm tra email";
                });
        });


        document.getElementById("save-phone-number-btn")?.addEventListener("click", e => {
            e.preventDefault();
            const phone = document.getElementById("phone-number").value.trim();
            if (!phone) return;

            tempUser.phone = phone;
            document.getElementById("phone").innerText = phone;

            closeModal("change-phone-number");
        });

        document.querySelectorAll("input[name='gender']").forEach(radio => {
            radio.addEventListener("change", e => {
                tempUser.gender = e.target.value;
            });
        });

        document.getElementById("save-birthday-btn")?.addEventListener("click", e => {
            e.preventDefault();
            const birthday = document.getElementById("birthDay").value;
            if (!birthday) return;
            tempUser.birthday = birthday;
            document.getElementById("birthday").innerText =
                new Date(birthday).toLocaleDateString("vi-VN");
            closeModal("change-birthday");
        });


        document.getElementById("saveInfoBtn")?.addEventListener("click", () => {

            const emailChanged = tempUser.email !== originalEmail;

            fetch("${pageContext.request.contextPath}/tai-khoan", {
                method: "POST",
                headers: {"Content-Type": "application/json"},
                body: JSON.stringify({
                    action: "updateProfile",
                    emailChanged: emailChanged,
                    name: tempUser.name,
                    email: tempUser.email,
                    phone: tempUser.phone,
                    gender: tempUser.gender,
                    birthday: tempUser.birthday
                })
            })
                .then(res => res.json())
                .then(data => {
                    if (!data.success) {
                        alert(data.message || "Cập nhật thất bại");
                        return;
                    }

                    if (emailChanged) {
                        document.getElementById("new-email").innerText = tempUser.email;
                        openModal("confirm-change-email");
                    } else {
                        openModal("confirm-save-info");
                    }
                })
                .catch(err => {
                    console.error(err);
                    alert("Có lỗi xảy ra");
                });
        });
    });

    function openModal(id) {
        document.getElementById(id).style.display = "block";
    }

    function closeModal(id) {
        document.getElementById(id).style.display = "none";
    }
</script>