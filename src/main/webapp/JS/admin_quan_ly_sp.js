
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

        window.openProductModal = function (isEdit = false) {
            const modal = document.getElementById("product-modal");
            const form = document.querySelector(".product-form");

            if (!modal || !form) return;

            document.getElementById("modal-title-product").innerText =
                isEdit ? "Chỉnh sửa" : "Thêm mới";

            document.getElementById("formAction").value =
                isEdit ? "updateItem" : "addItem";

            if (!isEdit) {
                form.reset();

                const currentImg = document.getElementById("currentImage");
                if (currentImg) {
                    currentImg.src = contextPath + "/images/no-image.png";
                    currentImg.style.display = "block"
                }

                document.getElementById("selectedImages").value = "";
                document.getElementById("imagePreviewContainer").innerHTML = "";

                const fileNameLabel = document.getElementById("imageFileName");
                if (fileNameLabel) fileNameLabel.innerText = "Chưa chọn ảnh";
            }

            modal.style.display = "flex";
        };

        window.closeProductModal = function () {
            document.getElementById("product-modal")?.style.setProperty("display", "none");
        };

        const priceInput = document.getElementById("price");
        const discountInput = document.getElementById("discount");
        const finalPriceInput = document.getElementById("finalPrice");

        function calculateFinalPrice() {
            const price = parseFloat(priceInput?.value) || 0;
            const discount = parseFloat(discountInput?.value) || 0;
            finalPriceInput.value = Math.round(price * (1 - discount / 100));
        }

        priceInput?.addEventListener("input", calculateFinalPrice);
        discountInput?.addEventListener("input", calculateFinalPrice);


        const table = document.querySelector(".product-table");
        if (table) {
            table.addEventListener("dblclick", (e) => {
                const row = e.target.closest("tr[data-id]");
                if (!row) return;

                const id = row.dataset.id;
                editProduct(id);
            });
        }
    });
    function editProduct(id) {
        fetch(`${window.APP_CONTEXT}/quanlysanpham?action=getEditData&id=${id}`)
            .then(res => {
                if (!res.ok) throw new Error("Server error");
                return res.json();
            })
            .then(item => {
                openProductModal(true);

                const form = document.querySelector(".product-form");
                if (!form) return;

                document.getElementById("productId").value = item.id;
                form.name.value = item.name || "";
                form.shortDescription.value = item.short_description || "";
                form.longDescription.value = item.long_description || "";
                form.categoryId.value = item.category_id;
                form.originId.value = item.origin_id;
                form.unitId.value = item.unit_id;
                form.price.value = item.price;
                form.discount.value = item.discount;
                form.sku.value = item.sku || "";
                form.minStock.value = item.min_stock;

                document.getElementById("finalPrice").value =
                    Math.round(item.price * (1 - item.discount / 100));

                if (item.imageUrl) {
                    const container = document.getElementById("imagePreviewContainer");
                    const selectedInput = document.getElementById("selectedImages");

                    container.innerHTML = "";

                    if (item.images && item.images.length > 0) {
                        const names = [];
                        const container = document.getElementById("imagePreviewContainer");
                        const selectedInput = document.getElementById("selectedImages");

                        container.innerHTML = "";

                        item.images.forEach(fileName => {
                            names.push(fileName);

                            const image = document.createElement("img");
                            image.src = contextPath + "/images/" + fileName;
                            image.className = "preview-img";
                            container.appendChild(image);
                        });

                        selectedInput.value = names.join(",");
                        document.getElementById("imageFileName").innerText =
                            `Đang có ${names.length} ảnh`;
                    }



                }

            })
            .catch(err => {
                console.error(err);
                alert("Không thể tải dữ liệu sản phẩm");
            });
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
    function deleteProduct(button, id) {
        if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này không?')) {
            window.location.href = `quanlysanpham?action=delete&id=${id}`;
        }
    }
    function deleteAndKeepPage(id, page) {
        if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này không?')) {
            window.location.href = `quanlysanpham?action=delete&id=${id}&page=${page}`;
        }
    }
