package cleanmeat.controller;

import cleanmeat.dao.CategoryDAO;
import cleanmeat.dao.ItemDAO;
import cleanmeat.dao.OriginDAO;
import cleanmeat.dao.UnitDAO;
import cleanmeat.model.Item;
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
import java.util.Collection;
import java.util.List;

@WebServlet(name = "ItemServlet", value = "/quanlysanpham")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 50 * 1024 * 1024
)
public class ItemServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ItemDAO itemDAO = new ItemDAO();
        String action = request.getParameter("action");
        if ("getEditData".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Item item = itemDAO.findById(id);

            Gson gson = new GsonBuilder()
                    .registerTypeAdapter(
                            LocalDate.class,
                            (JsonSerializer<LocalDate>) (src, typeOfSrc, context) ->
                                    new JsonPrimitive(src.toString())
                    )
                    .serializeNulls()
                    .create();

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            String json = gson.toJson(item);
            response.getWriter().write(json);
            response.getWriter().flush();
            return;
        }
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String currentPage = request.getParameter("page");
            if (currentPage == null) currentPage = "1";

            boolean success = itemDAO.delete(null, id);

            response.sendRedirect("quanlysanpham?page=" + currentPage);
            return;
        }


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
        if ("updateItem".equals(action)) {
            handleUpdateItem(request, response);
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

            ItemDAO itemDAO = new ItemDAO();
            int itemId = itemDAO.insertAndReturnId(item);

            if (itemId != -1) {
                // Lấy tất cả các Part từ request
                Collection<Part> parts = request.getParts();
                String uploadPath = getServletContext().getRealPath("/images");
                java.io.File uploadDir = new java.io.File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                String baseFileName = ""; // Lưu tên gốc của ảnh chính
                int photoIndex = 0;

                for (Part part : parts) {
                    // Kiểm tra part có phải là input file (tên "images") và có dữ liệu không
                    if (part.getName().equals("images") && part.getSize() > 0) {
                        String originalFileName = part.getSubmittedFileName();
                        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
                        String finalFileName;
                        int isPrimary = 0;

                        if (photoIndex == 0) {
                            // ẢNH ĐẦU TIÊN (PRIMARY)
                            baseFileName = System.currentTimeMillis() + "_main";
                            finalFileName = baseFileName + extension;
                            isPrimary = 1;
                        } else {
                            // CÁC ẢNH SAU (tên_chính + _n)
                            finalFileName = baseFileName + "_" + photoIndex + extension;
                            isPrimary = 0;
                        }

                        // Lưu file vật lý
                        part.write(uploadPath + java.io.File.separator + finalFileName);

                        // Lưu thông tin vào DB
                        itemDAO.insertImage(itemId, finalFileName, isPrimary);

                        photoIndex++;
                    }
                }
            }

            response.sendRedirect("quanlysanpham");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi thêm sản phẩm");
        }
    }
    private void handleUpdateItem(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            int id = Integer.parseInt(request.getParameter("productId"));
            ItemDAO itemDAO = new ItemDAO();
            Item item = itemDAO.findById(id);

            // 1. Cập nhật các thông tin văn bản
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

            // 2. Xử lý Update nhiều ảnh
            Collection<Part> parts = request.getParts();
            // Kiểm tra xem người dùng có chọn file mới nào không
            boolean hasNewImages = parts.stream().anyMatch(p -> p.getName().equals("images") && p.getSize() > 0);

            if (hasNewImages) {
                itemDAO.deleteAllImagesByItemId(id);

                String uploadPath = getServletContext().getRealPath("/images");
                String baseFileName = System.currentTimeMillis() + "_main";
                int photoIndex = 0;

                for (Part part : parts) {
                    if (part.getName().equals("images") && part.getSize() > 0) {
                        String originalName = part.getSubmittedFileName();
                        String extension = originalName.substring(originalName.lastIndexOf("."));
                        String finalFileName;
                        int isPrimary = (photoIndex == 0) ? 1 : 0;

                        if (photoIndex == 0) {
                            finalFileName = baseFileName + extension;
                        } else {
                            finalFileName = baseFileName + "_" + photoIndex + extension;
                        }

                        part.write(uploadPath + java.io.File.separator + finalFileName);
                        itemDAO.insertImage(id, finalFileName, isPrimary);

                        photoIndex++;
                    }
                }
            }

            itemDAO.update(item, id);
            response.sendRedirect("quanlysanpham");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi cập nhật sản phẩm và bộ ảnh");
        }
    }

}