package cleanmeat.dao;

import cleanmeat.model.News;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import static java.sql.DriverManager.getConnection;

public class NewsDAO extends BaseDAO<News> {

    @Override
    protected void loadAll() {

    }

    @Override
    protected News mapResultSetToEntity(ResultSet rs) throws SQLException {
        LocalDateTime created_at = rs.getTimestamp("created_at") != null
                ? rs.getTimestamp("created_at").toLocalDateTime() : null;
        LocalDateTime updated_at = rs.getTimestamp("updated_at") != null
                ? rs.getTimestamp("updated_at").toLocalDateTime() : null;

        News news = new News();
        news.setId(rs.getInt("id"));
        news.setTitle(rs.getString("title"));
        news.setAuthor(rs.getString("author"));
        news.setPicture_url(rs.getString("picture_url"));
        news.setContent(rs.getString("content"));
        news.setStatus(rs.getString("status"));
        news.setCreated_at(created_at);
        news.setUpdated_at(updated_at);
        return news;
    }

    @Override
    public boolean insert(News news) throws SQLException, ClassNotFoundException {
        return false;
    }

    @Override
    public boolean update(News news, int id) {
        return false;
    }

    @Override
    public boolean delete(int id) {
        return false;
    }

    @Override
    public News findById(int id) {
        String sql = "SELECT * FROM news WHERE id = ?";
        Connection conn = null;

        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
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
    public List<News> findAll() {
        List<News> list = new ArrayList<>();
        String sql = "SELECT * FROM news";
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
            if (conn != null) {
                ConnectionPool.getInstance().releaseConnection(conn);
            }
        }
        return list;
    }


    public List<News> findLatest(int limit) {
        List<News> list = new ArrayList<>();
        String sql = "SELECT * FROM news ORDER BY created_at DESC LIMIT ?";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, limit);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    list.add(mapResultSetToEntity(rs));
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

    public List<News> findByPage(int page) {
        List<News> list = new ArrayList<>();

        int pageSize = 4;
        int offset = (page - 1) * pageSize;

        String sql =
                "SELECT * FROM news " +
                        "ORDER BY created_at DESC " +
                        "LIMIT ? OFFSET ?";

        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setInt(1, pageSize);
                ps.setInt(2, offset);

                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    list.add(mapResultSetToEntity(rs));
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

    public int countPages() {
        int pageSize = 4;
        String sql = "SELECT COUNT(*) FROM news";

        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    int total = rs.getInt(1);
                    return (int) Math.ceil(total * 1.0 / pageSize);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                ConnectionPool.getInstance().releaseConnection(conn);
            }
        }
        return 1;
    }

}
