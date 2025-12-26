package cleanmeat.dao;

import cleanmeat.model.Category;
import cleanmeat.model.System_config;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO extends BaseDAO<Category>{
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
        String sql = "INSERT INTO categories (name, description, created_at, updated_at) VALUES (?, ?, NOW(), NOW())";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    protected boolean update(Category category, int id) {
        return false;
    }

    @Override
    protected boolean delete(Category category, int id) {
        return false;
    }

    @Override
    protected Category findById(int id) {
        return null;
    }

    @Override
    public List<Category> findAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM category";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToEntity(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
