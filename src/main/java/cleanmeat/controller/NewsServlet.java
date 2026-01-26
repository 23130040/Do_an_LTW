package cleanmeat.controller;

import cleanmeat.dao.NewsDAO;
import cleanmeat.model.Item;
import cleanmeat.model.News;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "NewsServlet", value = "/quan-ly-tin-tuc")
public class NewsServlet extends HttpServlet {
    private NewsDAO newsDAO = new NewsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "delete":
                deleteNews(request, response);
                break;
            case "get":
                getNewsJson(request, response);
                break;
            case "list":
            default:
                listNews(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("save".equals(action)) {
            saveNews(request, response);
        }
    }

    private void listNews(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String search = request.getParameter("search");
        int page = 1;
        int pageSize = 5;

        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException ignored) {}
        }

        List<News> news = newsDAO.searchAndFilter(search, page, pageSize);
        int totalNews = newsDAO.countFilteredNews(search);
        int totalPages = (int) Math.ceil((double) totalNews / pageSize);

        int windowSize = 5;
        int startPage = Math.max(1, page - windowSize / 2);
        int endPage = Math.min(totalPages, startPage + windowSize - 1);
        if (endPage - startPage + 1 < windowSize) {
            startPage = Math.max(1, endPage - windowSize + 1);
        }

        request.setAttribute("newsList", news);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);
        request.setAttribute("selectedSearch", search);

        request.getRequestDispatcher("/view/admin_quan_ly_tin_tuc.jsp").forward(request, response);
    }

    private void saveNews(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idParam = request.getParameter("id");
        News n = new News();
        n.setTitle(request.getParameter("title"));
        n.setAuthor(request.getParameter("author"));
        n.setContent(request.getParameter("content"));
        n.setStatus(request.getParameter("status"));
        n.setPicture_url("default.jpg");

        if (idParam == null || idParam.isEmpty()) {
            try { newsDAO.insert(n); } catch (Exception e) { e.printStackTrace(); response.sendRedirect("quan-ly-tin-tuc"); }
        } else {
            newsDAO.update(n, Integer.parseInt(idParam));
            String page = request.getParameter("page");
            response.sendRedirect("quan-ly-tin-tuc?page=" + (page != null ? page : "1"));
        }

    }

    private void deleteNews(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            newsDAO.delete(id);
        } catch (Exception e) { e.printStackTrace(); }

        String page = request.getParameter("page");
        response.sendRedirect("quan-ly-tin-tuc?page=" + (page != null ? page : "1"));
    }

    private void getNewsJson(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            News n = newsDAO.findById(id);
            if (n != null) {
                String cleanContent = n.getContent()
                        .replace("\\", "\\\\")
                        .replace("\"", "\\\"")
                        .replace("\n", "\\n")
                        .replace("\r", "");

                String json = String.format(
                        "{\"id\":%d, \"title\":\"%s\", \"author\":\"%s\", \"content\":\"%s\", \"status\":\"%s\"}",
                        n.getId(), n.getTitle(), n.getAuthor(), cleanContent, n.getStatus()
                );
                response.getWriter().write(json);
            }
        } catch (Exception e) {
            response.setStatus(500);
        }
    }
}