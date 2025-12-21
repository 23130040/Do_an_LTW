package vn.edu.hcmuaf.fit.do_an_ltw.services;

import vn.edu.hcmuaf.fit.do_an_ltw.dao.UserDAO;
import vn.edu.hcmuaf.fit.do_an_ltw.model.User;

public class UserService {
    private UserDAO userDAO;

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
}
