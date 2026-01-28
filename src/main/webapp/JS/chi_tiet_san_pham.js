document.addEventListener("DOMContentLoaded", function () {

    /* ========================= BIẾN CHUNG ========================= */
    const optionButtons = document.querySelectorAll(".option:not(.disabled)");
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

    /* ========================= UPDATE GIÁ ========================= */
    function updatePrice() {
        const qty = parseInt(qtyInput.value) || 1;
        priceEl.innerText = formatPrice(basePrice * qty);
        hiddenQty.value = qty;
    }

    /* ========================= CHỌN KHỐI LƯỢNG ========================= */
    function applyOption(btn) {
        if (!btn || btn.classList.contains("disabled")) return;

        optionButtons.forEach(b => b.classList.remove("active"));
        btn.classList.add("active");

        basePrice = parseInt(btn.dataset.price || 0);
        itemIdInput.value = btn.dataset.itemId;

        qtyInput.value = 1;
        hiddenQty.value = 1;

        updatePrice();
    }

    optionButtons.forEach(btn => {
        btn.addEventListener("click", () => applyOption(btn));
    });

    /* ========================= INIT ========================= */
    const activeBtn =
        document.querySelector(".option.active:not(.disabled)") || optionButtons[0];

    if (activeBtn) {
        basePrice = parseInt(activeBtn.dataset.price || 0);
        updatePrice();
    }

    /* ========================= + / - SỐ LƯỢNG ========================= */
    if (minusBtn && plusBtn && qtyInput && hiddenQty) {

        minusBtn.addEventListener("click", () => {
            let val = parseInt(qtyInput.value) || 1;
            if (val > 1) {
                qtyInput.value = val - 1;
                updatePrice();
            }
        });

        plusBtn.addEventListener("click", () => {
            let val = parseInt(qtyInput.value) || 1;
            qtyInput.value = val + 1;
            updatePrice();
        });
    }

    document.querySelectorAll(".option").forEach(btn => {
        btn.onclick = () => {
            if (btn.classList.contains("disabled")) return;

            document.querySelectorAll(".option").forEach(b => b.classList.remove("active"));
            btn.classList.add("active");

            document.getElementById("cart-item-id").value = btn.dataset.itemId;
            document.getElementById("product-price").innerText =
                new Intl.NumberFormat('vi-VN').format(btn.dataset.price) + "đ";
        };
    });


});
