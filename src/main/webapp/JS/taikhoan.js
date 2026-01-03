document.addEventListener("DOMContentLoaded", () => {
    const currentPath = window.location.pathname;
    let hasLinkActive = false;

    document.querySelectorAll("#sidebar .menu a").forEach(link => {
        const linkPath = new URL(link.href).pathname;

        if (currentPath === linkPath) {
            link.classList.add("active-link");
            hasLinkActive = true;
        }
    });

    if (!hasLinkActive) {
        const defaultLink = document.querySelector("#sidebar .menu .default-link");
        if (defaultLink) {
            defaultLink.classList.add("active-link");
        }
    }
});
