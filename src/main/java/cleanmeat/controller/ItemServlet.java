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
    }
}