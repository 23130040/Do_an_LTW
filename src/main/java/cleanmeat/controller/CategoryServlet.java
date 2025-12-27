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

@WebServlet(name = "CategoryServlet", value = "/quanlydanhmuc")
public class CategoryServlet extends HttpServlet {
    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categoryList = categoryDAO.findAll();
        request.setAttribute("categories", categoryList);

        OriginDAO originDAO = new OriginDAO();
        List<Origin> originList = originDAO.findAll();
        request.setAttribute("origin", originList);

        String activeTab = request.getParameter("tab");
        if (activeTab == null) activeTab = "QuanLyDanhMuc";
        request.setAttribute("activeTab", activeTab);

        request.getRequestDispatcher("/view/admin_quan_ly_danh_muc.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String desc = request.getParameter("description");

        Category newCat = new Category();
        newCat.setName(name);
        newCat.setDescription(desc);

        try {
            if(categoryDAO.insert(newCat)) {
                response.sendRedirect("admin-category?status=success");
            }
        } catch (Exception e) {
            response.sendRedirect("admin-category?status=error");
        }
    }
}