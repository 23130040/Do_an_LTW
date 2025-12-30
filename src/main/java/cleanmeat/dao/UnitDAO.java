package cleanmeat.dao;

import cleanmeat.model.Unit;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UnitDAO extends BaseDAO<Unit> {
    @Override
    protected Unit mapResultSetToEntity(ResultSet rs) throws SQLException {
        Unit unit = new Unit();
        unit.setId(rs.getInt("id"));
        unit.setName(rs.getString("name"));
        unit.setAmount(rs.getInt("amount"));
        return unit;
    }

    @Override
    public boolean insert(Unit unit) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO unit (name, amount, created_at) VALUES (?, ?, NOW())";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, unit.getName());
                ps.setInt(2, unit.getAmount());

                int rowsAffected = ps.executeUpdate();
                return rowsAffected > 0;
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
    public List<Unit> findAll() {
        List<Unit> list = new ArrayList<>();
        String sql = "SELECT * FROM unit";
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
    public Unit findById(int id) {
        String sql = "SELECT * FROM unit WHERE id = ?";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return mapResultSetToEntity(rs);
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
        return null;
    }

    @Override
    protected boolean update(Unit unit, int id) {
        String sql = "UPDATE unit SET name = ?, amount = ? WHERE id = ?";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, unit.getName());
                ps.setInt(2, unit.getAmount());
                ps.setInt(3, id);
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
    protected boolean delete(Unit unit, int id) {
        String sql = "DELETE FROM unit WHERE id = ?";
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
}