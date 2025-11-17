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

// Hàm mở Modal người dùng
function openUserModal(isEdit = false) {
    const modal = document.getElementById('user-modal');
    const modalTitle = document.getElementById('modal-title-user');

    if (isEdit) {
        modalTitle.textContent = 'Sửa';
    } else {
        modalTitle.textContent = 'Thêm';
        modal.querySelector('.user-form').reset();
        document.getElementById('userStatusText').textContent = 'Hoạt động';
    }
    modal.style.display = 'flex';
}

// Hàm đóng Modal người dùng
function closeUserModal() {
    document.getElementById('user-modal').style.display = 'none';
}

// Cập nhật trạng thái hiển thị của toggle switch
document.addEventListener('DOMContentLoaded', () => {
    const userStatusToggle = document.getElementById('userStatus');
    const userStatusText = document.getElementById('userStatusText');

    if (userStatusToggle && userStatusText) {
        userStatusToggle.addEventListener('change', function() {
            userStatusText.textContent = this.checked ? 'Hoạt động' : 'Khóa';
        });
        // Thiết lập trạng thái ban đầu
        userStatusText.textContent = userStatusToggle.checked ? 'Hoạt động' : 'Khóa';
    }
});

// Gán sự kiện cho nút "Thêm Người Dùng Mới"
document.querySelector('.control-panel .btn-primary').addEventListener('click', () => openUserModal(false));

// Gán sự kiện cho nút "Sửa" trong bảng
document.querySelectorAll('.edit-btn').forEach(button => {
    button.addEventListener('click', () => openUserModal(true));
});
