/* ================= GLOBAL UTILS ================= */
let emailVerified = false;
let searchTimeout = null;
let originalEmail = null;
let isEditMode = false;

function format(number) {
    if (isNaN(number)) return "0đ";
    return Number(number).toLocaleString("vi-VN") + "đ";
}

function formatDateVN(dateStr) {
    if (!dateStr) return "";
    const d = new Date(dateStr);
    if (isNaN(d)) return "";
    return d.toLocaleDateString("vi-VN");
}

function getStatusClass(status) {
    switch (status) {
        case "Chờ xác nhận": return "status-pending-bg";
        case "Đang giao": return "status-shipping-bg";
        case "Đã giao": return "status-delivered-bg";
        case "Đã hủy": return "status-cancelled-bg";
        default: return "bg-secondary";
    }
}

/* ================= DOM READY ================= */
document.addEventListener("DOMContentLoaded", () => {

    /* ================= USER MENU ================= */
    const userMenu = document.getElementById("userMenuContent");
    const notificationPanel = document.getElementById("notification-panel");

    window.toggleUserMenu = () => {
        userMenu?.classList.toggle("show");
        notificationPanel?.classList.remove("show-panel");
    };

    window.toggleNotificationMenu = () => {
        userMenu?.classList.remove("show");
        notificationPanel?.classList.toggle("show-panel");
    };

    document.addEventListener("click", e => {
        if (!e.target.closest(".user-dropdown") && !e.target.matches(".user-logo")) {
            userMenu?.classList.remove("show");
        }
        if (!e.target.closest("#notification-panel") && !e.target.matches(".notification-icon")) {
            notificationPanel?.classList.remove("show-panel");
        }
    });

    /* ================= USER MODAL ================= */
    const userModal = document.getElementById("user-modal");
    const userForm = userModal.querySelector(".user-form");
    const USER_API_URL = "quan-ly-nguoi-dung";

    window.openUserModal = (edit = false, user = null) => {
        userForm.reset();

        isEditMode = edit;
        emailVerified = false;
        originalEmail = null;

        const btnSendOTP = document.getElementById("btnSendOTP");

        if (edit && user) {
            document.getElementById("modal-title-user").innerText = "Sửa";
            fillUserForm(user);

            originalEmail = user.email;
            emailVerified = true;
            btnSendOTP.disabled = true;

            userForm.formAction.value = "update";
            userForm.userPassword.required = false;
            userForm.userConfirmPassword.required = false;
        } else {
            document.getElementById("modal-title-user").innerText = "Thêm";

            btnSendOTP.disabled = false;
            userForm.formAction.value = "add";
            userForm.userPassword.required = true;
            userForm.userConfirmPassword.required = true;
        }

        userModal.style.display = "flex";
    };

    window.closeUserModal = () => userModal.style.display = "none";

    window.editUser = id => {
        fetch(`${USER_API_URL}?action=edit&id=${id}`)
            .then(r => r.json())
            .then(user => openUserModal(true, user))
            .catch(() => showToast("Không thể tải user", "danger"));
    };

    function fillUserForm(user) {
        userForm.userIdHidden.value = user.id || "";
        userForm.userName.value = user.name || "";
        userForm.userEmail.value = user.email || "";
        if(user.phone === null || user.phone === "null") {
            user.phone = "";
        }
        userForm.userPhone.value = user.phone;
        userForm.userRole.value = user.role || "";
        userForm.userPassword.value = "";
        userForm.userConfirmPassword.value = "";
    }

    /* ================= DELETE USER ================= */
    let userIdToDelete = null;
    const deleteModal = new bootstrap.Modal(
        document.getElementById("deleteConfirmModal")
    );

    window.deleteUser = id => {
        userIdToDelete = id;
        deleteModal.show();
    };

    document.getElementById("btnConfirmDelete").addEventListener("click", () => {
        if (!userIdToDelete) return;

        fetch(`${USER_API_URL}?action=delete&id=${userIdToDelete}`, { method: "DELETE" })
            .then(r => r.text())
            .then(r => {
                if (r.trim() === "SUCCESS") {
                    showToast("Xóa thành công", "success");
                    setTimeout(() => location.reload(), 500);
                } else {
                    showToast("Xóa thất bại", "danger");
                }
            });
    });

    /* ================= OTP ================= */
    const btnSendOTP = document.getElementById("btnSendOTP");
    const btnVerifyOTP = document.getElementById("btnVerifyOTP");

    btnSendOTP.addEventListener("click", () => {
        const email = userForm.userEmail.value.trim();
        if (!email) return showToast("Vui lòng nhập email", "warning");

        fetch("send-otp", {
            method: "POST",
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            body: "email=" + encodeURIComponent(email)
        })
            .then(r => r.text())
            .then(r => {
                if (r === "OK") showToast("OTP đã gửi", "success");
                else showToast("Không thể gửi OTP", "danger");
            });
    });

    btnVerifyOTP.addEventListener("click", () => {
        const otp = userForm.userOTP.value.trim();
        if (!otp) return;

        fetch("verify-otp", {
            method: "POST",
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            body: `otp=${otp}&email=${encodeURIComponent(userForm.userEmail.value)}`
        })
            .then(r => r.text())
            .then(r => {
                if (r === "OK") {
                    emailVerified = true;
                    userForm.userEmail.readOnly = true;
                    showToast("Xác thực thành công", "success");
                } else {
                    showToast("OTP không đúng", "danger");
                }
            });
    });

    userForm.userEmail.addEventListener("input", () => {
        const email = userForm.userEmail.value.trim();
        btnSendOTP.disabled = isEditMode && email === originalEmail;
        emailVerified = isEditMode && email === originalEmail;
    });

    /* ================= SUBMIT ================= */
    userForm.addEventListener("submit", e => {
        e.preventDefault();

        const action = userForm.formAction.value;
        const email = userForm.userEmail.value.trim();
        const password = userForm.userPassword.value.trim();
        const confirm = userForm.userConfirmPassword.value.trim();
        const phone = userForm.userPhone.value.trim();

        if (isEditMode && email !== originalEmail && !emailVerified) {
            return showToast("Email mới chưa xác thực OTP", "warning");
        }

        if (action === "add") {
            if (!password || password.length < 8)
                return showToast("Mật khẩu tối thiểu 8 ký tự", "warning");
            if (password !== confirm)
                return showToast("Mật khẩu không khớp", "warning");
        }

        if (action === "update" && password) {
            if (password.length < 8)
                return showToast("Mật khẩu tối thiểu 8 ký tự", "warning");
            if (password !== confirm)
                return showToast("Mật khẩu không khớp", "warning");
        }

        if (!phone || !/^0\d{9}$/.test(phone))
            return showToast("Số điện thoại không hợp lệ", "warning");

        fetch(USER_API_URL, {
            method: "POST",
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            body: new URLSearchParams(new FormData(userForm))
        })
            .then(r => r.text())
            .then(r => {
                if (r.trim() === "SUCCESS") {
                    showToast("Thành công", "success");
                    setTimeout(() => location.reload(), 800);
                } else {
                    showToast(r, "danger");
                }
            });
    });

    /* ================= SEARCH ================= */
    const searchInput = document.getElementById("searchInput");
    const roleFilter = document.getElementById("roleFilter");

    function applyFilter() {
        const url = new URL(location.href);
        url.searchParams.set("search", searchInput.value);
        url.searchParams.set("role", roleFilter.value);
        location.href = url;
    }

    searchInput?.addEventListener("input", () => {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(applyFilter, 400);
    });

    roleFilter?.addEventListener("change", applyFilter);

    document.addEventListener("click", e => {
        const historyBtn = e.target.closest(".view-history");
        if (historyBtn) openHistoryModal(historyBtn.dataset.id);

        const detailBtn = e.target.closest(".view-detail");
        if (detailBtn) openOrderDetailModal(detailBtn.dataset);
    });
});

