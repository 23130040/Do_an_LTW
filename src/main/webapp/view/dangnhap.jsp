<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Clean Meat - Đăng nhập</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
          integrity="sha512-...paste-the-integrity-if-needed..."
          crossorigin="anonymous"
          referrerpolicy="no-referrer">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/dangnhap.css?v=2">
</head>
<body>
<div id="container">
    <div id="wrapper">
        <img src="${pageContext.request.contextPath}/images/logoCleanmeat.png" alt="logo">
        <h1>ĐĂNG NHẬP</h1>
        <form id="signin-form" method="post" action="${pageContext.request.contextPath}/dang-nhap">
            <div class="block user-name">
                <i class="fa-regular fa-user"></i>
                <input type="email" class="form-input" name='email' placeholder="Nhập email" required>
            </div>
            <div class="block password">
                <i class="fa-solid fa-lock"></i>
                <input type="password" class="form-input" name='password' placeholder="Nhập mật khẩu" required>
            </div>
            <div class="block forgot-password">
                <a href="#" class="link forgot"
                   id="open-forgot-modal-btn">Quên mật khẩu?</a>
            </div>
            <div id="login-error" class="error-message">${requestScope.error}</div>
            <div class="block submit">
                <button type="submit" class="home link form-submit" id="login-submit-btn">ĐĂNG NHẬP</button>
            </div>
        </form>
        <div class="separator-container">
            <div class="separator-line"></div>
            <span class="separator-text">HOẶC</span>
            <div class="separator-line"></div>
        </div>
        <div class="block social-login">
            <a href="${pageContext.request.contextPath}/login-google" class="link google-submit">
            <i class="fab fa-google"></i>
                TIẾP TỤC VỚI GOOGLE
            </a>
        </div>
        <div class="block sign-up">
            <span class="txt">Bạn chưa có tài khoản?</span>
            <a href="dang-ky" class="link sign-up">Đăng ký ngay</a>
        </div>
    </div>
</div>
<div id="forgotPasswordModal" class="modal">
    <div class="modal-content">
        <span class="close-btn" id="closeForgotModal">&times;</span>
        <form id="forgot-password-form">
            <h3>QUÊN MẬT KHẨU</h3>
            <div class="block email_reset">
                <i class="fa-regular fa-envelope"></i>
                <input type="email" class="form-input" name="resetEmail" placeholder="Nhập email của bạn" required>
            </div>
            <div id="email-error" class="error-message"></div>
            <div class="block submit">
                <button type="submit" class="home link form-submit" id="send-request-btn">Gửi yêu cầu</button>
            </div>
        </form>
    </div>
</div>
<!-- Confirmation Modal -->
<div id="confirmation-modal" class="modal">
    <div class="modal-content">
        <span class="close-btn" id="close-confirmation-modal">&times;</span>
        <div class="message">
            <p>
                <span class="txt">
                    Hệ thống đã gửi <strong>mã OTP</strong> đến địa chỉ
                </span>
                <span class="email" id="user-email"></span>.
            </p>
            <p class="note">
                Vui lòng kiểm tra hộp thư đến và thư mục spam.
            </p>
        </div>
        <!-- NHẬP OTP -->
        <form id="otp-verify-form">
            <div class="block otp-input">
                <input type="text"
                       name="otp"
                       maxlength="6"
                       placeholder="Nhập mã OTP (6 số)"
                       required
                       class="form-input">
            </div>
            <div id="otp-error" class="error-message"></div>
            <div class="button-group">
                <button type="button" id="cancel-btn" class="btn cancel-btn">Hủy bỏ</button>
                <button type="submit" class="btn confirm-btn">Xác minh</button>
            </div>
        </form>
        <div class="resend-wrapper">
            <span id="otp-timer" class="otp-timer"></span>
            <button id="resend-btn" class="btn resend-btn" style="display:none">Gửi lại mã OTP</button>
        </div>
    </div>
</div>

