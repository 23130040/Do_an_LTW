package cleanmeat.controller;

import cleanmeat.dao.ItemDAO;
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
        request.setAttribute("pageCss", "/CSS/trang_chu.css");
        request.setAttribute("pageJS", "/JS/trang_chu.js");
        request.setAttribute("pageClass", "home");
        request.setAttribute("pageId", "home-menu");

        ItemDAO itemDAO = new ItemDAO();
        request.setAttribute("newProduct", itemDAO.getNewestItem());
        request.setAttribute("featuredProduct", itemDAO.getFeaturedItem());
        request.setAttribute("bestSellerProduct", itemDAO.getBestSellerItem());
        request.setAttribute("bestDealProduct", itemDAO.getBestDealItem());

        request.getRequestDispatcher("/view/base/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
