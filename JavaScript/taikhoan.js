document.addEventListener("DOMContentLoaded", () => {
    /**Xử lý thanh tìm kiếm*/
    const openSearchBar = document.getElementById("open-searchBar");
    openSearchBar.addEventListener("click", showSearchBar);
    const closeSearchBarBtn = document.getElementById("close-searchBar");
    closeSearchBarBtn.addEventListener("click", closeSearchBar);

    //thay đổi giao diện khi nhấn vào các link trong sidebar
    changeTab();

    //xử lý việc thay đổi email
    const openChangeEmailModalBtn = document.getElementById("open-change-email-modal");
    openChangeEmailModalBtn.addEventListener("click", () => {
        openModal("change-email");
    });
    const closeChangeEmailModalBtn = document.getElementById("close-change-email-modal");
    closeChangeEmailModalBtn.addEventListener("click", () => {
        closeModal("change-email");
    });
    const saveChangeEmailBtn = document.getElementById("save-email-btn");
    saveChangeEmailBtn.addEventListener("click", () => {
        closeModal("change-email");
    });

    //Xử lý việc thay đổi số điện thoại
    const openChangePhoneNumberBtn = document.getElementById("open-change-phone-number");
    openChangePhoneNumberBtn.addEventListener("click", () => {
        openModal("change-phone-number");
    });
    const closeChangePhoneNumberBtn = document.getElementById("close-change-phone-number-modal");
    closeChangePhoneNumberBtn.addEventListener("click", () => {
        closeModal("change-phone-number");
    });
    const saveChangePhoneNumberBtn = document.getElementById("save-phone-number-btn");
    saveChangePhoneNumberBtn.addEventListener("click", () => {
        closeModal("change-phone-number");
    });
    //Xử lý thay ngày sinh
    const openChangeBirthDayBtn = document.getElementById("open-change-birthday-btn");
    openChangeBirthDayBtn.addEventListener("click", () => {
        openModal("change-birthday");
    });
    const closeChangeBirthDayBtn = document.getElementById("close-change-birthday-modal");
    closeChangeBirthDayBtn.addEventListener("click", () => {
        closeModal("change-birthday");
    });
    const saveChangeBirthDayBtn = document.getElementById("save-birthday-btn");
    saveChangeBirthDayBtn.addEventListener("click", () => {
        closeModal("change-birthday");
    });
    //Lưu thông tin
    const openConfirmSaveInfoModal = document.getElementById("saveInfoBtn");
    openConfirmSaveInfoModal.addEventListener("click", () => {
        openModal("confirm-save-info");
    });
    const closeConfirmSaveInfoModal = document.getElementById("close-confirm-save-info-modal");
    closeConfirmSaveInfoModal.addEventListener("click", () => {
        closeModal("confirm-save-info");
    });
    const confirmSaveInfobtn = document.getElementById("confirm-save-info-btn");
    confirmSaveInfobtn.addEventListener("click", () => {
        closeModal("confirm-save-info");
    });

    //Thêm địa chỉ
    const openAddAddressModal = document.getElementById("open-add-address-modal");
    openAddAddressModal.addEventListener("click", () => {
        document.getElementById("header-address").innerHTML = "Thêm địa chỉ mới";
        openModal("address-modal");
    });
    //Thay đổi địa chỉ
    const openChangeAddressModal = document.querySelectorAll(".open-change-address-modal");
    openChangeAddressModal.forEach(o => {
        o.addEventListener("click", () => {
            document.getElementById("header-address").innerHTML = "Thay đổi địa chỉ";
            openModal("address-modal");
        });
    });
    const closeAddressModal = document.getElementById("close-change-address-modal");
    closeAddressModal.addEventListener("click", () => {
        closeModal("address-modal");
    });
    const saveAddressBtn = document.getElementById("submit-btn");
    saveAddressBtn.addEventListener("click", () => {
        closeModal("address-modal");
    });

    //Lưu thay đổi mật khẩu
    const savePasswordBtn = document.getElementById("save-password-btn");
    savePasswordBtn.addEventListener("click", () => {
        openModal("confirm-save-password");
    });
    const confirmSavePasswordBtn = document.getElementById("confirm-save-password-btn");
    confirmSavePasswordBtn.addEventListener("click", () => {
        window.location.href = "../HTML/dangnhap.html";
    });
    //Xóa tài khoản
    const deleteBtn = document.getElementById("delete-btn");
    deleteBtn.addEventListener("click", () => {
        openModal("delete-account-modal");
    });
    const cancleDeleteAccBtn = document.getElementById("cancle-delete-account-btn");
    cancleDeleteAccBtn.addEventListener("click", () => {
        closeModal("delete-account-modal");
    });
    const closeDeleteAccBtn = document.getElementById("close-delete-account-modal");
    closeDeleteAccBtn.addEventListener("click", () => {
        closeModal("delete-account-modal");
    });
    const confirmDeleteAccBtn = document.getElementById("confirm-delete-account-btn");
    confirmDeleteAccBtn.addEventListener("click", () => {
        closeModal("delete-account-modal");
        openModal("input-password-modal");
    });

    //Nhập mật khẩu để xóa tài khoản
    const closeInputPasswordModal = document.getElementById("close-input-password-modal");
    closeInputPasswordModal.addEventListener("click", () => {
        closeModal("input-password-modal");
    });
    const cancleConfirmPasswordModal = document.getElementById("cancle-confirm-password-btn");
    cancleConfirmPasswordModal.addEventListener("click", () => {
        closeModal("input-password-modal");
    });
    const deleteAccBtn = document.getElementById("confirm-delete-btn");
    deleteAccBtn.addEventListener("click", () => {
        window.alert("Xóa tài khoản thành công. Hệ thống sẽ chuyển hướng về trang chủ.");
        window.location.href = "../HTML/trang_chu_chua_login.html";
    });

    window.addEventListener("click", (e) => {
        if (e.target === document.getElementById("change-email")) {
            closeModal("change-email");
        }
        if (e.target === document.getElementById("change-phone-number")) {
            closeModal("change-phone-number");
        }
        if (e.target === document.getElementById("change-birthday")) {
            closeModal("change-birthday");
        }
        if (e.target === document.getElementById("confirm-save-info")) {
            closeModal("confirm-save-info");
        }
        if (e.target === document.getElementById("address-modal")) {
            closeModal("address-modal");
        }
        if (e.target === document.getElementById("delete-account-modal")) {
            closeModal("delete-account-modal");
        }
        if (e.target === document.getElementById("input-password-modal")) {
            closeModal("input-password-modal");
        }
    });
});

