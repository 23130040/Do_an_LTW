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
const modal = document.getElementById("orderDetailModal");
const closeBtns = document.querySelectorAll(".close-btn, .close-btn-footer");
const viewDetailBtns = document.querySelectorAll(".view-detail");
const orderTableBody = document.querySelector(".order-table tbody");


// Hàm mở modal
function openModal(row) {
    modal.style.display = "block";
}

// Hàm đóng modal
function closeModal() {
    modal.style.display = "none";
}

// Xử lý click trên nút Xem chi tiết
viewDetailBtns.forEach(button => {
    button.onclick = function(e) {
        e.stopPropagation(); // Ngăn sự kiện nổi bọt lên hàng (tr) cha
        const row = this.closest('tr');
        openModal(row);
    }
});

// Nút đóng modal
closeBtns.forEach(btn => {
    btn.onclick = function() {
        closeModal();
    }
});

// Đóng modal khi người dùng click bên ngoài hộp thoại
window.onclick = function(event) {
    if (event.target === modal) {
        closeModal();
    }
}