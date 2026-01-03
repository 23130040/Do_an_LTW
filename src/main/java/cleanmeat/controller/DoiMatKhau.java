package cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "doi-mat-khau", value = "/doi-mat-khau")
public class DoiMatKhau extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageContent", "/view/matkhau_taikhoan.jsp");
        request.setAttribute("idContent", "password-content");
        request.getRequestDispatcher("/tai-khoan").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}