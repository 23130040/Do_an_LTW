package cleanmeat.controller;

import cleanmeat.model.*;
import cleanmeat.services.OrderService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.time.ZoneId;

@WebServlet(name = "chi-tiet-don-hang", value = "/chi-tiet-don-hang")
public class ChiTietDonHang extends HttpServlet {
    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/dang-nhap");
            return;
        }

        int orderId;
        try {
            orderId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/don-hang-cua-toi");
            return;
        }

        Order order = orderService.getOrderDetail(orderId, user.getId());
        if (order == null) {
            response.sendRedirect(request.getContextPath() + "/don-hang-cua-toi");
            return;
        }
        java.util.Date createdDate = java.util.Date.from(order.getCreated_at().atZone(ZoneId.systemDefault()).toInstant());

        request.setAttribute("order", order);
        request.setAttribute("created_at", createdDate);
        request.setAttribute("pageTitle", "Chi tiết đơn hàng");
        request.setAttribute("mainContent", "/view/chitietdonhang.jsp");
        request.setAttribute("pageCss", "/CSS/chitietdonhang.css");
        request.setAttribute("pageJS", "/JS/chitietdonhang.js");
        request.getRequestDispatcher("/view/base/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}