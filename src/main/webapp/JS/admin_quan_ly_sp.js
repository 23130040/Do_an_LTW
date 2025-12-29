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
document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".edit-btn").forEach(btn => {
        btn.addEventListener("click", () => openProductModal(true));
    });

    document.getElementById("add-product-btn")
        ?.addEventListener("click", () => openProductModal(false));
});

function openProductModal(isEdit = false) {
    const modal = document.getElementById('product-modal');
    const modalTitleSpan = document.getElementById('modal-title-product');
    const editButtons = document.querySelectorAll('.product-table .edit-btn');
    editButtons.forEach(button => {
        button.addEventListener('click', () => openProductModal(true));
    });


    modal.style.display = 'flex';
}

function closeProductModal() {
    document.getElementById('product-modal').style.display = 'none';
}
function removeSelectedWeight() {
    const select = document.getElementById("weightSelect");
    const selectedIndex = select.selectedIndex;

    // Không cho phép xóa option mặc định "Chọn khối lượng" (index 0)
    if (selectedIndex <= 0) {
        alert("Vui lòng chọn một khối lượng cụ thể để xóa!");
        return;
    }

    const val = select.options[selectedIndex].text;
    if (confirm(`Bạn có chắc muốn xóa khối lượng: ${val}?`)) {
        select.remove(selectedIndex);
        // Lưu ý: Nếu muốn xóa vĩnh viễn trong Database, bạn cần gọi API tại đây
    }
}

// Hàm Thêm option mới vào select
function addNewWeight() {
    const input = document.getElementById("newWeight");
    const weightValue = input.value.trim();
    const select = document.getElementById("weightSelect");

    if (weightValue === "") {
        alert("Vui lòng nhập khối lượng!");
        return;
    }

    // Tạo một option mới
    const newOption = document.createElement("option");
    newOption.text = weightValue;
    newOption.value = weightValue.toLowerCase().replace(/\s+/g, ''); // tạo value đơn giản

    select.add(newOption);
    input.value = ""; // Xóa trống input sau khi thêm
}

