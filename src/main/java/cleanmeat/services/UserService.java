package cleanmeat.services;

import cleanmeat.dao.UserDAO;
import cleanmeat.model.User;

public class UserService {
    private static UserDAO userDAO = new UserDAO();

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
    public static boolean isEmailRegistered(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return userDAO.existsByEmail(email);
    }
}
