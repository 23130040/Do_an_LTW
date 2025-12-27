// bấm vào ảnh
function changeImage(img) {
    document.getElementById('main-img').src = img.src;
    document.querySelectorAll('.thumb').forEach(t => t.classList.remove('active'));
    img.classList.add('active');
}
// Xử lý chọn khối lượng
const optionButtons = document.querySelectorAll('.option');

optionButtons.forEach(btn => {
    btn.addEventListener('click', () => {
        optionButtons.forEach(b => b.classList.remove('active'));

        btn.classList.add('active');
    });
});
function showSearchBar(){
    const searchBarContainer = document.getElementById("searchBar");
    searchBarContainer.classList.add("active");
    const inputSearchbar = document.getElementById("input-searchBar");
    inputSearchbar.classList.add("active");
    const closeMenuBar = document.getElementById("close-searchBar");
    closeMenuBar.classList.add("active");
}
function closeSearchBar(){
    const searchBarContainer = document.getElementById("searchBar");
    searchBarContainer.classList.remove("active");
    const inputSearchbar = document.getElementById("input-searchBar");
    inputSearchbar.classList.remove("active");
    const closeMenuBar = document.getElementById("close-searchBar");
    closeMenuBar.classList.remove("active");
}
document.addEventListener("DOMContentLoaded", function () {

    /* ========================= XỬ LÝ CHỌN KHỐI LƯỢNG ========================= */
    const optionButtons = document.querySelectorAll('.option');

    optionButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            optionButtons.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
        });
    });

    /* ========================= XỬ LÝ SỐ LƯỢNG + - ========================= */
    const minusBtn = document.querySelector('.qty-btn.minus');
    const plusBtn = document.querySelector('.qty-btn.plus');
    const qtyInput = document.querySelector('.qty input');

    if (minusBtn && plusBtn && qtyInput) {
        minusBtn.addEventListener('click', () => {
            let value = parseInt(qtyInput.value) || 1;
            if (value > 1) qtyInput.value = value - 1;
        });

        plusBtn.addEventListener('click', () => {
            let value = parseInt(qtyInput.value) || 1;
            qtyInput.value = value + 1;
        });
    }

    //Xử lý thanh tìm kiếm
    const openSearchBar = document.getElementById("open-searchBar");
    openSearchBar.addEventListener("click", showSearchBar);
    const closeSearchBarBtn = document.getElementById("close-searchBar");
    closeSearchBarBtn.addEventListener("click", closeSearchBar);
});
// MỞ xem them bình luận
document.querySelector(".see-more").addEventListener("click", function () {
    document.getElementById("comment-popup").style.display = "flex";
});

// ĐÓNG xem thêm bình luận
document.querySelector(".close-popup").addEventListener("click", function () {
    document.getElementById("comment-popup").style.display = "none";
});