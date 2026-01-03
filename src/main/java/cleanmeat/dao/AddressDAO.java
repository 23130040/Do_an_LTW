package cleanmeat.dao;

import cleanmeat.model.Address;
import cleanmeat.model.User;

import java.sql.*;
import java.time.LocalDate;
import java.util.*;
import java.util.Date;

public class AddressDAO extends BaseDAO<Address> {

    private Map<Integer, Address> addressMap;
    private UserDAO userDAO = new UserDAO();

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
        User user = new User(rs.getInt("user_id"), rs.getString("user_name"), rs.getString("user_email"));
        int id = rs.getInt("id");
        String address = rs.getString("address");
        boolean is_Default = rs.getBoolean("is_default");
        Date ca = rs.getDate("created_at");
        LocalDate created_at = (ca != null) ? ((java.sql.Date) ca).toLocalDate() : null;
        Date ua = rs.getTimestamp("updated_at");
        LocalDate updated_at = (ua != null) ? ((java.sql.Date) ua).toLocalDate() : null;
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
            try (PreparedStatement ps =
                         conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

                ps.setInt(1, address.getUser().getId());
                ps.setString(2, address.getAddress());
                ps.setBoolean(3, address.is_Default());

                if (ps.executeUpdate() == 0) return false;

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        address.setId(rs.getInt(1));
                        addressMap.put(address.getId(), address);
                    }
                }
                return true;
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            ConnectionPool.getInstance().releaseConnection(conn);
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
                ps.setBoolean(2, address.is_Default());
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
    public boolean delete(int id) {
        String sql = """
                DELETE FROM address
                WHERE id = ?
                """;
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                if (ps.executeUpdate() == 0) return false;
                addressMap.remove(id);
                return true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            ConnectionPool.getInstance().releaseConnection(conn);
        }
    }

    public List<Address> findAllByUser(User user) {
        String sql = """
                SELECT a.address, a.is_default FROM address as a
                WHERE user_id = ?
                """;
        List<Address> addresses = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, user.getId());
            rs = ps.executeQuery();
            while (rs.next()) {
                Address address = mapResultSetToEntity(rs);
                addresses.add(address);
            }
            return addresses;
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            close(rs, ps, conn);
        }
    }

    @Override
    public Address findById(int id) {
        return null;
    }

    @Override
    public List<Address> findAll() {
        return List.of();
    }
}
