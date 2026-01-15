document.addEventListener("DOMContentLoaded", () => {
    const params = new URLSearchParams(window.location.search);
    const tab = params.get("tab") || "ho-so";

    document
        .querySelectorAll("#sidebar .menu a")
        .forEach(a => a.classList.remove("active-link"));

    document
        .querySelector(`#sidebar .menu a[href*="tab=${tab}"]`)
        ?.classList.add("active-link");
});
