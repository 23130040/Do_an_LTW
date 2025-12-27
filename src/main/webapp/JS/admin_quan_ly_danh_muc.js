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

const totalPages = 2; // Tổng số trang cố định
let currentPage = 1;

// Hàm chuyển trang: Ẩn/hiện các hàng (<tr>) dựa trên class 'page-X'
window.changePage = function(direction) {
    const newPage = currentPage + direction;

    if (newPage >= 1 && newPage <= totalPages) {
        // Ẩn tất cả các hàng hiện tại
        document.querySelectorAll('.pagination-row').forEach(row => {
            row.style.display = 'none';
        });

        currentPage = newPage;

        // Hiển thị các hàng của trang mới
        document.querySelectorAll(`.page-${currentPage}`).forEach(row => {
            row.style.display = 'table-row'; // Hiển thị dưới dạng hàng bảng
        });

        // Cập nhật thông tin trang và trạng thái nút
        document.getElementById('currentPageInfo').textContent = `Trang ${currentPage} / ${totalPages}`;
        document.getElementById('prevPageBtn').classList.toggle('disabled', currentPage === 1);
        document.getElementById('nextPageBtn').classList.toggle('disabled', currentPage === totalPages);
    }
};

// Hàm chuyển đổi Tab (Đảm bảo logic phân trang được khởi động lại)
function openTab(evt, tabName) {
    var i, tabcontent, tablinks;

    // Ẩn tất cả tab content
    window.location.href = "quanlydanhmuc?tab=" + tabName;
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
        tabcontent[i].classList.remove("active");
    }

    // Loại bỏ class 'active' khỏi tất cả tab links
    tablinks = document.getElementsByClassName("tab-link");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].classList.remove("active");
    }

    // Hiển thị tab hiện tại và thêm class 'active' cho nút bấm
    document.getElementById(tabName).style.display = "block";
    document.getElementById(tabName).classList.add("active");
    evt.currentTarget.classList.add("active");

    // Nếu chuyển đến tab Quản lý Nguồn gốc, đảm bảo Trang 1 hiển thị
    if (tabName === 'QuanLyNguonGoc') {
        currentPage = 1;
        // Gọi changePage(0) để áp dụng trạng thái Trang 1
        changePage(0);
    }
}


document.addEventListener("DOMContentLoaded", function() {
    // Khởi tạo Tab đầu tiên
    if(document.getElementById("QuanLyDanhMuc")) {
        document.getElementById("QuanLyDanhMuc").style.display = "block";
        document.getElementById("QuanLyDanhMuc").classList.add("active");
        var firstTabLink = document.querySelector(".tab-links .tab-link");
        if(firstTabLink) {
            firstTabLink.classList.add("active");
        }
    }

    window.toggleNotificationMenu = function() {
        var panel = document.getElementById("notification-panel");
        panel.classList.toggle("show-panel");
    };

    window.toggleUserMenu = function() {
        var menu = document.getElementById("userMenuContent");
        menu.classList.toggle("show");
    };

    if(document.getElementById('QuanLyNguonGoc').style.display === 'block' || document.getElementById('QuanLyNguonGoc').classList.contains('active')) {
        changePage(0);
    }
});
// Hàm mở Modal
window.openModal = function(modalId) {
    document.getElementById(modalId).style.display = 'flex';
};

// Hàm đóng Modal
window.closeModal = function(modalId) {
    document.getElementById(modalId).style.display = 'none';
};

// Đóng Modal khi click bên ngoài hộp thoại
window.onclick = function(event) {
    if (event.target.classList.contains('modal')) {
        event.target.style.display = "none";
    }
}