package cleanmeat.controller;

import cleanmeat.model.Address;
import cleanmeat.model.User;
import cleanmeat.services.AddressService;
import cleanmeat.services.UserService;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "tai-khoan", value = "/tai-khoan")
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

        if (session == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String action = request.getParameter("action");
        AddressService addressService = new AddressService();
        UserService userService = new UserService();

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
                userService.changePassword(user.getId(), oldPassword, newPassword, confirmPassword);
                response.sendRedirect(request.getContextPath() + "/tai-khoan?tab=doi-mat-khau");
            } else if ("delete-account".equals(action)) {
                String json = request.getReader().lines().reduce("", (acc, line) -> acc + line);
                JsonObject body = JsonParser.parseString(json).getAsJsonObject();
                String password = body.get("password").getAsString();

                try {
                    boolean success = userService.deleteAccount(user.getId(), password);
                    var writer = response.getWriter();
                    if (success) {
                        session.invalidate();
                        writer.write("{\"success\": true}");
                    } else {
                        writer.write("{\"success\": false, \"message\": \"Mật khẩu không đúng\"}");
                    }
                } catch (Exception e) {
                    response.getWriter().write("{\"success\": false, \"message\": \"Lỗi hệ thống\"}");
                }
                return;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}