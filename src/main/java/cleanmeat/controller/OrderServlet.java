package cleanmeat.controller;

import cleanmeat.dao.OrderDAO;
import cleanmeat.model.Item;
import cleanmeat.model.Order;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderServlet", value = "/quan-ly-don-hang")
public class OrderServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String search = request.getParameter("search");
        String status = request.getParameter("status");

        int page = 1;
        int pageSize = 5;

        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException ignored) {}
        }else{



        List<Order> orders = orderDAO.searchAndFilter(search, status, page, pageSize);

        int totalItems = orderDAO.countFilteredOrders(search, status);
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        request.setAttribute("orders", orders);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("searchKeyword", search);
        request.setAttribute("selectedStatus", status);

        request.getRequestDispatcher("/view/admin_quan_ly_don_hang.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}