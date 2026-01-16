package cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "SanPhamController", value = "/san-pham")
public class SanPham extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/view/san_pham.jsp")
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
        }

        request.getRequestDispatcher("/view/san_pham.jsp")
                .forward(request, response);
    }
}
