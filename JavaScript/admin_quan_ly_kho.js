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
// Hàm mở Tab
function openTab(evt, tabName) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tab-content");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tab-link");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(tabName).style.display = "block";
    evt.currentTarget.className += " active";
}

// Mở tab 'Tồn Kho Hiện Tại' khi tải trang
document.addEventListener("DOMContentLoaded", function() {
    // Kích hoạt tab đầu tiên
    if (document.querySelector('.tab-link')) {
        document.querySelector('.tab-link').click();
    }
});

// Hàm mở Modal Nhập/Xuất Kho
function openStockModal(type) {
    const modal = document.getElementById('stockAdjustmentModal');
    const title = document.getElementById('stockModalTitle');
    const typeSelect = document.getElementById('type');

    modal.style.display = "block";
}

// Hàm đóng Modal
function closeStockModal() {
    document.getElementById('stockAdjustmentModal').style.display = "none";
}

// Đóng modal khi click ra ngoài
window.onclick = function(event) {
    const modal = document.getElementById('stockAdjustmentModal');
    if (event.target === modal) {
        closeStockModal();
    }
}