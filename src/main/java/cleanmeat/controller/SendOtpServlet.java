package cleanmeat.controller;

import cleanmeat.services.EmailService;
import cleanmeat.services.OTPUtil;
import cleanmeat.services.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "SendOtpServlet", value = "/send-otp")
public class SendOtpServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("text/plain; charset=UTF-8");
        String email = request.getParameter("email");

        if (email == null || email.isEmpty()) {
            response.getWriter().write("INVALID_EMAIL");
            return;
        }

        UserService userService = new UserService();
        if (userService.isEmailRegistered(email)) {
            response.getWriter().write("EMAIL_EXISTS");
            return;
        }

        HttpSession session = request.getSession();
        String otp = OTPUtil.generateOTP();

        session.setAttribute("OTP_CODE", otp);
        session.setAttribute("OTP_EMAIL", email);
        session.setAttribute("OTP_EXPIRE", System.currentTimeMillis() + 5 * 60 * 1000);

        EmailService.sendOTP(email, otp);

        response.getWriter().write("OK");
    }
}