package cleanmeat.dao;

import cleanmeat.model.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
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
        //orderMap = new HashMap<Integer, Order>();
        //loadAll();
    }

    @Override
    protected void loadAll() {
        String sql = "SELECT * FROM `order` ORDER BY id ASC";
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
        LocalDateTime created_at = rs.getTimestamp("created_at") != null
                ? rs.getTimestamp("created_at").toLocalDateTime() : null;
        LocalDateTime updated_at = rs.getTimestamp("updated_at") != null
                ? rs.getTimestamp("updated_at").toLocalDateTime() : null;
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
                update `order` 
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
        String sql = "delete from `order` where id = ?";
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
        List<Order> list = new ArrayList<>();
        String sql = """
                SELECT o.*, 
                       u.name AS user_name, u.phone AS user_phone, u.email AS user_email,
                       a.address AS detail_address
                FROM `order` o
                JOIN user u ON o.user_id = u.id
                JOIN address a ON o.address_id = a.id
                ORDER BY o.created_at DESC
                """;
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("user_id"));
                    user.setName(rs.getString("user_name"));
                    user.setPhone(rs.getString("user_phone"));

                    Address addr = new Address();
                    addr.setId(rs.getInt("address_id"));
                    addr.setAddress(rs.getString("detail_address"));

                    Order order = new Order(
                            rs.getInt("id"),
                            user,
                            addr,
                            rs.getDouble("total_price"),
                            rs.getString("status"),
                            rs.getTimestamp("created_at").toLocalDateTime(),
                            rs.getTimestamp("updated_at").toLocalDateTime()
                    );
                    list.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return list;
    }

    public List<Order> findByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = """
                    SELECT *
                    FROM `order`
                    WHERE user_id = ?
                    ORDER BY created_at DESC
                """;
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Order order = mapResultSetToEntity(rs);
                    order.setListItem(oiDAO.findByOrderId(order.getId()));
                    orders.add(order);
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return orders;
    }

    public List<Order> searchAndFilter(String keyword, String status, int page, int pageSize) {
        List<Order> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT o.*, u.name AS user_name, u.phone AS user_phone, a.address AS detail_address " +
                        "FROM `order` o " +
                        "JOIN user u ON o.user_id = u.id " +
                        "JOIN address a ON o.address_id = a.id " +
                        "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (u.name LIKE ? OR u.phone LIKE ? OR CAST(o.id AS CHAR) LIKE ?) ");
            String val = "%" + keyword.trim() + "%";
            params.add(val);
            params.add(val);
            params.add(val);
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND o.status = ? ");
            params.add(status);
        }

        sql.append(" ORDER BY o.created_at DESC LIMIT ? OFFSET ? ");
        params.add(pageSize);
        params.add((page - 1) * pageSize);

        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
                for (int i = 0; i < params.size(); i++) {
                    ps.setObject(i + 1, params.get(i));
                }

                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        User user = new User();
                        user.setName(rs.getString("user_name"));
                        user.setPhone(rs.getString("user_phone"));
                        Address addr = new Address();
                        addr.setAddress(rs.getString("detail_address"));

                        Order order = new Order(
                                rs.getInt("id"), user, addr,
                                rs.getDouble("total_price"),
                                rs.getString("status"),
                                rs.getTimestamp("created_at").toLocalDateTime(),
                                rs.getTimestamp("updated_at").toLocalDateTime()
                        );
                        list.add(order);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return list;
    }

    public int countFilteredOrders(String keyword, String status) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM `order` o JOIN user u ON o.user_id = u.id WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (u.name LIKE ? OR u.phone LIKE ? OR CAST(o.id AS CHAR) LIKE ?)");
            String val = "%" + keyword.trim() + "%";
            params.add(val);
            params.add(val);
            params.add(val);
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND o.status = ?");
            params.add(status);
        }
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
                for (int i = 0; i < params.size(); i++) {
                    ps.setObject(i + 1, params.get(i));
                }
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return 0;
    }
    public boolean updateStatus(int orderId, String status) {
        String sql = "UPDATE `order` SET status = ?, updated_at = NOW() WHERE id = ?";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {

                ps.setString(1, status);
                ps.setInt(2, orderId);
                return ps.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return false;
    }
}
