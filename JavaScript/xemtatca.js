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
        cartIcon.style.display = "none";
        login.style.display = "none";
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
    const searchIcon = document.querySelector(".search-icon");
    const cartIcon = document.querySelector(".cart-icon");
    const login = document.querySelector(".login");
    const logo = document.querySelector(".logo");

    window.addEventListener("scroll", () => {
        if (window.scrollY > 100) {
            menu.classList.add("fixed");
            searchIcon.classList.add("fixed");
            cartIcon.classList.add("fixed");
            login.classList.add("fixed");
            logo.classList.add("fixed");
        } else {
            menu.classList.remove("fixed");
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

// =================== XỬ LÍ DANH MỤC & SẮP XẾP CHUNG ===================
document.addEventListener("DOMContentLoaded", () => {
    const categoryButtons = document.querySelectorAll(".category");
    const products = document.querySelectorAll(".product-item");
    const customSelect = document.querySelector(".custom-select");
    const selected = customSelect.querySelector(".selected");
    const selectItems = customSelect.querySelectorAll(".select-list li");

    let currentCategory = "all";
    const originalOrder = Array.from(products);

    function getPrice(product) {
        const priceText = product.querySelector(".price .new")?.textContent || "0";
        return parseInt(priceText.replace(/\D/g, ""), 10);
    }

    function filterProducts(category) {
        currentCategory = category;

        products.forEach(p => {
            if (category === "all" || p.dataset.category === category) {
                p.style.display = "flex";
            } else {
                p.style.display = "none";
            }
        });

        sortProducts(selected.dataset.value);
    }

    function sortProducts(sortValue) {
        const parent = document.querySelector(".product-list");
        if (!parent) return;

        const available = Array.from(products)
            .filter(p => p.style.display !== "none" && !p.classList.contains("out-of-stock"));
        const outOfStock = Array.from(products)
            .filter(p => p.style.display !== "none" && p.classList.contains("out-of-stock"));

        if (sortValue === "up") {
            available.sort((a, b) => getPrice(a) - getPrice(b));
        } else if (sortValue === "down") {
            available.sort((a, b) => getPrice(b) - getPrice(a));
        } else if (sortValue === "default") {
            available.sort((a, b) => originalOrder.indexOf(a) - originalOrder.indexOf(b));
        }

        available.forEach(p => parent.appendChild(p));
        outOfStock.forEach(p => parent.appendChild(p));
    }

    categoryButtons.forEach(btn => {
        btn.addEventListener("click", () => {
            categoryButtons.forEach(b => b.classList.remove("active"));
            btn.classList.add("active");
            filterProducts(btn.dataset.category);
        });
    });

    selected.addEventListener("click", () => customSelect.classList.toggle("open"));
    selectItems.forEach(item => {
        item.addEventListener("click", () => {
            selected.textContent = item.textContent;
            selected.dataset.value = item.dataset.value;
            customSelect.classList.remove("open");
            sortProducts(item.dataset.value);
        });
    });

    document.addEventListener("click", e => {
        if (!customSelect.contains(e.target)) customSelect.classList.remove("open");
    });

    filterProducts("all");
});
