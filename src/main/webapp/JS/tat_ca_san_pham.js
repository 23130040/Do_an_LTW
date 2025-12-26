
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