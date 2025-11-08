// xử lý khi ấn nút user
function toggleUserMenu() {
    document.getElementById("userMenuContent").classList.toggle("show");
}

// Đóng menu nếu người dùng click ra ngoài
window.onclick = function(event) {
    if (!event.target.matches('.user-logo')) {
        var dropdowns = document.getElementsByClassName("dropdown-content");
        for (let i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.classList.contains('show')) {
                openDropdown.classList.remove('show');
            }
        }
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

