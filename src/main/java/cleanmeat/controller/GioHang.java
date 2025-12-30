package cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "gio-hang", value = "/gio-hang")
public class GioHang extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageTitle", "Giỏ hàng");
        request.setAttribute("mainContent", "/view/giohang.jsp");
        request.setAttribute("pageCss", "/CSS/giohang.css");
        request.setAttribute("pageJS", "/JS/giohang.js");
        request.getRequestDispatcher("/view/base/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}