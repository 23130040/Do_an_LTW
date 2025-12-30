package cleanmeat.controller;

import cleanmeat.dao.NewsDAO;
import cleanmeat.model.News;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "NewsServlet", value = "/quanlytintuc")
public class NewsServlet extends HttpServlet {
    private NewsDAO newsDAO = new NewsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<News> newsList = newsDAO.findAll();
        request.setAttribute("newsList", newsList);
        request.getRequestDispatcher("/view/admin_quan_ly_tin_tuc.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}