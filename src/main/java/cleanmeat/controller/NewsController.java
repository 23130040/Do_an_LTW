package cleanmeat.controller;

import cleanmeat.dao.NewsDAO;
import cleanmeat.model.News;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "news", value = "/tin-tuc")
public class NewsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        NewsDAO newsDAO = new NewsDAO();
        List<News> newsList = newsDAO.findAll();

        for (News n : newsList) {
            if (n.getCreated_at() != null) {
                n.setFormattedDate(
                        Date.valueOf(n.getCreated_at())
                );
            }
        }

        request.setAttribute("newsList", newsList);

        request.setAttribute("pageTitle", "Tin Tức");
        request.setAttribute("mainContent", "/view/tin_tuc.jsp");
        request.setAttribute("pageCss", "/CSS/tin_tuc.css");
        request.setAttribute("pageJS", "/JS/tin_tuc.js");

        request.getRequestDispatcher("/view/base/base.jsp")
                .forward(request, response);
    }
}
