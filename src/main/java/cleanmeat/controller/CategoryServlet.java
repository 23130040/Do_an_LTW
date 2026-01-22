package cleanmeat.controller;

import cleanmeat.dao.CategoryDAO;
import cleanmeat.dao.OriginDAO;
import cleanmeat.model.Category;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "CategoryServlet", value = "/quan-ly-danh-muc")
public class CategoryServlet extends HttpServlet {
    private CategoryDAO categoryDAO = new CategoryDAO();
    private OriginDAO originDAO = new OriginDAO();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            categoryDAO.delete(id);
            response.sendRedirect("quanlydanhmuc?tab=QuanLyDanhMuc&status=deleted");
            return;
        }
        request.setAttribute("categories", categoryDAO.findAll());
        request.setAttribute("origin", originDAO.findAll());

        String activeTab = request.getParameter("tab");
        if (activeTab == null) activeTab = "QuanLyDanhMuc";
        request.setAttribute("activeTab", activeTab);

        request.getRequestDispatcher("/view/admin_quan_ly_danh_muc.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String desc = request.getParameter("description");

        Category newCat = new Category(name, desc);
        try {
            if(categoryDAO.insert(newCat)) {
                response.sendRedirect("quanlydanhmuc?tab=QuanLyDanhMuc&status=success");
            } else {
                response.sendRedirect("quanlydanhmuc?tab=QuanLyDanhMuc&status=fail");
            }
        } catch (Exception e) {
            response.sendRedirect("quanlydanhmuc?tab=QuanLyDanhMuc&status=error");
        }
    }
}