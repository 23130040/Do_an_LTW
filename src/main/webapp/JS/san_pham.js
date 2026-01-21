document.addEventListener("DOMContentLoaded", () => {
    const sortBox = document.querySelector(".sort-box");
    if (!sortBox) return;

    const selected = sortBox.querySelector(".sort-selected");
    const items = sortBox.querySelectorAll(".sort-options li");

    selected.addEventListener("click", () => {
        sortBox.classList.toggle("open");
    });

    items.forEach(item => {
        item.addEventListener("click", () => {
            let sortValue = "";

            const text = item.textContent.toLowerCase();

            if (text.includes("tăng")) {
                sortValue = "price_asc";
            } else if (text.includes("giảm")) {
                sortValue = "price_desc";
            }

            updateUrlParam("sort", sortValue);
        });
    });

    document.addEventListener("click", (e) => {
        if (!sortBox.contains(e.target)) {
            sortBox.classList.remove("open");
        }
    });
});

function updateUrlParam(key, value) {
    const url = new URL(window.location.href);

    if (value === "" || value === null) {
        url.searchParams.delete(key);
    } else {
        url.searchParams.set(key, value);
    }

    url.searchParams.set("page", 1);

    window.location.href = url.toString();
}
