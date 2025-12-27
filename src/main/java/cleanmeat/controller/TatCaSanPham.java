package cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "tat-ca-san-pham", value = "/tat-ca-san-pham")
public class TatCaSanPham extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String page = request.getParameter("page");
        String keyword = request.getParameter("keyword");
        String category = request.getParameter("category");

        // TODO:
        // List<SanPham> list = sanPhamDAO.findAll(page, keyword, category);
        // int totalPage = sanPhamDAO.getTotalPage();

        request.setAttribute("pageTitle", "Tất cả sản phẩm");
        request.setAttribute("mainContent", "/view/tat_ca_san_pham.jsp");
        request.setAttribute("pageCss", "/css/tat_ca_san_pham.css");

        request.getRequestDispatcher("/view/base/base.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String category = request.getParameter("category");

        response.sendRedirect(
                "tat-ca-san-pham?keyword=" + keyword + "&category=" + category
        );
    }
}
