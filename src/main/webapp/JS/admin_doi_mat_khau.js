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
function showToast(msg, type = "info") {
    const toastEl = document.getElementById("appToast");

    toastEl.className =
        `toast align-items-center text-bg-${type} border-0`;

    document.getElementById("toastMessage").innerText = msg;

    new bootstrap.Toast(toastEl, { delay: 3000 }).show();
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
    })``
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
document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector(".password-change-form");

    if (!form) return;

    form.addEventListener("submit", function (e) {
        const newPassword = form.querySelector('input[name="newPassword"]').value;
        const confirmPassword = form.querySelector('input[name="confirmPassword"]').value;

        // Check độ dài
        if (newPassword.length < 8) {
            e.preventDefault();
            showToast("Mật khẩu mới phải có ít nhất 8 ký tự", "warning");
            return;
        }

        // Check khớp
        if (newPassword !== confirmPassword) {
            e.preventDefault();
            showToast("Mật khẩu xác nhận không khớp", "danger");
        }
    });
});
