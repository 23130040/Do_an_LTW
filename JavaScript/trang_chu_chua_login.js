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

