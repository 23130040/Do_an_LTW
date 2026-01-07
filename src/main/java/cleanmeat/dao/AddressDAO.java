package cleanmeat.dao;

import cleanmeat.model.Address;
import cleanmeat.model.User;

import java.sql.*;
import java.time.LocalDate;
import java.util.*;
import java.util.Date;

public class AddressDAO extends BaseDAO<Address> {

    private Map<Integer, Address> addressMap;

    public AddressDAO() {
        addressMap = new HashMap<Integer, Address>();
    }

    @Override
    protected void loadAll() {
        String sql = "SELECT a.*, u.id as user_id, u.name as user_name, u.email as user_email FROM address a JOIN user u ON a.user_id = u.id ORDER BY a.id ASC";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Address a = mapResultSetToEntity(rs);
                    addressMap.put(a.getId(), a);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            ConnectionPool.getInstance().releaseConnection(conn);
        }
    }

    @Override
    protected Address mapResultSetToEntity(ResultSet rs) throws SQLException {
        User user = new User(rs.getInt("user_id"),
                rs.getString("user_name"),
                rs.getString("user_email"));
        int id = rs.getInt("id");
        String address = rs.getString("address");
        boolean is_Default = rs.getBoolean("is_default");
        Timestamp ca = rs.getTimestamp("created_at");
        LocalDate created_at = (ca != null) ? ca.toLocalDateTime().toLocalDate() : null;
        Timestamp ua = rs.getTimestamp("updated_at");
        LocalDate updated_at = (ua != null) ? ua.toLocalDateTime().toLocalDate() : null;
        return new Address(id, user, address, is_Default, created_at, updated_at);
    }

    @Override
    public boolean insert(Address address) throws SQLException {
        String sql = """
                INSERT INTO address (user_id, address, is_default)
                VALUES (?, ?, ?)
                """;
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);
            try (PreparedStatement ps =
                         conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

                ps.setInt(1, address.getUser().getId());
                ps.setString(2, address.getAddress());
                ps.setBoolean(3, address.isDefaultAddress());

                if (ps.executeUpdate() == 0) return false;

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        address.setId(rs.getInt(1));
                        addressMap.put(address.getId(), address);
                    }
                }
                return true;
            }
        } catch (Exception e) {
            if (conn != null) conn.rollback();
            throw new RuntimeException(e);
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                ConnectionPool.getInstance().releaseConnection(conn);
            }
        }
    }

    @Override
    public boolean update(Address address, int id) {
        String sql = """
                UPDATE address
                SET address = ?, is_default = ?
                WHERE id = ?
                """;

        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, address.getAddress());
                ps.setBoolean(2, address.isDefaultAddress());
                ps.setInt(3, id);
                if (ps.executeUpdate() == 0) return false;
                addressMap.put(id, address);
                return true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            ConnectionPool.getInstance().releaseConnection(conn);
        }
    }

    @Override
    public boolean delete(int addressId) {
        String sql = """
                DELETE FROM address
                WHERE id = ?
                """;
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, addressId);

                if (ps.executeUpdate() == 0) return false;

                addressMap.remove(addressId);
                return true;
            }
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    throw new RuntimeException(ex);
                }
            }
            throw new RuntimeException(e);
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                ConnectionPool.getInstance().releaseConnection(conn);
            }
        }
    }

    public List<Address> findAllByUserId(int userId) {
        String sql = """
                    SELECT a.*, 
                           u.id AS user_id,
                           u.name AS user_name,
                           u.email AS user_email
                    FROM address a
                    JOIN user u ON a.user_id = u.id
                    WHERE u.id = ?
                    ORDER BY a.is_default DESC, a.id DESC
                """;
        List<Address> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapResultSetToEntity(rs));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            close(rs, ps, conn);
        }
        return list;
    }

    @Override
    public Address findById(int id) {
        String sql = """
                SELECT a.*, 
                       u.id   AS user_id,
                       u.name AS user_name,
                       u.email AS user_email
                FROM address a
                JOIN user u ON a.user_id = u.id
                WHERE a.id = ?
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEntity(rs);
                }
                return null;
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public void setDefaultByUser(int userId, int addressId) {
        String clearSql = "UPDATE address SET is_default = false WHERE user_id = ?";
        String setSql   = "UPDATE address SET is_default = true WHERE id = ?";

        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement ps1 = conn.prepareStatement(clearSql);
                 PreparedStatement ps2 = conn.prepareStatement(setSql)) {

                ps1.setInt(1, userId);
                ps1.executeUpdate();

                ps2.setInt(1, addressId);
                ps2.executeUpdate();
            }

            conn.commit();
        } catch (Exception e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ignored) {}
            throw new RuntimeException(e);
        } finally {
            try {
                if (conn != null) conn.setAutoCommit(true);
            } catch (SQLException ignored) {}
            ConnectionPool.getInstance().releaseConnection(conn);
        }
    }

    @Override
    public List<Address> findAll() {
        return List.of();
    }
}
