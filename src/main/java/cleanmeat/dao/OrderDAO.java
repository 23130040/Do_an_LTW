package cleanmeat.dao;

import cleanmeat.model.Address;
import cleanmeat.model.Order;
import cleanmeat.model.OrderItem;
import cleanmeat.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderDAO extends BaseDAO<Order> {
    private OrderItemDAO oiDAO = new OrderItemDAO();
    private UserDAO userDAO = new UserDAO();
    private AddressDAO addressDAO = new AddressDAO();
    private Map<Integer, Order> orderMap = new HashMap<>();

    public OrderDAO() {
        orderMap = new HashMap<Integer, Order>();
        loadAll();
    }

    @Override
    protected void loadAll() {
        String sql = "SELECT * FROM order ORDER BY id ASC";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = mapResultSetToEntity(rs);
                    order.setListItem(oiDAO.findByOrderId(order.getId()));
                    orderMap.put(order.getId(), order);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            ConnectionPool.getInstance().releaseConnection(conn);
        }
    }

    @Override
    protected Order mapResultSetToEntity(ResultSet rs) throws SQLException {
        int id = rs.getInt("id");
        User user = userDAO.findById(rs.getInt("user_id"));
        Address address = addressDAO.findById(rs.getInt("address_id"));
        double totalPrice = rs.getDouble("total_price");
        String status = rs.getString("status");
        LocalDate created_at = rs.getDate("created_at").toLocalDate();
        LocalDate updated_at = rs.getDate("updated_at").toLocalDate();
        return new Order(id, user, address, totalPrice, status, created_at, updated_at);
    }

    @Override
    public boolean insert(Order order) throws SQLException, ClassNotFoundException {
        String sql = """
                insert into order(user_id, address_id, total_price, status)
                values(?, ?, ?, ?)
                """;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);
            ps = conn.prepareStatement(sql);
            ps.setInt(1, order.getUser().getId());
            ps.setInt(2, order.getAddress().getId());
            ps.setDouble(3, order.getTotal_price());
            ps.setString(4, order.getStatus());

            if (ps.executeUpdate() == 0) return false;
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                order.setId(rs.getInt(1));
                orderMap.put(order.getId(), order);
            }
            return true;
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            close(rs, ps, conn);
        }
    }

    @Override
    public boolean update(Order order, int id) {
        String sql = """
                update order 
                set status = ?
                where id = ?
                """;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = getConnection();
            conn.setAutoCommit(false);
            ps = conn.prepareStatement(sql);
            ps.setString(1, order.getStatus());
            ps.setInt(2, id);
            if (ps.executeUpdate() > 0) {
                orderMap.put(id, order);
                return true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            close(null, ps, conn);
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "delete from order where id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            if (ps.executeUpdate() > 0) {
                orderMap.remove(id);
                return true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            close(null, ps, conn);
        }
        return false;
    }

    @Override
    public Order findById(int id) {
        return orderMap.get(id);
    }

    @Override
    public List<Order> findAll() {
        return new ArrayList<Order>(orderMap.values());
    }

    public List<Order> findByUserId(int userId) {
        return null;
    }
}
