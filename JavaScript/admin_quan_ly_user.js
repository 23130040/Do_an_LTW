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
        // Logic để load dữ liệu người dùng vào form (sẽ cần backend)
    } else {
        modalTitle.textContent = 'Thêm';
        // Reset form khi thêm mới
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

// Xử lý mở / khóa tài khoản
const userTableBody = document.querySelector('.user-table tbody');

if (userTableBody) {
    userTableBody.addEventListener('click', function(event) {
        let targetButton = event.target.closest('.btn-icon');

        if (!targetButton) return;

        // Tìm hàng (row) chứa nút được click
        const row = targetButton.closest('tr');
        if (!row) return;

        // Các phần tử cần cập nhật trong hàng đó
        const statusCell = row.querySelector('.status-badge');
        const actionCell = row.querySelector('td:last-child');

        // Xử lý Khóa tài khoản
        if (targetButton.classList.contains('lock-btn') && !targetButton.disabled) {
            // Giả lập cập nhật trạng thái
            statusCell.textContent = 'Đã khóa';
            statusCell.classList.remove('status-active');
            statusCell.classList.add('status-locked');

            // Thay đổi nút Khóa thành Mở khóa
            actionCell.innerHTML = `
                    <button class="btn-icon edit-btn"><i class="fas fa-edit"></i></button>
                    <button class="btn-icon unlock-btn" title="Mở khóa tài khoản"><i class="fas fa-lock-open"></i></button>
                `;
            alert('Tài khoản đã được khóa.');

            // Xử lý Mở khóa tài khoản
        } else if (targetButton.classList.contains('unlock-btn')) {
            // Giả lập cập nhật trạng thái
            statusCell.textContent = 'Hoạt động';
            statusCell.classList.remove('status-locked');
            statusCell.classList.add('status-active');

            // Thay đổi nút Mở khóa thành Khóa
            actionCell.innerHTML = `
                    <button class="btn-icon edit-btn"><i class="fas fa-edit"></i></button>
                    <button class="btn-icon lock-btn" title="Khóa tài khoản"><i class="fas fa-lock"></i></button>
                `;
            alert('Tài khoản đã được mở khóa.');
        }
    });
}