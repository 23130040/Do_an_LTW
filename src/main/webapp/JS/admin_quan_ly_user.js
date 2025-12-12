document.addEventListener("DOMContentLoaded", () => {

    /* ********************* USER MENU ****************/
    const userMenu = document.getElementById("userMenuContent");
    const notificationPanel = document.getElementById("notification-panel");

    window.toggleUserMenu = function () {
        userMenu.classList.toggle("show");
        notificationPanel.classList.remove("show-panel");
    };

    window.toggleNotificationMenu = function () {
        userMenu.classList.remove("show");
        notificationPanel.classList.toggle("show-panel");
    };

    document.addEventListener("click", (event) => {
        if (!event.target.closest(".user-dropdown") &&
            !event.target.matches(".user-logo")) {
            userMenu.classList.remove("show");
        }

        if (!event.target.closest("#notification-panel") &&
            !event.target.matches(".notification-icon")) {
            notificationPanel.classList.remove("show-panel");
        }
    });


    /* ************* USER MODAL (THÊM / SỬA) **************/
    const userModal = document.getElementById("user-modal");
    const modalTitle = document.getElementById("modal-title-user");
    const userForm = userModal.querySelector(".user-form");

    window.openUserModal = function (isEdit = false, userData = null) {
        userForm.reset();

        if (isEdit && userData) {
            modalTitle.textContent = "Sửa";
            fillUserForm(userData);
        } else {
            modalTitle.textContent = "Thêm";
        }

        userModal.style.display = "flex";
    };

    window.closeUserModal = function () {
        userModal.style.display = "none";
    };

    function fillUserForm(user) {
        userForm.querySelector("input[name='userName']").value = user.name;
        userForm.querySelector("input[name='userEmail']").value = user.email;
        userForm.querySelector("input[name='userPhone']").value = user.phone;
        userForm.querySelector("input[name='userRole']").value = user.role;
        userForm.querySelector("input[name='userPassword']").value = user.password;
    }


    document.querySelector(".control-panel .btn-primary")
        .addEventListener("click", () => openUserModal(false));


    document.addEventListener("click", (e) => {
        if (e.target.closest(".edit-btn")) {
            const btn = e.target.closest(".edit-btn");
            const row = btn.closest("tr");

            const user = {
                id: row.dataset.id,
                name: row.querySelector(".col-name").textContent.trim(),
                email: row.querySelector(".col-email").textContent.trim(),
                phone: row.querySelector(".col-phone").textContent.trim(),
                gender: row.querySelector(".col-gender").textContent.trim(),
                birthday: row.querySelector(".col-birthday").dataset.value,
                role: row.querySelector(".col-role").dataset.value,
                status: row.querySelector(".col-status").dataset.active === "true"
            };

            openUserModal(true, user);
        }
    });


    /* ***************** LỊCH SỬ MUA HÀNG **************/
    const historyModal = document.getElementById("historyModal");

    window.openHistoryModal = function (userId, userName) {
        document.getElementById("historyUserId").textContent = userId;
        historyModal.style.display = "flex";
    };

    window.closeHistoryModal = function () {
        historyModal.style.display = "none";
    };

    document.querySelector(".history-close-btn").addEventListener("click", closeHistoryModal);

    document.addEventListener("click", (event) => {
        if (event.target.closest(".view-history")) {
            const row = event.target.closest("tr");
            const userId = row.querySelector("td:nth-child(1)").textContent.trim();
            const userName = row.querySelector("td:nth-child(2)").textContent.trim();

            openHistoryModal(userId, userName);
        }
    });


    /* *********** ORDER DETAIL MODAL **************/
    const orderDetailModal = document.getElementById("orderDetailModal");

    document.addEventListener("click", (event) => {
        if (event.target.closest(".view-detail")) {
            orderDetailModal.style.display = "block";
        }

        if (event.target.closest("#orderDetailModal .close-btn") ||
            event.target.closest("#orderDetailModal .close-btn-footer")) {

            orderDetailModal.style.display = "none";
        }
    });
});
