// NÚT CỦA PHẦN GIỚI THIỆU
document.addEventListener("DOMContentLoaded", function () {

    // Xử lý nút ĐẶT HÀNG NGAY
    const orderBtn = document.querySelector(".order-btn");
    if (orderBtn) {
        orderBtn.addEventListener("click", function () {
            window.location.href = "../HTML/giohang.html";
        });
    }

    // Xử lý nút "Sản phẩm khuyến mãi"
    const discountBtn = document.querySelector(".discount-btn");
    if (discountBtn) {
        discountBtn.addEventListener("click", function () {
            window.location.href = "../HTML/san_pham.html";
        });
    }

});
