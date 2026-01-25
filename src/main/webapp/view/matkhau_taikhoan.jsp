<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--<div id="password-content" class="tab-content hidden">--%>
<div class="password-content header">
    <h1 class="txt big">
        ĐỔI MẬT KHẨU
    </h1>
</div>
<div class="password-content body">
    <form id="change-password-form" class="password-form"
          action="${pageContext.request.contextPath}/tai-khoan?tab=doi-mat-khau" method="post">
        <div class="profile-form group">
            <label for="current-password" class="profile-form label">Mật khẩu hiện tại</label>
            <input type="password" id="current-password" name="currentPassword"
                   class="profile-form input-field" placeholder="Nhập mật khẩu hiện tại">
        </div>

        <div class="profile-form group">
            <label for="new-password" class="profile-form label">Mật khẩu mới</label>
            <input type="password" id="new-password" name="newPassword" class="profile-form input-field"
                   placeholder="Nhập mật khẩu mới">
        </div>
        <div class="profile-form group">
            <label for="confirm-password" class="profile-form label">Xác nhận mật khẩu mới</label>
            <input type="password" id="confirm-password" name="confirmPassword"
                   class="profile-form input-field" placeholder="Nhập lại mật khẩu mới">
        </div>
        <div class="profile-form submit-row">
            <button type="submit" class="profile-form submit-btn" id="save-password-btn"
                    value="changePassword">Lưu Mật Khẩu
            </button>
        </div>
    </form>
</div>

<!--Modal xác nhận đổi mật khẩu-->
<div id="confirm-save-password" class="modal">
    <div class="modal-content">
        <div class="confirm-form">
            <div class="message-container">
                <div class="message">
                    <i class="fa-solid fa-circle-check"></i>
                    <span id="password-confirm">Đổi mật khẩu thành công!</span>
                </div>
                <span class="txt">Vui lòng đăng nhập lại.</span>
            </div>
            <div class="confirm-btn">
                <button id="confirm-save-password-btn">OK</button>
            </div>
        </div>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const form = document.getElementById("change-password-form");
        const modal = document.getElementById("confirm-save-password");
        const okBtn = document.getElementById("confirm-save-password-btn");

        if (!form || !modal) {
            console.error("Không tìm thấy phần tử Form hoặc Modal trong DOM");
            return;
        }

        form.addEventListener("submit", (e) => {
            e.preventDefault();

            const formData = new FormData(form);
            const url = form.getAttribute("action");
            const separator = url.includes("?") ? "&" : "?";
            const finalUrl = url + separator + "action=changePassword";

            console.log("Gửi yêu cầu đến:", finalUrl);

            fetch(finalUrl, {
                method: "POST",
                body: formData
            })
                .then(res => {
                    if (!res.ok) throw new Error("Mã lỗi: " + res.status);
                    return res.json();
                })
                .then(data => {
                    if (data.success) {
                        modal.classList.add("active");
                        modal.style.display = "block"; // Ép hiện modal nếu CSS chưa có active
                    } else {
                        alert(data.message || "Đổi mật khẩu thất bại");
                    }
                })
                .catch((error) => {
                    console.error("Chi tiết lỗi:", error);
                    alert("Lỗi kết nối: " + error.message);
                });
        });

        okBtn.addEventListener("click", () => {
            window.location.href = "${pageContext.request.contextPath}/dang-nhap";
        });
    });
</script>
