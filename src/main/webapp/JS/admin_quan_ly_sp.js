// Hàm User Menu
function toggleUserMenu() {
    document.getElementById("userMenuContent").classList.toggle("show");
}
// Hàm cho Notification Menu
function toggleNotificationMenu() {
    const userDropdown = document.getElementById("userMenuContent");
    const notificationPanel = document.getElementById("notification-panel");

    // Đóng User Menu nếu nó đang mở
    if (userDropdown) {
        userDropdown.classList.remove("show");
    }

    // Bật/Tắt Notification Panel
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

    if (selectedIndex <= 0) {
        alert("Vui lòng chọn một khối lượng cụ thể để xóa!");
        return;
    }

    const val = select.options[selectedIndex].text;
    if (confirm(`Bạn có chắc muốn xóa khối lượng: ${val}?`)) {
        select.remove(selectedIndex);
    }
}

window.addNewWeight = function() {
    const newWeightInput = document.getElementById('newWeight');
    const val = newWeightInput.value.trim();

    if (val === "") {
        alert("Vui lòng nhập khối lượng!");
        return;
    }

    if (isNaN(val) || parseFloat(val) <= 0) {
        alert("Vui lòng nhập một con số gram hợp lệ!");
        return;
    }

    const params = new URLSearchParams();
    params.append('action', 'addUnit');
    params.append('name', val);

    fetch('quanlysanpham', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: params.toString()
    })
        .then(response => {
            if (response.ok) return response.text();
            throw new Error('Lỗi mạng hoặc server');
        })
        .then(data => {
            if (data.trim() === "success") {
                alert("Thêm khối lượng thành công!");
                window.location.reload();
            } else {
                alert("Phản hồi từ server: " + data);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert("Lỗi: " + error.message);
        });
};