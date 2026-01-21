document.addEventListener("DOMContentLoaded", () => {
    const customSelect = document.querySelector(".custom-select");
    if (!customSelect) return;

    const selected = customSelect.querySelector(".selected");
    const items = customSelect.querySelectorAll(".select-list li");

    selected.addEventListener("click", () => {
        customSelect.classList.toggle("open");
    });

    items.forEach(item => {
        item.addEventListener("click", () => {
            const sortValue = item.dataset.value;
            updateUrlParam("sort", sortValue);
        });
    });

    document.addEventListener("click", e => {
        if (!customSelect.contains(e.target)) {
            customSelect.classList.remove("open");
        }
    });
});

function updateUrlParam(key, value) {
    const url = new URL(window.location.href);
    url.searchParams.set(key, value);
    url.searchParams.set("page", 1);
    window.location.href = url.toString();
}
