package cleanmeat.controller;

import cleanmeat.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import cleanmeat.dao.FeedbackDAO;
import cleanmeat.model.Feedback;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "QuanLyDanhGia", value = "/quan-ly-danh-gia")
public class FeedbackServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String rate = request.getParameter("rating");
        String type = request.getParameter("type");
        String keyword = request.getParameter("search");
        String action = request.getParameter("action");

        FeedbackDAO feedbackDAO = new FeedbackDAO();

        rate = (rate == null) ? "" : rate;
        type = (type == null) ? "" : type;
        keyword = (keyword == null) ? "" : keyword;

        java.time.format.DateTimeFormatter timeFmt = java.time.format.DateTimeFormatter.ofPattern("HH:mm");
        java.time.format.DateTimeFormatter dateFmt = java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy");
        request.setAttribute("localTimeFmt", timeFmt);
        request.setAttribute("localDateFmt", dateFmt);


        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                feedbackDAO.delete(id);
                response.sendRedirect("quan-ly-danh-gia");
                return;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        int page = 1;
        int pageSize = 5;

        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException ignored) {
            }
        }

        List<Feedback> list = feedbackDAO.searchAndFilter( keyword, rate, type, page, pageSize);
        int totalRecords = feedbackDAO.countFilteredFeedbacks( keyword, rate, type);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        int windowSize = 5;
        int half = windowSize / 2;

        int startPage = page - half;
        if (startPage < 1) {
            startPage = 1;
        }

        if (startPage + windowSize - 1 > totalPages) {
            startPage = Math.max(1, totalPages - windowSize + 1);
        }

        int endPage = Math.min(totalPages, startPage + windowSize - 1);
        int totalReviews = list.size();

        double avgRating = 0;
        if (!list.isEmpty()) {
            int sum = 0;
            for (Feedback f : list) {
                sum += f.getRating();
            }
            avgRating = (double) sum / list.size();

            avgRating = Math.round(avgRating * 10.0) / 10.0;
        }


        request.setAttribute("feedbackList", list);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);
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