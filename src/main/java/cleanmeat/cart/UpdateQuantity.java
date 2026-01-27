package cleanmeat.cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/cap-nhat-so-luong")
public class UpdateQuantity extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            response.sendError(400);
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        cart.updateQuantity(id, quantity);

        CartItem item = cart.getList()
                .stream()
                .filter(ci -> ci.getId() == id)
                .findFirst()
                .orElse(null);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        response.getWriter().write("""
                {
                  "subTotal": %.0f,
                  "cartTotal": %.0f,
                  "totalQuantity": %d
                }
                """.formatted(
                item != null ? item.getSubTotal() : 0,
                cart.getTotal(),
                cart.getTotalQuantity()
        ));
    }
}
