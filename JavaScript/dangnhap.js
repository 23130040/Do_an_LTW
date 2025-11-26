
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

// ======= Modal helper =======
function openModal(id) {
    document.getElementById(id).style.display = "block";
}
function closeModal(id) {
    document.getElementById(id).style.display = "none";
}

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

// ======= Đăng nhập =======
function login(event) {
    event.preventDefault();
    const form = document.getElementById('login-form');
    const emailInput = form.email;
    const passwordInput = form.password;
    const email = emailInput.value.trim();
    const password = passwordInput.value;

    // // Reset lỗi
    // emailInput.classList.remove("error-border");
    // passwordInput.classList.remove("error-border");
    // document.getElementById('login-error').style.display = "none";
    //
    // // Kiểm tra email hoặc password trống
    // if (email === '' && password === '') {
    //     showError('login-error', [emailInput, passwordInput], 'Vui lòng nhập email và mật khẩu!');
    //     return; // Dừng hàm
    // }
    // if (email === '') {
    //     showError('login-error', emailInput, 'Vui lòng nhập email!');
    //     return;
    // }
    // if (!checkEmail(email)) {
    //     showError('login-error',emailInput,'Email không hợp lệ!');
    //     return;
    // }
    // if (password === '') {
    //     showError('login-error', passwordInput, 'Vui lòng nhập mật khẩu!');
    //     return;
    // }

    if (email === 'admin.a@cleanmeat.com' && password === 'Admin@123456'){
        window.location.href = '../HTML/admin_thong_tin_tai_khoan.html';
    }else{
        window.location.href = '../HTML/trang_chu_da_login.html';
    }
}


// ======= Quên mật khẩu =======
let confirmTimer;
// function sendEmail(event) {
//     event.preventDefault();
//     const input = document.querySelector('#forgot-password-form input[name="reset_email"]');
//     const email = input.value.trim();
//
    // input.classList.remove("error-border");
    // document.getElementById("email-error").style.display = "none";

    // if (!email) return showError('email-error', input, "Vui lòng nhập email!");
    // if (!checkEmail(email)) return showError('email-error',input, "Email không hợp lệ!");
    //
    // if (!user) return showError('email-error', input, "Email này chưa được liên kết với bất kỳ tài khoản nào!");
    //
    // // Mở modal xác nhận
    // document.getElementById("user-email").textContent = email;

//     closeModal('forgotPasswordModal');
//     openModal('confirmation-modal');
//     startConfirmTimer();
// }

// ======= Hàm đặt lại mật khẩu =======
// function resetPassword(event) {
//     event.preventDefault();
//
//     const email = document.querySelector('#forgot-password-form input[name="reset_email"]').value.trim();
//     const passwordInput = document.querySelector('#resetpassword-form input[name="new_password"]');
//     const confirmInput = document.querySelector('#resetpassword-form input[name="confirm_new_password"]');
//     const password = passwordInput.value;
//     const confirm = confirmInput.value;
//
//     // Reset lỗi
//     document.getElementById("reset-password-error").style.display = "none";
//     passwordInput.classList.remove("error-border");
//     confirmInput.classList.remove("error-border");
//
//     // Kiểm tra lỗi
//     if (password === '') {
//         showError('reset-password-error', passwordInput, 'Vui lòng nhập mật khẩu!');
//         return;
//     }
//     if (confirm === '') {
//         showError('reset-password-error', confirmInput, 'Vui lòng nhập lại mật khẩu!');
//         return;
//     }
//     if (password !== confirm) {
//         showError('reset-password-error', confirmInput, 'Mật khẩu xác nhận không khớp!');
//         return;
//     }
//
//     // Cập nhật mật khẩu
//     const users = getUsers();
//     const user = users.find(u => u.email === email);
//     if (user) {
//         user.password = password;
//         saveUsers(users);
//         alert('Đặt lại mật khẩu thành công!');
//         closeModal('resetpasswordmodal');
//     }
// }

// ======= Timer xác nhận email =======
function startConfirmTimer() {
    clearTimeout(confirmTimer);
    confirmTimer = setTimeout(() => {
        closeModal('confirmation-modal');
        alert('Xác nhận email thành công!');
        openModal('resetpasswordmodal');
    }, 3000);
}

// ======= DOMContentLoaded =======
document.addEventListener('DOMContentLoaded', () => {
    // Nút đăng nhập
    document.getElementById('login-submit-btn')?.addEventListener('click', login);

    // Mở/đóng modal quên mật khẩu
    const forgotModal = document.getElementById('forgotPasswordModal');
    document.getElementById('open-forgot-modal-btn')?.addEventListener('click', e => { e.preventDefault(); openModal('forgotPasswordModal'); });
    document.getElementById('closeForgotModal')?.addEventListener('click', () => closeModal('forgotPasswordModal'));

    // Nút gửi yêu cầu
    document.getElementById('send-request-btn')?.addEventListener('click', ()=>{
        closeModal('forgotPasswordModal');
        openModal('confirmation-modal');
        startConfirmTimer();
    });

    // Modal confirmation
    const confirmModal = document.getElementById('confirmation-modal');
    document.getElementById('cancel-btn')?.addEventListener('click', () => { closeModal('confirmation-modal'); clearTimeout(confirmTimer); });
    document.getElementById('close-confirmation-modal')?.addEventListener('click', () => { closeModal('confirmation-modal'); clearTimeout(confirmTimer); });
    document.getElementById('resend-btn')?.addEventListener('click', () => {
        alert('Email đã được gửi lại. Vui lòng kiểm tra hộp thư đến và thư mục spam.');
        startConfirmTimer(); // reset timer 10s
    });

    //Modal reset password
    const resetpasswordModal = document.getElementById('resetpasswordmodal');
    document.getElementById('close-resetpasswordmodal').addEventListener('click', () => {closeModal('resetpasswordmodal');});
    document.getElementById('confirm-btn')?.addEventListener('click', () =>{
        closeModal('resetpasswordmodal');
    });
    // Click ngoài modal để đóng quên mật khẩu
    window.addEventListener('click', e => {
        if (e.target === forgotModal) closeModal('forgotPasswordModal');
        if (e.target === confirmModal) {
            closeModal('confirmation-modal')
            clearTimeout(confirmTimer);
        }
        if (e.target === resetpasswordModal) closeModal('resetpasswordmodal');
    });
});
