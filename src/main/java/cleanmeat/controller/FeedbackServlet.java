package cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import cleanmeat.dao.FeedbackDAO;
import cleanmeat.model.Feedback;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "QuanLyDanhGia", value = "/quanlydanhgia")
public class FeedbackServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String rate = request.getParameter("rating");
        String type = request.getParameter("type");
        String keyword = request.getParameter("search");

        rate = (rate == null) ? "" : rate;
        type = (type == null) ? "" : type;
        keyword = (keyword == null) ? "" : keyword;

        java.time.format.DateTimeFormatter timeFmt = java.time.format.DateTimeFormatter.ofPattern("HH:mm");
        java.time.format.DateTimeFormatter dateFmt = java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy");
        request.setAttribute("localTimeFmt", timeFmt);
        request.setAttribute("localDateFmt", dateFmt);

        FeedbackDAO dao = new FeedbackDAO();
        List<Feedback> list = dao.applyFilterAndSearch(rate, type, keyword);
        int totalReviews = list.size();

        double avgRating = 0;
        if (!list.isEmpty()) {
            int sum = 0;
            for (Feedback f : list) {
                sum += f.getRating();
            }
            avgRating = (double) sum / list.size();

            // làm tròn 1 chữ số thập phân cho đẹp
            avgRating = Math.round(avgRating * 10.0) / 10.0;
        }


        request.setAttribute("feedbackList", list);
        request.setAttribute("totalReviews", totalReviews);
        request.setAttribute("avgRating", avgRating);
        request.setAttribute("selectedRate", rate);
        request.setAttribute("selectedType", type);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher("/view/admin_quan_ly_danh_gia.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}