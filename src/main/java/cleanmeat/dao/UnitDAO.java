package cleanmeat.dao;

import cleanmeat.model.Unit;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class UnitDAO extends BaseDAO<Unit> {
    @Override
    protected Unit mapResultSetToEntity(ResultSet rs) throws SQLException {
        return null;
    }

    @Override
    protected boolean insert(Unit unit) throws SQLException, ClassNotFoundException {
        return false;
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
    protected List<Unit> findAll() {
        return List.of();
    }
}
