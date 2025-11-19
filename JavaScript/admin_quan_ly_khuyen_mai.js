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
// Hàm chuyển đổi tab
function openTab(tabName) {
    const tabContents = document.getElementsByClassName("tab-content");
    for (let i = 0; i < tabContents.length; i++) {
        tabContents[i].classList.remove('active');
    }

    const tabButtons = document.getElementsByClassName("tab-btn");
    for (let i = 0; i < tabButtons.length; i++) {
        tabButtons[i].classList.remove('active');
    }

    document.getElementById(tabName).classList.add('active');
    // Đặt active cho nút bấm tương ứng (dựa vào thứ tự)
    if (tabName === 'promotion') {
        tabButtons[0].classList.add('active');
    } else if (tabName === 'content') {
        tabButtons[1].classList.add('active');
    }
}
// Hàm mở modal chung
function openModal(modalId) {
    document.getElementById(modalId).style.display = 'block';
}

// Hàm đóng modal chung
function closeModal(modalId) {
    document.getElementById(modalId).style.display = 'none';
}

// Hàm mở modal tạo khuyến mãi
function openAddPromoModal() {
    document.getElementById('modal-title-promo').textContent = 'Thêm';
    // Logic khác khi mở modal (ví dụ: reset form,...)
    openModal('promo-modal');
}

// Hàm mở modal thêm banner
function openAddBannerModal() {
    document.getElementById('modal-title-banner').textContent = 'Thêm';
    // Logic khác khi mở modal
    openModal('banner-modal');
}

// Hàm mở modal tạo bài viết
function openAddArticleModal() {
    document.getElementById('modal-title-article').textContent = 'Tạo';
    // Logic khác khi mở modal
    openModal('article-modal');
}

