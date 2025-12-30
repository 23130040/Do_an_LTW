package cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "don-hang-cua-toi", value = "/don-hang-cua-toi")
public class DonHang extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageTitle", "Đơn hàng của tôi");
        request.setAttribute("mainContent", "/view/donhang.jsp");
        request.setAttribute("pageCss", "/CSS/donhang.css");
        request.setAttribute("pageJS", "/JS/donhang.js");
        request.getRequestDispatcher("/view/base/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}