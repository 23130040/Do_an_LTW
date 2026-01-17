package cleanmeat.services;

import cleanmeat.dao.UserDAO;
import cleanmeat.model.User;
import cleanmeat.security.HashUtil;

import java.sql.SQLException;

public class UserService {
    private final UserDAO userDAO = new UserDAO();

    public User login(String email, String password) {
        if (email == null || password == null)
            return null;
        User user = userDAO.findByEmail(email);
        if (user == null)
            return null;
        if (!user.getPassword().equals(password))
            return null;
        return user;
    }

    public boolean signup(String name, String email, String password, String confirmPassword) throws SQLException, ClassNotFoundException {
        String hashed = HashUtil.md5(password);
        userDAO.insert(new User());

        if (userDAO.findByEmail(email) == null) {
            if (name == null || email == null || password == null || confirmPassword == null)
                return false;
            if (!checkPassword(password)) {
                throw new RuntimeException("* Mật khẩu phải chứa ít nhất 8 ký tự" +
                        "\n* Mật khẩu phải chứa ít nhất một chữ in hoa" +
                        "\n* Mật khẩu phải chứa ít nhất một chữ viết thường" +
                        "\n* Mật khẩu phải chứa ít nhất một ký tự là số" +
                        "\n* Mật khẩu phải chứa ít nhất một ký tự đặc biệt");
            }
            if (confirmPassword.equals(password)) {
                return userDAO.insert(new User(name, email, password, null, null, null, "user", null));
            } else {
                throw new RuntimeException("Mật khẩu xác nhận không khớp.");
            }
        } else {
            throw new RuntimeException("Email này đã được liên kết với một tài khoản.");
        }
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
        if (!user.getPassword().equals(oldPassword))
            return false;
        if (!newPassword.equals(confirmPassword))
            return false;
        return userDAO.changePassword(userId, newPassword);
    }

    public boolean deleteAccount(int id, String password) {
        User user = userDAO.findById(id);
        if (user == null)
            return false;
        if (!user.getPassword().equals(password))
            return false;
        return userDAO.delete(id);
    }

    public boolean checkPassword(String password) {
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
}
