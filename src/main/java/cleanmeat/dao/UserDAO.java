package cleanmeat.dao;

import cleanmeat.model.Item;
import cleanmeat.model.User;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserDAO extends BaseDAO<User> {
    public Map<Integer, User> users = new HashMap<>();

    public UserDAO() {
        String sql = "SELECT * FROM user ORDER BY id ASC";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User user = mapResultSetToEntity(rs);
                    users.put(user.getId(), user);
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
    protected User mapResultSetToEntity(ResultSet rs) throws SQLException {
        int id = rs.getInt("id");
        String name = rs.getString("name");
        String email = rs.getString("email");
        String password = rs.getString("password");
        String phone = rs.getString("phone");
        String gender = rs.getString("gender");

        Date bd = rs.getDate("birthday");
        LocalDate birthday = (bd != null) ? bd.toLocalDate() : null;

        String role = rs.getString("role");
        String avatar = rs.getString("avatar");
        boolean status = rs.getBoolean("status");
        boolean email_verified = rs.getBoolean("email_verified");
        String verify_token = rs.getString("verify_token");
        LocalDateTime created_at = rs.getTimestamp("created_at") != null
                ? rs.getTimestamp("created_at").toLocalDateTime() : null;
        LocalDateTime updated_at = rs.getTimestamp("updated_at") != null
                ? rs.getTimestamp("updated_at").toLocalDateTime() : null;

        return new User(id, name, email, password, phone, gender,
                birthday, role, avatar, status, email_verified, verify_token, created_at, updated_at);
    }

    @Override
    public boolean insert(User user) throws SQLException, ClassNotFoundException {
        String sql = """
                INSERT INTO user
                (name, email, password, phone, gender, birthday, role, avatar,
                 status, email_verified, verify_token, created_at, updated_at)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())
                """;
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, user.getName());
                ps.setString(2, user.getEmail());
                ps.setString(3, user.getPassword());
                ps.setString(4, user.getPhone());
                ps.setString(5, user.getGender());
                ps.setDate(6, user.getBirthday() != null ? Date.valueOf(user.getBirthday()) : null);
                ps.setString(7, user.getRole());
                ps.setString(8, user.getAvatar());
                ps.setBoolean(9, user.isStatus());
                ps.setBoolean(10, user.isEmail_verified());
                ps.setString(11, user.getVerify_token());

                if (ps.executeUpdate() > 0) {
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) {
                            user.setId(rs.getInt(1));
                            users.put(user.getId(), user);
                        }
                    }
                    conn.commit();
                    return true;
                } else {
                    conn.rollback();
                    return false;
                }
            }
        } catch (Exception e) {
            if (conn != null) conn.rollback();
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
    }

    @Override
    public boolean update(User user, int id) {
        String sql = "UPDATE user SET name=?, email=?, password=?, phone=?, gender=?, birthday=?, role=?, avatar=?, status=?, updated_at=NOW() WHERE id=?";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, user.getName());
                ps.setString(2, user.getEmail());
                ps.setString(3, user.getPassword());
                ps.setString(4, user.getPhone());
                ps.setString(5, user.getGender());
                ps.setDate(6, user.getBirthday() != null ? Date.valueOf(user.getBirthday()) : null);
                ps.setString(7, user.getRole());
                ps.setString(8, user.getAvatar());
                ps.setBoolean(9, user.isStatus());
                ps.setInt(10, id);

                if (ps.executeUpdate() > 0) {
                    users.put(id, user);
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
        String sql = "DELETE FROM user WHERE id=?";
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(true);
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                if (ps.executeUpdate() > 0) {
                    users.remove(id);
                    return true;
                }
                ;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return false;
    }

    @Override
    public User findById(int id) {
        String sql = "SELECT * FROM user WHERE id=?";
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
    public List<User> findAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM user ORDER BY id ASC";
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

    public int getNoOfRecords() {
        String sql = "SELECT COUNT(id) FROM user";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return 0;
    }

    public List<User> findUsersByPage(int offset, int noOfRecords) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM user ORDER BY id ASC LIMIT ? OFFSET ?";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, noOfRecords);
                ps.setInt(2, offset);
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

    public List<User> searchAndFilter(String keyword, String role, int page, int pageSize) {
        List<User> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM user WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (name COLLATE utf8mb4_bin LIKE ? OR email COLLATE utf8mb4_bin LIKE ? OR phone COLLATE utf8mb4_bin LIKE ?)");
            String likeValue = "%" + keyword.trim() + "%";
            params.add(likeValue);
            params.add(likeValue);
            params.add(likeValue);
        }
        if (role != null && !role.trim().isEmpty()) {
            sql.append(" AND role = ?");
            params.add(role);
        }
        sql.append(" ORDER BY id ASC");

        sql.append(" LIMIT ? OFFSET ? ");
        params.add(pageSize);
        params.add((page - 1) * pageSize);

        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
                for (int i = 0; i < params.size(); i++) {
                    ps.setObject(i + 1, params.get(i));
                }

                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        list.add(mapResultSetToEntity(rs));
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

        return list;
    }

    public User findByEmail(String email) {
        String sql = "SELECT * FROM user WHERE email = ?";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);
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

    public boolean existsByEmail(String email) {
        String sql = "SELECT 1 FROM user WHERE email = ? LIMIT 1";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return false;
    }

    public boolean changePassword(int userId, String newPassword) {
        String sql = "UPDATE user SET password = ? WHERE id = ?";
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, newPassword);
                ps.setInt(2, userId);
                if (ps.executeUpdate() == 0) {
                    conn.rollback();
                    return false;
                }
                User user = users.get(userId);
                if (user != null) user.setPassword(newPassword);
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

    public User findByVerifyToken(String token) {
        String sql = "SELECT * FROM user WHERE verify_token = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEntity(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean verifyEmail(String token) {
        String sql = """
                    UPDATE user
                    SET email_verified = 1,
                        verify_token = NULL,
                        updated_at = NOW()
                    WHERE verify_token = ?
                """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePasswordByEmail(String email, String hashedPassword) {
        String sql = "UPDATE user SET password = ? WHERE email = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, hashedPassword);
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public int countFilteredUsers(String keyword, String role) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM user WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (name LIKE ? OR email LIKE ? OR phone LIKE ?)");
            String val = "%" + keyword.trim() + "%";
            params.add(val);
            params.add(val);
            params.add(val);
        }
        if (role != null && !role.isEmpty()) {
            sql.append(" AND role = ?");
            params.add(role);
        }

        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
                for (int i = 0; i < params.size(); i++) {
                    ps.setObject(i + 1, params.get(i));
                }
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt(1);
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
        return 0;
    }
}