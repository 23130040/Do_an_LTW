package cleanmeat.dao;

import cleanmeat.model.Item;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO extends BaseDAO<Item> {

    @Override
    protected Item mapResultSetToEntity(ResultSet rs) throws SQLException {
        Item item = new Item();
        item.setId(rs.getInt("id"));
        item.setName(rs.getString("name"));
        item.setShort_description(rs.getString("short_description"));
        item.setPrice(rs.getDouble("price"));
        item.setImageUrl(rs.getString("image_url"));
        item.setDiscount(rs.getDouble("discount"));
        item.setCurrent_stock(rs.getInt("current_stock"));
        item.setMin_stock(rs.getInt("min_stock"));
        item.setUnit_id(rs.getInt("unit_id"));
        item.setCategoryName(rs.getString("category_name"));
        item.setOriginName(rs.getString("origin_name"));
        item.setUnitName(rs.getString("unit_name"));
        item.setSku(rs.getString("sku"));
        item.setLong_description(rs.getString("long_description"));
        item.setCategory_id(rs.getInt("category_id"));
        item.setOrigin_id(rs.getInt("origin_id"));

        if (rs.getDate("created_at") != null) {
            item.setCreated_at(rs.getDate("created_at").toLocalDate());
        }
        if (rs.getDate("updated_at") != null) {
            item.setUpdated_at(rs.getDate("updated_at").toLocalDate());
        }
        return item;
    }

    @Override
    protected boolean insert(Item item) throws SQLException, ClassNotFoundException {
        return false;
    }

    @Override
    public boolean update(Item item, int id) {
        String sql = "UPDATE item SET sku = ?, name = ?, short_description = ?, long_description = ?, " +
                "category_id = ?, origin_id = ?, unit_id = ?, price = ?, discount = ?, " +
                "min_stock = ?, updated_at = NOW() WHERE id = ?";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, item.getSku());
                ps.setString(2, item.getName());
                ps.setString(3, item.getShort_description());
                ps.setString(4, item.getLong_description());
                ps.setInt(5, item.getCategory_id());
                ps.setInt(6, item.getOrigin_id());
                ps.setInt(7, item.getUnit_id());
                ps.setDouble(8, item.getPrice());
                ps.setDouble(9, item.getDiscount());
                ps.setInt(10, item.getMin_stock());
                ps.setInt(11, id);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return false;
    }

    public void updatePrimaryImage(int itemId, String url) {
        String sql = "UPDATE item_image SET url = ? WHERE item_id = ? AND is_primary = 1";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, url);
                ps.setInt(2, itemId);
                int rows = ps.executeUpdate();
                if (rows == 0) {
                    insertImage(itemId, url);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
    }

    @Override
    public Item findById(int id) {
        String sql = "SELECT i.*, img.url AS image_url, c.name AS category_name, o.name AS origin_name, u.name AS unit_name " +
                "FROM item i " +
                "LEFT JOIN item_image img ON i.id = img.item_id AND img.is_primary = 1 " +
                "LEFT JOIN category c ON i.category_id = c.id " +
                "LEFT JOIN origin o ON i.origin_id = o.id " +
                "LEFT JOIN unit u ON i.unit_id = u.id WHERE i.id = ?";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) return mapResultSetToEntity(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return null;
    }

    @Override
    public List<Item> findAll() {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT i.*, img.url AS image_url, c.name AS category_name, o.name AS origin_name, u.name AS unit_name " +
                "FROM item i LEFT JOIN item_image img ON i.id = img.item_id AND img.is_primary = 1 " +
                "LEFT JOIN category c ON i.category_id = c.id " +
                "LEFT JOIN origin o ON i.origin_id = o.id " +
                "LEFT JOIN unit u ON i.unit_id = u.id ORDER BY i.created_at DESC";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(mapResultSetToEntity(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return items;
    }

    public List<Item> findByPage(int page, int pageSize) {
        List<Item> list = new ArrayList<>();
        String sql = "SELECT i.*, img.url AS image_url, c.name AS category_name, o.name AS origin_name, u.name AS unit_name " +
                "FROM item i LEFT JOIN item_image img ON i.id = img.item_id AND img.is_primary = 1 " +
                "LEFT JOIN category c ON i.category_id = c.id " +
                "LEFT JOIN origin o ON i.origin_id = o.id " +
                "LEFT JOIN unit u ON i.unit_id = u.id ORDER BY i.created_at DESC LIMIT ? OFFSET ?";
        Connection conn = null;
        try {
            if (page < 1) page = 1;
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, pageSize);
                ps.setInt(2, (page - 1) * pageSize);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        list.add(mapResultSetToEntity(rs));
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

    public Item getNewestItem() {
        String sql = "SELECT i.*, img.url AS image_url, c.name AS category_name, o.name AS origin_name, u.name AS unit_name " +
                "FROM item i LEFT JOIN item_image img ON i.id = img.item_id AND img.is_primary = 1 " +
                "LEFT JOIN category c ON i.category_id = c.id LEFT JOIN origin o ON i.origin_id = o.id " +
                "LEFT JOIN unit u ON i.unit_id = u.id ORDER BY i.created_at DESC LIMIT 1";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSetToEntity(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return null;
    }

    public Item getFeaturedItem() {
        String sql = "SELECT i.*, img.url AS image_url, c.name AS category_name, o.name AS origin_name, u.name AS unit_name " +
                "FROM item i JOIN (SELECT item_id FROM feedback GROUP BY item_id ORDER BY AVG(rating) DESC LIMIT 1) f ON i.id = f.item_id " +
                "LEFT JOIN item_image img ON i.id = img.item_id AND img.is_primary = 1 " +
                "LEFT JOIN category c ON i.category_id = c.id LEFT JOIN origin o ON i.origin_id = o.id " +
                "LEFT JOIN unit u ON i.unit_id = u.id";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSetToEntity(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return null;
    }

    public Item getBestSellerItem() {
        String sql = "SELECT i.*, img.url AS image_url, c.name AS category_name, o.name AS origin_name, u.name AS unit_name " +
                "FROM item i LEFT JOIN order_item oi ON i.id = oi.item_id " +
                "LEFT JOIN item_image img ON i.id = img.item_id AND img.is_primary = 1 " +
                "LEFT JOIN category c ON i.category_id = c.id LEFT JOIN origin o ON i.origin_id = o.id " +
                "LEFT JOIN unit u ON i.unit_id = u.id GROUP BY i.id ORDER BY SUM(oi.quantity) DESC LIMIT 1";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSetToEntity(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return null;
    }

    public Item getBestDealItem() {
        String sql = "SELECT i.*, img.url AS image_url, c.name AS category_name, o.name AS origin_name, u.name AS unit_name " +
                "FROM item i LEFT JOIN order_item oi ON i.id = oi.item_id JOIN voucher_usage vu ON oi.order_id = vu.order_id " +
                "LEFT JOIN item_image img ON i.id = img.item_id AND img.is_primary = 1 " +
                "LEFT JOIN category c ON i.category_id = c.id LEFT JOIN origin o ON i.origin_id = o.id " +
                "LEFT JOIN unit u ON i.unit_id = u.id GROUP BY i.id ORDER BY MAX(vu.discount_amount) DESC LIMIT 1";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSetToEntity(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return null;
    }

    public int countItems() {
        String sql = "SELECT COUNT(*) FROM item";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return 0;
    }

    public int insertAndReturnId(Item item) {
        String sql = "INSERT INTO item (sku, name, short_description, long_description, category_id, origin_id, unit_id, " +
                "price, discount, current_stock, min_stock, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, item.getSku());
                ps.setString(2, item.getName());
                ps.setString(3, item.getShort_description());
                ps.setString(4, item.getLong_description());
                ps.setInt(5, item.getCategory_id());
                ps.setInt(6, item.getOrigin_id());
                ps.setInt(7, item.getUnit_id());
                ps.setDouble(8, item.getPrice());
                ps.setDouble(9, item.getDiscount());
                ps.setInt(10, item.getCurrent_stock());
                ps.setInt(11, item.getMin_stock());
                ps.executeUpdate();
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return -1;
    }

    public void insertImage(int itemId, String url) {
        String sql = "INSERT INTO item_image (item_id, url, is_primary) VALUES (?, ?, 1)";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, itemId);
                ps.setString(2, url);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
    }

    @Override
    protected boolean delete(Item item, int id) {
        return false;
    }
}