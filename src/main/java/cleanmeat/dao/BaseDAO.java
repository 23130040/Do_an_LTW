package cleanmeat.dao;

import java.sql.*;
import java.util.List;

public abstract class BaseDAO<T> {

    protected Connection getConnection() throws ClassNotFoundException, SQLException {
        return ConnectionPool.getInstance().getConnection();
    }

    protected abstract void loadAll();

    protected abstract T mapResultSetToEntity(ResultSet rs) throws SQLException;

    public abstract boolean insert(T t) throws SQLException, ClassNotFoundException;

    public abstract boolean update(T t, int id);

    public abstract boolean delete(int id);

    public abstract T findById(int id);

    public abstract List<T> findAll();

    public void close(ResultSet rs, PreparedStatement ps, Connection conn) {
        try {
            if (rs != null) rs.close();
        } catch (SQLException ignored) {}

        try {
            if (ps != null) ps.close();
        } catch (SQLException ignored) {}

        if (conn != null) {
            ConnectionPool.getInstance().releaseConnection(conn);
        }
    }
}

