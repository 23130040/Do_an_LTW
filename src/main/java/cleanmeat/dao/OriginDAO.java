package cleanmeat.dao;

import cleanmeat.model.Category;
import cleanmeat.model.Origin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OriginDAO  extends BaseDAO<Origin> {
    @Override
    protected Origin mapResultSetToEntity(ResultSet rs) throws SQLException {
        return new Origin(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("description"),
                rs.getTimestamp("created_at"),
                rs.getTimestamp("updated_at")
        );
    }

    @Override
    public boolean insert(Origin origin) throws SQLException, ClassNotFoundException {
        return false;
    }

    @Override
    protected boolean update(Origin origin, int id) {
        return false;
    }

    @Override
    protected boolean delete(Origin origin, int id) {
        return false;
    }

    @Override
    protected Origin findById(int id) {
        return null;
    }

    @Override
    public List<Origin> findAll() {
        List<Origin> list = new ArrayList<>();
        String sql = "SELECT * FROM origin";
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
