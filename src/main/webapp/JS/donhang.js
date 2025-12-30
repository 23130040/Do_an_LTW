document.addEventListener("DOMContentLoaded", () => {
    const tabs = document.querySelectorAll(".tab");
    const groups = document.querySelectorAll(".order-group");

    tabs.forEach(tab => {
        tab.addEventListener("click", () => {
            tabs.forEach(t => t.classList.remove("active"));
            tab.classList.add("active");

            groups.forEach(g => g.classList.add("hidden"));
            document.getElementById(tab.dataset.target).classList.remove("hidden");
        });
    });
});
