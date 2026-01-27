package cleanmeat.controller;

import cleanmeat.cart.Cart;
import cleanmeat.model.User;
import cleanmeat.services.AddressService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/xac-nhan-dat-hang")
public class XacNhanDatHang extends HttpServlet {
    AddressService addressService = new AddressService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart");
        session.setAttribute("addressDefault", addressService.getDefaultAddress(user.getId()));
        // Nếu chưa đăng nhập, bắt buộc quay về trang login
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/dang-nhap");
            return;
        }

        // Nếu giỏ hàng trống, quay về trang giỏ hàng
        if (cart == null || cart.getList().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/gio-hang");
            return;
        }

        request.setAttribute("pageTitle", "Xác nhận đặt hàng");
        request.setAttribute("mainContent", "/view/xacnhandathang.jsp");
        request.setAttribute("pageCss", "/CSS/xacnhandathang.css");
        request.setAttribute("pageJS", "/JS/xacnhandathang.js");
        request.getRequestDispatcher("/view/base/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}