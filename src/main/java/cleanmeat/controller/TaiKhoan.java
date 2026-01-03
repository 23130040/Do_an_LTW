package cleanmeat.controller;

import cleanmeat.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "tai-khoan", value = "/tai-khoan")
public class TaiKhoan extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageTitle", "Tài khoản của tôi");

        request.setAttribute("pageCss", "/CSS/taikhoan.css");
        request.setAttribute("pageJS", "/JS/taikhoan.js");

        if (request.getAttribute("pageContent") == null) {
            request.setAttribute("pageContent", "/view/hoso_taikhoan.jsp");
            request.setAttribute("idContent", "profile-content");
        }

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user != null && user.getBirthday() != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

            request.setAttribute("birthday", user.getBirthday().format(formatter));
        }

        if  (user != null) {
            request.setAttribute("user", user);
        }

        request.setAttribute("mainContent", "/view/taikhoan.jsp");
        request.getRequestDispatcher("/view/base/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}