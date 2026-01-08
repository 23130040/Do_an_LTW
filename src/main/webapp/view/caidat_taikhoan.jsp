<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--<div id="setting-content" class="tab-content hidden">--%>
<div class="setting-content header">
    <h1 class="txt big">NHỮNG THIẾT LẬP RIÊNG TƯ</h1>
</div>
<div class="setting-content body">
    <div class="setting-content left">
        <h3 class="txt small">Yêu cầu xóa tài khoản</h3>
    </div>
    <div class="setting-content right">
        <button type="button" class="setting-content" id="delete-btn">Xóa bỏ</button>
    </div>
</div>

<div id="delete-account-modal" class="modal">
    <div class="modal-content">
        <span class="close-btn" id="close-delete-account-modal">&times;</span>
        <div class="delete-account-form">
            <div class="message">
                <i class="fa-solid fa-circle-question"></i>
                <span class="txt">Bạn chắc chắn xóa tài khoản?</span>
            </div>
            <div class="btn-group">
                <button type="button" class="cancle-btn" id="cancle-delete-account-btn">Hủy</button>
                <button type="button" class="confirm-btn" id="confirm-delete-account-btn">Xác nhận</button>
            </div>
        </div>
    </div>
</div>

<div id="input-password-modal" class="modal">
    <div class="modal-content">
        <span class="close-btn" id="close-input-password-modal">&times;</span>
        <div class="password-form">
            <h2>Vui lòng nhập mật khẩu</h2>
            <div class="form-input">
                <label for="password" class="profile-form label"><i class="fa-solid fa-key"></i></label>
                <input type="password" id="password" name="password" class="profile-form input-field"
                       placeholder="Nhập mật khẩu">
            </div>
            <div class="btn-group">
                <button type="button" class="cancle-btn" id="cancle-confirm-password-btn">Hủy</button>
                <button type="submit" class="confirm-btn" id="confirm-delete-btn">Xóa tài khoản</button>
            </div>
        </div>
    </div>
</div>

<div id="confirm-modal" class="modal">
    <div class="modal-content">
        <div id="message"></div>
        <div id="btn" class="btn-group">
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        const openDeleteModalBtn = document.getElementById("delete-btn");
        openDeleteModalBtn.addEventListener("click", () => {
            openModal("delete-account-modal");
        });

        const closeDeleteModalBtn = document.getElementById("close-delete-account-modal");
        closeDeleteModalBtn.addEventListener("click", () => {
            closeModal("delete-account-modal");
        });

        const cancleDeleteModalBtn = document.getElementById("cancle-delete-account-btn");
        cancleDeleteModalBtn.addEventListener("click", () => {
            closeModal("delete-account-modal");
        });

        const confirmDeleteBtn = document.getElementById("confirm-delete-account-btn");
        confirmDeleteBtn.addEventListener("click", () => {
            openModal("input-password-modal");
        });

        const closePasswordModal = document.getElementById("close-input-password-modal");
        closePasswordModal.addEventListener("click", () => {
            closeModal("input-password-modal");
        });

        const canclePasswordModal = document.getElementById("cancle-confirm-password-btn");
        canclePasswordModal.addEventListener("click", () => {
            closeModal("input-password-modal");
        });

        window.addEventListener("click", (e) => {
            if (e.target === "delete-account-modal") closeModal("delete-account-modal");
            if (e.target === "input-password-modal") closeModal("input-password-modal");
        });

        //dùng AJAX để điều hướng các hành động khi chọn xác nhận xóa tài khoản
        document.getElementById("confirm-delete-btn").addEventListener("click", () => {
            const password = document.getElementById("password").value;

            fetch("/tai-khoan?action=delete-account", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({password})
            }).then(res => res.json())
                .then(data => {
                    closeModal("input-password-modal");

                    const message = document.getElementById("message");
                    const btn = document.getElementById("btn");

                    if (data.success) {
                        let countdown = 5;
                        message.innerHTML = `<p><i class="fa-solid fa-check"></i>Xóa tài khoản thành công! Chuyển về trang chủ sau <span id="countdown">${countdown}</span></p>`;
                        openModal("confirm-modal");
                        let interval = setInterval(() => {
                            countdown--;
                            document.getElementById("countdown").textContent = countdown;
                            if (countdown <= 0) {
                                clearInterval(interval);
                                window.location.href = "${pageContext.request.contextPath}/trang-chu";
                            }
                        }, 1000);
                    } else {
                        message.innerHTML = `<p>Xóa thất bại: ${data.message}</p>`;
                        btn.innerHTML = `<button type="button" id="ok-btn" class="confirm-btn">OK</button>`;
                        openModal("confirm-modal");
                        document.getElementById("ok-btn").addEventListener("click", () => {
                            closeModal("confirm-modal");
                            openModal("input-password-modal");
                        });
                    }
                });
        });
    });

    function openModal(id) {
        document.getElementById(id).style.display = "block";
    }

    function closeModal(id) {
        document.getElementById(id).style.display = "none";
    }
</script>