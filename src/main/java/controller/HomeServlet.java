package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(
        name = "HomeServlet",
        urlPatterns = {"/home", "/gioithieu"}
)
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        if (uri.endsWith("/gioithieu")) {
            req.setAttribute("pageTitle", "Giới thiệu");
            req.setAttribute("pageCss", "gioithieu.css");
            req.setAttribute("mainContent", "../view/gioithieu.jsp");
        } else {
            req.setAttribute("pageTitle", "Trang chủ");
            req.setAttribute("pageCss", "home.css"); // nếu chưa có thì có thể bỏ
            req.setAttribute("mainContent", "../view/home.jsp");
        }


        req.getRequestDispatcher("/web/view/base.jsp")
                .forward(req, resp);
    }
}
