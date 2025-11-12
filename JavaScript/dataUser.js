//Lấy danh sách người dùng
function getUsers(){
    const usersJSON = localStorage.getItem("users");
    return usersJSON ? JSON.parse(usersJSON) : [];
}
//Lưu người dùng
function saveUsers(users){
    localStorage.setItem("users", JSON.stringify(users));
}
/*function checkEmail(email){
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}
function checkPasswordStrength(password) {
    const minLength = 8;

    const passwordRegex = new RegExp(
        `(?=.*[a-z])` +
        `(?=.*[A-Z])` +
        `(?=.*\\d)` +
        `(?=.*[!@#$%^&*()])` +
        `[A-Za-z\\d!@#$%^&*()]{${minLength},}`
    );

    if (password.length < minLength) {
        return "Mật khẩu phải có ít nhất 8 ký tự.";
    }

    if (!passwordRegex.test(password)) {
        let errors = [];
        if (!/(?=.*[a-z])/.test(password)) errors.push("chữ cái thường");
        if (!/(?=.*[A-Z])/.test(password)) errors.push("chữ cái hoa");
        if (!/(?=.*\d)/.test(password)) errors.push("chữ số");
        if (!/(?=.*[!@#$%^&*()])/.test(password)) errors.push("ký tự đặc biệt");

        return `Mật khẩu phải chứa ít nhất một: ${errors.join(", ")}.`;
    }

    return null;
}*/

//đăng ký
function signup(event) {
    event.preventDefault();

    const form = document.getElementById('signup-form');
    const name = form.querySelector('input[name="name"]').value.trim();
    const email = form.querySelector('input[name="email"]').value.trim();
    const password = form.querySelector('input[name="password"]').value;
    const confirm = form.querySelector('input[name="confirm-password"]').value;

    /*const isEmailValid = checkEmail(email);
    if (!isEmailValid) {
        alert('Lỗi: Email không hợp lê!');
        return;
    }*/

    if (password !== confirm){
        alert("Lỗi: Mật khẩu xác nhận không khớp!");
        return;
    }

    /*const isPasswordValid = checkPasswordStrength(password);
    if (isPasswordValid){
        alert('Lỗi mật khẩu: ' + isPasswordValid);
        return;
    }*/

    let users = getUsers();

    if (users.some(user => user.email === email)){
        alert("Lỗi: Email này đã được đăng ký!");
        return;
    }

    const newUser = {
        name: name,
        email: email,
        password: password,
        role: 'user'
    }
    users.push(newUser);
    saveUsers(users);

    alert('Đăng ký thành công! Vui lòng đăng nhập.');

    window.location.href= '../HTML/TrangDangNhap.html';
}
//đăng nhập
function login(event) {
    event.preventDefault();

    const form = document.getElementById('login-form');
    const email = form.querySelector('input[name="email"]').value.trim();
    const password = form.querySelector('input[name="password"]').value;

    let users = getUsers();

    const user = users.find(user => user.email === email && user.password === password);

    if(user){
        sessionStorage.setItem('users', JSON.stringify({
            email: user.email,
            password: user.password,
            role: user.role
            }
        ));
        alert('Đăng nhập thành công!');
        window.location.href= '../HTML/trang_chu_da_login.html';
    }else{
        alert('Email hoặc mật khẩu không đúng!');
    }
}

function resetPassword(event) {
    event.preventDefault();

    const form = document.getElementById('forgotPasswordModal');
    const email = form.querySelector('input[name="reset_email"]').value.trim();
    const newPassword = form.querySelector('input[name="new_password"]').value;

    let users = getUsers();

    const userIndex = users.findIndex(user => user.email === email);

    if (userIndex !== -1) {
        users[userIndex].password = newPassword;
        saveUsers(users);
        alert('Mật khẩu của tài khoản ' + email + ' đã được đặt lại thành công!');
        document.getElementById('forgotPasswordModal').style.display = 'none';
    } else {
        alert('Lỗi: Không tìm thấy tài khoản với email này.');
    }
}
document.addEventListener('DOMContentLoaded', () => {
    const signupBTN = document.getElementById('register-submit-btn');
    if (signupBTN) {
        signupBTN.addEventListener('click', signup);
    }
    const loginBTN = document.getElementById('login-submit-btn');
    if (loginBTN) {
        loginBTN.addEventListener('click', login);
    }

    const openForgotBtn = document.getElementById('open-forgot-modal-btn');
    const forgotPasswordModal = document.getElementById('forgotPasswordModal');
    const closeForgotBtn = document.getElementById('closeForgotModal');
    const resetBtn = document.getElementById('reset-password-btn');

    if (openForgotBtn) {
        openForgotBtn.addEventListener('click', (e) => {
            e.preventDefault();
            forgotPasswordModal.style.display = 'block';
        })
    }
    if (closeForgotBtn) {
        closeForgotBtn.addEventListener('click', (e) => {
            forgotPasswordModal.style.display = 'none';
        })
    }
    if (resetBtn) {
        resetBtn.addEventListener('click', resetPassword);
    }

    window.onclick = function(event) {
        if (event.target === forgotPasswordModal) {
            forgotPasswordModal.style.display = 'none';
        }
    }
});
