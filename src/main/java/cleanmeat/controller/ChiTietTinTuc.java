package cleanmeat.controller;

import cleanmeat.dao.NewsDAO;
import cleanmeat.model.News;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "chi-tiet-tin-tuc", value = "/chi-tiet-tin-tuc")
public class ChiTietTinTuc extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null) {
            response.sendRedirect("tin-tuc");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("tin-tuc");
            return;
        }

        NewsDAO newsDAO = new NewsDAO();
        News news = newsDAO.findById(id);

        if (news == null) {
            response.sendRedirect("tin-tuc");
            return;
        }

        request.setAttribute("news", news);

        // Cột phải: tin mới nhất
        request.setAttribute("latestNews", newsDAO.findLatest(3));

        request.setAttribute("pageTitle", news.getTitle());
        request.setAttribute("mainContent", "/view/chi_tiet_tin_tuc.jsp");
        request.setAttribute("pageCss", "/css/chi_tiet_tin_tuc.css");

        request.getRequestDispatcher("/view/base/base.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }
}
