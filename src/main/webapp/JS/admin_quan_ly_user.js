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

        const userPassword = document.getElementById('userPassword');
        const userConfirmPassword = document.getElementById('userConfirmPassword');
        const userIdHidden = document.getElementById('userIdHidden');

        if (isEdit && userData) {
            modalTitle.textContent = "Sửa";
            fillUserForm(userData);


            userForm.setAttribute('action', USER_API_URL + '?action=update');
            userPassword.placeholder = 'Bỏ trống nếu không muốn đổi';
            userPassword.removeAttribute('required');
            userConfirmPassword.removeAttribute('required');
            userIdHidden.value = userData.id;


        } else {
            modalTitle.textContent = "Thêm";


            userForm.setAttribute('action', USER_API_URL + '?action=add');
            userPassword.placeholder = 'Nhập mật khẩu';
            userPassword.setAttribute('required', 'required');
            userConfirmPassword.setAttribute('required', 'required');
            userIdHidden.value = '';

        }

        userModal.style.display = "flex";
    };

    window.closeUserModal = function () {
        userModal.style.display = "none";
    };
    const USER_API_URL = 'quanlyuser';

    window.editUser = function (id) {

        fetch(USER_API_URL + '?action=edit&id=' + id)
            .then(response => {
                if (!response.ok) {

                    return response.text().then(text => Promise.reject(text));
                }
                return response.json();
            })
            .then(user => {
                console.log("Dữ liệu User từ Servlet:", user);
                openUserModal(true, user);
            })
            .catch(error => {
                console.error('Lỗi khi tải thông tin người dùng:', error);
                alert('Lỗi: Không thể tải thông tin người dùng. Chi tiết: ' + error);
            });
    }

    function fillUserForm(user) {
        document.getElementById('userIdHidden').value = user.id || "";

        document.getElementById('userName').value = user.name || "";
        document.getElementById('userEmail').value = user.email || "";
        document.getElementById('userPhone').value = user.phone || "";

        document.getElementById('userRole').value = user.role || "";

        document.getElementById('userPassword').value = "";
        document.getElementById('userConfirmPassword').value = "";
    }


    document.querySelector(".control-panel .btn-primary")
        .addEventListener("click", () => openUserModal(false));

    window.deleteUser = function (id) {
        if (!confirm(`Bạn có chắc chắn muốn xóa người dùng ID: ${id} không? Thao tác này không thể hoàn tác.`)) {
            return;
        }

        const URL = USER_API_URL + '?action=delete&id=' + id;

        fetch(URL, {
            method: 'DELETE'
        })
            .then(response => {
                if (response.ok) {
                    return response.text();
                } else {
                    return response.text().then(text => Promise.reject(text));
                }
            })
            .then(message => {
                alert("Xóa thành công: " + message);
                window.location.reload();
            })
            .catch(errorText => {
                console.error('Lỗi khi xóa người dùng:', errorText);
                alert('Lỗi: ' + errorText);
            });
    };

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
    const searchInput = document.getElementById('searchInput');
    const roleFilter = document.getElementById('roleFilter');

    function applyFilterAndSearch() {
        const keyword = searchInput.value;
        const role = roleFilter.value;

        let url = 'quanlyuser?';

        if (keyword) {
            url += 'search=' + encodeURIComponent(keyword) + '&';
        }

        url += 'role=' + encodeURIComponent(role) + '&';


        if (url.endsWith('&')) {
            url = url.slice(0, -1);
        }

        window.location.href = url;
    }

    searchInput.addEventListener('input', () => {
        clearTimeout(searchTimeout);

        searchTimeout = setTimeout(applyFilterAndSearch, 500);
    });

    roleFilter.addEventListener('change', applyFilterAndSearch);
    searchInput.addEventListener('keypress', (event) => {
        if (event.key === 'Enter') {
            event.preventDefault();

            if (typeof searchTimeout !== 'undefined') {
                clearTimeout(searchTimeout);
            }

            applyFilterAndSearch();
        }
    });

});
