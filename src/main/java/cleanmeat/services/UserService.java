package cleanmeat.services;

import cleanmeat.dao.UserDAO;
import cleanmeat.model.User;
import cleanmeat.security.HashUtil;
import jakarta.mail.internet.InternetAddress;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.UUID;

public class UserService {
    private final UserDAO userDAO = new UserDAO();

    private static final String GOOGLE_ONLY_PREFIX = "__GOOGLE_ONLY__:";

    private boolean isGoogleOnlyUser(User user) {
        return user.getPassword() != null
                && user.getPassword().startsWith(GOOGLE_ONLY_PREFIX);
    }

    public User login(String email, String password) {
        if (email == null || email.trim().isEmpty())
            throw new RuntimeException("Email không được để trống");
        if (password == null || password.trim().isEmpty())
            throw new RuntimeException("Mật khẩu không được để trống");
        User user = userDAO.findByEmail(email);
        if (user == null)
            throw new RuntimeException("Email hoặc mật khẩu không đúng");
        if (isGoogleOnlyUser(user)) {
            throw new RuntimeException("Tài khoản này đăng nhập bằng Google");
        }
        String hashedInput = HashUtil.md5(password);
        if (!user.getPassword().equals(hashedInput))
            throw new RuntimeException("Email hoặc mật khẩu không đúng");
        if (!user.isEmail_verified())
            throw new RuntimeException("Tài khoản chưa được xác thực email");
        return user;
    }

    public boolean signup(String name, String email, String password, String confirmPassword, String contextPath) throws SQLException, ClassNotFoundException {
        if (name == null || name.trim().isEmpty())
            throw new RuntimeException("Tên không được để trống");
        if (email == null || email.trim().isEmpty())
            throw new RuntimeException("Email không được để trống");
        if (password == null || password.trim().isEmpty())
            throw new RuntimeException("Mật khẩu không được để trống");
        if (confirmPassword == null || confirmPassword.trim().isEmpty())
            throw new RuntimeException("Mật khẩu xác nhận không được để trống");
        name = name.trim();
        email = email.trim();
        if (!isValidEmail(email))
            throw new RuntimeException("Địa chỉ email không hợp lệ.");
        if (userDAO.existsByEmail(email))
            throw new RuntimeException("Email này đã được liên kết tới một tài khoản khác.");
        if (!isValidPassword(password))
            throw new RuntimeException("Mật khẩu không đủ mạnh.");
        if (!password.equals(confirmPassword))
            throw new RuntimeException("Mật khẩu xác nhận không khớp.");
        String hashedPassword = HashUtil.md5(password);
        String token = UUID.randomUUID().toString();
        User user = new User(name, email, hashedPassword, null, null, null, "customer", null, token);
        boolean success = userDAO.insert(user);
        if (success) {
            String verifyLink = "http://localhost:8080" + contextPath + "/xac-thuc-email?token=" + token;
            EmailService.sendVerifyEmail(user.getEmail(), user.getName(), verifyLink);
        }
        return success;
    }

    public boolean isEmailRegistered(String email) {
        if (email == null || email.trim().isEmpty())
            throw new RuntimeException("Email không được để trống");
        if (!isValidEmail(email))
            throw new RuntimeException("Email không hợp lệ");
        return userDAO.existsByEmail(email.trim());
    }

    public boolean changePassword(int userId, String oldPassword, String newPassword, String confirmPassword) {
        User user = userDAO.findById(userId);
        if (user == null)
            return false;
        String hashedOld = HashUtil.md5(oldPassword);
        if (!user.getPassword().equals(hashedOld))
            throw new RuntimeException("Mật khẩu hiện tại không đúng");
        if (!newPassword.equals(confirmPassword)) {
            throw new RuntimeException("Mật khẩu mới không khớp nhau");
        }
        String hashedNew = HashUtil.md5(newPassword);
        return userDAO.changePassword(userId, hashedNew);
    }

    public boolean deleteAccount(int id, String password) {
        User user = userDAO.findById(id);
        if (user == null)
            return false;
        String hashed = HashUtil.md5(password);
        if (!user.getPassword().equals(hashed))
            return false;
        return userDAO.delete(id);
    }

    private boolean isValidPassword(String password) {
        if (password == null || password.trim().isEmpty())
            return false;
        boolean checkLength = password.length() >= 8;
        boolean checkUpper = false;
        boolean checkNumber = false;
        boolean checkLower = false;
        boolean checkSpecial = false;
        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) {
                checkUpper = true;
            } else if (Character.isLowerCase(c)) {
                checkLower = true;
            } else if (Character.isDigit(c)) {
                checkNumber = true;
            } else if (!Character.isLetterOrDigit(c)) {
                checkSpecial = true;
            }
            if (checkUpper && checkNumber && checkLower && checkSpecial) break;
        }
        return checkLength && checkUpper && checkNumber && checkLower && checkSpecial;
    }

    public boolean isValidEmail(String email) {
        try {
            InternetAddress emailAddr = new InternetAddress(email);
            emailAddr.validate();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean verifyEmailByToken(String token) {
        if (userDAO.findByVerifyToken(token) != null) {
            return userDAO.verifyEmail(token);
        }
        return false;
    }

    public boolean resetPasswordByEmail(String email, String hashedPassword) {
        return userDAO.updatePasswordByEmail(email, hashedPassword);
    }

    public void updateProfile(int id, String name, String email, String phone, String gender, LocalDate birthday, String avatar) {
        userDAO.updateProfile(id, name, email, phone, gender, birthday, avatar);
    }

    public boolean updateEmailVerificationStatus(int id, String token, boolean b) {
        return userDAO.updateVerification(id, token, b);
    }
    public void changePasswordForGoogleUser(
            int userId,
            String newPassword,
            String confirmPassword
    ) {
        if (newPassword == null || newPassword.length() < 8) {
            throw new RuntimeException("Mật khẩu mới phải có ít nhất 8 ký tự");
        }

        if (!newPassword.equals(confirmPassword)) {
            throw new RuntimeException("Mật khẩu xác nhận không khớp");
        }

        String hashed = HashUtil.md5(newPassword);
        userDAO.changePassword(userId, hashed);
    }
}
