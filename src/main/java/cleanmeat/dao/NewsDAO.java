package cleanmeat.dao;

import cleanmeat.model.Feedback;
import cleanmeat.model.News;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NewsDAO extends BaseDAO<News> {
    @Override
    protected News mapResultSetToEntity(ResultSet rs) throws SQLException {
        News news = new News();
        news.setId(rs.getInt("id"));
        news.setTitle(rs.getString("title"));
        news.setAuthor(rs.getString("author"));
        news.setPicture_url(rs.getString("picture_url"));
        news.setContent(rs.getString("content"));
        news.setStatus(rs.getString("status"));
        news.setCreated_at(rs.getDate("created_at").toLocalDate());
        if (rs.getDate("updated_at") != null) {
            news.setUpdated_at(rs.getDate("updated_at").toLocalDate());
        }
        return news;
    }

    @Override
    protected boolean insert(News news) throws SQLException, ClassNotFoundException {
        return false;
    }

    @Override
    protected boolean update(News news, int id) {
        return false;
    }

    @Override
    protected boolean delete(News news, int id) {
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
