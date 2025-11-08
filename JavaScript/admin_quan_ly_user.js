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
