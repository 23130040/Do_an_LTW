<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                           value="male" ${user.gender == 'male' ? 'checked' : ''}>
                    <label for="gender-male" class="profile-form radio-label">Nam</label>
                    <input type="radio" id="gender-female" name="gender"
                           value="female" ${user.gender == 'female' ? 'checked' : ''}>
                    <label for="gender-female" class="profile-form radio-label">Nữ</label>
                    <input type="radio" id="gender-other" name="gender"
                           value="other" ${empty user.gender || user.gender == 'other' ? 'checked' : ''}>
                    <label for="gender-other" class="profile-form radio-label">Khác</label>
                </div>
            </div>
            <div class="profile-form group">
                <label class="profile-form label">Ngày sinh</label>
                <div class="profile-form value-wrapper">
                    <span class="profile-form static-value" id="birthday">
                        <c:choose>
                            <c:when test="${not empty birthday}">${birthday}</c:when>
                            <c:otherwise>
                                01/01/1999
                            </c:otherwise>
                        </c:choose>
                    </span>
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
                    <button type="button" id="confirm-save-info-btn">OK</button>
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
            <button type="button" id="confirm-save-info-btn">OK</button>
        </span>
    </div>
</div>
<div id="change-email" class="modal">
    <div class="modal-content">
        <span class="close-btn" id="close-change-email-modal">&times;</span>
        <div class="email-form">
            <div class="form-input">
                <label for="newEmail" class="profile-form label"><i class="fa-solid fa-envelope"></i></label>
                <input type="email" id="newEmail" name="newEmail" class="profile-form input-field"
                       placeholder="Nhập địa chỉ Email mới">
            </div>
            <div class="error-message" id="email-error"></div>
            <span class="confirm-btn">
                <button type="button" id="save-email-btn">Lưu</button>
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
            <div class="error-message" id="phone-error"></div>
            <span class="confirm-btn">
                <button type="button" id="save-phone-number-btn">Lưu</button>
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
            <div class="error-message" id="error-birthday"></div>
            <span class="confirm-btn">
                    <button type="button" id="save-birthday-btn">Lưu</button>
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

        const saveEmailBtn = document.getElementById("save-email-btn");
        const emailInput = document.getElementById("newEmail");
        const emailSpan = document.getElementById("email");

        saveEmailBtn.addEventListener("click", (e) => {
            e.preventDefault();
            const newEmail = emailInput.value.trim();
            const emailError = document.getElementById("email-error");
            emailError.textContent = "";
            if (!newEmail) {
                emailError.textContent = "Email không được để trống";
                return;
            }
            if (!isValidEmailFormat(newEmail)) {
                emailError.textContent = "Email không đúng định dạng";
                return;
            }
            emailSpan.textContent = newEmail;
            closeModal("change-email");
            emailInput.value = "";
        });

        const savePhoneBtn = document.getElementById("save-phone-number-btn");
        const phoneNumberInput = document.getElementById("phone-number");
        const phoneSpan = document.getElementById("phone");

        savePhoneBtn.addEventListener("click", (e) => {
            e.preventDefault();
            const newPhone = phoneNumberInput.value.trim();
            const phoneError = document.getElementById("phone-error");
            phoneError.textContent = "";
            if (!newPhone) {
                phoneError.textContent = "Số điện thoại không được để trống";
                return;
            }
            if (!isValidPhoneFormat(newPhone)) {
                phoneError.textContent = "Số điện thoại không hợp lệ";
                return;
            }
            phoneSpan.textContent = newPhone;
            closeModal("change-phone-number");
            phoneNumberInput.value = "";
        });

        const changeBirthdayBtn = document.getElementById("save-birthday-btn");
        const newBirthdayInput = document.getElementById("birthDay");
        const birthdaySpan = document.getElementById("birthday");

        changeBirthdayBtn.addEventListener("click", (e) => {
            e.preventDefault();
            const newBirthday = newBirthdayInput.value;
            const errorBirthday = document.getElementById("error-birthday");
            errorBirthday.textContent = '';
            if (!newBirthday) {
                errorBirthday.textContent = "Vui lòng chọn ngày sinh";
                return;
            }
            birthdaySpan.textContent = formatDate(newBirthday);
            closeModal("change-birthday");
        });

        document.getElementById("saveInfoBtn").addEventListener("click", (e) => {
            e.preventDefault();

            const data = {
                action: "updateProfile",
                name: document.getElementById("name-input").value.trim(),
                email: emailSpan.textContent.trim(),
                phone: phoneSpan.textContent.trim(),
                gender: getSelectedGender(),
                birthday: newBirthdayInput.value
            };

            fetch(`${pageContext.request.contextPath}/tai-khoan`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(data)
            })
                .then(res => res.json())
                .then(result => {
                    if (result.success) {
                        openModal("confirm-save-info");
                    } else {
                        alert(result.message || "Cập nhật thất bại");
                    }
                })
                .catch(err => {
                    console.error(err);
                    alert("Lỗi kết nối server");
                });
        });

    });

    function getSelectedGender() {
        const checked = document.querySelector('input[name="gender"]:checked');
        return checked ? checked.value : null;
    }

    function openModal(id) {
        document.getElementById(id).style.display = "block";
    }

    function closeModal(id) {
        document.getElementById(id).style.display = "none";
    }

    function isValidEmailFormat(email) {
        const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return regex.test(email);
    }

    function isValidPhoneFormat(phone) {
        const regex = /^0\d{9}$/;
        return regex.test(phone);
    }

    function formatDate(date) {
        const formatDate = date.split("-");
        return formatDate[2] + "/" + formatDate[1] + "/" + formatDate[0];
    }

</script>