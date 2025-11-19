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
    list.scrollBy({left: 300, behavior: 'smooth'});
}
// bấm vào ảnh
function changeImage(img) {
    document.getElementById('main-img').src = img.src;
    document.querySelectorAll('.thumb').forEach(t => t.classList.remove('active'));
    img.classList.add('active');
}
// Xử lý chọn khối lượng
const optionButtons = document.querySelectorAll('.option');

optionButtons.forEach(btn => {
    btn.addEventListener('click', () => {
        optionButtons.forEach(b => b.classList.remove('active'));

        btn.classList.add('active');
    });
});
document.addEventListener("DOMContentLoaded", function () {

    /* ========================= XỬ LÝ CHỌN KHỐI LƯỢNG ========================= */
    const optionButtons = document.querySelectorAll('.option');

    optionButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            optionButtons.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
        });
    });

    /* ========================= XỬ LÝ SỐ LƯỢNG + - ========================= */
    const minusBtn = document.querySelector('.qty-btn.minus');
    const plusBtn = document.querySelector('.qty-btn.plus');
    const qtyInput = document.querySelector('.qty input');

    if (minusBtn && plusBtn && qtyInput) {
        minusBtn.addEventListener('click', () => {
            let value = parseInt(qtyInput.value) || 1;
            if (value > 1) qtyInput.value = value - 1;
        });

        plusBtn.addEventListener('click', () => {
            let value = parseInt(qtyInput.value) || 1;
            qtyInput.value = value + 1;
        });
    }

});
// MỞ xem them bình luận
document.querySelector(".see-more").addEventListener("click", function () {
    document.getElementById("comment-popup").style.display = "flex";
});

// ĐÓNG xem thêm bình luận
document.querySelector(".close-popup").addEventListener("click", function () {
    document.getElementById("comment-popup").style.display = "none";
});
