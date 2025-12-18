package vn.edu.hcmuaf.fit.do_an_ltw.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.do_an_ltw.dao.FeedbackDAO;
import vn.edu.hcmuaf.fit.do_an_ltw.model.Feedback;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "GetFeedbackHistoryServlet", value = "/getFeedbackHistory")
public class GetFeedbackHistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        FeedbackDAO dao = new FeedbackDAO();
        List<Feedback> history = dao.getChatHistoryByUserId(userId);

        StringBuilder json = new StringBuilder();
        json.append("[");
        for (int i = 0; i < history.size(); i++) {
            Feedback f = history.get(i);
            json.append("{");
            json.append("\"id\":").append(f.getId()).append(",");
            json.append("\"response_id\":").append(f.getResponse_id()).append(",");
            json.append("\"comment\":\"").append(escapeJson(f.getComment())).append("\",");
            json.append("\"created_at\":\"").append(f.getCreated_at()).append("\"");
            json.append("}");
            if (i < history.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json.toString());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }

}