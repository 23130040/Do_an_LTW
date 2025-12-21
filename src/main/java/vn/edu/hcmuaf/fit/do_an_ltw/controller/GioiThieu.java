package vn.edu.hcmuaf.fit.do_an_ltw.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "gioi-thieu", value = "/gioi-thieu")
public class GioiThieu extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageTitle", "Giới Thiệu");
        request.setAttribute("mainContent", "/view/gioithieu.jsp");
        request.setAttribute("pageCss", "/css/gioithieu.css");
        request.setAttribute("pageJS", "/js/gioithieu.js");
        request.getRequestDispatcher("/view/base/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}