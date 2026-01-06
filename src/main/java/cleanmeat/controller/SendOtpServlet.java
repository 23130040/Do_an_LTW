package cleanmeat.controller;

import cleanmeat.services.EmailService;
import cleanmeat.services.OTPUtil;
import cleanmeat.services.OtpData;
import cleanmeat.services.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

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

        if (UserService.isEmailRegistered(email)) {
            response.getWriter().write("EMAIL_EXISTS");
            return;
        }

        HttpSession session = request.getSession();

        Map<String, OtpData> otpMap =
                (Map<String, OtpData>) session.getAttribute("OTP_MAP");

        if (otpMap == null) {
            otpMap = new HashMap<>();
        }

        String otp = OTPUtil.generateOTP();
        long expireAt = System.currentTimeMillis() + 5 * 60 * 1000;

        otpMap.put(email, new OtpData(otp, expireAt));
        session.setAttribute("OTP_MAP", otpMap);

        EmailService.sendOTP(email, otp);


        EmailService.sendOTP(email, otp);

        response.getWriter().write("OK");
    }
}