package cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "chi-tiet-tin-tuc", value = "/chi-tiet-tin-tuc")
public class ChiTietTinTuc extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        // Lấy dữ liệu tin tức từ DB theo id
        // TinTuc tin = tinTucDAO.findById(id);
        // request.setAttribute("tin", tin);

        request.setAttribute("pageTitle", "Chi tiết tin tức");
        request.setAttribute("mainContent", "/view/chi_tiet_tin_tuc.jsp");
        request.setAttribute("pageCss", "/CSS/chi_tiet_tin_tuc.css");

        request.getRequestDispatcher("/view/base/base.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }
}
