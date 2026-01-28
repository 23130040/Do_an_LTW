package cleanmeat.controller;

import cleanmeat.dao.ItemDAO;
import cleanmeat.dao.FeedbackDAO;
import cleanmeat.dao.OriginDAO;
import cleanmeat.model.Item;
import cleanmeat.model.Feedback;
import cleanmeat.model.RatingSummary;
import cleanmeat.model.Origin;

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
    private OriginDAO originDAO; // ✅ THÊM

    @Override
    public void init() {
        itemDAO = new ItemDAO();
        feedbackDAO = new FeedbackDAO();
        originDAO = new OriginDAO(); // ✅ THÊM
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

        Item sp = itemDAO.findById(itemId);
        if (sp == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String sku = sp.getSku();
        if (sku == null || sku.length() < 2) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }

        String baseSku = sku.substring(0, sku.length() - 2);

        List<Item> variantList = itemDAO.findBySkuBase(baseSku);
        if (variantList == null) {
            variantList = new ArrayList<>();
        }

        Item baseItem = variantList.isEmpty() ? sp : variantList.get(0);

        RatingSummary rating =
                feedbackDAO.getRatingSummaryByItemId(sp.getId());
        if (rating == null) {
            rating = new RatingSummary(0.0, 0);
        }

        List<Feedback> feedbackList =
                feedbackDAO.findByItemId(sp.getId());
        if (feedbackList == null) {
            feedbackList = new ArrayList<>();
        }

        Origin origin = null;
        if (baseItem.getOrigin_id() > 0) {
            origin = originDAO.findById(baseItem.getOrigin_id());
        }
        request.setAttribute("origin", origin);

        request.setAttribute("sp", sp);
        request.setAttribute("baseItem", baseItem);
        request.setAttribute("variantList", variantList);
        request.setAttribute("rating", rating);
        request.setAttribute("feedbackList", feedbackList);

        request.setAttribute("pageTitle", baseItem.getName());
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

            String itemIdRaw = request.getParameter("itemId");
            String qtyRaw = request.getParameter("quantity");

            if (itemIdRaw == null || qtyRaw == null) {
                response.sendRedirect(request.getContextPath() + "/san-pham");
                return;
            }

            int itemId;
            int quantity;

            try {
                itemId = Integer.parseInt(itemIdRaw);
                quantity = Integer.parseInt(qtyRaw);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/san-pham");
                return;
            }

            if (quantity < 1) quantity = 1;

            HttpSession session = request.getSession();

            @SuppressWarnings("unchecked")
            Map<Integer, Integer> cart =
                    (Map<Integer, Integer>) session.getAttribute("cart");

            if (cart == null) {
                cart = new HashMap<>();
            }

            cart.put(itemId, cart.getOrDefault(itemId, 0) + quantity);
            session.setAttribute("cart", cart);

            Item addedItem = itemDAO.findById(itemId);
            if (addedItem != null && addedItem.getSku() != null) {

                String sku = addedItem.getSku();
                if (sku.length() >= 2) {
                    String baseSku = sku.substring(0, sku.length() - 2);
                    List<Item> list = itemDAO.findBySkuBase(baseSku);

                    if (list != null && !list.isEmpty()) {
                        response.sendRedirect(
                                request.getContextPath()
                                        + "/product?id=" + list.get(0).getId()
                        );
                        return;
                    }
                }
            }

            response.sendRedirect(request.getContextPath() + "/san-pham");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/san-pham");
    }
}