document.addEventListener("DOMContentLoaded", () => {
    setupSearchBox();
    setupStickyMenu();
});

// Gắn sự kiện tìm kiếm
function setupSearchBox() {
    const openSearchBarBtn = document.getElementById("open-searchBar");
    openSearchBarBtn.addEventListener("click", () => {
        inputSearchBar.classList.add("active");
        closeSearchBar.classList.add("active");
    });
    const inputSearchBar = document.getElementById("input-searchBar");
    const closeSearchBar = document.getElementById("close-searchBar");
    closeSearchBar.addEventListener("click", () => {
        inputSearchBar.classList.remove("active");
        closeSearchBar.classList.remove("active");
    });
}

// Sticky Menu khi cuộn
function setupStickyMenu() {
    const menu = document.getElementById("home-menu");

    window.addEventListener("scroll", () => {
        if (window.scrollY > 100) {
            menu.classList.remove("home");
        }else{
            menu.classList.add("home");
        }
    });
}
