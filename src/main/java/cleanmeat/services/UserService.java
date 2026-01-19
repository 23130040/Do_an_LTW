package cleanmeat.services;

import cleanmeat.dao.UserDAO;
import cleanmeat.model.User;
import cleanmeat.security.HashUtil;
import jakarta.mail.internet.InternetAddress;

import java.sql.SQLException;

public class UserService {
    private final UserDAO userDAO = new UserDAO();

    public User login(String email, String password) {
        if (email == null || password == null)
            return null;
        User user = userDAO.findByEmail(email);
        if (user == null)
            return null;
        String hashedInput = HashUtil.md5(password);
        if (!user.getPassword().equals(hashedInput))
            return null;
        return user;
    }

    public boolean signup(String name, String email, String password, String confirmPassword) throws SQLException, ClassNotFoundException {
        if (!isValidEmail(email))
            throw new RuntimeException("Địa chỉ email không hợp lệ.");
        if (userDAO.findByEmail(email) != null)
            throw new RuntimeException("Email này đã được liên kết tới một tài khoản khác.");
        if (!isValidPassword(password))
            throw new RuntimeException("Mật khẩu không đủ mạnh.");
        if (!password.equals(confirmPassword))
            throw new RuntimeException("Mật khẩu xác nhận không khớp.");
        String hashedPassword = HashUtil.md5(password);
        User user = new User(name, email, hashedPassword, null, null, null, "user", null);
        return userDAO.insert(user);
    }

    public boolean isEmailRegistered(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return userDAO.existsByEmail(email);
    }

    public boolean changePassword(int userId, String oldPassword, String newPassword, String confirmPassword) {
        User user = userDAO.findById(userId);
        if (user == null)
            return false;
        String hashedOld = HashUtil.md5(oldPassword);
        if (!user.getPassword().equals(hashedOld))
            return false;
        if (!newPassword.equals(confirmPassword)) {
            return false;
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

    private boolean isValidEmail(String email) {
        try {
            InternetAddress emailAddr = new InternetAddress(email);
            emailAddr.validate();
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
