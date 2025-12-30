package cleanmeat.services;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class OTPService {
    public static boolean verifyOtp(HttpServletRequest request, String inputOtp) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;

        String otp = (String) session.getAttribute("OTP_CODE");
        String emailInSession = (String) session.getAttribute("OTP_EMAIL");
        Long expire = (Long) session.getAttribute("OTP_EXPIRE");

        if (otp == null || expire == null) return false;
        if (System.currentTimeMillis() > expire) return false;

        boolean match = otp.equals(inputOtp);

        if (match) {
            session.setAttribute("EMAIL_VERIFIED", true);
            // QUAN TRỌNG: Phải giữ OTP_EMAIL lại để UserServlet đối chiếu
            // session.removeAttribute("OTP_CODE");
            session.removeAttribute("OTP_EXPIRE");
        }
        return match;
    }
}
