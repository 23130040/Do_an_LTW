document.addEventListener("DOMContentLoaded", () => {

    const deliveryModal = $("delivery-message");
    const confirmReturnModal = $("confirm-return-order-modal");
    const redirectModal = $("redirect-modal");

    function $(id) {
        return document.getElementById(id);
    }

    async function updateStatusAjax(orderId, newStatus) {
        try {
            const url = (window.contextPath || "") + "/cap-nhat-trang-thai-don-hang";
            const res = await fetch(url, {
                method: "POST",
                headers: {"Content-Type": "application/x-www-form-urlencoded"},
                body: `orderId=${orderId}&status=${encodeURIComponent(newStatus)}`
            });

            if (!res.ok) return false;
            const json = await res.json();
            return json.success === true;
        } catch (err) {
            console.error("AJAX Error:", err);
            return false;
        }
    }

    /** ===================== ĐÃ NHẬN HÀNG ===================== **/
    const confirmOrderBtn = $("confirm-order-btn");
    if (confirmOrderBtn) {
        confirmOrderBtn.onclick = async function () {
            const orderId = this.dataset.id;
            this.disabled = true;

            const ok = await updateStatusAjax(orderId, "Đã Giao");
            if (ok) {
                redirectModal.style.display = "block";
            } else {
                alert("Cập nhật trạng thái thất bại!");
                this.disabled = false;
            }
        };
    }

    /** ===================== HỦY ĐƠN ===================== **/
    const cancelOrderBtn = $("cancel-order-btn");
    if (cancelOrderBtn) {
        cancelOrderBtn.onclick = function () {
            confirmReturnModal.querySelector(".txt").innerText =
                "Bạn có chắc chắn muốn hủy đơn hàng này?";
            confirmReturnModal.style.display = "block";
        };

        $("confirm-btn").onclick = async () => {
            const orderId = cancelOrderBtn.dataset.id;
            const ok = await updateStatusAjax(orderId, "Đã Hủy");
            if (ok) location.reload();
            else alert("Không thể hủy đơn hàng!");
        };

        $("cancle-btn").onclick = () => {
            confirmReturnModal.style.display = "none";
        };
    }

    /** ===================== ĐIỀU HƯỚNG ===================== **/
    $("return-to-home-btn")?.addEventListener("click", () => {
        window.location.href = (window.contextPath || "") + "/trang-chu";
    });

    $("view-orders-btn")?.addEventListener("click", () => {
        window.location.href = (window.contextPath || "") + "/don-hang-cua-toi";
    });

    /** ===================== XEM PHÍ GIAO ===================== **/
    $("open-delivery-message")?.addEventListener("click", () => {
        deliveryModal.style.display = "block";
    });

    /** ===================== CLOSE MODAL ===================== **/
    $("close-message-modal")?.addEventListener("click", () => deliveryModal.style.display = "none");
    $("close-confirm-return-order-modal")?.addEventListener("click", () => confirmReturnModal.style.display = "none");

    window.onclick = (e) => {
        if (e.target === deliveryModal) deliveryModal.style.display = "none";
        if (e.target === confirmReturnModal) confirmReturnModal.style.display = "none";
        if (e.target === redirectModal) redirectModal.style.display = "none";
    };
});
