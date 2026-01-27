package cleanmeat.controller;

import cleanmeat.dao.OrderDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "UpdateOrderStatusServlet", value = "//update-order-status")
public class UpdateOrderStatusServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            String status = req.getParameter("status");

            OrderDAO dao = new OrderDAO();
            boolean success = dao.updateStatus(orderId, status);

            resp.getWriter().write(
                    "{\"success\": " + success + "}"
            );
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write(
                    "{\"success\": false, \"message\": \"Lỗi dữ liệu\"}"
            );
        }
    }
}