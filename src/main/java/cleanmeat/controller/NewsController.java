package cleanmeat.controller;

import cleanmeat.dao.NewsDAO;
import cleanmeat.model.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/tin-tuc")
public class NewsController extends HttpServlet {

    private final NewsDAO newsDAO = new NewsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int page = 1;

        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException ignored) {}

        int totalPages = newsDAO.countPages();
        if (totalPages < 1) totalPages = 1;

        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;

        List<News> newsList = newsDAO.findByPage(page);

        request.setAttribute("newsList", newsList);
        request.setAttribute("latestNews", newsDAO.findLatest(3));
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.setAttribute("pageTitle", "Tin Tức");
        request.setAttribute("mainContent", "/view/tin_tuc.jsp");
        request.setAttribute("pageCss", "/CSS/tin_tuc.css");

        request.getRequestDispatcher("/view/base/base.jsp")
                .forward(request, response);
    }
}
