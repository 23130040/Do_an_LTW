package cleanmeat.controller;

import cleanmeat.model.User;
import cleanmeat.services.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "dang-ky", value = "/dang-ky")
@MultipartConfig
public class DangKy extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/view/dangky.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        UserService userService = new UserService();
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        try {
            userService.signup(name, email, password, confirmPassword);
            response.getWriter().write("""
                    {
                        "status": "success",
                        "message": "Đăng ký thành công"
                    }
                    """);
        } catch (RuntimeException e) {
            response.getWriter().write("""
                    {
                        "status": "error",
                        "message": "%s"
                    }
                    """.formatted(e.getMessage()));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}