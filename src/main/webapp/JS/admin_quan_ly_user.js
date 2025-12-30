let emailVerified = false;

document.addEventListener("DOMContentLoaded", () => {

    /* ================= USER MENU ================= */
    const userMenu = document.getElementById("userMenuContent");
    const notificationPanel = document.getElementById("notification-panel");

    window.toggleUserMenu = () => {
        userMenu.classList.toggle("show");
        notificationPanel.classList.remove("show-panel");
    };

    window.toggleNotificationMenu = () => {
        userMenu.classList.remove("show");
        notificationPanel.classList.toggle("show-panel");
    };

    document.addEventListener("click", (e) => {
        if (!e.target.closest(".user-dropdown") && !e.target.matches(".user-logo")) {
            userMenu.classList.remove("show");
        }
        if (!e.target.closest("#notification-panel") && !e.target.matches(".notification-icon")) {
            notificationPanel.classList.remove("show-panel");
        }
    });

    /* ================= USER MODAL ================= */
    const userModal = document.getElementById("user-modal");
    const modalTitle = document.getElementById("modal-title-user");
    const userForm = userModal.querySelector(".user-form");
    const USER_API_URL = "quanlyuser";

    window.openUserModal = (isEdit = false, userData = null) => {
        userForm.reset();
        emailVerified = false;

        const userEmail = document.getElementById("userEmail");
        const userPassword = document.getElementById("userPassword");
        const userConfirmPassword = document.getElementById("userConfirmPassword");
        const userIdHidden = document.getElementById("userIdHidden");

        userEmail.readOnly = false;

        if (isEdit && userData) {
            modalTitle.textContent = "Sửa";
            fillUserForm(userData);

            userForm.action = USER_API_URL + "?action=update";
            userPassword.removeAttribute("required");
            userConfirmPassword.removeAttribute("required");

            emailVerified = true;
            userEmail.readOnly = true;
        } else {
            modalTitle.textContent = "Thêm";

            userForm.action = USER_API_URL + "?action=add";
            userPassword.required = true;
            userConfirmPassword.required = true;
            userIdHidden.value = "";
        }

        userModal.style.display = "flex";
    };

    window.closeUserModal = () => {
        userModal.style.display = "none";
    };

    function fillUserForm(user) {
        document.getElementById("userIdHidden").value = user.id || "";
        document.getElementById("userName").value = user.name || "";
        document.getElementById("userEmail").value = user.email || "";
        document.getElementById("userPhone").value = user.phone || "";
        document.getElementById("userRole").value = user.role || "";
    }

    /* ================= OTP ================= */
    document.getElementById("btnSendOTP").addEventListener("click", () => {
        const email = document.getElementById("userEmail").value.trim();

        if (!email) {
            alert("Vui lòng nhập email");
            return;
        }

        fetch("send-otp", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "email=" + encodeURIComponent(email)
        })
            .then(res => res.text())
            .then(data => {
                switch (data) {
                    case "OK":
                        alert("OTP đã gửi tới email");
                        break;
                    case "EMAIL_NOT_FOUND":
                        alert("Email chưa tồn tại trong hệ thống");
                        break;
                    case "INVALID_EMAIL":
                        alert("Email không hợp lệ");
                        break;
                    case "EMAIL_EXISTS":
                        alert("Email đã tồn tại");
                        break;
                    default:
                        alert("Không thể gửi OTP");
                }
            })
            .catch(() => alert("Lỗi kết nối server"));
    });

    document.getElementById("btnVerifyOTP").addEventListener("click", () => {
        const otp = document.getElementById("userOTP").value.trim();
        if (!otp) {
            alert("Vui lòng nhập mã OTP");
            return;
        }

        fetch("verify-otp", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "otp=" + encodeURIComponent(otp)
        })
            .then(res => res.text())
            .then(data => {
                if (data === "OK") {
                    alert("Xác thực email thành công");
                    emailVerified = true;
                    document.getElementById("userEmail").readOnly = true;
                } else {
                    alert("OTP sai hoặc đã hết hạn");
                }
            });
    });

    /* ================= FORM SUBMIT ================= */
    userForm.addEventListener("submit", (e) => {
        e.preventDefault();
        submitUserForm();
    });
    function submitUserForm() {
        fetch(userForm.action, {
            method: "POST",
            body: new FormData(userForm)
        })
            .then(res => res.text())
            .then(data => {
                switch (data.trim()) {

                    case "EMAIL_NOT_VERIFIED":
                        alert("⚠Email chưa được xác thực. Vui lòng kiểm tra email và nhập OTP.");
                        break;

                    case "EMAIL_EXISTS":
                        alert("⚠Email đã tồn tại trong hệ thống.");
                        break;

                    case "SUCCESS":
                        alert("Thêm người dùng thành công");
                        window.location.reload();
                        break;

                    default:
                        alert("Có lỗi xảy ra: " + data);
                }
            })
            .catch(() => alert("Lỗi kết nối server"));
    }

    window.editUser = function (id) {

        fetch(USER_API_URL + '?action=edit&id=' + id)
            .then(response => {
                if (!response.ok) {

                    return response.text().then(text => Promise.reject(text));
                }
                return response.json();
            })
            .then(user => {
                console.log("Dữ liệu User từ Servlet:", user);
                openUserModal(true, user);
            })
            .catch(error => {
                console.error('Lỗi khi tải thông tin người dùng:', error);
                alert('Lỗi: Không thể tải thông tin người dùng. Chi tiết: ' + error);
            });
    }

    function fillUserForm(user) {
        document.getElementById('userIdHidden').value = user.id || "";

        document.getElementById('userName').value = user.name || "";
        document.getElementById('userEmail').value = user.email || "";
        document.getElementById('userPhone').value = user.phone || "";

        document.getElementById('userRole').value = user.role || "";

        document.getElementById('userPassword').value = "";
        document.getElementById('userConfirmPassword').value = "";
    }

});
