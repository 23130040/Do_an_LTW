package cleanmeat.dao;

import cleanmeat.model.Feedback;
import cleanmeat.model.User;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class FeedbackDAO extends BaseDAO<Feedback> {

    public static Map<Integer, Feedback> feedbacks = new ConcurrentHashMap<>();
    private UserDAO userDAO = new UserDAO();

    public FeedbackDAO() {
        String sql = "SELECT f.*, u.name AS user_name, i.name AS item_name FROM feedback f " +
                "LEFT JOIN user u ON f.user_id = u.id " +
                "LEFT JOIN item i ON f.item_id = i.id ORDER BY f.created_at DESC";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Feedback feedback = mapResultSetToEntity(rs);
                    feedbacks.put(feedback.getId(), feedback);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
    }

    @Override
    protected void loadAll() {

    }

    @Override
    protected Feedback mapResultSetToEntity(ResultSet rs) throws SQLException {
        int id = rs.getInt("id");
        int response_id = rs.getInt("response_id");
        int user_id = rs.getInt("user_id");
        int item_id = rs.getInt("item_id");
        int rating = rs.getInt("rating");
        String comment = rs.getString("comment");

        LocalDateTime created_at = rs.getTimestamp("created_at") != null
                ? rs.getTimestamp("created_at").toLocalDateTime() : null;
        LocalDateTime updated_at = rs.getTimestamp("updated_at") != null
                ? rs.getTimestamp("updated_at").toLocalDateTime() : null;

        User user = null;
        try {
            String userName = rs.getString("user_name");
            if (userName != null) {
                user = new User();
                user.setId(user_id);
                user.setName(userName);
            }
        } catch (SQLException e) {
            user = userDAO.findById(user_id);
        }

        Feedback feedback = new Feedback(id, response_id, user, item_id, rating, comment, created_at, updated_at);
        try {
            String itemName = rs.getString("item_name");
            feedback.setItem_name(itemName);
        } catch (SQLException ignored) {}
        try {
            feedback.setReplied(rs.getInt("is_replied") == 1);
        } catch (SQLException ignored) {}

        return feedback;
    }

    @Override
    public boolean update(Feedback feedback, int id) {
        String sql = "UPDATE feedback SET response_id = ?, rating = ?, comment = ?, updated_at = NOW() WHERE id = ?";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, feedback.getResponse_id());
                ps.setInt(2, feedback.getRating());
                ps.setString(3, feedback.getComment());
                ps.setInt(4, id);

                if (ps.executeUpdate() > 0) {
                    feedbacks.put(id, feedback);
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM feedback WHERE id = ? OR response_id = ?";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                ps.setInt(2, id);
                if (ps.executeUpdate() > 0) {
                    feedbacks.remove(id);
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return false;
    }

    @Override
    public Feedback findById(int id) {
        String sql = "SELECT f.*, u.name AS user_name, i.name AS item_name \n" +
                "FROM feedback f \n" +
                "LEFT JOIN user u ON f.user_id = u.id \n" +
                "LEFT JOIN item i ON f.item_id = i.id WHERE f.id = ?";
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
    public List<Feedback> findAll() {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.*, u.name AS user_name, i.name AS item_name, " +
                "(SELECT EXISTS(SELECT 1 FROM feedback r WHERE r.response_id = f.id)) AS is_replied " +
                "FROM feedback f " +
                "LEFT JOIN user u ON f.user_id = u.id " +
                "LEFT JOIN item i ON f.item_id = i.id " +
                "WHERE f.response_id = 0";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
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

    public List<Feedback> applyFilterAndSearch(String rate, String type, String keyword) {
        List<Feedback> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT f.*, u.name AS user_name, i.name AS item_name, " +
                "(SELECT EXISTS(SELECT 1 FROM feedback r WHERE r.response_id = f.id)) AS is_replied " +
                "FROM feedback f " +
                "LEFT JOIN user u ON f.user_id = u.id " +
                "LEFT JOIN item i ON f.item_id = i.id " +
                "WHERE f.response_id = 0");
        List<Object> params = new ArrayList<>();

        if (rate != null && !rate.trim().isEmpty()) {
            try {
                int ratingValue = Integer.parseInt(rate.trim());
                sql.append(" AND f.rating = ?");
                params.add(ratingValue);
            } catch (NumberFormatException ignored) {}
        }

        if ("no-reply".equals(type)) {
            sql.append(" AND NOT EXISTS (SELECT 1 FROM feedback r WHERE r.response_id = f.id)");
        } else if ("replied".equals(type)) {
            sql.append(" AND EXISTS (SELECT 1 FROM feedback r WHERE r.response_id = f.id)");
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND f.comment LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }

        sql.append(" ORDER BY created_at DESC");

        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
                for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) list.add(mapResultSetToEntity(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return list;
    }

    public List<Feedback> getChatHistoryByUserId(int userId) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.*, u.name AS user_name, i.name AS item_name FROM feedback f " +
                "LEFT JOIN user u ON f.user_id = u.id " +
                "LEFT JOIN item i ON f.item_id = i.id " +
                "WHERE f.user_id = ? OR f.response_id IN (SELECT id FROM feedback WHERE user_id = ?) " +
                "ORDER BY f.created_at ASC";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                ps.setInt(2, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) list.add(mapResultSetToEntity(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return list;
    }

    public boolean insertReply(int parentId, int adminId, String comment) {
        String sql = "INSERT INTO feedback (response_id, user_id, item_id, rating, comment, created_at) " +
                "SELECT ?, ?, item_id, rating, ?, NOW() FROM feedback WHERE id = ?";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, parentId);
                ps.setInt(2, adminId);
                ps.setString(3, comment);
                ps.setInt(4, parentId);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return false;
    }

    @Override public boolean insert(Feedback feedback) { return false; }
}