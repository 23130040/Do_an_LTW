document.addEventListener("DOMContentLoaded", () => {
    /**Xử lý việc hiện thông tin vân chuyện*/
    const opendeliveryMessageBtn = document.getElementById("opendeliverymessage");
    const deliveryMessage = document.getElementById("delivery-message");
    opendeliveryMessageBtn.addEventListener("click", () => {
        deliveryMessage.style.display = "block";
    });

    /**Xử lý việc ẩn thông tin vận chuyển*/
    const closedeliveryMessageBtn = document.getElementById("close-message-modal");
    closedeliveryMessageBtn.addEventListener("click", () => {
        deliveryMessage.style.display = "none";
    });

    window.addEventListener('click', (e) => {
        if (e.target === deliveryMessage) deliveryMessage.style.display = "none";
    });

    // ===== XÓA SẢN PHẨM =====
    document.querySelectorAll(".trash-btn").forEach(btn => {
        btn.addEventListener("click", () => {
            const id = btn.dataset.id;

            fetch(`${contextPath}/cart-remove`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: `id=${id}`
            }).then(() => location.reload());
        });
    });

    // ===== TĂNG / GIẢM SỐ LƯỢNG =====
    document.querySelectorAll(".quantity-btn").forEach(btn => {
        btn.addEventListener("click", () => {
            const id = btn.dataset.id;
            const action = btn.dataset.action;

            const wrapper = btn.closest(".amount-wrapper");
            const input = wrapper.querySelector(".quantity-input");

            let quantity = parseInt(input.value);

            if (action === "increase") quantity++;
            if (action === "decrease" && quantity > 1) quantity--;

            fetch(`${contextPath}/cap-nhat-so-luong`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: `id=${id}&quantity=${quantity}`
            })
                .then(res => res.json())
                .then(data => {
                    input.value = quantity;

                    btn.closest("tr")
                        .querySelector(".total")
                        .innerText = data.subTotal;

                    document.querySelector("#subtotal").innerText = data.cartTotal;
                    document.querySelector(".total.number").innerText = data.cartTotal;
                });
        });
    });
});

;




