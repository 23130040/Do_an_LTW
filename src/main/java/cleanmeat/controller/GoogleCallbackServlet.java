package cleanmeat.controller;

import cleanmeat.model.GoogleUserInfo;
import cleanmeat.model.User;
import cleanmeat.security.AuthConstants;
import cleanmeat.security.GoogleOAuthUtil;
import cleanmeat.dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;


import java.io.IOException;
import java.sql.SQLException;
import java.util.UUID;

@WebServlet(name = "GoogleCallbackServlet", value = "/login-google-callback")
public class GoogleCallbackServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String code = req.getParameter("code");
        if (code == null || code.isBlank()) {
            resp.sendRedirect(req.getContextPath() + "/dang-nhap");
            return;
        }

        String redirectUri =
                req.getScheme() + "://" +
                        req.getServerName() + ":" +
                        req.getServerPort() +
                        req.getContextPath() +
                        "/login-google-callback";

        GoogleUserInfo googleUser =
                GoogleOAuthUtil.getUserInfo(code, redirectUri);


        // 2. Validate Google response
        if (googleUser == null
                || googleUser.getEmail() == null
              ) {

            resp.sendRedirect(req.getContextPath()
                    + "/dang-nhap?error=google_login_failed");
            return;
        }

        String email = googleUser.getEmail();
        String name = googleUser.getName();
        String avatar = googleUser.getPicture();

        UserDAO userDAO = new UserDAO();
            User user = userDAO.findByEmail(email);

        if (user == null) {
            user = new User();
            user.setEmail(email);
            user.setName(name);
            user.setAvatar(avatar);
            user.setRole("customer");
            user.setStatus(true);
            user.setEmail_verified(true);

            user.setPassword(
                    AuthConstants.GOOGLE_ONLY_PREFIX + UUID.randomUUID()
            );

            try {
                userDAO.insert(user);
                System.out.println("INSERT GOOGLE USER OK: " + email);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        else {
            boolean needUpdate = false;

            if (user.getAvatar() == null || !user.getAvatar().equals(avatar)) {
                user.setAvatar(avatar);
                needUpdate = true;
            }

            if (user.getName() == null || user.getName().isBlank()) {
                user.setName(name);
                needUpdate = true;
            }

            if (needUpdate) {
                userDAO.updateProfileFromGoogle(user);
            }
        }

        HttpSession oldSession = req.getSession(false);
        if (oldSession != null) {
            oldSession.invalidate();
        }

        HttpSession newSession = req.getSession(true);
        newSession.setAttribute("user", user);
        String role = user.getRole();

        if ("admin".equalsIgnoreCase(role)) {
            resp.sendRedirect(req.getContextPath() + "/thong-ke");
        } else {
            resp.sendRedirect(req.getContextPath() + "/trang-chu");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}