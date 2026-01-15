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

    if (modal && event.target === modal) {
        closeStockModal();
    }
});

document.addEventListener("DOMContentLoaded", function () {
    const firstTab = document.querySelector(".tab-link");
    if (firstTab) {
        firstTab.click();
    }
});
