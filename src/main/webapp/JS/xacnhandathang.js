document.addEventListener("DOMContentLoaded", () => {

    /* ================== TIỆN ÍCH ================== */
    const $ = id => document.getElementById(id);
    const show = el => el.style.display = "block";
    const hide = el => el.style.display = "none";

    /* ================== MODAL ================== */
    const modals = {
        redirect: $("redirect-modal"),
        delivery: $("delivery-message"),
        editProfile: $("edit-profile-modal"),
        addAddress: $("add-address-modal")
    };

    /* ================== ĐẶT HÀNG ================== */
    $("confirmOrder").onclick = () => show(modals.redirect);

    $("return-to-home-btn").onclick = () =>
        window.location.href = contextPath + "/trang-chu";

    $("view-orders-btn").onclick = () =>
        window.location.href = contextPath + "/don-hang-cua-toi";

    /* ================== THÔNG TIN VẬN CHUYỂN ================== */
    $("opendeliverymessage").onclick = () => show(modals.delivery);
    $("close-message-modal").onclick = () => hide(modals.delivery);

    /* ================== CHỈNH SỬA THÔNG TIN ================== */
    $("edit-profile").onclick = () => show(modals.editProfile);

    [
        "cancle-edit-profile-btn",
        "close-edit-profile-modal"
    ].forEach(id => $(id).onclick = () => hide(modals.editProfile));

    $("confirm-edit-profile-btn").onclick = () => {
        const name = document.querySelector('input[name="name"]').value;
        const phone = document.querySelector('input[name="phoneNumber"]').value;

        if (name) $("name").innerText = name;
        if (phone) $("phone-number").innerText = phone;

        hide(modals.editProfile);
    };

    /* ================== ĐỊA CHỈ ================== */
    $("add-address-btn").onclick = () => show(modals.addAddress);
    $("close-add-address-modal").onclick = () => hide(modals.addAddress);

    // chọn địa chỉ
    document.querySelectorAll(".address").forEach(address => {
        address.onclick = () => {
            document.querySelectorAll(".address")
                .forEach(a => a.classList.remove("check"));

            address.classList.add("check");

            $("address").innerText = address.innerText;
            $("address").dataset.addressId = address.dataset.id;
        };
    });

    /* ================== CLICK RA NGOÀI MODAL ================== */
    window.onclick = e => {
        Object.values(modals).forEach(modal => {
            if (e.target === modal) hide(modal);
        });
    };
});
