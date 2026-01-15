package cleanmeat.dao;

import cleanmeat.model.Item;
import cleanmeat.model.Order;
import cleanmeat.model.OrderItem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDAO extends BaseDAO<OrderItem> {

    OrderDAO orderDAO = new OrderDAO();
    ItemDAO itemDAO = new ItemDAO();

    public List<OrderItem> findByOrderId(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String sql = """
                select * from order_item where order_id = ?;
                """;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();
            Order order = orderDAO.findById(orderId);
            while (rs.next()) {
                Item item = itemDAO.findById(rs.getInt("item_id"));
                OrderItem orderItem = new OrderItem(
                        order,
                        item,
                        rs.getDouble("price"),
                        rs.getDouble("quantity"),
                        rs.getDate("creates_at").toLocalDate());
                orderItems.add(orderItem);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            close(rs, ps, conn);
        }
        return orderItems;
    }

    @Override
    protected void loadAll() {
    }

    @Override
    protected OrderItem mapResultSetToEntity(ResultSet rs) throws SQLException {
        return null;
    }

    @Override
    public boolean insert(OrderItem orderItem) throws SQLException, ClassNotFoundException {
        return false;
    }

    @Override
    public boolean update(OrderItem orderItem, int id) {
        return false;
    }

    @Override
    public boolean delete(int id) {
        return false;
    }

    @Override
    public OrderItem findById(int id) {
        return null;
    }

    @Override
    public List<OrderItem> findAll() {
        return List.of();
    }
}
