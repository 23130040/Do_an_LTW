package cleanmeat.controller;

import cleanmeat.dao.OrderItemDAO;
import cleanmeat.model.OrderItem;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializer;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "OrderDetailServlet", value = "/OrderDetailServlet")
public class OrderDetailServlet extends HttpServlet {
    private OrderItemDAO oiDAO = new OrderItemDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");

        String idStr = request.getParameter("id");

        if (idStr == null || idStr.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing order id");
            return;
        }

        int orderId;
        try {
            orderId = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid order id");
            return;
        }

        List<OrderItem> items = oiDAO.findByOrderId(orderId);

        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDate.class,
                        (JsonSerializer<LocalDate>) (src, type, ctx) ->
                                new JsonPrimitive(src.toString()))
                .create();

        response.getWriter().write(gson.toJson(items));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}