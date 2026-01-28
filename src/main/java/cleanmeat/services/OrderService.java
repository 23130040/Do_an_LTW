package cleanmeat.services;

import cleanmeat.cart.Cart;
import cleanmeat.cart.CartItem;
import cleanmeat.dao.OrderDAO;
import cleanmeat.dao.OrderItemDAO;
import cleanmeat.model.Address;
import cleanmeat.model.Order;
import cleanmeat.model.OrderItem;
import cleanmeat.model.User;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderService {
    OrderDAO orderDAO = new OrderDAO();

    public List<Order> getListOrder(int userId) {
        return orderDAO.findByUserId(userId);
    }

    public Order getOrderDetail(int orderId, int userId) {
        return orderDAO.findByIdAndUser(orderId, userId);
    }

    public boolean placeOrder(User user, Cart cart, int addressId) {
        Order order = new Order();
        order.setUser(user);

        Address addr = new Address();
        addr.setId(addressId);
        order.setAddress(addr);

        order.setTotal_price(cart.getTotal());
        order.setStatus("Chờ Xác Nhận");

        List<OrderItem> items = new ArrayList<>();
        for (CartItem ci : cart.getList()) {
            items.add(new OrderItem(
                    ci.getItem(),
                    ci.getItem().getPrice(),
                    ci.getQuantity()
            ));
        }
        order.setListItem(items);
        try {
            return orderDAO.insert(order);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Order> getListOrderWaiting(int userId) {
        List<Order> orders = new ArrayList<>();
        for (Order o : getListOrder(userId)) {
            if (o.getStatus().equalsIgnoreCase("Chờ Xác Nhận")) {
                orders.add(o);
            }
        }
        return orders;
    }

    public List<Order> getListOrderDelivering(int userId) {
        List<Order> orders = new ArrayList<>();
        for (Order o : getListOrder(userId)) {
            if (o.getStatus().equalsIgnoreCase("Đang Giao")) {
                orders.add(o);
            }
        }
        return orders;
    }

    public List<Order> getListOrderDone(int userId) {
        List<Order> orders = new ArrayList<>();
        for (Order o : getListOrder(userId)) {
            if (o.getStatus().equalsIgnoreCase("Đã Giao")) {
                orders.add(o);
            }
        }
        return orders;
    }

    public List<Order> getListOrderCancle(int userId) {
        List<Order> orders = new ArrayList<>();
        for (Order o : getListOrder(userId)) {
            if (o.getStatus().equalsIgnoreCase("Đã Hủy")) {
                orders.add(o);
            }
        }
        return orders;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        return orderDAO.updateStatus(orderId, status);
    }

}
