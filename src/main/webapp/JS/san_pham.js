document.addEventListener("DOMContentLoaded", function () {

    const sortBox = document.querySelector(".sort-box");
    if (!sortBox) return;

    const selected = sortBox.querySelector(".sort-selected");
    const options = sortBox.querySelectorAll(".sort-options li");

    selected.addEventListener("click", function (e) {
        e.stopPropagation();
        sortBox.classList.toggle("open");
    });

    options.forEach(option => {
        option.addEventListener("click", function (e) {
            e.stopPropagation();

            const sortValue = option.dataset.sort;
            const sortText = option.textContent.trim();

            selected.textContent = sortText;

            const url = new URL(window.location.href);

            if (!sortValue || sortValue === "default") {
                url.searchParams.delete("sort");
            } else {
                url.searchParams.set("sort", sortValue);
            }

            url.searchParams.set("page", 1);

            window.location.href = url.toString();
        });
    });

    document.addEventListener("click", function () {
        sortBox.classList.remove("open");
    });
});
