<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Clean Meat</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/dangky.css?v=2">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
          integrity="sha512-...paste-the-integrity-if-needed..."
          crossorigin="anonymous"
          referrerpolicy="no-referrer">
</head>
<body>
<div id="container">
    <div id="wrapper">
        <img src="${pageContext.request.contextPath}/images/logoCleanmeat.png" alt="logo">
        <h1 class="heading-title">ĐĂNG KÝ</h1>
        <form id="signup-form">
            <div class="block user-name">
                <i class="fa-regular fa-user"></i>
                <input type="text" class="form-input" name="name" value="${requestScope.name}"
                       placeholder="Nhập họ và tên" required>
            </div>

            <div class="block email">
                <i class="fa-regular fa-envelope"></i>
                <input type="text" class="form-input" name="email" value="${requestScope.email}"
                       placeholder="Nhập email" required>
            </div>

            <div class="block password">
                <i class="fa-solid fa-lock"></i>
                <input type="password" class="form-input" name="password" placeholder="Tạo mật khẩu" required>
            </div>

            <div class="block confirm_password">
                <i class="fa-solid fa-lock"></i>
                <input type="password" class="form-input" name="confirmPassword" placeholder="Nhập lại mật khẩu"
                       required>
            </div>
            <div id="signup-error" class="error-message"></div>
            <div class="block submit">
                <button type="submit" class="home link form-submit" id="register-submit-btn">ĐĂNG KÝ</button>
            </div>
            <div class="separator-container">
                <div class="separator-line"></div>
                <span class="separator-text">HOẶC</span>
                <div class="separator-line"></div>
            </div>
            <div class="block social-login">
                <a href="#" class="link google-submit">
                    <i class="fab fa-google"></i>
                    TIẾP TỤC VỚI GOOGLE
                </a>
            </div>
            <div class="block sign-up">
                <span class="txt">Bạn đã có tài khoản?</span>
                <a href="dang-nhap" class="link sign_up">Đăng nhập ngay</a>
            </div>
        </form>
    </div>
</div>
<div id="confirm-modal" class="modal">
    <div class="modal-content">
        <div id="message"></div>
        <div id="btn" class="btn-group">OK</div>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", () => {

        document.getElementById("signup-form").addEventListener("submit", (e) => {
            e.preventDefault();
            const form = e.target;
            const formData = new FormData(form);
            const errorDiv = document.getElementById("signup-error");
            const message = document.getElementById("message");
            errorDiv.textContent = "";

            fetch(`${pageContext.request.contextPath}/dang-ky`, {
                method: "POST",
                body: formData
            }).then(res => res.json())
                .then(data => {
                    let redirectTimer = null;
                    if (data.status === "success") {
                        let countdown = 5;
                        message.innerHTML = `<p class='big-txt'><i class="fa-solid fa-check"></i> Đăng ký tài khoản thành công!</p>
                                            <p class='small-txt'>Vui lòng kiểm tra email và nhấp vào liên kết xác minh để kích hoạt tài khoản.</p>
                                            <p class='small-txt'>Sau khi xác minh, bạn có thể đăng nhập bình thường.</p>
                                            <p class='small-txt'>Hệ thống sẽ tự động chuyển hướng sau <span id="countdown">${countdown}</span>s</p>`;
                        openModal("confirm-modal");
                        redirectTimer = setInterval(() => {
                            countdown--;
                            document.getElementById("countdown").textContent = countdown;
                            if (countdown <= 0) {
                                clearInterval(redirectTimer);
                                window.location.href = "${pageContext.request.contextPath}/dang-nhap";
                            }
                        }, 1000);
                    } else {
                        errorDiv.textContent = data.message;
                    }
                    document.getElementById("btn").addEventListener("click", () => {
                        if (redirectTimer) {
                            clearInterval(redirectTimer);
                        }
                        window.location.href = "${pageContext.request.contextPath}/dang-nhap";
                    })
                }).catch(err => {
                message.innerHTML = `<p><i class="fa-solid fa-triangle-exclamation"></i>Có lỗi xảy ra. Vui lòng thử lại!</p>`;
                openModal("confirm-modal");
            });
        });
    });
    function openModal(id) {
        document.getElementById(id).style.display = "block";
    }
</script>
</body>
</html>