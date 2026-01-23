package cleanmeat.dao;

import cleanmeat.model.ProductStatisticDTO;
import cleanmeat.model.StatisticDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StatisticDAO extends BaseDAO<StatisticDTO> {

    public StatisticDTO getGeneralStatistics() {
        StatisticDTO dto = new StatisticDTO();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT " +
                " (SELECT SUM(total_price) FROM `order` WHERE status = 'Đã giao') AS totalRevenue, " +
                " (SELECT COUNT(*) FROM `order` WHERE status = 'Đã giao') AS totalOrders, " +
                " (SELECT COUNT(*) FROM `user` WHERE role = 'user') AS totalUsers, " +
                " (SELECT COUNT(*) FROM `item` WHERE current_stock <= min_stock) AS lowStock, " +
                " (SELECT COUNT(*) FROM `order` WHERE status = 'Chờ xác nhận') AS pendingOrders, " +
                " (SELECT COUNT(*) FROM `order` WHERE status = 'Đang giao') AS shippingOrders, " +
                " (SELECT COUNT(*) FROM `order` WHERE status = 'Đã giao') AS completedOrders, " +
                " (SELECT COUNT(*) FROM `order` WHERE status = 'Đã hủy') AS cancelledOrders";

        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                dto.setTotalRevenue(rs.getDouble("totalRevenue"));
                dto.setTotalOrders(rs.getInt("totalOrders"));
                dto.setTotalUsers(rs.getInt("totalUsers"));
                dto.setLowStockCount(rs.getInt("lowStock"));
                dto.setPendingOrders(rs.getInt("pendingOrders"));
                dto.setShippingOrders(rs.getInt("shippingOrders"));
                dto.setCompletedOrders(rs.getInt("completedOrders"));
                dto.setCancelledOrders(rs.getInt("cancelledOrders"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return dto;
    }
    public List<ProductStatisticDTO> getTopSellingProducts() {
        List<ProductStatisticDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT i.name, " +
                "SUM(oi.quantity) as sold, " +
                "SUM(oi.price * oi.quantity) as revenue, " +
                "(SUM(oi.price * oi.quantity) * 100 / (SELECT SUM(total_price) FROM `order` WHERE status = 'Đã giao')) as percentage, " +
                "AVG(f.rating) as ratingAvg " +
                "FROM order_item oi " +
                "JOIN `item` i ON oi.item_id = i.id " +
                "JOIN `order` o ON oi.order_id = o.id " +
                "LEFT JOIN `feedback` f ON i.id = f.item_id " +
                "WHERE o.status = 'Đã giao' " +
                "GROUP BY i.id, i.name " +
                "ORDER BY sold DESC LIMIT 5";

        try {
            conn = getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                ProductStatisticDTO p = new ProductStatisticDTO();
                p.setProductName(rs.getString("name"));
                p.setQuantitySold(rs.getInt("sold"));
                p.setRevenue(rs.getDouble("revenue"));
                p.setPercentage(rs.getDouble("percentage"));
                p.setRatingAvg(rs.getDouble("ratingAvg"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) ConnectionPool.getInstance().releaseConnection(conn);
        }
        return list;
    }

    @Override
    protected void loadAll() {

    }

    @Override
    protected StatisticDTO mapResultSetToEntity(ResultSet rs) throws SQLException {
        return null;
    }

    @Override
    public boolean insert(StatisticDTO statisticDTO) throws SQLException, ClassNotFoundException {
        return false;
    }

    @Override
    public boolean update(StatisticDTO statisticDTO, int id) {
        return false;
    }

    @Override
    public boolean delete(int id) {
        return false;
    }

    @Override
    public StatisticDTO findById(int id) {
        return null;
    }

    @Override
    public List<StatisticDTO> findAll() {
        return List.of();
    }
}
