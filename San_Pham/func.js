document.addEventListener("scroll", () => {
    const menu = document.querySelector(".menu");
    const bannerHeight = document.querySelector(".banner").offsetHeight;

    if (window.scrollY > bannerHeight - 150) {
        menu.classList.add("fixed");
    } else {
        menu.classList.remove("fixed");
    }

});