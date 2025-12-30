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
        <form id="signup-form" method="post" action="dang-ky">
            <div class="block user-name">
                <i class="fa-regular fa-user"></i>
                <input type="text" class="form-input" name="name" placeholder="Nhập họ và tên" required>
            </div>

            <div class="block email">
                <i class="fa-regular fa-envelope"></i>
                <input type="text" class="form-input" name="email" placeholder="Nhập email" required>
            </div>

            <div class="block password">
                <i class="fa-solid fa-lock"></i>
                <input type="password" class="form-input" name="password" placeholder="Tạo mật khẩu" required>
            </div>

            <div class="block confirm_password">
                <i class="fa-solid fa-lock"></i>
                <input type="password" class="form-input" name="confirm-password" placeholder="Nhập lại mật khẩu"
                       required>
            </div>
            <div id="signup-error" class="error-message"></div>
            <div class="block submit">
                <button class="home link form-submit" id="register-submit-btn">ĐĂNG KÝ</button>
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
<script src="${pageContext.request.contextPath}/JS/dangky.js"></script>
</body>
</html>