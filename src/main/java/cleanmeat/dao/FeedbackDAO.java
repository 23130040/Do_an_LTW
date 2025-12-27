package cleanmeat.dao;

import cleanmeat.model.Feedback;
import cleanmeat.model.User;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FeedbackDAO extends BaseDAO<Feedback> {

    public static Map<Integer, Feedback> feedbacks = new HashMap<>();
    private UserDAO userDAO = new UserDAO();

    public FeedbackDAO() {
        String sql = "SELECT * FROM feedback ORDER BY created_at DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Feedback feedback = mapResultSetToEntity(rs);
                feedbacks.put(feedback.getId(), feedback);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                closeResource(conn, ps, rs);
            } catch (SQLException ignored) {}
        }
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
                ? rs.getTimestamp("created_at").toLocalDateTime()
                : null;

        LocalDateTime updated_at = rs.getTimestamp("updated_at") != null
                ? rs.getTimestamp("updated_at").toLocalDateTime()
                : null;

        User user = userDAO.findById(user_id);

        Feedback feedback = new Feedback(id, response_id, user, item_id, rating, comment, created_at, updated_at);

        try {
            feedback.setReplied(rs.getInt("is_replied") == 1);
        } catch (SQLException ignored) {
        }

        return feedback;
    }

    @Override
    public boolean insert(Feedback feedback) throws SQLException, ClassNotFoundException {
        return false;
    }

    @Override
    public boolean update(Feedback feedback, int id) {
        String sql = "UPDATE feedback SET response_id = ?, rating = ?, comment = ?, updated_at = NOW() WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, feedback.getResponse_id());
            ps.setInt(2, feedback.getRating());
            ps.setString(3, feedback.getComment());
            ps.setInt(4, id);

            if (ps.executeUpdate() > 0) {
                feedbacks.put(id, feedback);
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                closeResource(conn, ps, null);
            } catch (SQLException ignored) {}
        }
    }

    @Override
    public boolean delete(Feedback feedback, int id) {
        String sql = "DELETE FROM feedback WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            if (ps.executeUpdate() > 0) {
                feedbacks.remove(id);
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                closeResource(conn, ps, null);
            } catch (SQLException ignored) {}
        }
    }

    @Override
    public Feedback findById(int id) {
        String sql = "SELECT * FROM feedback WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToEntity(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                closeResource(conn, ps, rs);
            } catch (SQLException ignored) {}
        }
        return null;
    }

    @Override
    public List<Feedback> findAll() {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.*, " +
                "(SELECT EXISTS(SELECT 1 FROM feedback r WHERE r.response_id = f.id)) AS is_replied " +
                "FROM feedback f WHERE f.response_id = 0";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToEntity(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                closeResource(conn, ps, rs);
            } catch (SQLException ignored) {}
        }
        return list;
    }

    public List<Feedback> applyFilterAndSearch(String rate, String type, String keyword) {
        List<Feedback> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT f.*, " +
                "(SELECT EXISTS(SELECT 1 FROM feedback r WHERE r.response_id = f.id)) AS is_replied " +
                "FROM feedback f WHERE f.response_id = 0");
        List<Object> params = new ArrayList<>();

        if (rate != null && !rate.trim().isEmpty()) {
            try {
                int ratingValue = Integer.parseInt(rate.trim());
                sql.append(" AND rating = ?");
                params.add(ratingValue);
            } catch (NumberFormatException ignored) {}
        }

        if ("no-reply".equals(type)) {
            sql.append(" AND NOT EXISTS (SELECT 1 FROM feedback r WHERE r.response_id = f.id)");
        } else if ("replied".equals(type)) {
            sql.append(" AND EXISTS (SELECT 1 FROM feedback r WHERE r.response_id = f.id)");
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND comment LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }

        sql.append(" ORDER BY created_at DESC");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToEntity(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                closeResource(conn, ps, rs);
            } catch (SQLException ignored) {}
        }
        return list;
    }
    public List<Feedback> getChatHistoryByUserId(int userId) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM feedback " +
                "WHERE user_id = ? OR response_id IN (SELECT id FROM feedback WHERE user_id = ?) " +
                "ORDER BY created_at ASC";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToEntity(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public boolean insertReply(int parentId, int adminId, String comment) {
        String sql = """
        INSERT INTO feedback (response_id, user_id, item_id, rating, comment, created_at)
        SELECT ?, ?, item_id, rating, ?, NOW()
        FROM feedback
        WHERE id = ?
    """;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, parentId);
            ps.setInt(2, adminId);
            ps.setString(3, comment);
            ps.setInt(4, parentId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}