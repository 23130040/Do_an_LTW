package cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "tin-tuc", value = "/tin-tuc")
public class TinTuc extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("pageTitle", "Tin Tức");
        request.setAttribute("mainContent", "/view/tin_tuc.jsp");
        request.setAttribute("pageCss", "/css/tin_tuc.css");
        request.setAttribute("pageJS", "/js/tin_tuc.js");

        request.getRequestDispatcher("/view/base/base.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
