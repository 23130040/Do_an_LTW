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
    document.getElementById("add-product-btn")
        ?.addEventListener("click", () => openProductModal(false));
});

function openProductModal() {
    const modal = document.getElementById('product-modal');
    const title = document.getElementById('modal-title-product');
    const actionInput = document.getElementById('formAction');
    const form = document.querySelector('.product-form');

    if (title) title.innerText = "Thêm";
    if (actionInput) actionInput.value = "addItem";
    if (form) form.reset();
    if (modal) modal.style.display = 'flex';
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
function editProduct(id) {
    console.log("Đang lấy dữ liệu cho sản phẩm ID:", id);

    fetch(`quanlysanpham?action=getEditData&id=${id}`)
        .then(res => {
            if (!res.ok) throw new Error("Lỗi mạng");
            return res.json();
        })
        .then(item => {
            console.log("Dữ liệu nhận được:", item);

            document.getElementById('modal-title-product').innerText = "Chỉnh Sửa";
            document.getElementById('formAction').value = "updateItem";
            document.getElementById('productId').value = item.id;

            const form = document.querySelector('.product-form');

            form.name.value = item.name || "";
            form['shortDescription'].value = item.short_description || "";
            form['longDescription'].value = item.long_description || "";
            form.categoryId.value = item.category_id;
            form.originId.value = item.origin_id;
            form.unitId.value = item.unit_id;
            form.price.value = item.price;
            form.discount.value = item.discount;
            form.sku.value = item.sku || "";
            form.minStock.value = item.min_stock;

            const price = parseFloat(item.price) || 0;
            const discount = parseFloat(item.discount) || 0;
            document.getElementById('finalPrice').value = Math.round(price * (1 - discount / 100));

            document.getElementById('product-modal').style.display = 'flex';
        })
        .catch(err => {
            console.error("Lỗi khi mở modal chỉnh sửa:", err);
            alert("Không thể tải dữ liệu sản phẩm!");
        });
}
document.addEventListener("DOMContentLoaded", () => {
    const priceInput = document.getElementById('price');
    const discountInput = document.getElementById('discount');
    const finalPriceInput = document.getElementById('finalPrice');

    function calculateFinalPrice() {
        const price = parseFloat(priceInput.value) || 0;
        const discount = parseFloat(discountInput.value) || 0;
        const finalPrice = price * (1 - discount / 100);
        finalPriceInput.value = Math.round(finalPrice);
    }

    priceInput.addEventListener('input', calculateFinalPrice);
    discountInput.addEventListener('input', calculateFinalPrice);
});