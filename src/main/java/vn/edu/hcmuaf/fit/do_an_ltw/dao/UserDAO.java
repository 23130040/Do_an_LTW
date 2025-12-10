package vn.edu.hcmuaf.fit.do_an_ltw.dao;

import vn.edu.hcmuaf.fit.do_an_ltw.model.User;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
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
                LocalDate created_at = rs.getDate("created_at").toLocalDate();
                LocalDate updated_at = rs.getDate("updated_at").toLocalDate();

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
        return null;
    }

    @Override
    protected boolean insert(User user) {
        return false;
    }

    @Override
    protected boolean update(User user, int id) {
        return false;
    }

    @Override
    protected boolean delete(User user, int id) {
        return false;
    }

    @Override
    protected User findById(int id) {
        return null;
    }

    @Override
    protected List<User> findAll() {
        return new ArrayList<>(users.values());
    }

}
