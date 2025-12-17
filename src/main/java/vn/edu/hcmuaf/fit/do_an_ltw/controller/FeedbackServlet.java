package vn.edu.hcmuaf.fit.do_an_ltw.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.do_an_ltw.dao.FeedbackDAO;
import vn.edu.hcmuaf.fit.do_an_ltw.model.Feedback;

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

        request.setAttribute("feedbackList", list);
        request.setAttribute("selectedRate", rate);
        request.setAttribute("selectedType", type);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher("admin_quan_ly_danh_gia.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}