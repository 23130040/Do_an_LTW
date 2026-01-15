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
});




