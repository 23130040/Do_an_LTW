package cleanmeat.controller;

import cleanmeat.dao.ItemDAO;
import cleanmeat.dao.FeedbackDAO;
import cleanmeat.model.Item;
import cleanmeat.model.Feedback;
import cleanmeat.model.RatingSummary;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.*;

@WebServlet(
        name = "ChiTietSanPham",
        value = {"/chi-tiet-san-pham", "/product"}
)
public class ChiTietSanPham extends HttpServlet {

    private ItemDAO itemDAO;
    private FeedbackDAO feedbackDAO;

    @Override
    public void init() {
        itemDAO = new ItemDAO();
        feedbackDAO = new FeedbackDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /* ===== LẤY ID ===== */
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/san-pham");
            return;
        }

        int itemId;
        try {
            itemId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/san-pham");
            return;
        }

        /* ===== LẤY SẢN PHẨM HIỆN TẠI ===== */
        Item currentItem = itemDAO.findById(itemId);
        if (currentItem == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        /* ===== SKU BASE ===== */
        String sku = currentItem.getSku();
        if (sku == null || sku.length() < 2) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }

        String baseSku = sku.substring(0, sku.length() - 2);

        List<Item> variantList = itemDAO.findBySkuBase(baseSku);
        if (variantList == null) {
            variantList = new ArrayList<>();
        }

        Item baseItem = currentItem;

        RatingSummary rating =
                feedbackDAO.getRatingSummaryByItemId(baseItem.getId());
        if (rating == null) {
            rating = new RatingSummary(5.0, 0);
        }

        List<Feedback> feedbackList =
                feedbackDAO.findByItemId(baseItem.getId());

        if (feedbackList == null) {
            feedbackList = new ArrayList<>();
        }

        /* ===== ĐẨY SANG JSP ===== */
        request.setAttribute("variantList", variantList);
        request.setAttribute("rating", rating);
        request.setAttribute("feedbackList", feedbackList);
        request.setAttribute("baseItem", currentItem);

        request.setAttribute("pageTitle", currentItem.getName());
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
