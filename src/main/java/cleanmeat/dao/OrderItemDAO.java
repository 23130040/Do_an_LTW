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

    ItemDAO itemDAO = new ItemDAO();

    public List<OrderItem> findByOrderId(int orderId) {
        List<OrderItem> list = new ArrayList<>();
        String sql = """
                    SELECT oi.*, i.*
                    FROM order_item oi
                    JOIN item i ON oi.item_id = i.id
                    WHERE oi.order_id = ?
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Item item = itemDAO.mapResultSetToEntity(rs);
                OrderItem oi = new OrderItem(
                        item,
                        rs.getDouble("price"),
                        rs.getInt("quantity")
                );
                list.add(oi);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;
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
