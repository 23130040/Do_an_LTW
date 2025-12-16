package vn.edu.hcmuaf.fit.do_an_ltw.dao;

import vn.edu.hcmuaf.fit.do_an_ltw.model.Feedback;
import vn.edu.hcmuaf.fit.do_an_ltw.model.User;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO extends BaseDAO<Feedback> {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected Feedback mapResultSetToEntity(ResultSet rs) throws SQLException {
        int id = rs.getInt("id");
        int response_id = rs.getInt("response_id");
        int user_id = rs.getInt("user_id");
        int item_id = rs.getInt("item_id");
        int rating = rs.getInt("rating");
        String comment = rs.getString("comment");

        Timestamp createdTimestamp = rs.getTimestamp("created_at");
        LocalDateTime created_at = (createdTimestamp != null) ? createdTimestamp.toLocalDateTime() : null;

        Timestamp updatedTimestamp = rs.getTimestamp("updated_at");
        LocalDateTime updated_at = (updatedTimestamp != null) ? updatedTimestamp.toLocalDateTime() : null;

        User user = userDAO.findById(user_id);

        return new Feedback(id, response_id, user, item_id, rating, comment, created_at, updated_at);
    }

    @Override
    public List<Feedback> findAll() {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM feedback ORDER BY created_at DESC";

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
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return list;
    }

    @Override
    protected boolean insert(Feedback feedback) throws SQLException, ClassNotFoundException { return false; }
    @Override
    protected boolean update(Feedback feedback, int id) { return false; }
    @Override
    protected boolean delete(Feedback feedback, int id) { return false; }
    @Override
    protected Feedback findById(int id) { return null; }

}