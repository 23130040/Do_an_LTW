package cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/dang-xuat")
public class DangXuat extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String from = request.getParameter("from");

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        if ("admin".equals(from)) {
            response.sendRedirect(request.getContextPath() + "/dang-nhap");
        } else {
            response.sendRedirect(request.getContextPath() + "/trang-chu");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}