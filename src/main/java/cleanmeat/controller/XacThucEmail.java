package cleanmeat.controller;

import cleanmeat.services.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/xac-thuc-email")
public class XacThucEmail extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String token = request.getParameter("token");
        if (token == null || token.isEmpty()) {
            response.getWriter().write("Token không hợp lệ.");
            return;
        }
        boolean verified = userService.verifyEmailByToken(token);
        if (verified) {
            response.getWriter().write("Xác minh email thành công. Bạn có thể đăng nhập.");
        } else {
            response.getWriter().write("Link xác minh không hợp lệ hoặc đã hết hạn.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}