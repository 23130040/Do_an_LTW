package cleanmeat.controller;

import cleanmeat.dao.CategoryDAO;
import cleanmeat.dao.ItemDAO;
import cleanmeat.dao.OriginDAO;
import cleanmeat.dao.UnitDAO;
import cleanmeat.model.Item;
import cleanmeat.model.Unit;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ItemServlet", value = "/quanlysanpham")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class ItemServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ItemDAO itemDAO = new ItemDAO();
        UnitDAO unitDAO = new UnitDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        OriginDAO originDAO = new OriginDAO();

        int page = 1;
        int pageSize = 5;

        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException ignored) {}
        }

        List<Item> items = itemDAO.findByPage(page, pageSize);
        int totalItems = itemDAO.countItems();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        request.setAttribute("items", items);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.setAttribute("unitList", unitDAO.findAll());
        request.setAttribute("categories", categoryDAO.findAll());
        request.setAttribute("origin", originDAO.findAll());

        request.getRequestDispatcher("/view/admin_quan_ly_sp.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        UnitDAO unitDAO = new UnitDAO();

        if ("addUnit".equals(action)) {
            try {
                String rawInput = request.getParameter("name");
                int amount = Integer.parseInt(rawInput.replaceAll("[^0-9]", ""));
                String name = "";

                java.text.DecimalFormat df = new java.text.DecimalFormat("#.##");

                if (amount < 1000) {
                    name = amount + "g";
                } else {
                    double kgValue = (double) amount / 1000;
                    name = df.format(kgValue) + "kg";
                }

                Unit newUnit = new Unit(name, amount);
                boolean isInserted = unitDAO.insert(newUnit);

                if (isInserted) {
                    response.setContentType("text/plain");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("success");
                    response.getWriter().flush();
                }
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Lỗi: " + e.getMessage());
            }
            return;
        }
        if ("addItem".equals(action)) {
            handleAddItem(request, response);
        }
    }
    private void handleAddItem(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            Item item = new Item();

            item.setName(request.getParameter("name"));
            item.setShort_description(request.getParameter("shortDescription"));
            item.setLong_description(request.getParameter("longDescription"));

            item.setCategory_id(Integer.parseInt(request.getParameter("categoryId")));
            item.setOrigin_id(Integer.parseInt(request.getParameter("originId")));
            item.setUnit_id(Integer.parseInt(request.getParameter("unitId")));

            double price = Double.parseDouble(request.getParameter("price"));

            String discountRaw = request.getParameter("discount");

            double discount = 0;
            if (discountRaw != null && !discountRaw.trim().isEmpty()) {
                discount = Double.parseDouble(discountRaw);
            }

            if (discount < 0) discount = 0;
            if (discount > 100) discount = 100;


            item.setPrice(price);
            item.setDiscount(discount);


            item.setSku(request.getParameter("sku"));
            item.setMin_stock(Integer.parseInt(request.getParameter("minStock")));
            item.setCurrent_stock(0);

            Part imagePart = request.getPart("image");
            String imageUrl = null;

            if (imagePart != null && imagePart.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("/uploads");

                java.io.File uploadDir = new java.io.File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                imagePart.write(uploadPath + "/" + fileName);
                imageUrl = "uploads/" + fileName;
            }

            ItemDAO itemDAO = new ItemDAO();
            int itemId = itemDAO.insertAndReturnId(item);

            if (imageUrl != null) {
                itemDAO.insertImage(itemId, imageUrl);
            }

            response.sendRedirect("quanlysanpham");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi thêm sản phẩm");
        }
    }

}