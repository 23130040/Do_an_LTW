package cleanmeat.controller;

import cleanmeat.dao.CategoryDAO;
import cleanmeat.dao.ItemDAO;
import cleanmeat.dao.OriginDAO;
import cleanmeat.dao.UnitDAO;
import cleanmeat.model.Item;
import cleanmeat.model.ItemImage;
import cleanmeat.model.Unit;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializer;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "ItemServlet", value = "/quan-ly-san-pham")
public class ItemServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ItemDAO itemDAO = new ItemDAO();
        String action = request.getParameter("action");
        if ("checkSKU".equals(action)) {
            String sku = request.getParameter("sku");
            String idStr = request.getParameter("id");
            int currentId = (idStr == null || idStr.isEmpty()) ? 0 : Integer.parseInt(idStr);

            boolean isDuplicate = itemDAO.checkSKUExists(sku, currentId);

            response.setContentType("text/plain");
            response.getWriter().write(isDuplicate ? "exists" : "ok");
            return;
        }
        if ("getEditData".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));

            Item item = itemDAO.findById(id);

            if (item == null) {
                response.sendError(404);
                return;
            }


            Gson gson = new GsonBuilder()
                    .registerTypeAdapter(LocalDate.class,
                            (JsonSerializer<LocalDate>) (src, type, ctx) -> new JsonPrimitive(src.toString()))

                    .registerTypeAdapter(LocalDateTime.class,
                            (JsonSerializer<LocalDateTime>) (src, type, ctx) -> new JsonPrimitive(src.toString()))

                    .serializeNulls()
                    .create();

            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(gson.toJson(item));
            return;
        }

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String currentPage = request.getParameter("page");
            if (currentPage == null) currentPage = "1";

            boolean success = itemDAO.delete(id);

            response.sendRedirect("quan-ly-san-pham?page=" + currentPage);
            return;
        } else {


            UnitDAO unitDAO = new UnitDAO();
            CategoryDAO categoryDAO = new CategoryDAO();
            OriginDAO originDAO = new OriginDAO();

            String search = request.getParameter("search");
            String category = request.getParameter("category");
            String origin = request.getParameter("origin");


            int page = 1;
            int pageSize = 5;

            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                } catch (NumberFormatException ignored) {
                }
            }

            List<Item> items = itemDAO.searchAndFilter(search, category, origin, page, pageSize);
            int totalItems = itemDAO.countFilteredItems(search, category, origin);
            int totalPages = (int) Math.ceil((double) totalItems / pageSize);

            int windowSize = 5;
            int half = windowSize / 2;

            int startPage = page - half;
            if (startPage < 1) {
                startPage = 1;
            }

            if (startPage + windowSize - 1 > totalPages) {
                startPage = Math.max(1, totalPages - windowSize + 1);
            }

            int endPage = Math.min(totalPages, startPage + windowSize - 1);

            request.setAttribute("items", items);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("startPage", startPage);
            request.setAttribute("endPage", endPage);

            request.setAttribute("selectedSearch", search);
            request.setAttribute("selectedCat", category);
            request.setAttribute("selectedOrg", origin);

            request.setAttribute("unitList", unitDAO.findAll());
            request.setAttribute("categories", categoryDAO.findAll());
            request.setAttribute("origin", originDAO.findAll());

            request.setAttribute("selectedSearch", search != null ? search : "");
            request.setAttribute("selectedCat", category != null ? category : "");
            request.setAttribute("selectedOrg", origin != null ? origin : "");

            request.getRequestDispatcher("/view/admin_quan_ly_sp.jsp").forward(request, response);
        }
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
        if ("updateItem".equals(action)) {
            handleUpdateItem(request, response);
        }
    }

    private void handleAddItem(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            ItemDAO itemDAO = new ItemDAO();
            Item item = new Item();

            item.setName(request.getParameter("name"));
            item.setShort_description(request.getParameter("shortDescription"));
            item.setLong_description(request.getParameter("longDescription"));
            item.setCategory_id(Integer.parseInt(request.getParameter("categoryId")));
            item.setOrigin_id(Integer.parseInt(request.getParameter("originId")));
            item.setUnit_id(Integer.parseInt(request.getParameter("unitId")));
            item.setPrice(Double.parseDouble(request.getParameter("price")));
            item.setDiscount(Double.parseDouble(request.getParameter("discount")));
            item.setSku(request.getParameter("sku"));
            item.setMin_stock(Integer.parseInt(request.getParameter("minStock")));
            item.setCurrent_stock(0);

            int itemId = itemDAO.insertAndReturnId(item);
            if (itemId <= 0) {
                throw new RuntimeException("Không thể tạo sản phẩm");
            }

            String selectedImages = request.getParameter("selectedImages");
            if (selectedImages != null && !selectedImages.isBlank()) {
                String[] images = selectedImages.split(",");

                for (int i = 0; i < images.length; i++) {
                    itemDAO.insertImage(itemId, images[i], i == 0 ? 1 : 0);
                }
            }

            response.sendRedirect("quan-ly-san-pham");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi thêm sản phẩm");
        }
    }

    private void handleUpdateItem(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            String currentPage = request.getParameter("currentPage");
            if (currentPage == null || currentPage.isEmpty()) {
                currentPage = "1";
            }
            int id = Integer.parseInt(request.getParameter("productId"));
            ItemDAO itemDAO = new ItemDAO();
            Item item = itemDAO.findById(id);

            if (item == null) {
                throw new RuntimeException("Sản phẩm không tồn tại");
            }

            item.setSku(request.getParameter("sku"));
            item.setName(request.getParameter("name"));
            item.setShort_description(request.getParameter("shortDescription"));
            item.setLong_description(request.getParameter("longDescription"));
            item.setCategory_id(Integer.parseInt(request.getParameter("categoryId")));
            item.setOrigin_id(Integer.parseInt(request.getParameter("originId")));
            item.setUnit_id(Integer.parseInt(request.getParameter("unitId")));
            item.setPrice(Double.parseDouble(request.getParameter("price")));
            item.setDiscount(Double.parseDouble(request.getParameter("discount")));
            item.setMin_stock(Integer.parseInt(request.getParameter("minStock")));

            itemDAO.update(item, id);

            itemDAO.deleteAllImagesByItemId(id);

            String selectedImages = request.getParameter("selectedImages");
            if (selectedImages != null && !selectedImages.isBlank()) {
                String[] images = selectedImages.split(",");

                for (int i = 0; i < images.length; i++) {
                    itemDAO.insertImage(id, images[i], i == 0 ? 1 : 0);
                }
            }

            response.sendRedirect("quan-ly-san-pham?page=" + currentPage);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi cập nhật sản phẩm");
        }
    }

}