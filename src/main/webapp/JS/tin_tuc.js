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

    const openSearchBar = document.getElementById("open-searchBar");
    openSearchBar.addEventListener("click", showSearchBar);
    const closeSearchBarBtn = document.getElementById("close-searchBar");
    closeSearchBarBtn.addEventListener("click", closeSearchBar);
});