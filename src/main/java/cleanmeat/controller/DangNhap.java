package cleanmeat.controller;

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
            try {
                userService.isEmailRegistered(resetEmail);
                String otp = OTPUtil.generateOTP();
                session.setAttribute("resetOtp", otp);
                session.setAttribute("resetEmail", resetEmail);
                session.setAttribute("otpExpire",
                        System.currentTimeMillis() + 5 * 60 * 1000); // 5 phút
                EmailService.sendOTP(resetEmail, otp);
                response.getWriter().write("""
                            {
                              "success": true,
                              "email": "%s"
                            }
                        """.formatted(resetEmail));
            } catch (Exception e) {
                response.getWriter().write("""
                            {
                              "success": false,
                              "message": "%s"
                            }
                        """.formatted(e.getMessage()));
            }
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