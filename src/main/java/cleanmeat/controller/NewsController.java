package cleanmeat.controller;

import cleanmeat.dao.NewsDAO;
import cleanmeat.model.News;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/tin-tuc")
public class NewsController extends HttpServlet {

    private NewsDAO newsDAO = new NewsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (Exception e) {
                page = 1;
            }
        }

        int totalPages = newsDAO.countPages();

        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;

        List<News> newsList = newsDAO.findByPage(page);

        request.setAttribute("newsList", newsList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.setAttribute("pageTitle", "Tin Tức");
        request.setAttribute("mainContent", "/view/tin_tuc.jsp");
        request.setAttribute("pageCss", "/CSS/tin_tuc.css");

        request.getRequestDispatcher("/view/base/base.jsp")
                .forward(request, response);

    }
}
