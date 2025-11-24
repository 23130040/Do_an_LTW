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
    const searchInput = document.getElementById("search-input");
    const searchClose = document.getElementById("search-close");
    const cartIcon = document.querySelector(".cart-icon");
    const searchLabel = document.getElementById("search-label");
    const login = document.querySelector(".login");

    // Khi click vào Ô tìm kiếm hoặc icon
    searchLabel.addEventListener("click", () => {
        searchBox.classList.add("active");
        searchInput.focus();
    });

    // Khi bấm dấu X để đóng search
    searchClose.addEventListener("click", () => {
        searchBox.classList.remove("active");
        searchInput.blur();
        cartIcon.style.display = "flex";
        login.style.display = "flex";
    });
}

// Sticky Menu khi cuộn
function setupStickyMenu() {
    const menu = document.getElementById("menu");
    const rightMenu = document.querySelector(".right-section");
    const searchIcon = document.querySelector(".search-icon");
    const cartIcon = document.querySelector(".cart-icon");
    const login = document.querySelector(".login");
    const logo = document.querySelector(".logo");

    window.addEventListener("scroll", () => {
        if (window.scrollY > 100) {
            menu.classList.add("fixed");
            rightMenu.classList.add("fixed");
            searchIcon.classList.add("fixed");
            cartIcon.classList.add("fixed");
            login.classList.add("fixed");
            logo.classList.add("fixed");
        } else {
            menu.classList.remove("fixed");
            rightMenu.classList.remove("fixed");
            searchIcon.classList.remove("fixed");
            cartIcon.classList.remove("fixed");
            login.classList.remove("fixed");
            logo.classList.remove("fixed");
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

// Cuộn ngang trang khi ấn mũi tên trái phải
function scrollToLeft(button) {
    const carousel = button.closest('.product-carousel');
    const list = carousel.querySelector('.product-list');
    list.scrollBy({ left: -300, behavior: 'smooth' });
}

function scrollToRight(button) {
    const carousel = button.closest('.product-carousel');
    const list = carousel.querySelector('.product-list');
    list.scrollBy({ left: 300, behavior: 'smooth' });
}

// PHẦN XỬ LÍ DANH MỤC
document.addEventListener("DOMContentLoaded", () => {
    const categoryButtons = document.querySelectorAll(".category");
    const products = document.querySelectorAll(".product-item");
    const viewAllBtn = document.getElementById("viewAllBtn");
    const customSelect = document.querySelector(".custom-select");
    const selected = customSelect.querySelector(".selected");
    const list = customSelect.querySelector(".select-list");
    const items = list.querySelectorAll("li");
    const realSelect = document.getElementById("sortSelect");

    let currentCategory = "heo";

    function getPrice(product) {
        const text = product.querySelector(".price").textContent;
        const nums = text.split(/[^0-9]+/).filter(s => s !== "");
        return parseInt(nums.join(""));
    }

    function filterProducts(category) {
        products.forEach(p => {
            p.style.display = (p.dataset.category === category) ? "flex" : "none";
        });
    }

    function sortProducts(sortValue) {
        const visibleProducts = Array.from(products).filter(p => p.style.display !== "none");
        visibleProducts.sort((a, b) => {
            const priceA = getPrice(a);
            const priceB = getPrice(b);
            if (sortValue === "up") return priceA - priceB;
            if (sortValue === "down") return priceB - priceA;
            return 0;
        });
        const parent = visibleProducts[0]?.parentNode;
        visibleProducts.forEach(p => parent.appendChild(p));
    }

    // Mặc định
    filterProducts(currentCategory);
    sortProducts("default");

    // Nút danh mục
    categoryButtons.forEach(btn => {
        btn.addEventListener("click", () => {
            categoryButtons.forEach(b => b.classList.remove("active"));
            btn.classList.add("active");
            currentCategory = btn.dataset.category;
            filterProducts(currentCategory);
            sortProducts(realSelect.value);
        });
    });

    // Xem tất cả
    if (viewAllBtn) {
        viewAllBtn.addEventListener("click", () => {
            window.location.href = "../HTML/XemTatCa.html";
        });
    }

    // Custom select
    selected.addEventListener("click", () => {
        customSelect.classList.toggle("open");
    });

    items.forEach(item => {
        item.addEventListener("click", () => {
            selected.textContent = item.textContent;
            realSelect.value = item.dataset.value;
            customSelect.classList.remove("open");
            sortProducts(realSelect.value);
        });
    });

    document.addEventListener("click", (e) => {
        if (!customSelect.contains(e.target)) {
            customSelect.classList.remove("open");
        }
    });
});
