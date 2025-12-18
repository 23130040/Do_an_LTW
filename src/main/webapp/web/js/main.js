// Gắn sự kiện tìm kiếm
function setupSearchBox() {
    const searchBox = document.getElementById("searchBox");
    const searchInput = document.getElementById("search-input");
    const searchClose = document.getElementById("search-close");
    const cartIcon = document.querySelector(".cart-icon");
    const searchLabel = document.getElementById("search-label");
    const login = document.querySelector(".login");

    if (!searchBox || !searchInput || !searchClose || !searchLabel || !cartIcon || !login) return;

    // Khi click vào ô tìm kiếm hoặc icon
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

    if (!menu || !searchIcon || !cartIcon || !login || !logo) return;

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

// ================================
// CHUNG CHO PAGE RIÊNG (gioithieu.jsp)
// ================================

// Hiệu ứng thanh tìm kiếm nhỏ (nếu có)
function showSearchBar(){
    const searchBarContainer = document.getElementById("searchBar");
    const inputSearchbar = document.getElementById("input-searchBar");
    const closeMenuBar = document.getElementById("close-searchBar");

    if(!searchBarContainer || !inputSearchbar || !closeMenuBar) return;

    searchBarContainer.classList.add("active");
    inputSearchbar.classList.add("active");
    closeMenuBar.classList.add("active");
}

function closeSearchBar(){
    const searchBarContainer = document.getElementById("searchBar");
    const inputSearchbar = document.getElementById("input-searchBar");
    const closeMenuBar = document.getElementById("close-searchBar");

    if(!searchBarContainer || !inputSearchbar || !closeMenuBar) return;

    searchBarContainer.classList.remove("active");
    inputSearchbar.classList.remove("active");
    closeMenuBar.classList.remove("active");
}

// Cuộn ngang carousel
function scrollToLeft(button) {
    const carousel = button.closest('.product-carousel');
    if(!carousel) return;
    const list = carousel.querySelector('.product-list');
    if(list) list.scrollBy({ left: -300, behavior: 'smooth' });
}

function scrollToRight(button) {
    const carousel = button.closest('.product-carousel');
    if(!carousel) return;
    const list = carousel.querySelector('.product-list');
    if(list) list.scrollBy({ left: 300, behavior: 'smooth' });
}

// Cập nhật banner nếu cần
function updateBannerFromAttributes() {
    const container = document.querySelector("#banner-container");
    if (!container) return;

    const title = container.dataset.bannerTitle;
    const desc = container.dataset.bannerDesc;

    if (title) {
        const greetTitle = document.getElementById("greet-title");
        if(greetTitle) greetTitle.textContent = title;
    }

    if (desc) {
        const greetDesc = document.getElementById("greet-desc");
        if(greetDesc) greetDesc.textContent = desc;
    }
}

