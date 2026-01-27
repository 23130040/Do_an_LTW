package cleanmeat.controller;

import cleanmeat.model.Address;
import cleanmeat.model.User;
import cleanmeat.services.AddressService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/dia-chi")
public class DiaChi extends HttpServlet {
    AddressService addressService = new AddressService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String addressText = request.getParameter("address");

        Address address = new Address(user, addressText, false);

        try {
            addressService.addAddress(address);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect(request.getContextPath() + "/xac-nhan-dat-hang");
    }
}