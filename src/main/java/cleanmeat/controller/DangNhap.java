package cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import cleanmeat.model.User;
import cleanmeat.services.UserService;

import java.io.IOException;

@WebServlet(name = "dang-nhap", value = "/dang-nhap")
public class DangNhap extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/view/dangnhap.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService userService = new UserService();
        User user = userService.login(request.getParameter("email"), request.getParameter("password"));

        if (user != null) {
            request.getSession().setAttribute("user", user);

            String role = user.getRole();

            if ("admin".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/view/admin_thong_ke.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/trang-chu");
            }
            return;
        } else {
            request.setAttribute("errorMessage", "Email hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/view/dangnhap.jsp").forward(request, response);
        }
    }
}