package cleanmeat.controller;

import cleanmeat.dao.CategoryDAO;
import cleanmeat.dao.OriginDAO;
import cleanmeat.model.Category;
import cleanmeat.model.Origin;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OriginServlet", value = "/quanlynguongoc")
public class OriginServlet extends HttpServlet {
    private OriginDAO originDAO = new OriginDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.equals("list")) {
            List<Origin> list = originDAO.findAll(); // Lấy dữ liệu từ DB
            request.setAttribute("origin", list); // Đặt tên là "categories" để JSP dùng
            request.getRequestDispatcher("/view/admin_quan_ly_danh_muc.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String desc = request.getParameter("description");

        Origin newOrg = new Origin();
        newOrg.setName(name);
        newOrg.setDescription(desc);

        try {
            if(originDAO.insert(newOrg)) {
                response.sendRedirect("admin-origin?status=success");
            }
        } catch (Exception e) {
            response.sendRedirect("admin-origin?status=error");
        }
    }
}