package cleanmeat.services;

import cleanmeat.dao.OrderDAO;
import cleanmeat.model.Order;

import java.util.List;

public class OrderService {
    OrderDAO orderDAO = new OrderDAO();

    public List<Order> getListOrder(int userId) {
        return orderDAO.findByUserId(userId);
    }

    public Order getOrderDetail(int orderId, int userId) {
        return orderDAO.findByIdAndUser(orderId, userId);
    }
}
