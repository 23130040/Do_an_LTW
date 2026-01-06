package cleanmeat.services;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.util.Map;

public class OTPService {
    public static boolean verifyOtp(HttpServletRequest request,
                                    String inputOtp,
                                    String inputEmail) {

        HttpSession session = request.getSession(false);
        if (session == null) return false;

        Map<String, OtpData> otpMap =
                (Map<String, OtpData>) session.getAttribute("OTP_MAP");

        if (otpMap == null) return false;

        OtpData data = otpMap.get(inputEmail);
        if (data == null) return false;

        if (data.isExpired()) {
            otpMap.remove(inputEmail);
            return false;
        }

        if (!data.getOtp().equals(inputOtp)) return false;

        session.setAttribute("EMAIL_VERIFIED", true);
        session.setAttribute("VERIFIED_EMAIL", inputEmail);

        otpMap.remove(inputEmail);

        return true;
    }

}
