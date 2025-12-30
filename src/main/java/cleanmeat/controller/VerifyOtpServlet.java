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
        boolean valid = OTPService.verifyOtp(request, inputOtp);

        response.setContentType("text/plain");
        response.getWriter().write(valid ? "OK" : "FAIL");
    }
}