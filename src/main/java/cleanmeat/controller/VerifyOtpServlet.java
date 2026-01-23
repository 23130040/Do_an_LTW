package cleanmeat.controller;

import cleanmeat.services.OTPService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "VerifyOtpServlet", value = "/verify-otp")
public class VerifyOtpServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String inputOtp = request.getParameter("otp");
        String inputEmail = request.getParameter("email");
        boolean valid = OTPService.verifyOtp(request, inputOtp, inputEmail);
        response.setContentType("text/plain");
        response.getWriter().write(valid ? "OK" : "FAIL");
    }
}