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
    const USER_API_URL = "quan-ly-nguoi-dung";

    window.openUserModal = (isEdit = false, userData = null) => {
        userForm.reset();
        emailVerified = false;

        const userEmail = document.getElementById("userEmail");
        const userPassword = document.getElementById("userPassword");
        const userConfirmPassword = document.getElementById("userConfirmPassword");
        const userIdHidden = document.getElementById("userIdHidden");

        userEmail.readOnly = false;
        const formActionInput = document.getElementById("formAction");

        if (isEdit && userData) {
            modalTitle.textContent = "Sửa";
            fillUserForm(userData);

            formActionInput.value = "update";
            userPassword.removeAttribute("required");
            userConfirmPassword.removeAttribute("required");

            emailVerified = true;
            userEmail.readOnly = true;
        } else {
            modalTitle.textContent = "Thêm";

            formActionInput.value = "add";
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
            showToast("Vui lòng nhập email", "warning");
            return;
        }

        fetch("send-otp", {
            method: "POST",
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            body: "email=" + encodeURIComponent(email)
        })
            .then(res => res.text())
            .then(data => {
                switch (data) {
                    case "OK":
                        showToast("OTP đã gửi tới email", "success");
                        break;
                    case "INVALID_EMAIL":
                        showToast("Email không hợp lệ", "warning");
                        break;
                    case "EMAIL_EXISTS":
                        showToast("Email đã tồn tại", "danger");
                        break;
                    default:
                        showToast("Không thể gửi OTP", "danger");
                }
            })
            .catch(() => showToast("Lỗi kết nối server", "danger"));
    });

    document.getElementById("btnVerifyOTP").addEventListener("click", () => {
        const otp = document.getElementById("userOTP").value.trim();
        if (!otp) {
            alert("Vui lòng nhập mã OTP");
            return;
        }

        fetch("verify-otp", {
            method: "POST",
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            body: "otp=" + encodeURIComponent(otp)
                + "&email=" + encodeURIComponent(document.getElementById("userEmail").value)
        })
            .then(res => res.text())
            .then(data => {
                if (data === "OK") {
                    showToast("Xác thực email thành công", "success");
                    emailVerified = true;
                    document.getElementById("userEmail").readOnly = true;
                } else {
                    showToast("OTP sai hoặc đã hết hạn", "danger");
                }
            });
    });

    /* ================= FORM SUBMIT ================= */
    userForm.addEventListener("submit", (e) => {
        e.preventDefault();
        submitUserForm();
    });

    function submitUserForm() {
        const actionInput = document.getElementById("formAction");

        if (!actionInput.value) {
            actionInput.value = document.getElementById("userIdHidden").value
                ? "update"
                : "add";
        }
        const password = document.getElementById("userPassword").value;
        const confirmPassword = document.getElementById("userConfirmPassword").value;
        const action = document.getElementById("formAction").value;

        if (action === "add" || password || confirmPassword) {
            if (password !== confirmPassword) {
                showToast("Mật khẩu chưa trùng khớp", "warning");
                return;
            }
        }

        const formData = new FormData(userForm);
        const data = new URLSearchParams(formData);
        fetch(USER_API_URL, {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: data
        })
            .then(res => res.text())
            .then(data => {
                switch (data.trim()) {
                    case "EMAIL_NOT_VERIFIED":
                        showToast("Email chưa được xác thực", "warning");
                        break;
                    case "INVALID_ACTION":
                        showToast("Hành động không hợp lệ", "danger");
                        break;
                    case "SUCCESS":
                        showToast("Thành công", "success");
                        setTimeout(() => location.reload(), 1000);
                        break;
                    default:
                        showToast("Lỗi: " + data, "danger");
                }
            })
            .catch(() => showToast("Lỗi kết nối server", "danger"));
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

    function showToast(message, type = "info") {
        const toastEl = document.getElementById("appToast");
        const toastBody = document.getElementById("toastMessage");

        toastEl.className = "toast align-items-center border-0";

        const typeClassMap = {
            success: "text-bg-success",
            danger: "text-bg-danger",
            warning: "text-bg-warning",
            info: "text-bg-primary"
        };

        toastEl.classList.add(typeClassMap[type] || "text-bg-primary");
        toastBody.textContent = message;

        const toast = new bootstrap.Toast(toastEl, {delay: 3000});
        toast.show();
    }
    let userIdToDelete = null;
    const deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));

    window.deleteUser = function (id) {
        userIdToDelete = id;
        deleteModal.show();
    };

    document.getElementById('deleteConfirmModal').addEventListener('hidden.bs.modal', function () {
        const backdrops = document.querySelectorAll('.modal-backdrop');
        backdrops.forEach(b => b.remove());

        document.body.classList.remove('modal-open');
        document.body.style.overflow = '';
        document.body.style.paddingRight = '';
    });

    document.getElementById('btnConfirmDelete').addEventListener('click', () => {
        if (!userIdToDelete) return;

        const btn = document.getElementById('btnConfirmDelete');
        btn.disabled = true;

        fetch(`${USER_API_URL}?action=delete&id=${userIdToDelete}`, {
            method: "DELETE"
        })
            .then(response => response.text())
            .then(data => {
                if (data.includes("thành công")) {
                    deleteModal.hide();
                    showToast("Xóa người dùng thành công", "success");

                    setTimeout(() => {
                        location.reload();
                    }, 500);
                } else {
                    showToast("Lỗi: " + data, "danger");
                    btn.disabled = false;
                }
            })
            .catch(error => {
                console.error('Lỗi xóa:', error);
                deleteModal.hide();
                btn.disabled = false;
            });
    });
    function calculateFinalPrice() {
        const price = parseFloat(document.getElementById("price").value) || 0;
        const discount = parseFloat(document.getElementById("discount").value) || 0;

        let finalPrice = price * (100 - discount) / 100;

        if (finalPrice < 0) finalPrice = 0;

        document.getElementById("finalPrice").value = Math.round(finalPrice);
    }

    document.getElementById("price").addEventListener("input", calculateFinalPrice);
    document.getElementById("discount").addEventListener("input", calculateFinalPrice);

});
const searchInput = document.getElementById('searchInput');
const roleFilter = document.getElementById('roleFilter');

function applyFilterAndSearch() {
    const keyword = searchInput.value;
    const role = roleFilter.value;

    let url = 'quan-ly-nguoi-dung?';

    if (keyword) {
        url += 'search=' + encodeURIComponent(keyword) + '&';
    }

    url += 'role=' + encodeURIComponent(role) + '&';


    if (url.endsWith('&')) {
        url = url.slice(0, -1);
    }

    window.location.href = url;
}

searchInput.addEventListener('input', () => {
    clearTimeout(searchTimeout);

    searchTimeout = setTimeout(applyFilterAndSearch, 500);
});

roleFilter.addEventListener('change', applyFilterAndSearch);
searchInput.addEventListener('keypress', (event) => {
    if (event.key === 'Enter') {
        event.preventDefault();

        if (typeof searchTimeout !== 'undefined') {
            clearTimeout(searchTimeout);
        }

        applyFilterAndSearch();
    }
});