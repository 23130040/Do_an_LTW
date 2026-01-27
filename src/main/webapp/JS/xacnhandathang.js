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

    document.querySelectorAll('.address').forEach(item => {
        item.addEventListener('click', function () {
            document.querySelectorAll('.address').forEach(a => a.classList.remove('check'));
            this.classList.add('check');
            let addressText = this.querySelector('.address-detail').childNodes[0].textContent.trim();
            let isDefault = this.getAttribute('data-is-default') === 'true';

            const mainAddressDisplay = document.getElementById('address');
            const defaultTag = document.getElementById('tag-default');
            mainAddressDisplay.innerText = addressText;
            mainAddressDisplay.classList.remove('error', 'invalid');

            if (isDefault) {
                defaultTag.style.display = "block"; // Hiện chữ Mặc định
            } else {
                defaultTag.style.display = "none";  // Ẩn chữ Mặc định
            }

        });
    });

    /* ================== CLICK RA NGOÀI MODAL ================== */
    window.onclick = e => {
        Object.values(modals).forEach(modal => {
            if (e.target === modal) hide(modal);
        });
    };

    /* ================== KIỂM TRA TRẠNG THÁI SAU KHI LOAD TRANG ================== */
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('orderStatus') === 'success') {
        show(modals.redirect);
    }

    /* ================== XỬ LÝ ĐẶT HÀNG AJAX ================== */
    $("confirmOrder").onclick = () => {
        // Tìm địa chỉ đang có class 'check' (do người dùng click chọn)
        // Nếu chưa click cái nào, lấy cái mặc định (có sẵn class 'check' từ JSP)
        const selectedAddress = document.querySelector('.address.check');
        const addressId = selectedAddress ? selectedAddress.getAttribute('data-id') : null;

        if (!addressId) {
            alert("Vui lòng chọn hoặc thêm địa chỉ giao hàng!");
            return;
        }

        // Hiện loading hoặc disable nút để tránh spam click
        $("confirmOrder").disabled = true;
        $("confirmOrder").innerText = "ĐANG XỬ LÝ...";

        fetch(window.location.pathname, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `addressId=${addressId}`
        })
            .then(response => response.json())
            .then(data => {
                if (data.status === "success") {
                    show(modals.redirect); // Hiện modal thành công
                } else {
                    alert("Lỗi: " + data.message);
                    $("confirmOrder").innerText = "ĐẶT HÀNG";
                    $("confirmOrder").disabled = false;
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("Mất kết nối với máy chủ.");
                $("confirmOrder").disabled = false;
            });
    };
});
