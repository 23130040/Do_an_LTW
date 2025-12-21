package vn.edu.hcmuaf.fit.do_an_ltw.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;

@WebServlet(name = "Home", value = "/trang-chu")
public class TrangChu extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageTitle", "Trang chủ");
        request.setAttribute("mainContent", "/view/trang_chu.jsp");
        request.setAttribute("pageCss", "/css/trang_chu.css");
        request.setAttribute("pageJS", "/js/trang_chu.js");
        request.setAttribute("pageClass", "home");
        request.setAttribute("pageId", "home-menu");
        request.getRequestDispatcher("/view/base/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
