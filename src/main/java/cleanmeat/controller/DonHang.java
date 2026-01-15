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
        request.setAttribute("pageTitle", "Đơn hàng của tôi");
        request.setAttribute("mainContent", "/view/donhang.jsp");
        request.setAttribute("pageCss", "/CSS/donhang.css");
        request.setAttribute("pageJS", "/JS/donhang.js");
        request.getRequestDispatcher("/view/base/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        OrderService orderService = new OrderService();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        List<Order> orders = orderService.getListOrder(user.getId());
        request.setAttribute("orders", orders);
    }
}