package cleanmeat.controller;

import cleanmeat.dao.ItemDAO;
import cleanmeat.model.Item;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "san-pham", value = "/san-pham")
public class SanPham extends HttpServlet {

    private final ItemDAO itemDAO = new ItemDAO();
    private static final int PAGE_SIZE = 16;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String categoryParam = request.getParameter("category");
        String origin = request.getParameter("origin");
        String sort = request.getParameter("sort");

        String categoryDB = categoryParam;
        if ("bo".equals(categoryParam)) {
            categoryDB = "1";
        } else if ("heo".equals(categoryParam)) {
            categoryDB = "2";
        } else if ("ga".equals(categoryParam)) {
            categoryDB = "3";
        }

        if (sort == null || sort.isBlank()) {
            sort = "default";
        }

        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (Exception ignored) {}

        List<Item> items = itemDAO.searchAndFilterForSanPham(
                keyword,
                categoryDB,
                origin,
                sort,
                page,
                PAGE_SIZE
        );

        int totalItems = itemDAO.countFilteredItems(
                keyword,
                categoryDB,
                origin
        );

        int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);

        // ===== SET ATTRIBUTE =====
        request.setAttribute("items", items);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.setAttribute("keyword", keyword);
        request.setAttribute("category", categoryParam);
        request.setAttribute("origin", origin);
        request.setAttribute("sort", sort);

        request.setAttribute("pageTitle", "Sản phẩm");
        request.setAttribute("mainContent", "/view/san_pham.jsp");
        request.setAttribute("pageCss", "/CSS/san_pham.css");
        request.setAttribute("pageJS", "/JS/san_pham.js");

        request.getRequestDispatcher("/view/base/base.jsp")
                .forward(request, response);
    }
}
