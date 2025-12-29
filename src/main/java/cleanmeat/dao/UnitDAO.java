package cleanmeat.dao;

import cleanmeat.model.Origin;
import cleanmeat.model.Unit;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UnitDAO extends BaseDAO<Unit> {
    @Override
    protected Unit mapResultSetToEntity(ResultSet rs) throws SQLException {
        Unit unit = new Unit();
        unit.setId(rs.getInt("id"));
        unit.setName(rs.getString("name"));
        unit.setAmount(rs.getInt("amount"));
        return unit;
    }

    @Override
    public boolean insert(Unit unit) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO unit (name, amount, created_at) VALUES (?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, unit.getName());
            ps.setDouble(2, unit.getAmount());

            ps.setDate(3, java.sql.Date.valueOf(java.time.LocalDate.now()));

            int rowsAffected = ps.executeUpdate();

            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    protected boolean update(Unit unit, int id) {
        return false;
    }

    @Override
    protected boolean delete(Unit unit, int id) {
        return false;
    }

    @Override
    protected Unit findById(int id) {
        return null;
    }

    @Override
    public List<Unit> findAll() {
        List<Unit> list = new ArrayList<>();
        String sql = "SELECT * FROM unit";
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
