package vn.edu.hcmuaf.fit.do_an_ltw.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.do_an_ltw.model.User;
import vn.edu.hcmuaf.fit.do_an_ltw.services.UserService;

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
            response.sendRedirect(request.getContextPath() + "/trang-chu");
            return;
        }
    }
}