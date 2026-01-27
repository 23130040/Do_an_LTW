package cleanmeat.controller;

import cleanmeat.dao.ItemDAO;
import cleanmeat.model.Item;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(
        name = "ChiTietSanPham",
        value = {"/chi-tiet-san-pham", "/product"}
)
public class ChiTietSanPham extends HttpServlet {

    private ItemDAO itemDAO;

    @Override
    public void init() {
        itemDAO = new ItemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ===== LẤY ID TỪ URL =====
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/san-pham");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/san-pham");
            return;
        }

        // ===== LẤY SẢN PHẨM =====
        Item item = itemDAO.findById(id);
        if (item == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // ===== ĐẨY DỮ LIỆU SANG JSP =====
        request.setAttribute("sp", item);

        request.setAttribute("pageTitle", item.getName());
        request.setAttribute("mainContent", "/view/chi_tiet_san_pham.jsp");
        request.setAttribute("pageCss", "/CSS/chi_tiet_san_pham.css");
        request.setAttribute("pageJS", "/JS/chi_tiet_san_pham.js");

        request.getRequestDispatcher("/view/base/base.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("addCart".equals(action)) {

            int itemId = Integer.parseInt(request.getParameter("itemId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            HttpSession session = request.getSession();

            @SuppressWarnings("unchecked")
            Map<Integer, Integer> cart =
                    (Map<Integer, Integer>) session.getAttribute("cart");

            if (cart == null) {
                cart = new HashMap<>();
            }

            cart.put(itemId, cart.getOrDefault(itemId, 0) + quantity);
            session.setAttribute("cart", cart);

            response.sendRedirect(
                    request.getContextPath() + "/product?id=" + itemId
            );
            return;
        }

        response.sendRedirect(request.getContextPath() + "/san-pham");
    }
}
