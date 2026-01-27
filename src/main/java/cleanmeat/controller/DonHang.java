package cleanmeat.controller;

import cleanmeat.model.Order;
import cleanmeat.model.User;
import cleanmeat.services.OrderService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "don-hang-cua-toi", value = "/don-hang-cua-toi")
public class DonHang extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/dang-nhap");
            return;
        }

        OrderService orderService = new OrderService();
        List<Order> orders = orderService.getListOrder(user.getId());

        request.setAttribute("orders", orders);
        request.setAttribute("waitingOrders", orderService.getListOrderWaiting(user.getId()));
        request.setAttribute("deliveringOrders", orderService.getListOrderDelivering(user.getId()));
        request.setAttribute("doneOrders", orderService.getListOrderDone(user.getId()));
        request.setAttribute("cancleOrders", orderService.getListOrderCancle(user.getId()));
        request.setAttribute("pageTitle", "Đơn hàng của tôi");
        request.setAttribute("mainContent", "/view/donhang.jsp");
        request.setAttribute("pageCss", "/CSS/donhang.css");
        request.setAttribute("pageJS", "/JS/donhang.js");
        request.getRequestDispatcher("/view/base/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}