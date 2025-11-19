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
//tin tuc 1 2
document.addEventListener("DOMContentLoaded", function () {
    const pages = document.querySelectorAll(".page-content");
    const pageButtons = document.querySelectorAll(".page");
    const prevBtn = document.querySelector(".prev");
    const nextBtn = document.querySelector(".next");
    let currentPage = 1;
    const totalPages = pages.length;

    // Hàm hiển thị trang theo số
    function showPage(pageNumber) {
        pages.forEach(page => {
            page.style.display = (page.dataset.page == pageNumber) ? "grid" : "none";
        });

        pageButtons.forEach(btn => {
            btn.classList.toggle("active", btn.dataset.page == pageNumber);
        });

        currentPage = pageNumber;
    }

    // Gán sự kiện cho các nút số
    pageButtons.forEach(btn => {
        btn.addEventListener("click", function (e) {
            e.preventDefault();
            const page = parseInt(this.dataset.page);
            showPage(page);
        });
    });

    // Nút "prev"
    prevBtn.addEventListener("click", function (e) {
        e.preventDefault();
        if (currentPage > 1) {
            showPage(currentPage - 1);
        }
    });

    // Nút "next"
    nextBtn.addEventListener("click", function (e) {
        e.preventDefault();
        if (currentPage < totalPages) {
            showPage(currentPage + 1);
        }
    });

    // Hiển thị trang đầu tiên mặc định
    showPage(1);
});
