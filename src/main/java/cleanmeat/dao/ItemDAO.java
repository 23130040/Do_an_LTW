package cleanmeat.dao;

import cleanmeat.model.Item;
import cleanmeat.model.ItemImage;
import cleanmeat.model.Unit;
import cleanmeat.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO extends BaseDAO<Item> {

    UnitDAO unitDAO = new UnitDAO();

    @Override
    protected void loadAll() {

    }

    @Override
    protected Item mapResultSetToEntity(ResultSet rs) throws SQLException {
        LocalDateTime created_at = rs.getTimestamp("created_at") != null
                ? rs.getTimestamp("created_at").toLocalDateTime() : null;
        LocalDateTime updated_at = rs.getTimestamp("updated_at") != null
                ? rs.getTimestamp("updated_at").toLocalDateTime() : null;

        Item item = new Item();
        item.setId(rs.getInt("id"));
        item.setName(rs.getString("name"));
        item.setShort_description(rs.getString("short_description"));
        item.setImageUrl(rs.getString("image_url"));

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

        double originalPrice = rs.getDouble("price");
        double discount = rs.getDouble("discount");
        double fPrice = originalPrice * (100 - discount) / 100;

        item.setPrice(originalPrice);
        item.setDiscount(discount);
        item.setFinalPrice(fPrice);

        item.setCreated_at(created_at);
        item.setUpdated_at(updated_at);
        return item;
    }

    @Override
    public boolean insert(Item item) throws SQLException, ClassNotFoundException {
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
                    insertImage(itemId, url, 1);
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
        Item item = null;
        Connection conn = null;
        try {
            conn = getConnection();
            String sql = "SELECT i.*, img.url AS image_url, c.name AS category_name, o.name AS origin_name, u.name AS unit_name " +
                    "FROM item i " +
                    "LEFT JOIN item_image img ON i.id = img.item_id AND img.is_primary = 1 " +
                    "LEFT JOIN category c ON i.category_id = c.id " +
                    "LEFT JOIN origin o ON i.origin_id = o.id " +
                    "LEFT JOIN unit u ON i.unit_id = u.id WHERE i.id = ?";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        item = mapResultSetToEntity(rs);
                    }
                }
            }

            if (item != null) {
                item.setImages(findImagesByItemId(id));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return item;
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
        String sql = "SELECT \n" +
                "    i.*, \n" +
                "    img.url AS image_url, \n" +
                "    c.name AS category_name, \n" +
                "    o.name AS origin_name, \n" +
                "    u.name AS unit_name, \n" +
                "(i.price * (100 - i.discount) / 100) AS final_price\n" +
                "FROM item i\n" +
                "LEFT JOIN item_image img ON i.id = img.item_id AND img.is_primary = 1\n" +
                "LEFT JOIN category c ON i.category_id = c.id\n" +
                "LEFT JOIN origin o ON i.origin_id = o.id\n" +
                "LEFT JOIN unit u ON i.unit_id = u.id\n" +
                "ORDER BY i.discount DESC\n" +
                "LIMIT 1;";
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

    public void insertImage(int itemId, String url, int isPrimary) {
        String sql = "INSERT INTO item_image (item_id, url, is_primary) VALUES (?, ?, ?)";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, itemId);
                ps.setString(2, url);
                ps.setInt(3, isPrimary);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
    }

    @Override
    public boolean delete(int id) {
        String sqlDeleteImage = "DELETE FROM item_image WHERE item_id = ?";
        String sqlDeleteItem = "DELETE FROM item WHERE id = ?";
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement psImg = conn.prepareStatement(sqlDeleteImage);
                 PreparedStatement psItem = conn.prepareStatement(sqlDeleteItem)) {

                psImg.setInt(1, id);
                psImg.executeUpdate();

                psItem.setInt(1, id);
                int result = psItem.executeUpdate();

                conn.commit();
                return result > 0;
            } catch (SQLException e) {
                if (conn != null) conn.rollback();
                throw e;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return false;
    }

    public void deleteAllImagesByItemId(int itemId) {
        String sql = "DELETE FROM item_image WHERE item_id = ?";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, itemId);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
    }

    public List<Item> searchAndFilter(
            String keyword,
            String category,
            String origin,
            int page,
            int pageSize
    ) {
        List<Item> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT i.*, img.url AS image_url, c.name AS category_name, " +
                        "o.name AS origin_name, u.name AS unit_name " +
                        "FROM item i " +
                        "LEFT JOIN item_image img ON i.id = img.item_id AND img.is_primary = 1 " +
                        "LEFT JOIN category c ON i.category_id = c.id " +
                        "LEFT JOIN origin o ON i.origin_id = o.id " +
                        "LEFT JOIN unit u ON i.unit_id = u.id " +
                        "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (i.name LIKE ? OR i.sku LIKE ?) ");
            String val = "%" + keyword.trim() + "%";
            params.add(val);
            params.add(val);
        }

        if (category != null && !category.isEmpty()) {
            sql.append(" AND i.category_id = ? ");
            params.add(Integer.parseInt(category));
        }

        if (origin != null && !origin.isEmpty()) {
            sql.append(" AND i.origin_id = ? ");
            params.add(Integer.parseInt(origin));
        }
        sql.append(" ORDER BY i.created_at DESC ");

        sql.append(" LIMIT ? OFFSET ? ");
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

    public int countFilteredItems(String keyword, String category, String origin) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM item WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (name LIKE ? OR sku LIKE ?)");
            String val = "%" + keyword.trim() + "%";
            params.add(val);
            params.add(val);
        }

        if (category != null && !category.isEmpty()) {
            sql.append(" AND category_id = ?");
            params.add(category);
        }

        if (origin != null && !origin.isEmpty()) {
            sql.append(" AND origin_id = ?");
            params.add(origin);
        }

        sql.append(" AND RIGHT(sku, 1) = '1'");

        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
                for (int i = 0; i < params.size(); i++) {
                    ps.setObject(i + 1, params.get(i));
                }
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt(1);
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
        return 0;
    }

    public List<String> findImagesByItemId(int itemId) {
        List<String> list = new ArrayList<>();
        String sql = "SELECT url FROM item_image WHERE item_id = ? ORDER BY is_primary DESC, id ASC";

        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, itemId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        list.add(rs.getString("url"));
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

    public boolean checkSKUExists(String sku, int currentId) {
        String sql = "SELECT COUNT(*) FROM item WHERE sku = ? AND id != ?";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, sku);
                ps.setInt(2, currentId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt(1) > 0;
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
        return false;
    }

    public List<Item> searchAndFilterForSanPham(
            String keyword,
            String category,
            String origin,
            String sort,
            int page,
            int pageSize
    ) {
        List<Item> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT i.*, img.url AS image_url, c.name AS category_name, " +
                        "o.name AS origin_name, u.name AS unit_name " +
                        "FROM item i " +
                        "LEFT JOIN item_image img ON i.id = img.item_id AND img.is_primary = 1 " +
                        "LEFT JOIN category c ON i.category_id = c.id " +
                        "LEFT JOIN origin o ON i.origin_id = o.id " +
                        "LEFT JOIN unit u ON i.unit_id = u.id " +
                        "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (i.name LIKE ? OR i.sku LIKE ?) ");
            String val = "%" + keyword.trim() + "%";
            params.add(val);
            params.add(val);
        }

        if (category != null && !category.isEmpty()) {
            sql.append(" AND i.category_id = ? ");
            params.add(Integer.parseInt(category));
        }

        if (origin != null && !origin.isEmpty()) {
            sql.append(" AND i.origin_id = ? ");
            params.add(Integer.parseInt(origin));
        }

        sql.append(" AND RIGHT(i.sku, 1) = '1' ");

        // ===== SORT =====
        if ("price_asc".equals(sort)) {
            sql.append(" ORDER BY (i.price * (100 - i.discount) / 100) ASC ");
        } else if ("price_desc".equals(sort)) {
            sql.append(" ORDER BY (i.price * (100 - i.discount) / 100) DESC ");
        } else {
            sql.append(" ORDER BY i.created_at DESC ");
        }

        // ===== PAGINATION =====
        sql.append(" LIMIT ? OFFSET ? ");
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

    public List<Item> findBySkuBase(String skuBase) {
        List<Item> list = new ArrayList<>();

        String sql = """
        SELECT i.*, 
               img.url AS image_url,
               c.name AS category_name,
               o.name AS origin_name,
               u.name AS unit_name
        FROM item i
        LEFT JOIN item_image img 
            ON i.id = img.item_id AND img.is_primary = 1
        LEFT JOIN category c ON i.category_id = c.id
        LEFT JOIN origin o ON i.origin_id = o.id
        LEFT JOIN unit u ON i.unit_id = u.id
        WHERE i.sku LIKE CONCAT(?, '__')
        ORDER BY RIGHT(i.sku, 2)
    """;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, skuBase);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToEntity(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}