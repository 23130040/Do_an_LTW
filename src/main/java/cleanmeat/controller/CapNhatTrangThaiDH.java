package cleanmeat.controller;

import cleanmeat.services.OrderService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/cap-nhat-trang-thai-don-hang")
public class CapNhatTrangThaiDH extends HttpServlet {
    OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        String status = req.getParameter("status");

        boolean ok = orderService.updateOrderStatus(orderId, status);

        resp.setContentType("application/json;charset=UTF-8");
        resp.getWriter().write("{\"success\": " + ok + "}");
    }
}