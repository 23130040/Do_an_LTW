document.addEventListener('DOMContentLoaded', () => {
    const registerBtn = document.getElementById('register-submit-btn');
    registerBtn.addEventListener('click', () => {
        alert('Đăng ký thành công! Vui lòng đăng nhập.');
        window.location.href = '../HTML/dangnhap.html';
    });
});

// function checkEmail(email) {
//     const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
//     return emailRegex.test(email);
// }
//
// function checkPassword(password) {
//     const checkLength = password.length >= 8;
//     const checkUpper = /[A-Z]/.test(password);
//     const checkNumber = /\d/.test(password);
//     const checkLower = /[a-z]/.test(password);
//     const checkSpecial = /[!@#$%^&*()_+\-=[\]{};':"\\|,.<>/?]/.test(password);
//     return checkLength && checkUpper && checkNumber && checkLower && checkSpecial;
// }
// // ======= Hiển thị lỗi =======
// function showError(id, inputs, message) {
//     const errorDiv = document.getElementById(id);
//     errorDiv.textContent = message;
//     errorDiv.style.display = "block";
//     if (Array.isArray(inputs)) {
//         inputs.forEach(input => input.classList.add("error-border"));
//     }else{
//         inputs.classList.add("error-border");
//     }
// }
// ======= Đăng ký =======
// function signup(event) {
//     event.preventDefault();
//     const form = document.getElementById('signup-form');
//     const nameInput = form.name;
//     const name = nameInput.value.trim();
//     const emailInput = form.email;
//     const email = emailInput.value.trim();
//     const passwordInput = form.password;
//     const password = passwordInput.value;
//     const confirmInput = form.confirm_password;
//     const confirm = confirmInput.value;

    // nameInput.classList.remove("error-border");
    // emailInput.classList.remove("error-border");
    // passwordInput.classList.remove("error-border");
    // confirmInput.classList.remove("error-border");
    //
    // document.getElementById("signup-error").style.display = "none";

    // if (name === ''){
    //     showError('signup-error',nameInput,'Vui lòng nhập họ và tên!');
    //     return;
    // }
    // if (email === ''){
    //     showError('signup-error',emailInput,'Vui lòng nhập email!');
    //     return;
    // }
    // if (password === ''){
    //     showError('signup-error', passwordInput,'Vui lòng nhập mật khẩu!');
    //     return;
    // }
    // if (confirm === ''){
    //     showError('signup-error',confirmInput,'Vui lòng nhập lại mật khẩu!');
    //     return;
    // }
    // if (!checkEmail(email)) {
    //     showError('signup-error',emailInput,'Email không hợp lệ!');
    //     return;
    // }
    // if (!checkPassword(password)) {
    //     showError('signup-error',passwordInput,'Mật khẩu phải có ít nhất 8 ký tự, bao gồm ít nhất một chữ cái hoa, một chữ cái thường, một chữ số và một ký tự đặc biệt.');
    //     return;
    // }
    // if (password !== confirm) {
    //     showError('signup-error',confirmInput,"Mật khẩu xác nhận không khớp!");
    //     return;
    // }
// }
