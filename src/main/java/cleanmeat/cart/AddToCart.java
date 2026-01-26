package cleanmeat.cart;

import cleanmeat.model.Item;
import cleanmeat.services.ItemService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/them-vao-gio")
public class AddToCart extends HttpServlet {
    ItemService itemService = new ItemService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        int itemId = Integer.parseInt(request.getParameter("itemId"));
        Item item = itemService.getItemById(itemId);
        cart.addCartItem(new CartItem(item.getId(), item, 1));
        response.sendRedirect("san-pham");
    }
}