/* ================= HISTORY MODAL ================= */
function openHistoryModal(userId) {
    const modal = document.getElementById("historyModal");
    const tbody = modal.querySelector("tbody");
    modal.style.display = "flex";
    document.getElementById("historyUserId").innerText = "#" + userId;

    tbody.innerHTML = `<tr><td colspan="5" class="text-center">Đang tải...</td></tr>`;

    fetch(`admin/user-orders?userId=${userId}`)
        .then(r => r.json())
        .then(list => {
            tbody.innerHTML = "";
            if (!list.length) {
                tbody.innerHTML = `<tr><td colspan="5">Chưa có đơn</td></tr>`;
                return;
            }

            list.forEach(o => {
                tbody.insertAdjacentHTML("beforeend", `
                    <tr>
                        <td>${o.id}</td>
                        <td>${formatDateVN(o.created_at)}</td>
                        <td>${format(o.total_price)}</td>
                        <td><span class="badge ${getStatusClass(o.status)}">${o.status}</span></td>
                        <td>
                            <button class="btn-sm view-detail"
                                data-id="${o.id}"
                                data-status="${o.status}"
                                data-date="${o.created_at}"
                                data-customer="${o.user.name}"
                                data-phone="${o.user.phone ? o.user.phone : 'Chưa có'}"
                                data-address="${o.address.address}"
                                data-total="${o.total_price}">
                                <i class="fas fa-eye"></i>
                            </button>
                        </td>
                    </tr>
                `);
            });
        });
}

