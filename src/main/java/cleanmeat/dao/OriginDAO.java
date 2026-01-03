package cleanmeat.dao;

import cleanmeat.model.Origin;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OriginDAO extends BaseDAO<Origin> {

    @Override
    protected void loadAll() {

    }

    @Override
    protected Origin mapResultSetToEntity(ResultSet rs) throws SQLException {
        return new Origin(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("description"),
                rs.getTimestamp("created_at"),
                rs.getTimestamp("updated_at")
        );
    }

    @Override
    public boolean insert(Origin origin) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO origin (name, description, created_at, updated_at) VALUES (?, ?, NOW(), NOW())";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, origin.getName());
                ps.setString(2, origin.getDescription());
                return ps.executeUpdate() > 0;
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
    public boolean delete(int id) {
        String sql = "DELETE FROM origin WHERE id = ?";
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
    public List<Origin> findAll() {
        List<Origin> list = new ArrayList<>();
        String sql = "SELECT * FROM origin";
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

    @Override
    public boolean update(Origin origin, int id) {
        return false;
    }

    @Override
    public Origin findById(int id) {
        String sql = "SELECT * FROM origin WHERE id = ?";
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
            if (conn != null) {
                ConnectionPool.getInstance().releaseConnection(conn);
            }
        }
        return null;
    }
}