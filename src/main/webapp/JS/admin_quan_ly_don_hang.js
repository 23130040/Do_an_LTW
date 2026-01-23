const modal = document.getElementById("orderDetailModal");
const closeBtns = document.querySelectorAll(".close-btn, .close-btn-footer");
const viewDetailBtns = document.querySelectorAll(".view-detail");
const orderTableBody = document.querySelector(".order-table tbody");


function format(number) {
    return Number(number).toLocaleString('vi-VN');
}
function formatDateVN(dateStr) {
    if (!dateStr) return "";
    const [year, month, day] = dateStr.split("-");
    return `${day}-${month}-${year}`;
}

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
viewDetailBtns.forEach(button => {
    button.addEventListener("click", function (e) {
        e.preventDefault();
        e.stopPropagation();

        const { id, status, date, customer, phone, address, total } = this.dataset;

        modalOrderId.innerText = "#" + id;
        modalOrderStatus.innerText = status;
        modalOrderDate.innerText = formatDateVN(date);
        modalCustomerName.innerText = customer;
        modalCustomerPhone.innerText = phone;
        modalShippingAddress.innerText = address;
        modalGrandTotal.innerText = total;

        loadOrderItems(id);
        openModal();
    });
});


function loadOrderItems(orderId) {
    const tbody = document.getElementById("modalProductList");
    tbody.innerHTML = '<tr><td colspan="4" style="text-align:center;">Đang tải sản phẩm...</td></tr>';

    fetch(`${CONTEXT_PATH}/OrderDetailServlet?id=${orderId}`)

        .then(response => {
            if (!response.ok) throw new Error("Network response was not ok");
            return response.json();
        })
        .then(data => {
            tbody.innerHTML = "";

            if (data.length === 0) {
                tbody.innerHTML = '<tr><td colspan="4" style="text-align:center;">Không có sản phẩm nào.</td></tr>';
                return;
            }

            data.forEach(oi => {
                const row = `
        <tr>
            <td>${oi.item.name}</td>
            <td>${format(oi.price)}đ</td>
            <td>${oi.quantity}</td>
            <td>${format(oi.price * oi.quantity)}đ</td>
        </tr>
    `;
                tbody.insertAdjacentHTML("beforeend", row);
            });

        })
        .catch(error => {
            console.error('Error:', error);
            tbody.innerHTML = '<tr><td colspan="4" style="text-align:center; color:red;">Lỗi khi tải chi tiết sản phẩm.</td></tr>';
        });
}
const searchInput = document.getElementById('searchInput');
const statusFilter = document.getElementById('statusFilter');

document.addEventListener("DOMContentLoaded", function() {
    const searchInput = document.getElementById('searchInput');
    const statusFilter = document.getElementById('statusFilter');

    function applyFilterAndSearch() {
        const keyword = searchInput.value.trim();
        const status = statusFilter.value;

        const params = new URLSearchParams();
        if (keyword !== "") params.append('search', keyword);
        if (status !== "") params.append('status', status);
        params.append('page', '1');

        window.location.href = 'quan-ly-don-hang?' + params.toString();
    }

    if (statusFilter) {
        statusFilter.addEventListener('change', applyFilterAndSearch);
    }

    if (searchInput) {
        searchInput.addEventListener('keypress', (event) => {
            if (event.key === 'Enter') {
                applyFilterAndSearch();
            }
        });
    }
});