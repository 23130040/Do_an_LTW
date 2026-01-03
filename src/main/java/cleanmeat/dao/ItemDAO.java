package cleanmeat.dao;

import cleanmeat.model.Item;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
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


        item.setCreated_at(rs.getDate("created_at").toLocalDate());
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
    protected boolean update(Item item, int id) {
        return false;
    }

    @Override
    protected boolean delete(Item item, int id) {
        return false;
    }

    @Override
    protected Item findById(int id) {
        return null;
    }

    @Override
    public List<Item> findAll() {
        List<Item> items = new ArrayList<>();
        String sql = """
        SELECT i.*, img.url AS image_url, c.name AS category_name, o.name AS origin_name, u.name AS unit_name
                                  FROM item i LEFT JOIN item_image img
                                         ON i.id = img.item_id
                                        AND img.is_primary = 1
                                  LEFT JOIN category c
                                         ON i.category_id = c.id
                                  LEFT JOIN origin o
                                         ON i.origin_id = o.id
                                  LEFT JOIN unit u
                                         ON i.unit_id = u.id
                                  ORDER BY i.created_at DESC;
    """;

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
            if (conn != null) {
                ConnectionPool.getInstance().releaseConnection(conn);
            }
        }
        return items;
    }
    public List<Item> findByPage(int page, int pageSize) {
        List<Item> list = new ArrayList<>();

        String sql = """
        SELECT i.*, img.url AS image_url,
               c.name AS category_name,
               o.name AS origin_name,
               u.name AS unit_name
        FROM item i
        LEFT JOIN item_image img
               ON i.id = img.item_id
              AND img.is_primary = 1
        LEFT JOIN category c ON i.category_id = c.id
        LEFT JOIN origin o ON i.origin_id = o.id
        LEFT JOIN unit u ON i.unit_id = u.id
        ORDER BY i.created_at DESC
        LIMIT ? OFFSET ?
    """;

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

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException("Lỗi khi phân trang sản phẩm", e);
        } finally {
            if (conn != null) {
                ConnectionPool.getInstance().releaseConnection(conn);
            }
        }
        return list;
    }

    public Item getNewestItem() {
        String sql = "SELECT i.*, img.url AS image_url FROM item i LEFT JOIN item_image img ON i.id = img.item_id AND img.is_primary = 1" +
                " ORDER BY i.created_at ASC LIMIT 1;";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    return mapResultSetToEntity(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                ConnectionPool.getInstance().releaseConnection(conn);
            }
        }
        return null;
    }
    public Item getFeaturedItem() {
        String sql = "SELECT i.*, img.url AS image_url FROM item i " +
                "LEFT JOIN item_image img ON i.id = img.item_id AND img.is_primary = 1 " +
                "JOIN feedback f ON i.id = f.item_id " +
                "GROUP BY i.id, i.name, i.short_description, i.price, i.unit_id, i.current_stock, " +
                "i.min_stock, i.created_at, i.updated_at, img.url " +
                "ORDER BY AVG(f.rating) DESC LIMIT 1";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEntity(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return null;
    }

    public Item getBestSellerItem() {
        String sql = "SELECT i.* FROM item i " +
                "LEFT JOIN order_item oi ON i.id = oi.item_id " +
                "GROUP BY i.id, i.name, i.short_description, i.long_description, i.category_id, " +
                "i.origin_id, i.price, i.unit_id, i.current_stock, i.min_stock, i.created_at, i.updated_at " +
                "ORDER BY SUM(oi.quantity) DESC LIMIT 1";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEntity(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return null;
    }

    public Item getBestDealItem() {
        String sql = "SELECT i.* FROM item i " +
                "LEFT JOIN order_item oi ON i.id = oi.item_id " +
                "JOIN voucher_usage vu ON oi.order_id = vu.order_id " +
                "GROUP BY i.id, i.name, i.short_description, i.long_description, i.category_id, " +
                "i.origin_id, i.price, i.unit_id, i.current_stock, i.min_stock, i.created_at, i.updated_at " +
                "ORDER BY MAX(vu.discount_amount) DESC LIMIT 1";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEntity(rs);
                }
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

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException("Lỗi khi đếm số lượng sản phẩm", e);
        } finally {
            if (conn != null) {
                ConnectionPool.getInstance().releaseConnection(conn);
            }
        }
        return 0;
    }

}
