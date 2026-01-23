package cleanmeat.controller;

import cleanmeat.dao.StatisticDAO;
import cleanmeat.model.ProductStatisticDTO;
import cleanmeat.model.StatisticDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "StatisticalServlet", value = "/thong-ke")
public class StatisticalServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        StatisticDAO dao = new StatisticDAO();

        StatisticDTO stats = dao.getGeneralStatistics();
        request.setAttribute("stats", stats);

        List<ProductStatisticDTO> topProducts = dao.getTopSellingProducts();
        request.setAttribute("topProducts", topProducts);

        request.getRequestDispatcher("/view/admin_thong_ke.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}