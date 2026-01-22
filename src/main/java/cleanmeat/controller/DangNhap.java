package cleanmeat.controller;

import cleanmeat.security.HashUtil;
import cleanmeat.security.OTPUtil;
import cleanmeat.services.EmailService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import cleanmeat.model.User;
import cleanmeat.services.UserService;

import java.io.IOException;

@WebServlet(name = "dang-nhap", value = "/dang-nhap")
public class DangNhap extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/view/dangnhap.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        UserService userService = new UserService();
        //quên mật khẩu
        if ("quen-mat-khau".equals(action)) {
            String resetEmail = request.getParameter("resetEmail");
            if (resetEmail == null || resetEmail.trim().isEmpty()) {
                response.getWriter().write("""
                            {
                              "success": false,
                              "message": "Email không được để trống"
                            }
                        """);
                return;
            }
            if (!userService.isEmailRegistered(resetEmail)) {
                response.getWriter().write("""
                            {
                              "success": false,
                              "message": "Email không tồn tại"
                            }
                        """);
                return;
            }
            String otp = OTPUtil.generateOTP();
            session.setAttribute("resetOtp", otp);
            session.setAttribute("resetEmail", resetEmail);
            session.setAttribute("otpExpire", System.currentTimeMillis() + 5 * 60 * 1000);
            EmailService.sendOTP(resetEmail, otp);
            response.getWriter().write("""
                        {
                          "success": true,
                          "email": "%s"
                        }
                    """.formatted(resetEmail));
            return;
        }
        //xác thực otp
        if ("xac-minh-otp".equals(action)) {
            String inputOtp = request.getParameter("otp");
            String sessionOtp = (String) session.getAttribute("resetOtp");
            Long expireTime = (Long) session.getAttribute("otpExpire");
            if (sessionOtp == null || expireTime == null) {
                response.getWriter().write("""
                            {
                              "success": false,
                              "message": "OTP không tồn tại hoặc đã hết hạn"
                            }
                        """);
                return;
            }
            if (System.currentTimeMillis() > expireTime) {
                session.removeAttribute("resetOtp");
                response.getWriter().write("""
                            {
                              "success": false,
                              "message": "OTP đã hết hạn"
                            }
                        """);
                return;
            }
            if (!sessionOtp.equals(inputOtp)) {
                response.getWriter().write("""
                            {
                              "success": false,
                              "message": "OTP không chính xác"
                            }
                        """);
                return;
            }
            session.setAttribute("otpVerified", true);
            session.removeAttribute("resetOtp");
            response.getWriter().write("""
                        {
                          "success": true
                        }
                    """);
            return;
        }
        //gửi lại otp
        if ("gui-lai-otp".equals(action)) {
            String email = (String) session.getAttribute("resetEmail");
            String otp = OTPUtil.generateOTP();
            session.setAttribute("resetOtp", otp);
            session.setAttribute("otpExpire",
                    System.currentTimeMillis() + 5 * 60 * 1000);
            EmailService.sendOTP(email, otp);
            response.getWriter().write("""
                        {
                          "success": true,
                          "message": "Đã gửi lại mã OTP"
                        }
                    """);
            return;
        }
        //đổi mật khẩu
        if ("doi-mat-khau".equals(action)) {
            Boolean otpVerified = (Boolean) session.getAttribute("otpVerified");
            String email = (String) session.getAttribute("resetEmail");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmNewPassword");
            if (otpVerified == null || !otpVerified || email == null) {
                response.getWriter().write("""
                            {
                              "success": false,
                              "message": "Phiên đặt lại mật khẩu không hợp lệ"
                            }
                        """);
                return;
            }
            if (newPassword == null || newPassword.isEmpty()) {
                response.getWriter().write("""
                            {
                              "success": false,
                              "message": "Mật khẩu không được để trống"
                            }
                        """);
                return;
            }
            if (!newPassword.equals(confirmPassword)) {
                response.getWriter().write("""
                            {
                              "success": false,
                              "message": "Mật khẩu xác nhận không khớp"
                            }
                        """);
                return;
            }
            String hashedPassword = HashUtil.md5(newPassword);
            boolean success = userService.resetPasswordByEmail(email, hashedPassword);
            if (success) {
                session.removeAttribute("otpVerified");
                session.removeAttribute("resetEmail");
                session.removeAttribute("otpExpire");
                response.getWriter().write("""
                            {
                              "success": true,
                              "message": "Đổi mật khẩu thành công"
                            }
                        """);
            } else {
                response.getWriter().write("""
                            {
                              "success": false,
                              "message": "Đổi mật khẩu thất bại"
                            }
                        """);
            }
            return;
        }
        //đăng nhập
        try {
            User user = userService.login(request.getParameter("email"), request.getParameter("password"));
            session.setAttribute("user", user);
            String role = user.getRole();
            if ("admin".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/view/admin_thong_ke.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/trang-chu");
            }
        } catch (RuntimeException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/view/dangnhap.jsp").forward(request, response);
        }
    }
}