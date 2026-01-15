package cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "san-pham", value = "/san-pham")
public class SanPham extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("pageTitle", "Sản Phẩm");
        request.setAttribute("mainContent", "/view/san_pham.jsp");
        request.setAttribute("pageCss", "/CSS/san_pham.css");
        request.setAttribute("pageJS", "/JS/san_pham.js");

        request.getRequestDispatcher("/view/base/base.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("search".equals(action)) {
            String keyword = request.getParameter("keyword");
            request.setAttribute("keyword", keyword);
        }

        if ("addCart".equals(action)) {
            String productId = request.getParameter("productId");
            //  xử lý thêm giỏ hàng
        }

        request.setAttribute("pageTitle", "Sản Phẩm");
        request.setAttribute("mainContent", "/view/san_pham.jsp");
        request.setAttribute("pageCss", "/css/san_pham.css");

        request.getRequestDispatcher("/view/base/base.jsp")
                .forward(request, response);
    }
}
