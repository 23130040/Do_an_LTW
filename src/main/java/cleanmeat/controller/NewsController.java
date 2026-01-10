package cleanmeat.controller;

import cleanmeat.dao.NewsDAO;
import cleanmeat.model.News;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "news", value = "/tin-tuc")
public class NewsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        NewsDAO newsDAO = new NewsDAO();

        // ===== PHÂN TRANG =====
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        List<News> newsList = newsDAO.findByPage(page);
        int totalPages = newsDAO.countPages();

        // Format date
        for (News n : newsList) {
            if (n.getCreated_at() != null) {
                n.setFormattedDate(
                        java.sql.Date.valueOf(n.getCreated_at())
                );
            }
        }

        // ===== SET ATTRIBUTE =====
        request.setAttribute("newsList", newsList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.setAttribute("pageTitle", "Tin Tức");
        request.setAttribute("mainContent", "/view/tin_tuc.jsp");
        request.setAttribute("pageCss", "/CSS/tin_tuc.css");
        request.setAttribute("pageJS", "/JS/tin_tuc.js");

        request.getRequestDispatcher("/view/base/base.jsp")
                .forward(request, response);
    }
}
