package cleanmeat.controller;

import cleanmeat.dao.CategoryDAO;
import cleanmeat.dao.OriginDAO;
import cleanmeat.model.Origin;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "OriginServlet", value = "/quanlynguongoc")
public class OriginServlet extends HttpServlet {
    OriginDAO originDAO = new OriginDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            originDAO.delete(id);
            response.sendRedirect("quanlydanhmuc?tab=QuanLyNguonGoc&status=deleted");
            return;
        }
        request.setAttribute("categories", new CategoryDAO().findAll());
        request.setAttribute("origin", new OriginDAO().findAll());

        String activeTab = request.getParameter("tab");
        if (activeTab == null) activeTab = "QuanLyNguonGoc";
        request.setAttribute("activeTab", activeTab);

        request.getRequestDispatcher("/view/admin_quan_ly_danh_muc.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("originName");
        String code = request.getParameter("originCode");

        Origin newOrg = new Origin();
        newOrg.setName(name);
        newOrg.setDescription(code);

        try {
            if(originDAO.insert(newOrg)) {
                response.sendRedirect("quanlydanhmuc?tab=QuanLyNguonGoc&status=success");
            } else {
                response.sendRedirect("quanlydanhmuc?tab=QuanLyNguonGoc&status=fail");
            }
        } catch (Exception e) {
            response.sendRedirect("quanlydanhmuc?tab=QuanLyNguonGoc&status=error");
        }
    }
}