package cleanmeat.dao;

import cleanmeat.model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO extends BaseDAO<Category> {
    @Override
    protected void loadAll() {

    }

    @Override
    protected Category mapResultSetToEntity(ResultSet rs) throws SQLException {
        return new Category(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("description"),
                rs.getTimestamp("created_at"),
                rs.getTimestamp("updated_at")
        );
    }

    @Override
    public boolean insert(Category category) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO category (name, description, created_at, updated_at) VALUES (?, ?, NOW(), NOW())";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, category.getName());
                ps.setString(2, category.getDescription());

                int rowAffected = ps.executeUpdate();
                return rowAffected > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (conn != null) {
                ConnectionPool.getInstance().releaseConnection(conn);
            }
        }
    }

    @Override
    public boolean update(Category category, int id) {
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM category WHERE id = ?";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                return ps.executeUpdate() > 0;
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

    @Override
    public Category findById(int id) {
        return null;
    }

    @Override
    public List<Category> findAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM category";
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
            if (conn != null) {
                ConnectionPool.getInstance().releaseConnection(conn);
            }
        }
        return list;
    }
}
