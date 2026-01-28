package cleanmeat.controller;

import cleanmeat.model.Address;
import cleanmeat.model.User;
import cleanmeat.services.AddressService;
import cleanmeat.services.EmailService;
import cleanmeat.services.UserService;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

@WebServlet(name = "tai-khoan", value = "/tai-khoan")
@MultipartConfig
public class TaiKhoan extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageTitle", "Tài khoản của tôi");
        request.setAttribute("pageCss", "/CSS/taikhoan.css");
        request.setAttribute("pageJS", "/JS/taikhoan.js");

        String tab = request.getParameter("tab");
        if ("dia-chi".equals(tab)) {
            request.setAttribute("pageContent", "/view/diachi_taikhoan.jsp");
            request.setAttribute("idContent", "address-content");
        } else if ("doi-mat-khau".equals(tab)) {
            request.setAttribute("pageContent", "/view/matkhau_taikhoan.jsp");
            request.setAttribute("idContent", "password-content");
        } else if ("cai-dat".equals(tab)) {
            request.setAttribute("pageContent", "/view/caidat_taikhoan.jsp");
            request.setAttribute("idContent", "setting-content");
        } else {
            request.setAttribute("pageContent", "/view/hoso_taikhoan.jsp");
            request.setAttribute("idContent", "profile-content");
        }

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user != null && user.getBirthday() != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            request.setAttribute("birthday", user.getBirthday().format(formatter));
        }

        if (user != null) {
            AddressService addressService = new AddressService();
            request.setAttribute("addresses", addressService.getUserAddresses(user.getId()));
            request.setAttribute("user", user);
        }

        request.setAttribute("mainContent", "/view/taikhoan.jsp");
        request.getRequestDispatcher("/view/base/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        User user = (User) session.getAttribute("user");
        UserService userService = new UserService();
        AddressService addressService = new AddressService();

        String contentType = request.getContentType();
        String action = request.getParameter("action");
        JsonObject body = null;

        // ====== NHẬN JSON BODY (AJAX) ======
        if (contentType != null && contentType.contains("application/json")) {
            String json = request.getReader().lines().reduce("", String::concat);
            body = JsonParser.parseString(json).getAsJsonObject();
            action = body.has("action") ? body.get("action").getAsString() : null;
        }

        try {
            if ("add".equals(action)) {
                String addressDetail = request.getParameter("address");
                Address address = new Address(user, addressDetail, false);
                addressService.addAddress(address);
                response.sendRedirect(request.getContextPath() + "/tai-khoan?tab=dia-chi");
            } else if ("setDefault".equals(action)) {
                int addressId = Integer.parseInt(request.getParameter("addressId"));
                addressService.setAddressDefault(user.getId(), addressId);
                response.sendRedirect(request.getContextPath() + "/tai-khoan?tab=dia-chi");
            } else if ("delete".equals(action)) {
                int addressId = Integer.parseInt(request.getParameter("addressId"));
                addressService.deleteAddress(addressId, user.getId());
                response.sendRedirect(request.getContextPath() + "/tai-khoan?tab=dia-chi");
            } else if ("update".equals(action)) {
                int addressId = Integer.parseInt(request.getParameter("addressId"));
                Address oldAddress = addressService.getAddressById(addressId);
                boolean isDefault = oldAddress.isDefaultAddress();
                String addressDetail = request.getParameter("address");
                Address newAddress = new Address(user, addressDetail, isDefault);
                addressService.updateAddress(newAddress, addressId, user.getId());
                response.sendRedirect(request.getContextPath() + "/tai-khoan?tab=dia-chi");
            } else if ("changePassword".equals(action)) {
                String oldPassword = request.getParameter("currentPassword");
                String newPassword = request.getParameter("newPassword");
                String confirmPassword = request.getParameter("confirmPassword");
                try {
                    userService.changePassword(user.getId(), oldPassword, newPassword, confirmPassword);
                    response.getWriter().write("{\"success\": true}");
                } catch (RuntimeException e) {
                    response.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
                }
                return;
            } else if ("delete-account".equals(action)) {
                String password = body.get("password").getAsString();
                boolean ok = userService.deleteAccount(user.getId(), password);

                if (ok) {
                    session.invalidate();
                    response.getWriter().write("{\"success\":true}");
                } else {
                    response.getWriter().write("{\"success\":false, \"message\":\"Mật khẩu không đúng\"}");
                }
                return;
            } else if ("updateProfile".equals(action)) {
                String oldEmail = user.getEmail();
                String name = body.get("name").getAsString();
                String email = body.get("email").getAsString();
                String phone = body.get("phone").getAsString();
                String avatar = body.has("avatar") && !body.get("avatar").isJsonNull()
                        ? body.get("avatar").getAsString()
                        : user.getAvatar();
                String gender = body.has("gender") && !body.get("gender").isJsonNull()
                        ? body.get("gender").getAsString()
                        : null;
                String birthdayStr = body.has("birthday") && !body.get("birthday").isJsonNull()
                        ? body.get("birthday").getAsString()
                        : null;

                if (gender != null) {
                    gender = switch (gender) {
                        case "male" -> "male";
                        case "female" -> "female";
                        default -> null;
                    };
                }

                LocalDate birthday = null;
                if (birthdayStr != null && !birthdayStr.isBlank()) {
                    if (birthdayStr.contains("/")) {
                        DateTimeFormatter f = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                        birthday = LocalDate.parse(birthdayStr, f);
                    } else {
                        birthday = LocalDate.parse(birthdayStr); // yyyy-MM-dd
                    }
                }
                try {
                    boolean emailChanged = !oldEmail.equalsIgnoreCase(email);

                    // Cập nhật Profile
                    userService.updateProfile(user.getId(), name, email, phone, gender, birthday, avatar);

                    if (emailChanged) {
                        String token = UUID.randomUUID().toString();
                        // 1. Cập nhật verify_token và đặt email_verified = false (0) trong DB
                        userService.updateEmailVerificationStatus(user.getId(), token, false);

                        // 2. Gửi email xác thực
                        String verifyLink = "http://localhost:8080" + request.getContextPath() + "/xac-thuc-email?token=" + token;
                        EmailService.sendVerifyEmail(email, name, verifyLink);

                        // Cập nhật lại đối tượng user trong session
                        user.setEmail_verified(false);
                        user.setVerify_token(token);
                    }

                    // Cập nhật thông tin mới vào session object
                    user.setName(name);
                    user.setEmail(email);
                    user.setPhone(phone);
                    user.setGender(gender);
                    user.setBirthday(birthday);
                    user.setAvatar(avatar);
                    session.setAttribute("user", user);

                    // Trả về JSON chính xác cho Client
                    JsonObject jsonResponse = new JsonObject();
                    jsonResponse.addProperty("success", true);
                    jsonResponse.addProperty("emailChanged", emailChanged);
                    jsonResponse.addProperty("newEmail", email);

                    response.getWriter().write(jsonResponse.toString());
                } catch (Exception e) {
                    e.printStackTrace();
                    response.setStatus(500);
                    response.getWriter().write("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
                }
                return;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}