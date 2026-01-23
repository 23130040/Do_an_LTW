
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quản lý thống kê và phân tích</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin_thong_ke.css">
</head>
<body>
<div class="admin-container">
    <!---------------- Thanh menu ------------------->
    <jsp:include page="base/admin_header.jsp" />

    <!---------------- Side Bar ------------------->
    <div class="main-wrapper">
        <jsp:include page="base/admin_sidebar.jsp">
            <jsp:param name="active" value="statistic"/>
        </jsp:include>

        <main class="content">
            <h2 class="page-title">Tổng Quan Thống Kê</h2>

            <div class="kpi-row">
                <div class="kpi-card bg-red">
                    <div class="kpi-icon"><i class="fas fa-chart-line"></i></div>
                    <div class="kpi-info">
            <span class="kpi-value">
                <fmt:formatNumber value="${stats.totalRevenue}" pattern="#,###"/>₫
            </span>
                        <span class="kpi-label">Doanh Thu</span>
                    </div>
                </div>

                <div class="kpi-card bg-blue">
                    <div class="kpi-icon"><i class="fas fa-shopping-cart"></i></div>
                    <div class="kpi-info">
            <span class="kpi-value">
                <fmt:formatNumber value="${stats.totalOrders}" pattern="#,###"/>
            </span>
                        <span class="kpi-label">Đơn Hàng</span>
                    </div>
                </div>

                <div class="kpi-card bg-yellow">
                    <div class="kpi-icon"><i class="fas fa-user-plus"></i></div>
                    <div class="kpi-info">
            <span class="kpi-value">
                <fmt:formatNumber value="${stats.totalUsers}" pattern="#,###"/>
            </span>
                        <span class="kpi-label">Khách Hàng</span>
                    </div>
                </div>

                <div class="kpi-card bg-dark">
                    <div class="kpi-icon"><i class="fas fa-boxes"></i></div>
                    <div class="kpi-info">
                        <span class="kpi-value">${stats.lowStockCount}</span>
                        <span class="kpi-label">Mục Cần Nhập</span>
                    </div>
                </div>
            </div>


            <div class="widget-row full-width-widget">
                <div class="widget-card">
                    <h4><i class="fas fa-medal"></i> Top 5 Sản Phẩm Bán Chạy</h4>
                    <table class="data-table">
                        <thead>
                        <tr>
                            <th>Sản Phẩm</th>
                            <th>Đã Bán</th>
                            <th>Doanh Thu</th>
                            <th>Tỷ Trọng (%)</th>
                            <th>Đánh Giá</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="p" items="${topProducts}">
                            <tr>
                                <td>${p.productName}</td>
                                <td><fmt:formatNumber value="${p.quantitySold}" /></td>
                                <td><fmt:formatNumber value="${p.revenue}" maxFractionDigits="0"/></td>
                                <td><fmt:formatNumber value="${p.percentage}" maxFractionDigits="1"/>%</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.ratingAvg > 0}">
                                            <i class="fas fa-star" style="color: #ffc107;"></i>
                                            <fmt:formatNumber value="${p.ratingAvg}" maxFractionDigits="1"/>/5
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Chưa có đánh giá</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="widget-row two-cols">
                <div class="widget-card">
                    <h4><i class="fas fa-clipboard-list"></i> Trạng Thái Đơn Hàng</h4>
                    <ul class="order-status-list">
                        <li>
                            <i class="fas fa-circle status-pending"></i>
                            Chờ Xác Nhận: <span>${stats.pendingOrders} Đơn</span>
                        </li>
                        <li>
                            <i class="fas fa-circle status-shipped"></i>
                            Đang Giao Hàng: <span>${stats.shippingOrders} Đơn</span>
                        </li>
                        <li>
                            <i class="fas fa-circle status-completed"></i>
                            Đã Giao Hàng: <span>${stats.completedOrders} Đơn</span>
                        </li>
                        <li>
                            <i class="fas fa-circle status-cancelled"></i>
                            Đã Hủy: <span>${stats.cancelledOrders} Đơn</span>
                        </li>
                    </ul>
                </div>

            </div>
        </main>
    </div>
    <!------------------- PHẦN THÔNG BÁO ----------------->
    <div id="notification-panel" class="notification-panel">
        <div class="panel-header">
            <h3>Thông Báo Mới (3)</h3>
            <span class="close-panel-btn" onclick="toggleNotificationMenu()">&times;</span>
        </div>
        <div class="panel-content">
            <a href="#" class="notification-item unread">
                <i class="fas fa-shopping-cart"></i>
                <p>Đơn hàng mới #0012 vừa được tạo.</p>
            </a>
            <a href="#" class="notification-item unread">
                <i class="fas fa-exclamation-triangle"></i>
                <p>Tồn kho Thịt Bò Thăn Nội < 5kg.</p>
            </a>
            <a href="#" class="notification-item">
                <i class="fas fa-comment"></i>
                <p>Có 1 phản hồi mới cho sản phẩm Thịt Heo.</p>
            </a>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/JS/admin_thong_ke.js"></script>
</body>
</html>