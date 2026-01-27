package cleanmeat.controller;

import cleanmeat.dao.UserDAO;
import cleanmeat.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet(name = "InfomationAdminServlet", value = "/admin-thong-tin-tai-khoan")
public class InfomationAdminServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User currentUser = (User) session.getAttribute("user");


        request.setAttribute("currentUser", currentUser);
        request.getRequestDispatcher("/view/admin_thong_tin_tai_khoan.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User currentUser = (User) session.getAttribute("user");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String birthdayStr = request.getParameter("birthday");

        LocalDate birthday = null;
        if (birthdayStr != null && !birthdayStr.isEmpty()) {
            birthday = LocalDate.parse(birthdayStr);
        }

        userDAO.updateProfile(currentUser.getId(), name, email, phone, gender, birthday, currentUser.getAvatar());

        User refreshedUser = userDAO.findById(currentUser.getId());
        session.setAttribute("user", refreshedUser);

        response.sendRedirect(request.getContextPath() + "/admin-thong-tin-tai-khoan");
    }

}