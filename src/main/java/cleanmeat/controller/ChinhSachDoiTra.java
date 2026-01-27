package cleanmeat.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(
        name = "ChinhSachDoiTra",
        value = {"/chinh-sach-doi-tra"}
)
public class ChinhSachDoiTra extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("pageTitle", "Chính sách đổi trả");
        request.setAttribute("mainContent", "/view/chinh_sach_doi_tra.jsp");
        request.setAttribute("pageCss", "/CSS/chinh_sach_doi_tra.css");

        request.getRequestDispatcher("/view/base/base.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
