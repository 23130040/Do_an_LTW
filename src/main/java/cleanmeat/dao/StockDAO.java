package cleanmeat.dao;

import cleanmeat.model.Item;
import cleanmeat.model.Stock_history;
import cleanmeat.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class StockDAO extends BaseDAO<Stock_history> {
    @Override
    protected void loadAll() {

    }

    @Override
    protected Stock_history mapResultSetToEntity(ResultSet rs) throws SQLException {
        Item item = new Item();
        item.setId(rs.getInt("item_id"));
        item.setName(rs.getString("item_name"));
        item.setCategoryName(rs.getString("category_name"));
        item.setOriginName(rs.getString("origin_name"));
        item.setUnitName(rs.getString("unit_name"));

        LocalDateTime created_at = rs.getTimestamp("created_at") != null
                ? rs.getTimestamp("created_at").toLocalDateTime() : null;

        User user = new User();
        user.setName(rs.getString("created_by_name"));

        return new Stock_history(
                rs.getInt("id"),
                item,
                rs.getString("type"),
                rs.getInt("quantity"),
                created_at,
                user
        );
    }

    @Override
    public boolean insert(Stock_history stockHistory) throws SQLException, ClassNotFoundException {
        return false;
    }

    @Override
    public boolean update(Stock_history stockHistory, int id) {
        return false;
    }

    @Override
    public boolean delete(int id) {
        return false;
    }

    @Override
    public Stock_history findById(int id) {
        return null;
    }

    @Override
    public List<Stock_history> findAll() {
        return List.of();
    }


    public List<Stock_history> findByPageAndType(int page, int pageSize, String type) {
        List<Stock_history> list = new ArrayList<>();
        String sql = """
                    SELECT sh.id, sh.type, sh.quantity, sh.created_at,
                           i.id AS item_id, i.name AS item_name, i.sku AS sku,
                           c.name AS category_name,
                           o.name AS origin_name,
                           u.name AS unit_name,
                           us.name AS created_by_name
                    FROM stock_history sh
                    JOIN item i ON sh.item_id = i.id
                    JOIN category c ON i.category_id = c.id
                    JOIN origin o ON i.origin_id = o.id
                    JOIN unit u ON i.unit_id = u.id
                    JOIN user us ON sh.created_by = us.id
                    WHERE sh.type = ?
                    ORDER BY sh.created_at DESC
                    LIMIT ? OFFSET ?
                """;

        int offset = (page - 1) * pageSize;
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, type);
                ps.setInt(2, pageSize);
                ps.setInt(3, offset);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    list.add(mapResultSetToEntity(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }

        return list;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM stock_history";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ResultSet rs = ps.executeQuery();
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return 0;
    }

    public int countByType(String type) {
        String sql = "SELECT COUNT(*) FROM stock_history WHERE type = ?";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, type);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return 0;
    }

    public boolean createStockTransaction(int itemId, String type, int quantity, int userId) {
        Connection conn = null;
        String insertSql = "INSERT INTO stock_history (item_id, type, quantity, created_by, created_at) VALUES (?, ?, ?, ?, NOW())";
        String updateStockSql = type.equals("Nhap")
                ? "UPDATE item SET current_stock = current_stock + ? WHERE id = ?"
                : "UPDATE item SET current_stock = current_stock - ? WHERE id = ?";

        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement psInsert = conn.prepareStatement(insertSql)) {
                psInsert.setInt(1, itemId);
                psInsert.setString(2, type);
                psInsert.setInt(3, quantity);
                psInsert.setInt(4, userId);
                psInsert.executeUpdate();
            }

            try (PreparedStatement psUpdate = conn.prepareStatement(updateStockSql)) {
                psUpdate.setInt(1, quantity);
                psUpdate.setInt(2, itemId);
                psUpdate.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (Exception e) {
            if (conn != null) try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
    }

    public List<Stock_history> searchAndFilter(String type, String keyword, String category, String origin, int page, int pageSize) {
        List<Stock_history> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                """
                            SELECT sh.id, sh.type, sh.quantity, sh.created_at,
                                   i.id AS item_id, i.name AS item_name,
                                   c.name AS category_name,
                                   o.name AS origin_name,
                                   u.name AS unit_name,
                                   us.name AS created_by_name
                            FROM stock_history sh
                            JOIN item i ON sh.item_id = i.id
                            JOIN category c ON i.category_id = c.id
                            JOIN origin o ON i.origin_id = o.id
                            JOIN unit u ON i.unit_id = u.id
                            JOIN user us ON sh.created_by = us.id
                            WHERE sh.type = ?
                        """
        );
        List<Object> params = new ArrayList<>();
        params.add(type);

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (i.name LIKE ? OR i.sku LIKE ? OR us.name LIKE ?)");
            String val = "%" + keyword.trim() + "%";
            params.add(val);
            params.add(val);
            params.add(val);
        }
        if (category != null && !category.isEmpty()) {
            sql.append(" AND i.category_id = ?");
            params.add(category);
        }
        if (origin != null && !origin.isEmpty()) {
            sql.append(" AND i.origin_id = ?");
            params.add(origin);
        }

        sql.append(" ORDER BY sh.created_at DESC LIMIT ? OFFSET ?");
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
                        list.add(mapResultSetToEntity(rs));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                ConnectionPool.getInstance().releaseConnection(conn);
            }
        }
        return list;
    }

    public int countSearchFilter(String type, String keyword, String category, String origin) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM stock_history sh " +
                "JOIN item i ON sh.item_id = i.id JOIN user us ON sh.created_by = us.id WHERE sh.type = ?");
        List<Object> params = new ArrayList<>();
        params.add(type);

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (i.name LIKE ? OR i.sku LIKE ? OR us.name LIKE ?)");
            String val = "%" + keyword.trim() + "%";
            params.add(val);
            params.add(val);
            params.add(val);
        }
        if (category != null && !category.isEmpty()) {
            sql.append(" AND i.category_id = ?");
            params.add(category);
        }
        if (origin != null && !origin.isEmpty()) {
            sql.append(" AND i.origin_id = ?");
            params.add(origin);
        }

        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
                for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
                ResultSet rs = ps.executeQuery();
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                ConnectionPool.getInstance().releaseConnection(conn);
            }
        }
        return 0;
    }

}
