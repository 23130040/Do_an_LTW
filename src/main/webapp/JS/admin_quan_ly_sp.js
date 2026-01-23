function formatNumber(n) {
    if (n === null || n === undefined || n === "") return "";
    let value = n.toString().replace(/\D/g, "");
    return value.replace(/\B(?=(\d{3})+(?!\d))/g, ".");
}

function getRawValue(str) {
    if (!str) return 0;
    return parseInt(str.toString().replace(/\./g, "")) || 0;
}

const contextPath = window.APP_CONTEXT;

function toggleUserMenu() {
    document.getElementById("userMenuContent")?.classList.toggle("show");
}

function toggleNotificationMenu() {
    document.getElementById("userMenuContent")?.classList.remove("show");
    document.getElementById("notification-panel")?.classList.toggle("show-panel");
}

document.addEventListener("click", (event) => {
    const userDropdown = document.getElementById("userMenuContent");
    const notificationPanel = document.getElementById("notification-panel");

    if (event.target.closest(".product-table")) return;

    if (!event.target.closest('.user-dropdown')) {
        userDropdown?.classList.remove("show");
    }

    if (!event.target.closest('#notification-panel') &&
        !event.target.matches('.notification-icon')) {
        notificationPanel?.classList.remove("show-panel");
    }
});
document.addEventListener("DOMContentLoaded", () => {
    const priceInput = document.getElementById("price");
    const discountInput = document.getElementById("discount");
    const skuInput = document.querySelector('input[name="sku"]');
    const skuError = document.getElementById("skuError");
    const productIdInput = document.getElementById("productId");
    const productForm = document.querySelector(".product-form");

    function calculateFinalPrice() {
        const fPriceInput = document.getElementById("finalPrice");
        const price = getRawValue(priceInput.value);
        const discount = parseFloat(discountInput?.value) || 0;
        const finalValue = Math.round(price * (1 - discount / 100));
        fPriceInput.value = formatNumber(finalValue);
    }

    priceInput?.addEventListener("input", function () {
        let cursorPosition = this.selectionStart;
        let oldLength = this.value.length;
        this.value = formatNumber(this.value);
        let newLength = this.value.length;
        cursorPosition = cursorPosition + (newLength - oldLength);
        this.setSelectionRange(cursorPosition, cursorPosition);
        calculateFinalPrice();
    });

    discountInput?.addEventListener("input", calculateFinalPrice);

    skuInput?.addEventListener("blur", function () {
        const sku = this.value.trim();
        const productId = productIdInput.value;

        if (!sku) {
            this.classList.remove("input-error");
            skuError.style.display = "none";
            return;
        }

        fetch(`${contextPath}/quan-ly-san-pham?action=checkSKU&sku=${sku}&id=${productId}`)
            .then(res => res.text())
            .then(data => {
                if (data.trim() === "exists") {
                    skuInput.classList.add("input-error");
                    skuError.style.display = "block";
                } else {
                    skuInput.classList.remove("input-error");
                    skuError.style.display = "none";
                }
            });
    });

    skuInput?.addEventListener("input", () => {
        skuInput.classList.remove("input-error");
        skuError.style.display = "none";
    });

    productForm?.addEventListener("submit", function (e) {
        if (skuError.style.display === "block") {
            e.preventDefault();
            alert("Mã SKU đã tồn tại!");
            skuInput.focus();
            return;
        }

        if (priceInput) {
            priceInput.value = getRawValue(priceInput.value);
        }
    });

    window.openProductModal = function (isEdit = false) {
        const modal = document.getElementById("product-modal");
        if (!modal || !productForm) return;

        document.getElementById("modal-title-product").innerText = isEdit ? "Chỉnh sửa" : "Thêm mới";
        document.getElementById("formAction").value = isEdit ? "updateItem" : "addItem";

        if (!isEdit) {
            productForm.reset();
            document.getElementById("productId").value = "";
            document.getElementById("selectedImages").value = "";
            document.getElementById("imagePreviewContainer").innerHTML = "";
            document.getElementById("imageFileName").innerText = "Chưa chọn ảnh";
            skuInput.classList.remove("input-error");
            skuError.style.display = "none";
        }
        modal.style.display = "flex";
    };
    window.closeProductModal = function () {
        document.getElementById("product-modal")?.style.setProperty("display", "none");
    };
});

function editProduct(id) {
    fetch(`${window.APP_CONTEXT}/quan-ly-san-pham?action=getEditData&id=${id}`)
        .then(res => res.json())
        .then(item => {
            openProductModal(true);
            const form = document.querySelector(".product-form");

            document.getElementById("productId").value = item.id;
            form.name.value = item.name;
            form.shortDescription.value = item.short_description;
            form.longDescription.value = item.long_description;
            form.categoryId.value = item.category_id;
            form.originId.value = item.origin_id;
            form.unitId.value = item.unit_id;
            form.sku.value = item.sku || "";
            form.minStock.value = item.min_stock;

            const priceVal = Math.floor(parseFloat(item.price) || 0);
            form.price.value = formatNumber(priceVal);
            form.discount.value = item.discount;

            const finalPrice = Math.round(priceVal * (1 - item.discount / 100));
            document.getElementById("finalPrice").value = formatNumber(finalPrice);

            const container = document.getElementById("imagePreviewContainer");
            container.innerHTML = "";
            if (item.images && item.images.length > 0) {
                item.images.forEach(imgName => {
                    const img = document.createElement("img");
                    img.src = `${window.APP_CONTEXT}/images/${imgName}`;
                    img.className = "preview-img";
                    img.style = "width:80px; margin-right:5px; border:1px solid #ddd";
                    container.appendChild(img);
                });
                document.getElementById("selectedImages").value = item.images.join(",");
                document.getElementById("imageFileName").innerText = `Đang có ${item.images.length} ảnh`;
            }
        })
        .catch(err => alert("Không thể tải dữ liệu sản phẩm"));
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

window.addNewWeight = function () {
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

    fetch('quan-ly-san-pham', {
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

function deleteProduct(button, id) {
    if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này không?')) {
        window.location.href = `quan-ly-san-pham?action=delete&id=${id}`;
    }
}

function deleteAndKeepPage(id, page) {
    if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này không?')) {
        window.location.href = `quan-ly-san-pham?action=delete&id=${id}&page=${page}`;
    }
}

const searchInput = document.getElementById('searchInput');
const categoryFilter = document.getElementById('categoryFilter');
const originFilter = document.getElementById('originFilter');

function applyFilterAndSearch() {
    const keyword = searchInput.value.trim();
    const category = categoryFilter.value;
    const origin = originFilter.value;

    const params = new URLSearchParams();

    if (keyword) params.append('search', keyword);
    if (category) params.append('category', category);
    if (origin) params.append('origin', origin);

    params.append('page', '1');

    window.location.href = 'quan-ly-san-pham?' + params.toString();
}


categoryFilter.addEventListener('change', applyFilterAndSearch);
originFilter.addEventListener('change', applyFilterAndSearch);

searchInput.addEventListener('keypress', (event) => {
    if (event.key === 'Enter') {
        event.preventDefault();
        if (typeof searchTimeout !== 'undefined') {
            clearTimeout(searchTimeout);
        }
        applyFilterAndSearch();
    }
});
