package cleanmeat.controller;

import cleanmeat.dao.UserDAO;
import cleanmeat.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "ho-so", value = "/ho-so")
public class HoSo extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageContent", "/view/hoso_taikhoan.jsp");
        request.setAttribute("idContent", "profile-content");
        request.getRequestDispatcher("/tai-khoan").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}