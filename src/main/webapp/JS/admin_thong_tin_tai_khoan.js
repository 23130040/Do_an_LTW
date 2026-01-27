// Hàm User Menu
function toggleUserMenu() {
    document.getElementById("userMenuContent").classList.toggle("show");
}
// Hàm cho Notification Menu
function toggleNotificationMenu() {
    const userDropdown = document.getElementById("userMenuContent");
    const notificationPanel = document.getElementById("notification-panel");

    // 1. Đóng User Menu nếu nó đang mở
    if (userDropdown) {
        userDropdown.classList.remove("show");
    }

    // 2. Bật/Tắt Notification Panel
    if (notificationPanel) {
        notificationPanel.classList.toggle("show-panel");
    }
}


// Xử lý đóng cả hai menu khi người dùng click ra ngoài
window.onclick = function(event) {
    const userDropdown = document.getElementById("userMenuContent");
    const notificationPanel = document.getElementById("notification-panel");
    const notificationIcon = document.querySelector('.notification-icon');

    if (
        !event.target.matches('.user-logo') &&
        userDropdown && userDropdown.classList.contains('show') &&
        !event.target.closest('.user-dropdown')
    ) {
        userDropdown.classList.remove('show');
    }

    if (
        notificationPanel &&
        notificationPanel.classList.contains('show-panel') &&
        !event.target.matches('.notification-icon') &&
        !event.target.closest('#notification-panel')
    ) {
        notificationPanel.classList.remove('show-panel');
    }
}

const updateForm = document.getElementById("update-form");

const emailInput = document.getElementById("email");
const otpInput = document.getElementById("otp");

const btnSendOTP = document.querySelector(".btn-send-otp");
const btnVerifyOTP = document.querySelector(".btn-verify-otp");


btnSendOTP.addEventListener("click", () => {
    const email = emailInput.value.trim();
    if (!email) {
        showToast("Vui lòng nhập email", "warning");
        return;
    }

    fetch("send-otp", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "email=" + encodeURIComponent(email)
    })
        .then(r => r.text())
        .then(r => {
            if (r === "OK") {
                showToast("OTP đã gửi", "success");
            } else {
                showToast("Không thể gửi OTP", "danger");
            }
        });
});


btnVerifyOTP.addEventListener("click", () => {
    const otp = otpInput.value.trim();
    const email = emailInput.value.trim();

    if (!otp) {
        showToast("Vui lòng nhập OTP", "warning");
        return;
    }

    fetch("verify-otp", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: `otp=${encodeURIComponent(otp)}&email=${encodeURIComponent(email)}`
    })
        .then(r => r.text())
        .then(r => {
            if (r === "OK") {
                emailVerified = true;
                emailInput.readOnly = true;
                showToast("Xác thực thành công", "success");
            } else {
                showToast("OTP không đúng", "danger");
            }
        });
});
emailInput.addEventListener("input", () => {
    const email = emailInput.value.trim();

    if (isEditMode && email === originalEmail) {
        btnSendOTP.disabled = true;
        emailVerified = true;
    } else {
        btnSendOTP.disabled = false;
        emailVerified = false;
        emailInput.readOnly = false;
    }
});

function showToast(msg, type = "info") {
    const toastEl = document.getElementById("appToast");
    toastEl.className = `toast text-bg-${type}`;
    document.getElementById("toastMessage").innerText = msg;
    new bootstrap.Toast(toastEl, {delay: 3000}).show();
}

window.toggleStatus = function(userId, isChecked) {
    const params = new URLSearchParams();
    params.append('action', 'updateStatus');
    params.append('id', userId);
    params.append('status', isChecked);

    fetch('quan-ly-nguoi-dung', {
        method: 'POST',
        body: params,
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        }
    })
        .then(response => response.text())
        .then(data => {
            if (data.trim() === "SUCCESS") {
                showToast("Cập nhật trạng thái thành công", "success");
            } else {
                showToast("Lỗi khi cập nhật trạng thái", "danger");
                setTimeout(() => location.reload(), 1000);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showToast("Lỗi kết nối máy chủ", "danger");
        });
};