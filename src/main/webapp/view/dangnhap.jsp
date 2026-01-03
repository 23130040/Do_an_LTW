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
        <form method="post" action="dang-nhap">
            <div class="block user-name">
                <i class="fa-regular fa-user"></i>
                <input type="text" class="form-input" name='email' placeholder="Nhập email" required>
            </div>
            <div class="block password">
                <i class="fa-solid fa-lock"></i>
                <input type="password" class="form-input" name='password' placeholder="Nhập mật khẩu" required>
            </div>
            <div class="block forgot-password">
                <a href="${pageContext.request.contextPath}#forgotPasswordModal" class="link forgot"
                   id="open-forgot-modal-btn">Quên mật khẩu?</a>
            </div>
            <div id="login-error" class="error-message"></div>
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
            <a href="#" class="link google-submit">
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
            <p class="txt">Nhập email</p>
            <div class="block email_reset">
                <i class="fa-regular fa-envelope"></i>
                <input type="email" class="form-input" name='reset_email' placeholder="Nhập email của bạn" required>
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
                    Hệ thống đã gửi <strong>email xác nhận</strong> đến địa chỉ
                </span>
                <span class="email" id="user-email"></span>.
            </p>
            <p class="note">
                Vui lòng kiểm tra hộp thư đến và thư mục spam. Nếu bạn chưa nhận được email, hãy nhấn “Gửi lại”.
            </p>
        </div>
        <div class="button-group">
            <button id="cancel-btn" class="btn cancel-btn">Hủy bỏ</button>
            <button id="resend-btn" class="btn resend-btn">Gửi lại email</button>
        </div>
    </div>
</div>
<!--reset password----->
<div id="resetpasswordmodal" class="modal">
    <div class="modal-content">
        <span class="close-btn" id="close-reset-password-modal">&times;</span>
        <form id="reset-password-form" method="post" action="">
            <h3>ĐẶT LẠI MẬT KHẨU</h3>
            <p class="txt">Nhập mật khẩu mới</p>
            <div class="block password-reset">
                <i class="fa-solid fa-lock"></i>
                <input type="password" class="form-input" name='new-password' placeholder="Nhập mật khẩu" required>
            </div>
            <div class="block confirm_password_reset">
                <i class="fa-solid fa-lock"></i>
                <input type="password" class="form-input" name='confirm-new-password' placeholder="Nhập lại mật khẩu"
                       required>
            </div>
            <div id="reset-password-error" class="error-message"></div>
            <div class="block submit">
                <button type="submit" id="reset-submit-btn"></button>
            </div>
        </form>
    </div>
</div>
<script src="${pageContext.request.contextPath}js/dangnhap.js"></script>
</body>
</html>