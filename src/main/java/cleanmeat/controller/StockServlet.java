package cleanmeat.controller;

import cleanmeat.dao.StockDao;
import cleanmeat.model.Item;
import cleanmeat.dao.ItemDAO;
import cleanmeat.model.Stock_history;
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

    }
}