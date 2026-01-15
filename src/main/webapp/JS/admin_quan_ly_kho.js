function toggleUserMenu() {
    const userMenu = document.getElementById("userMenuContent");
    if (userMenu) {
        userMenu.classList.toggle("show");
    }
}

function toggleNotificationMenu() {
    const userMenu = document.getElementById("userMenuContent");
    const notificationPanel = document.getElementById("notification-panel");

    if (userMenu) {
        userMenu.classList.remove("show");
    }

    if (notificationPanel) {
        notificationPanel.classList.toggle("show-panel");
    }
}

function openTab(evt, tabName) {
    const tabContents = document.getElementsByClassName("tab-content");
    const tabLinks = document.getElementsByClassName("tab-link");

    for (let i = 0; i < tabContents.length; i++) {
        tabContents[i].style.display = "none";
    }

    for (let i = 0; i < tabLinks.length; i++) {
        tabLinks[i].classList.remove("active");
    }

    const targetTab = document.getElementById(tabName);
    if (targetTab) {
        targetTab.style.display = "block";
    }

    if (evt && evt.currentTarget) {
        evt.currentTarget.classList.add("active");
    }
}

function openStockModal(type) {
    const modal = document.getElementById("stockAdjustmentModal");
    const title = document.getElementById("stockModalTitle");
    const typeSelect = document.getElementById("type");

    if (!modal) return;

    if (title) {
        title.innerText = type === "input" ? "Tạo Phiếu Nhập Kho" : "Tạo Phiếu Xuất Kho";
    }

    if (typeSelect) {
        typeSelect.value = type === "input" ? "Nhap" : "Xuat";
    }

    modal.style.display = "block";

    $('.select2-enable').select2({
        placeholder: "-- Gõ mã SKU hoặc tên sản phẩm --",
        allowClear: true,
        width: '100%',
        dropdownParent: $('#stockAdjustmentModal')
    });
}

function closeStockModal() {
    const modal = document.getElementById("stockAdjustmentModal");
    if (modal) {
        modal.style.display = "none";
    }
}

window.addEventListener("click", function (event) {
    const userMenu = document.getElementById("userMenuContent");
    const notificationPanel = document.getElementById("notification-panel");
    const modal = document.getElementById("stockAdjustmentModal");

    if (
        userMenu &&
        userMenu.classList.contains("show") &&
        !event.target.closest(".user-dropdown") &&
        !event.target.matches(".user-logo")
    ) {
        userMenu.classList.remove("show");
    }

    if (
        notificationPanel &&
        notificationPanel.classList.contains("show-panel") &&
        !event.target.closest("#notification-panel") &&
        !event.target.matches(".notification-icon")
    ) {
        notificationPanel.classList.remove("show-panel");
    }

});

document.addEventListener("DOMContentLoaded", function () {
    const urlParams = new URLSearchParams(window.location.search);
    const tabParam = urlParams.get('tab');

    if (tabParam) {
        if (tabParam === 'input_history') {
            document.querySelector(".tab-link[onclick*='input_history']").click();
        } else if (tabParam === 'output_history') {
            document.querySelector(".tab-link[onclick*='output_history']").click();
        }
    } else {
        const firstTab = document.querySelector(".tab-link");
        if (firstTab) {
            firstTab.click();
        }
    }
});
document.getElementById("stockForm").addEventListener("submit", function(e) {
    const qty = document.getElementById("quantity").value;
    const item = document.getElementById("item_id").value;

    if (!item || qty <= 0) {
        e.preventDefault();
        alert("Vui lòng nhập đầy đủ thông tin sản phẩm và số lượng hợp lệ!");
    }
});