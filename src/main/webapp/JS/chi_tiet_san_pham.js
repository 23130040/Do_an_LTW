document.addEventListener("DOMContentLoaded", function () {

    /* ========================= BIẾN CHUNG ========================= */
    const optionButtons = document.querySelectorAll(".option");
    const priceEl = document.getElementById("product-price");
    const itemIdInput = document.getElementById("cart-item-id");

    const minusBtn = document.querySelector(".qty-minus");
    const plusBtn = document.querySelector(".qty-plus");
    const qtyInput = document.getElementById("qty-input");
    const hiddenQty = document.getElementById("cart-qty");

    let basePrice = 0;

    /* ========================= FORMAT GIÁ ========================= */
    function formatPrice(price) {
        return Number(price).toLocaleString("vi-VN") + "đ";
    }

    /* ========================= UPDATE GIÁ + QTY ========================= */
    function updatePriceAndQty() {
        let qty = parseInt(qtyInput.value);
        if (isNaN(qty) || qty < 1) qty = 1;

        qtyInput.value = qty;
        hiddenQty.value = qty;

        priceEl.innerText = formatPrice(basePrice * qty);
    }

    /* ========================= CHỌN KHỐI LƯỢNG ========================= */
    function applyOption(btn) {
        if (!btn || btn.classList.contains("disabled")) return;

        optionButtons.forEach(b => b.classList.remove("active"));
        btn.classList.add("active");

        const price = btn.dataset.price;
        const itemId = btn.dataset.itemId;

        if (price) basePrice = parseInt(price);
        if (itemId) itemIdInput.value = itemId;

        qtyInput.value = 1;
        hiddenQty.value = 1;

        updatePriceAndQty();
    }

    optionButtons.forEach(btn => {
        btn.addEventListener("click", function () {
            applyOption(this);
        });
    });

    /* ========================= INIT BAN ĐẦU ========================= */
    const activeBtn =
        document.querySelector(".option.active:not(.disabled)") ||
        document.querySelector(".option:not(.disabled)");

    if (activeBtn) {
        basePrice = parseInt(activeBtn.dataset.price || 0);
        itemIdInput.value = activeBtn.dataset.itemId || itemIdInput.value;
        updatePriceAndQty();
    }

    /* ========================= + / - SỐ LƯỢNG ========================= */
    if (minusBtn && plusBtn && qtyInput && hiddenQty) {

        minusBtn.addEventListener("click", function () {
            let val = parseInt(qtyInput.value) || 1;
            if (val > 1) {
                qtyInput.value = val - 1;
                updatePriceAndQty();
            }
        });

        plusBtn.addEventListener("click", function () {
            let val = parseInt(qtyInput.value) || 1;
            qtyInput.value = val + 1;
            updatePriceAndQty();
        });

        qtyInput.addEventListener("input", function () {
            updatePriceAndQty();
        });
    }
    function addToCart(itemId) {
        document.getElementById("cart-item-id").value = itemId;
        document.querySelector("form").submit();
    }
});