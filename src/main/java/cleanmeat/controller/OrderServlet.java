package cleanmeat.controller;

import cleanmeat.dao.OrderDAO;
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
        List<Order> orderList = orderDAO.findAll();

        request.setAttribute("orders", orderList);

        request.getRequestDispatcher("/view/admin_quan_ly_don_hang.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}