/* ================= ORDER DETAIL ================= */
function openOrderDetailModal(order) {
    const modal = document.getElementById("orderDetailModal");
    modal.style.display = "flex";

    document.getElementById("modalOrderId").innerText = "#" + order.id;
    document.getElementById("modalOrderStatus").innerText = order.status;
    document.getElementById("modalOrderDate").innerText = formatDateVN(order.date);
    document.getElementById("modalCustomerName").innerText = order.customer;
    document.getElementById("modalCustomerPhone").innerText = order.phone;
    document.getElementById("modalShippingAddress").innerText = order.address;
    document.getElementById("modalGrandTotal").innerText = format(order.total);

    loadOrderItems(order.id);
}

function loadOrderItems(orderId) {
    const tbody = document.getElementById("modalProductList");
    tbody.innerHTML = `<tr><td colspan="4" class="text-center">Đang tải...</td></tr>`;

    fetch(`${CONTEXT_PATH}/OrderDetailServlet?id=${orderId}`)
        .then(r => {
            if (!r.ok) throw new Error('Network response was not ok');
            return r.json();
        })
        .then(list => {
            tbody.innerHTML = "";
            if (!list || list.length === 0) {
                tbody.innerHTML = `<tr><td colspan="4" class="text-center">Không có sản phẩm nào.</td></tr>`;
                return;
            }
            list.forEach(i => {
                const itemName = i.item ? i.item.name : "Sản phẩm không tên";

                tbody.insertAdjacentHTML("beforeend", `
                    <tr>
                        <td>${itemName}</td>
                        <td>${format(i.price)}</td>
                        <td>${i.quantity}</td>
                        <td>${format(i.price * i.quantity)}</td>
                    </tr>
                `);
            });
        })
        .catch(err => {
            console.error("Lỗi load sản phẩm:", err);
            tbody.innerHTML = `<tr><td colspan="4" class="text-center text-danger">Lỗi tải dữ liệu</td></tr>`;
        });
}
document.addEventListener("click", e => {

    // Đóng Order Detail Modal
    const closeOrderBtn = e.target.closest(
        "#orderDetailModal .close-btn, #orderDetailModal .close-btn-footer"
    );
    if (closeOrderBtn) {
        closeOrderDetailModal();
        return;
    }

    // Đóng History Modal
    const closeHistoryBtn = e.target.closest(
        "#historyModal .close-btn, #historyModal .close-btn-footer"
    );
    if (closeHistoryBtn) {
        closeHistoryModal();
    }
});
function closeHistoryModal() {
    const modal = document.getElementById("historyModal");
    if (!modal) return;

    modal.style.display = "none";

    const tbody = modal.querySelector("tbody");
    if (tbody) tbody.innerHTML = "";
}


function closeOrderDetailModal() {
    const modal = document.getElementById("orderDetailModal");
    if (!modal) return;

    modal.style.display = "none";

    document.getElementById("modalProductList").innerHTML = "";
}

/* ================= TOAST ================= */
function showToast(msg, type = "info") {
    const toastEl = document.getElementById("appToast");
    toastEl.className = `toast text-bg-${type}`;
    document.getElementById("toastMessage").innerText = msg;
    new bootstrap.Toast(toastEl, {delay: 3000}).show();
}

window.toggleStatus = function(userId, isChecked) {
    const params = new URLSearchParams();
    params.append('action', 'updateStatus');
    params.append('id', userId);
    params.append('status', isChecked);

    fetch('quan-ly-nguoi-dung', {
        method: 'POST',
        body: params,
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        }
    })
        .then(response => response.text())
        .then(data => {
            if (data.trim() === "SUCCESS") {
                showToast("Cập nhật trạng thái thành công", "success");
            } else {
                showToast("Lỗi khi cập nhật trạng thái", "danger");
                setTimeout(() => location.reload(), 1000);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showToast("Lỗi kết nối máy chủ", "danger");
        });
};