function changeTab(targetId) {
    //1. Lấy tất cả các link trong sidebar
    const sidebarLinks = document.querySelectorAll('#sidebar .sidebar.menu a');
    //2. lây tất cả các nội dung tab
    const tabContents = document.querySelectorAll('.main-content .tab-content');

    function switchTab(targetId) {
        // A. Ẩn tất cả các nội dung tab
        tabContents.forEach(content => {
            content.classList.remove('active');
            content.classList.add('hidden');
        });
        const targetContent = document.querySelector(targetId);
        if (targetContent) {
            targetContent.classList.add('active');
            targetContent.classList.remove('hidden');
        }
        sidebarLinks.forEach(link => {
            // Xóa lớp 'active-link' khỏi tất cả
            link.classList.remove('active-link');
        });
        // Thêm lớp 'active-link' vào link hiện tại
        document.querySelector(`#sidebar .sidebar.menu a[href="${targetId}"]`).classList.add('active-link');
    }

    // 3. Thiết lập sự kiện click cho các liên kết
    sidebarLinks.forEach(link => {
        link.addEventListener('click', function (event) {
            // Ngăn chặn hành vi mặc định của thẻ <a> (chuyển hướng/nhảy trang)
            event.preventDefault();

            const targetId = this.getAttribute('href');

            // Gọi hàm chuyển đổi tab
            switchTab(targetId);
        });
    });

    const initialTarget = sidebarLinks[0].getAttribute('href');
    switchTab(initialTarget);
}

function openModal(id) {
    document.getElementById(id).style.display = 'block';
}

function closeModal(id) {
    document.getElementById(id).style.display = "none";
}

function showSearchBar() {
    const searchBarContainer = document.getElementById("searchBar");
    searchBarContainer.classList.add("active");
    const inputSearchbar = document.getElementById("input-searchBar");
    inputSearchbar.classList.add("active");
    const closeMenuBar = document.getElementById("close-searchBar");
    closeMenuBar.classList.add("active");
}

function closeSearchBar() {
    const searchBarContainer = document.getElementById("searchBar");
    searchBarContainer.classList.remove("active");
    const inputSearchbar = document.getElementById("input-searchBar");
    inputSearchbar.classList.remove("active");
    const closeMenuBar = document.getElementById("close-searchBar");
    closeMenuBar.classList.remove("active");
}