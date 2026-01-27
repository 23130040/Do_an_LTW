package cleanmeat.controller;

import cleanmeat.model.User;
import cleanmeat.services.UserService;
import cleanmeat.security.AuthConstants;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "AdminDoiMatKhau", value = "/admin-doi-mat-khau")
public class AdminPassServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        boolean isGoogleAccount =
                user.getPassword() != null &&
                        user.getPassword().startsWith(AuthConstants.GOOGLE_ONLY_PREFIX);

        request.setAttribute("isGoogleAccount", isGoogleAccount);

        request.getRequestDispatcher("/view/admin_doi_mat_khau.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("dang-nhap");
            return;
        }

        User currentUser = (User) session.getAttribute("user");

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
            boolean isGoogleAccount =
                    currentUser.getPassword() != null
                            && currentUser.getPassword().startsWith(AuthConstants.GOOGLE_ONLY_PREFIX);

            if (isGoogleAccount) {
                userService.changePasswordForGoogleUser(
                        currentUser.getId(),
                        newPassword,
                        confirmPassword
                );
            } else {
                userService.changePassword(
                        currentUser.getId(),
                        oldPassword,
                        newPassword,
                        confirmPassword
                );
            }

            request.setAttribute("toastType", "success");
            request.setAttribute("toastMessage", "Đổi mật khẩu thành công!");

        } catch (RuntimeException e) {
            request.setAttribute("toastType", "danger");
            request.setAttribute("toastMessage", e.getMessage());
        }

        request.getRequestDispatcher("/view/admin_doi_mat_khau.jsp")
                .forward(request, response);
    }

}