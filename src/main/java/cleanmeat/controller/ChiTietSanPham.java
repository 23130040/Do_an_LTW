package cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "chi-tiet-san-pham", value = "/chi-tiet-san-pham")
public class ChiTietSanPham extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        // TODO: Lấy sản phẩm theo id từ DB
        // SanPham sp = sanPhamDAO.findById(id);
        // request.setAttribute("sp", sp);

        request.setAttribute("pageTitle", "Chi tiết sản phẩm");
        request.setAttribute("mainContent", "/view/chi_tiet_san_pham.jsp");
        request.setAttribute("pageCss", "/css/chi_tiet_san_pham.css");
        request.setAttribute("pageJS", "/js/chi_tiet_san_pham.js");

        request.getRequestDispatcher("/view/base/base.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("addCart".equals(action)) {
            String productId = request.getParameter("productId");
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // TODO: Xử lý thêm giỏ hàng (session/cart)
        }

        response.sendRedirect("chi-tiet-san-pham?id=" + request.getParameter("productId"));
    }
}
