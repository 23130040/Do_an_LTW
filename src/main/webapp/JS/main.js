document.addEventListener("DOMContentLoaded", () => {
    setupSearchBox();
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


