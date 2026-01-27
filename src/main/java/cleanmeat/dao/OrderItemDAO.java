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
                    SELECT
                                             oi.price AS oi_price,
                                             oi.quantity,
                                             i.id AS item_id,
                                             i.name AS item_name
                                         FROM order_item oi
                                         JOIN item i ON oi.item_id = i.id
                                         WHERE oi.order_id = ?
                """;
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, orderId);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Item item = new Item();
                    item.setId(rs.getInt("item_id"));
                    item.setName(rs.getString("item_name"));

                    OrderItem oi = new OrderItem(
                            item,
                            rs.getDouble("oi_price"),
                            rs.getInt("quantity")
                    );
                    list.add(oi);
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
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
