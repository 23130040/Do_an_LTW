package cleanmeat.services;

import cleanmeat.dao.UserDAO;
import cleanmeat.model.User;

public class UserService {
    private static UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAO();
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
        return userDAO.existsByEmail(email);
    }
}
