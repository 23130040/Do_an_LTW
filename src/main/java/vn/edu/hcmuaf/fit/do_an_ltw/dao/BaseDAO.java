package vn.edu.hcmuaf.fit.do_an_ltw.dao;

import java.sql.*;
import java.util.List;

public abstract class BaseDAO<T> {

    protected Connection getConnection() throws ClassNotFoundException, SQLException {
        return ConnectionPool.getInstance().getConnection();
    }

    //thực thi câu lệnh select
    protected ResultSet selectData(String sql) throws ClassNotFoundException, SQLException {
        Connection conn = getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        return rs;
    }

    //thực thi các câu lệnh update, insert, delete
    protected void executeSQL(String sql) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        try {
            conn = getConnection();

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.executeUpdate();

                conn.commit();
            }
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            closeResource(conn, null, null);
        }
    }

    protected abstract T mapResultSetToEntity(ResultSet rs) throws SQLException;

    protected abstract boolean insert(T t) throws SQLException, ClassNotFoundException;

    protected abstract boolean update(T t, int id);

    protected abstract boolean delete(T t, int id);

    protected abstract T findById(int id);

    protected abstract List<T> findAll();

    protected void closeResource(Connection conn, PreparedStatement ps, ResultSet rs) throws SQLException {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                System.err.println(e.getMessage());
                e.printStackTrace();
            }
        }
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                System.err.println(e.getMessage());
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.err.println(e.getMessage());
                e.printStackTrace();
            }
        }
    }

}
