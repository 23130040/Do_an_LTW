function toggleUserMenu() {
    const menu = document.getElementById("userMenuContent");
    if (menu) menu.classList.toggle("show");
}

function toggleNotificationMenu() {
    const userDropdown = document.getElementById("userMenuContent");
    const notificationPanel = document.getElementById("notification-panel");

    if (userDropdown) userDropdown.classList.remove("show");
    if (notificationPanel) notificationPanel.classList.toggle("show-panel");
}

// Đóng menu khi click ra ngoài
window.addEventListener('click', function(event) {
    const userDropdown = document.getElementById("userMenuContent");
    const notificationPanel = document.getElementById("notification-panel");

    if (userDropdown && !event.target.closest('.user-dropdown') && !event.target.matches('.user-logo')) {
        userDropdown.classList.remove("show");
    }

    if (notificationPanel && !event.target.closest('#notification-panel') && !event.target.matches('.notification-icon')) {
        notificationPanel.classList.remove("show-panel");
    }
});

function openTab(evt, tabName) {
    const tabcontent = document.getElementsByClassName("tab-content");
    for (let i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
        tabcontent[i].classList.remove("active");
    }

    const tablinks = document.getElementsByClassName("tab-link");
    for (let i = 0; i < tablinks.length; i++) {
        tablinks[i].classList.remove("active");
    }

    const activeTab = document.getElementById(tabName);
    if (activeTab) {
        activeTab.style.display = "block";
        activeTab.classList.add("active");
    }

    if (evt && evt.currentTarget) {
        evt.currentTarget.classList.add("active");
    } else {
        // Trường hợp gọi từ URL (không có sự kiện click)
        for (let link of tablinks) {
            if (link.getAttribute("onclick").includes(tabName)) {
                link.classList.add("active");
            }
        }
    }
}

document.addEventListener("DOMContentLoaded", function() {
    const urlParams = new URLSearchParams(window.location.search);
    const tabParam = urlParams.get('tab');

    if (tabParam) {
        openTab(null, tabParam);
    } else {
        openTab(null, "QuanLyDanhMuc");
    }

    if (tabParam === 'QuanLyNguonGoc' && typeof changePage === "function") {
        changePage(0);
    }
});

window.openModal = function(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) modal.style.display = 'flex';
};

window.closeModal = function(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) modal.style.display = 'none';
};
function deleteCategory(id) {
    if (confirm("Bạn có chắc chắn muốn xóa danh mục này?")) {
        window.location.href = "quan-ly-danh-muc?action=delete&id=" + id;
    }
}

function deleteOrigin(id) {
    if (confirm("Bạn có chắc chắn muốn xóa nguồn gốc này?")) {
        // Gọi đến OriginServlet
        window.location.href = "quan-ly-nguon-goc?action=delete&id=" + id;
    }
}