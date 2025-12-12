package vn.edu.hcmuaf.fit.do_an_ltw.dao;

import vn.edu.hcmuaf.fit.do_an_ltw.model.User;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserDAO extends BaseDAO<User>{
    public static Map<Integer,User> users = new HashMap<Integer,User>();


    public UserDAO() {
        String sql = "select * from user";
        try {
            ResultSet rs = selectData(sql);
            while (rs.next()) {
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
                Date createdDate = rs.getDate("created_at");
                LocalDate created_at = (createdDate != null) ? createdDate.toLocalDate() : null;

                Date updatedDate = rs.getDate("updated_at");
                LocalDate updated_at = (updatedDate != null) ? updatedDate.toLocalDate() : null;

                User user = new User(id, name, email, password, phone, gender, birthday, role, avatar, status, created_at, updated_at);
                users.put(id, user);
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
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

        Date createdDate = rs.getDate("created_at");
        LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;

        Date updatedDate = rs.getDate("updated_at");
        LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;

        return new User(id, name, email, password, phone, gender,
                birthday, role, avatar, status, createdAt, updatedAt);
    }


    @Override
    public boolean insert(User user) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO user (name, email, password, phone, gender, birthday, role, avatar, status, created_at, updated_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";

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

                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
                    conn.commit();

                    try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int newId = generatedKeys.getInt(1);
                            user.setId(newId);

                            users.put(newId, user);
                        }
                    }
                    return true;
                } else {
                    conn.rollback();
                    return false;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ignored) {
                }
            }
        }
    }

    @Override
    public boolean update(User user, int id) {
        String sql = "UPDATE user SET name=?, email=?, password=?, phone=?, gender=?, birthday=?, role=?, avatar=?, status=?, updated_at=NOW() " +
                "WHERE id=?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

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

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(User user, int id) {
        String sql = "DELETE FROM user WHERE id=?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public User findById(int id) {
        String sql = "SELECT * FROM user WHERE id=?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToEntity(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<User> findAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM user";

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