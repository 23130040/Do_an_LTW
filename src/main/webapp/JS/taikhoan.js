document.addEventListener("DOMContentLoaded", () => {
    const sidebar = document.getElementById("sidebar");
    if (!sidebar) return;

    const params = new URLSearchParams(window.location.search);
    const tab = params.get("tab") || "ho-so";

    sidebar
        .querySelectorAll(".menu a")
        .forEach(a => a.classList.remove("active-link"));

    const activeLink = sidebar.querySelector(
        `.menu a[href*="tab=${tab}"]`
    );

    if (activeLink) {
        activeLink.classList.add("active-link");
    }
});
