package cleanmeat.dao;

import cleanmeat.model.News;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


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
        String sql = "INSERT INTO news (title, author, picture_url, content, status, created_at, updated_at) VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, news.getTitle());
                ps.setString(2, news.getAuthor());
                ps.setString(3, news.getPicture_url());
                ps.setString(4, news.getContent());
                ps.setString(5, news.getStatus());
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                ConnectionPool.getInstance().releaseConnection(conn);
            }
        }
        return false;
    }

    @Override
    public boolean update(News news, int id) {
        String sql = "UPDATE news SET title = ?, author = ?, content = ?, status = ?, updated_at = NOW() WHERE id = ?";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, news.getTitle());
                ps.setString(2, news.getAuthor());
                ps.setString(3, news.getContent());
                ps.setString(4, news.getStatus());
                ps.setInt(5, id);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                ConnectionPool.getInstance().releaseConnection(conn);
            }
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM news WHERE id = ?";
        Connection conn = null;
        try {
            conn = getConnection();
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                ConnectionPool.getInstance().releaseConnection(conn);
            }
        }
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

    public List<News> searchAndFilter(String keyword, int page, int pageSize) {
        List<News> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT n.* " +
                        "FROM news n " +
                        "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (n.title LIKE ? OR n.author LIKE ?) ");
            String val = "%" + keyword.trim() + "%";
            params.add(val);
            params.add(val);
        }

        sql.append(" ORDER BY n.created_at DESC");
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


    public int countFilteredNews(String keyword) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) " +
                        "FROM news n " +
                        "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (n.title LIKE ? OR n.author LIKE ?) ");
            String val = "%" + keyword.trim() + "%";
            params.add(val);
            params.add(val);
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
