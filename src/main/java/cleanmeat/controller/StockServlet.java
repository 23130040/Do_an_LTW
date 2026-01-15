package cleanmeat.controller;

import cleanmeat.dao.StockDao;
import cleanmeat.model.Item;
import cleanmeat.dao.ItemDAO;
import cleanmeat.model.Stock_history;
import cleanmeat.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "StockServlet", value = "/quanlykho")
public class StockServlet extends HttpServlet {
    private static final int PAGE_SIZE = 6;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            page = Integer.parseInt(pageParam);
        }

        StockDao stockDao = new StockDao();

        List<Stock_history> list = stockDao.findByPage(page, PAGE_SIZE);
        int totalRecords = stockDao.countAll();
        int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);

        ItemDAO itemDao = new ItemDAO();
        List<Item> itemList = itemDao.findAll();

        request.setAttribute("stockList", list);
        request.setAttribute("items", itemList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

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

            StockDao stockDao = new StockDao();
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