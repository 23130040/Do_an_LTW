package cleanmeat.controller;

import cleanmeat.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import cleanmeat.dao.FeedbackDAO;

import java.io.IOException;

@WebServlet(name = "ReplyFeedbackServlet", value = "/replyFeedback")
public class ReplyFeedbackServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int parentId = Integer.parseInt(request.getParameter("parentId"));
        String comment = request.getParameter("comment");

        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");
        int adminId = admin.getId();

        FeedbackDAO dao = new FeedbackDAO();
        boolean success = dao.insertReply(parentId, adminId, comment);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"success\":" + success + "}");
    }
}