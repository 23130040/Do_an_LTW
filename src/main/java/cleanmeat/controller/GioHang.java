package cleanmeat.controller;

import cleanmeat.cart.Cart;
import cleanmeat.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "gio-hang", value = "/gio-hang")
public class GioHang extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        request.setAttribute("pageTitle", "Giỏ hàng");
        request.setAttribute("mainContent", "/view/giohang.jsp");
        request.setAttribute("pageCss", "/CSS/giohang.css");
        request.setAttribute("pageJS", "/JS/giohang.js");
        request.getRequestDispatcher("/view/base/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}