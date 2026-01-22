package cleanmeat.controller;

import cleanmeat.dao.*;
import cleanmeat.model.Stock_history;
import cleanmeat.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "StockServlet", value = "/quan-ly-kho")
public class StockServlet extends HttpServlet {
    private static final int PAGE_SIZE = 6;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String currentTab = request.getParameter("tab");
        if (currentTab == null || (!currentTab.equals("input_history") && !currentTab.equals("output_history"))) {
            currentTab = "input_history";
        }

        String type = currentTab.equals("input_history") ? "Nhap" : "Xuat";

        UnitDAO unitDAO = new UnitDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        OriginDAO originDAO = new OriginDAO();
        StockDAO stockDao = new StockDAO();

        String search = request.getParameter("search");
        String category = request.getParameter("category");
        String origin = request.getParameter("origin");

        int page = 1;
        int pageSize = 5;

        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException ignored) {}
        }

        List<Stock_history> list = stockDao.searchAndFilter(type, search, category, origin, page, pageSize);
        int totalRecords = stockDao.countSearchFilter(type, search, category, origin);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);



        ItemDAO itemDao = new ItemDAO();
        request.setAttribute("selectedSearch", search);
        request.setAttribute("selectedCat", category);
        request.setAttribute("selectedOrg", origin);
        request.setAttribute("stockList", list);
        request.setAttribute("items", itemDao.findAll());
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("activeTab", currentTab);
        request.setAttribute("categories", categoryDAO.findAll());
        request.setAttribute("origin", originDAO.findAll());

        request.getRequestDispatcher("/view/admin_quan_ly_kho.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        User currentUser = (User) session.getAttribute("user");


        try {
            String itemStr = request.getParameter("item");
            String type = request.getParameter("type");
            String quantityStr = request.getParameter("quantity");

            if (itemStr == null || quantityStr == null || type == null) {
                response.sendRedirect(request.getContextPath() + "/quanlykho?status=error");
                return;
            }

            int itemId = Integer.parseInt(itemStr);
            int quantity = Integer.parseInt(quantityStr);

            int userId = currentUser.getId();

            StockDAO stockDao = new StockDAO();
            boolean success = stockDao.createStockTransaction(itemId, type, quantity, userId);

            if (success) {
                String targetTab = type.equals("Nhap") ? "input_history" : "output_history";
                response.sendRedirect(request.getContextPath() + "/quanlykho?status=success&tab=" + targetTab);
            } else {
                response.sendRedirect(request.getContextPath() + "/quanlykho?status=error");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/quanlykho?status=invalid_input");
        }
    }
}