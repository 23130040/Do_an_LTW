package cleanmeat.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.Queue;

public class ConnectionPool {
    private static final int MAX_CONNECTIONS = 10;
    private static final int TIMEOUT = 2;
    private final Queue<Connection> pool = new LinkedList<Connection>();
    private static final String URL = "jdbc:mysql://localhost:3306/cleanmeat?zeroDateTimeBehavior=CONVERT_TO_NULL";
    private static final String USER = "root";
    private static final String PASSWORD = "123456";
    private static class Holder {
        private static final ConnectionPool INSTANCE = new ConnectionPool();
    }

    public static ConnectionPool getInstance() {
        return Holder.INSTANCE;
    }

    private ConnectionPool() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            for (int i = 0; i < MAX_CONNECTIONS; i++) {
                pool.offer(createConnection());
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException("Init ConnectionPool failed", e);
        }
    }

    private Connection createConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public Connection getConnection() throws SQLException {
        synchronized (pool) {
            if (pool.isEmpty()) {
                throw new SQLException("Connection pool exhausted");
            }

            Connection conn = pool.poll();
            if (!isValid(conn)) {
                conn = createConnection();
            }
            return conn;
        }
    }

    public void releaseConnection(Connection conn) {
        if (conn == null) return;
        try {
            if (isValid(conn)) {
                conn.setAutoCommit(true);
                synchronized (pool) {
                    pool.offer(conn);
                }
            }
        } catch (SQLException e) {
            closeQuietly(conn);
        }
    }

    private boolean isValid(Connection conn) {
        try {
            return conn != null && !conn.isClosed() && conn.isValid(TIMEOUT);
        } catch (SQLException e) {
            return false;
        }
    }

    private void closeQuietly(Connection conn) {
        try {
            if (conn != null) conn.close();
        } catch (SQLException ignored) {
        }
    }
}
