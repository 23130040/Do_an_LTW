// Gắn sự kiện tìm kiếm
function setupSearchBox() {
    const searchBox = document.getElementById("searchBox");
    const searchInput = document.getElementById("search-input");
    const searchClose = document.getElementById("search-close");
    const cartIcon = document.querySelector(".cart-icon");
    const searchLabel = document.getElementById("search-label");
    const userIcon = document.querySelector(".user-icon");


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
        userIcon.style.display = "flex";
    });
}

// Sticky Menu khi cuộn
function setupStickyMenu() {
    const menu = document.getElementById("menu");
    const searchIcon = document.querySelector(".search-icon");
    const cartIcon = document.querySelector(".cart-icon");
    const userIcon = document.querySelector(".user-icon");
    const logo = document.querySelector(".logo");

    window.addEventListener("scroll", () => {
        if (window.scrollY > 100) {
            menu.classList.add("fixed");
            searchIcon.classList.add("fixed");
            cartIcon.classList.add("fixed");
            userIcon.classList.add("fixed");
            logo.classList.add("fixed");
        } else {
            menu.classList.remove("fixed");
            searchIcon.classList.remove("fixed");
            cartIcon.classList.remove("fixed");
            userIcon.classList.remove("fixed");
            logo.classList.remove("fixed");
        }
    });
}

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

// ===== Dropdown menu cho user icon =====
function setupUserMenu() {
    const userIcon = document.querySelector(".user-icon");
    const userMenu = document.getElementById("user-menu");

    if (!userIcon || !userMenu) return;

    // Khi click vào icon user
    userIcon.addEventListener("click", (e) => {
        e.stopPropagation();
        userMenu.classList.toggle("show");
    });

    // Click ra ngoài thì ẩn menu
    document.addEventListener("click", (e) => {
        if (!userIcon.contains(e.target)) {
            userMenu.classList.remove("show");
        }
    });
}

document.addEventListener("DOMContentLoaded", () => {
    setupSearchBox();
    setupStickyMenu();
    setupUserMenu();
});





