// Hàm import HTML vào phần tử chỉ định
function includeHTML(selector, filePath, callback) {
    fetch(filePath)
        .then(res => res.text())
        .then(html => {
            document.querySelector(selector).innerHTML = html;
            if (callback) callback();
        });
}

// Gắn sự kiện tìm kiếm
function setupSearchBox() {
    const searchBox = document.getElementById("searchBox");
    const label = document.getElementById("search-label");
    const input = document.getElementById("search-input");
    const closeBtn = document.getElementById("search-close");

    if (!searchBox || !label || !input || !closeBtn) return;

    label.addEventListener("click", () => {
        searchBox.classList.add("active");
        input.focus();
    });

    closeBtn.addEventListener("click", (e) => {
        e.stopPropagation();
        searchBox.classList.remove("active");
        input.value = "";
    });
}

// Sticky Menu khi cuộn
function setupStickyMenu() {
    const menu = document.getElementById("menu");
    const searchIcon = document.querySelector(".search-icon");
    const cartIcon = document.querySelector(".cart-icon");

    window.addEventListener("scroll", () => {
        if (window.scrollY > 100) {
            menu.classList.add("fixed");
            searchIcon.classList.add("fixed");
            cartIcon.classList.add("fixed");
        } else {
            menu.classList.remove("fixed");
            searchIcon.classList.remove("fixed");
            cartIcon.classList.remove("fixed");
        }
    });
}

// Đợi DOM load xong rồi mới chạy
document.addEventListener("DOMContentLoaded", () => {
    setupSearchBox();
    setupStickyMenu();
});


// Import header → xong rồi mới gắn sự kiện vào
includeHTML("#header-container", "header.html", () => {
    setupSearchBox();
    setupStickyMenu();
});

// Footer import bình thường
includeHTML("#footer-container", "footer.html");

function updateBannerFromAttributes() {
    const container = document.querySelector("#banner-container");
    if (!container) return;

    const title = container.dataset.bannerTitle;
    const desc = container.dataset.bannerDesc;

    if (title) document.getElementById("greet-title").textContent = title;
    if (desc) document.getElementById("greet-desc").textContent = desc;
}


// Banner import nếu cần
includeHTML("#banner-container", "banner.html", () => {
    updateBannerFromAttributes();
});

