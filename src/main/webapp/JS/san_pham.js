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