<!--reset password----->
<div id="resetpasswordmodal" class="modal">
    <div class="modal-content">
        <span class="close-btn" id="close-reset-password-modal">&times;</span>
        <form id="reset-password-form" method="post"
              action="${pageContext.request.contextPath}/dang-nhap?action=doi-mat-khau">
            <h3>ĐẶT LẠI MẬT KHẨU</h3>
            <div class="block password-reset">
                <i class="fa-solid fa-lock"></i>
                <input type="password" class="form-input" name='newPassword' placeholder="Nhập mật khẩu mới" required>
            </div>
            <div class="block confirm_password_reset">
                <i class="fa-solid fa-lock"></i>
                <input type="password" class="form-input" name='confirmNewPassword' placeholder="Nhập lại mật khẩu mới"
                       required>
            </div>
            <div id="reset-password-error" class="error-message"></div>
            <div class="block submit">
                <button type="submit" class="home link form-submit" id="reset-submit-btn">Đổi mật khẩu</button>
            </div>
        </form>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const openForgetPasswordModalBtn = document.getElementById("open-forgot-modal-btn");
        openForgetPasswordModalBtn.addEventListener("click", (e) => {
            e.preventDefault();
            openModal("forgotPasswordModal");
        });
        const closeForgetPasswordModalBtn = document.getElementById("closeForgotModal");
        closeForgetPasswordModalBtn.addEventListener("click", () => {
            closeModal("forgotPasswordModal");
        });

        const closeOtpModalbtn = document.getElementById("close-confirmation-modal");
        closeOtpModalbtn.addEventListener("click", () => {
            closeModal("confirmation-modal");
        });

        const cancleBtn = document.getElementById("cancel-btn");
        cancleBtn.addEventListener("click", () => {
            closeModal("confirmation-modal");
        });
        window.addEventListener("click", (e) => {
            if (e.target.id === "forgotPasswordModal") closeModal("forgotPasswordModal");
            if (e.target.id === "confirmation-modal") closeModal("confirmation-modal");
        });

        document.getElementById("forgot-password-form").addEventListener("submit", (e) => {
            e.preventDefault();
            const form = e.target;
            const formData = new FormData(form);
            const params = new URLSearchParams(formData);
            const errorDiv = document.getElementById("email-error");
            errorDiv.textContent = "";
            fetch(`${pageContext.request.contextPath}/dang-nhap?action=quen-mat-khau`, {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: params
            }).then(res => res.json())
                .then(data => {
                    if (data.success) {
                        closeModal("forgotPasswordModal");
                        document.getElementById("user-email").textContent = data.email;
                        openModal("confirmation-modal");
                        clearInterval(otpCountdownInterval);
                        startOtpCountdown(300);
                    } else {
                        errorDiv.textContent = data.message;
                    }
                }).catch(err => {
                errorDiv.textContent = "Có lỗi xảy ra, vui lòng thử lại";
                console.error(err);
            });
        });

        /*XÁC MINH OTP*/
        document.getElementById("otp-verify-form").addEventListener("submit", e => {
            e.preventDefault();
            const otp = e.target.otp.value;
            const errorDiv = document.getElementById("otp-error");
            errorDiv.textContent = "";
            fetch(`${pageContext.request.contextPath}/dang-nhap?action=xac-minh-otp`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: new URLSearchParams({otp})
            })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        closeModal("confirmation-modal");
                        openModal("resetpasswordmodal");
                    } else {
                        errorDiv.textContent = data.message;
                    }
                })
                .catch(err => {
                    console.error(err);
                    errorDiv.textContent = "OTP không hợp lệ hoặc đã hết hạn";
                });
        });

        //gửi lại otp
        document.getElementById("resend-btn").addEventListener("click", () => {
            fetch(`${pageContext.request.contextPath}/dang-nhap?action=gui-lai-otp`, {
                method: "POST"
            })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        clearInterval(otpCountdownInterval);
                        startOtpCountdown(60);
                    }
                    alert(data.message);
                });
        });

        document.getElementById("reset-password-form").addEventListener("submit", e => {
            e.preventDefault();
            fetch(e.target.action, {
                method: "POST",
                body: new URLSearchParams(new FormData(e.target))
            })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        alert("Đổi mật khẩu thành công");
                        location.reload();
                    } else {
                        document.getElementById("reset-password-error").textContent = data.message;
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

    let otpCountdownInterval;

    function startOtpCountdown(seconds) {
        const timerEl = document.getElementById("otp-timer");
        const resendBtn = document.getElementById("resend-btn");
        resendBtn.style.display = "none";
        timerEl.style.display = "block";
        let remaining = seconds;
        timerEl.innerHTML = `Mã OTP còn hiệu lực trong <strong>${remaining}s</strong>`;
        if (otpCountdownInterval) clearInterval(otpCountdownInterval);
        otpCountdownInterval = setInterval(() => {
            remaining--;
            if (remaining <= 0) {
                clearInterval(otpCountdownInterval);
                timerEl.style.display = "none";
                resendBtn.style.display = "inline-block";
            } else {
                timerEl.innerHTML = `Mã OTP còn hiệu lực trong <strong>${remaining}s</strong>`;
            }
        }, 1000);
    }
</script>
</body>
</html>