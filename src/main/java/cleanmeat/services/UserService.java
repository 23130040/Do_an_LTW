package cleanmeat.services;

import cleanmeat.dao.UserDAO;
import cleanmeat.model.User;

import java.sql.SQLException;

public class UserService {
    private static UserDAO userDAO = new UserDAO();
    private String error;

    public UserService() {

    }

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

        if (userDAO.findByEmail(email) == null) {
            if (name == null || email == null || password == null || confirmPassword == null)
                return false;
            if (confirmPassword.equals(password)) {
                return userDAO.insert(new User(name, email, password, null, null, null, "user", null));
            }else{
                error = "Mật khẩu xác nhận không khớp.";
            }
        }else{
            error = "Email này đã được liên kết với một tài khoản.";
        }
        return false;

    }

    public static boolean isEmailRegistered(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return userDAO.existsByEmail(email);
    }

}
