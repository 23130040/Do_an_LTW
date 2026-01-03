package cleanmeat.dao;

import cleanmeat.model.System_config;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ConfigDAO extends BaseDAO<System_config> {

    @Override
    protected void loadAll() {

    }

    @Override
    protected System_config mapResultSetToEntity(ResultSet rs) throws SQLException {
        int id = rs.getInt("id");
        String name = rs.getString("name");
        String email = rs.getString("email");
        String hotline = rs.getString("hotline");
        String tax_code = rs.getString("tax_code");
        String facebook = rs.getString("facebook");
        String instagram = rs.getString("instagram");
        String address = rs.getString("address");
        String logo_url = rs.getString("logo_url");
        int user_id = rs.getInt("created_by");


        return new System_config(id, name, email, hotline, tax_code, facebook, instagram, address, logo_url);
    }

    public System_config getSystemConfig() {
        String sql = "SELECT * FROM system_config LIMIT 1";
        Connection conn = null;
        try {
            conn = getConnection();
            try (
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
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

    @Override
    public boolean update(System_config config, int id) {
        String sql = "UPDATE system_config SET name=?, email=?, hotline=?, tax_code=?, facebook=?, instagram=?, address=?, logo_url=? WHERE id=?";
        Connection conn = null;
        try {
            conn = getConnection();
            try (
                    PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, config.getName());
                ps.setString(2, config.getEmail());
                ps.setString(3, config.getHotline());
                ps.setString(4, config.getTax_code());
                ps.setString(5, config.getFacebook());
                ps.setString(6, config.getInstagram());
                ps.setString(7, config.getAddress());
                ps.setString(8, config.getLogo_url());
                ps.setInt(9, id);

                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                ConnectionPool.getInstance().releaseConnection(conn);
            }
        }
    }

    @Override
    public boolean insert(System_config config) throws SQLException {
        String sql = "INSERT INTO system_config (name, email, hotline, tax_code, facebook, instagram, address, logo_url, created_by)" +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);";
        Connection conn = null;

        try {
            conn = getConnection();
            try (
                    PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, config.getName());
                ps.setString(2, config.getEmail());
                ps.setString(3, config.getHotline());
                ps.setString(4, config.getTax_code());
                ps.setString(5, config.getFacebook());
                ps.setString(6, config.getInstagram());
                ps.setString(7, config.getAddress());
                ps.setString(8, config.getLogo_url());
                ps.setInt(9, 1);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                ConnectionPool.getInstance().releaseConnection(conn);
            }
        }
    }

    public boolean hasConfig() {
        String sql = "SELECT COUNT(*) FROM system_config";
        Connection conn = null;

        try {
            conn = getConnection();
            try (
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
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
    public boolean delete(int id) {
        return false;
    }

    @Override
    public System_config findById(int id) {
        return getSystemConfig();
    }

    @Override
    public List<System_config> findAll() {
        return new ArrayList<>();
    }
}