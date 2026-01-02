package cleanmeat.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.Queue;

public class ConnectionPool {
    private static final int MAX_CONNECTIONS = 10;
    private final Queue<Connection> pool = new LinkedList<Connection>();

    private static class Holder {
        private static final ConnectionPool INSTANCE = new ConnectionPool();
    }

    public static ConnectionPool getInstance() {
        return Holder.INSTANCE;
    }

    public ConnectionPool() {
        try {
            for (int i = 0; i < MAX_CONNECTIONS; i++) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/cleanmeat?zeroDateTimeBehavior=CONVERT_TO_NULL";
                String user = "root";
                String password = "";
                Connection conn = DriverManager.getConnection(url, user, password);
                pool.add(conn);
            }
        } catch (ClassNotFoundException e1) {
            e1.printStackTrace();
        } catch (SQLException e2) {
            e2.printStackTrace();
        }
    }

    public Connection getConnection() {
        synchronized (pool) {
            while (pool.isEmpty()) {
                try {
                    pool.wait(5000);
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                }
            }
            return pool.poll();
        }
    }

    public void releaseConnection(Connection conn) {
        if (conn == null) return;
        try {
            if (!conn.isClosed()) {
                conn.setAutoCommit(true);
                synchronized (pool) {
                    pool.offer(conn);
                    pool.notifyAll();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void closePool() {
        synchronized (pool) {
            for (Connection conn : pool) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            pool.clear();
        }
    }

}
